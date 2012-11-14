// Copyright (c) 2012 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "remoting/host/remote_input_filter.h"

#include <algorithm>

#include "base/logging.h"
#include "remoting/proto/event.pb.h"

namespace {

// The number of remote mouse events to record for the purpose of eliminating
// "echoes" detected by the local input detector. The value should be large
// enough to cope with the fact that multiple events might be injected before
// any echoes are detected.
const unsigned int kNumRemoteMousePositions = 50;

// The number of milliseconds for which to block remote input when local input
// is received.
const int64 kRemoteBlockTimeoutMillis = 2000;

} // namespace

namespace remoting {

RemoteInputFilter::RemoteInputFilter(protocol::InputEventTracker* event_tracker)
    : event_tracker_(event_tracker) {
}

RemoteInputFilter::~RemoteInputFilter() {
}

void RemoteInputFilter::LocalMouseMoved(const SkIPoint& mouse_pos) {
  // If this is a genuine local input event (rather than an echo of a remote
  // input event that we've just injected), then ignore remote inputs for a
  // short time.
  std::list<SkIPoint>::iterator found_position =
      std::find(injected_mouse_positions_.begin(),
                injected_mouse_positions_.end(), mouse_pos);
  if (found_position != injected_mouse_positions_.end()) {
    // Remove it from the list, and any positions that were added before it,
    // if any.  This is because the local input monitor is assumed to receive
    // injected mouse position events in the order in which they were injected
    // (if at all).  If the position is found somewhere other than the front of
    // the queue, this would be because the earlier positions weren't
    // successfully injected (or the local input monitor might have skipped over
    // some positions), and not because the events were out-of-sequence.  These
    // spurious positions should therefore be discarded.
    injected_mouse_positions_.erase(injected_mouse_positions_.begin(),
                                    ++found_position);
  } else {
    // Release all pressed buttons or keys, disable inputs, and note the time.
    event_tracker_->ReleaseAll();
    latest_local_input_time_ = base::TimeTicks::Now();
  }
}

void RemoteInputFilter::InjectKeyEvent(const protocol::KeyEvent& event) {
  if (ShouldIgnoreInput())
    return;
  event_tracker_->InjectKeyEvent(event);
}

void RemoteInputFilter::InjectMouseEvent(const protocol::MouseEvent& event) {
  if (ShouldIgnoreInput())
    return;
  if (event.has_x() && event.has_y()) {
    injected_mouse_positions_.push_back(SkIPoint::Make(event.x(), event.y()));
    if (injected_mouse_positions_.size() > kNumRemoteMousePositions) {
      VLOG(1) << "Injected mouse positions queue full.";
      injected_mouse_positions_.pop_front();
    }
  }
  event_tracker_->InjectMouseEvent(event);
}

bool RemoteInputFilter::ShouldIgnoreInput() const {
  // Ignore remote events if the local mouse moved recently.
  int64 millis =
      (base::TimeTicks::Now() - latest_local_input_time_).InMilliseconds();
  if (millis < kRemoteBlockTimeoutMillis)
    return true;
  return false;
}

}  // namespace remoting
