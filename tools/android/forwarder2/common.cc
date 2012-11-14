// Copyright (c) 2012 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "tools/android/forwarder2/common.h"

#include <errno.h>
#include <unistd.h>

#include "base/eintr_wrapper.h"
#include "base/logging.h"
#include "base/safe_strerror_posix.h"

namespace forwarder2 {

void PError(const char* msg) {
  LOG(ERROR) << msg << ": " << safe_strerror(errno);
}

void CloseFD(int fd) {
  const int errno_copy = errno;
  if (HANDLE_EINTR(close(fd)) < 0) {
    PError("close");
    errno = errno_copy;
  }
}

}  // namespace forwarder2
