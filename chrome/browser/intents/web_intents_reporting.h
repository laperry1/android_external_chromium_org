// Copyright (c) 2012 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef CHROME_BROWSER_INTENTS_WEB_INTENTS_REPORTING_H_
#define CHROME_BROWSER_INTENTS_WEB_INTENTS_REPORTING_H_

#include "base/string16.h"
#include "chrome/browser/intents/web_intents_util.h"
#include "webkit/glue/web_intent_reply_data.h"

namespace base {
class TimeDelta;
}

namespace webkit_glue {
struct WebIntentData;
}

namespace web_intents {

// primarily an implementation detail, but declared in this scope
// so they can be used in generating bucket ids
enum TypeId {
  TYPE_ID_CUSTOM = 1,
  TYPE_ID_APPLICATION,
  TYPE_ID_AUDIO,
  TYPE_ID_EXAMPLE,
  TYPE_ID_IMAGE,
  TYPE_ID_MESSAGE,
  TYPE_ID_MODEL,
  TYPE_ID_MULTIPART,
  TYPE_ID_TEXT,
  TYPE_ID_VIDEO,
};

#define INTENT_UMA_BUCKET(ACTION, TYPE) \
 (ACTION_ID_##ACTION << 8) | TYPE_ID_##TYPE

// UMA buckets for reporting the Web Intent action and type.
enum UMABucket {
  BUCKET_CUSTOM_CUSTOM = INTENT_UMA_BUCKET(CUSTOM, CUSTOM),
  BUCKET_CUSTOM_APPLICATION = INTENT_UMA_BUCKET(CUSTOM, APPLICATION),
  BUCKET_CUSTOM_AUDIO = INTENT_UMA_BUCKET(CUSTOM, AUDIO),
  BUCKET_CUSTOM_EXAMPLE = INTENT_UMA_BUCKET(CUSTOM, EXAMPLE),
  BUCKET_CUSTOM_IMAGE = INTENT_UMA_BUCKET(CUSTOM, IMAGE),
  BUCKET_CUSTOM_MESSAGE = INTENT_UMA_BUCKET(CUSTOM, MESSAGE),
  BUCKET_CUSTOM_MODEL = INTENT_UMA_BUCKET(CUSTOM, MODEL),
  BUCKET_CUSTOM_MULTIPART = INTENT_UMA_BUCKET(CUSTOM, MULTIPART),
  BUCKET_CUSTOM_TEXT = INTENT_UMA_BUCKET(CUSTOM, TEXT),
  BUCKET_CUSTOM_VIDEO = INTENT_UMA_BUCKET(CUSTOM, VIDEO),
  BUCKET_EDIT_CUSTOM = INTENT_UMA_BUCKET(EDIT, CUSTOM),
  BUCKET_EDIT_APPLICATION = INTENT_UMA_BUCKET(EDIT, APPLICATION),
  BUCKET_EDIT_AUDIO = INTENT_UMA_BUCKET(EDIT, AUDIO),
  BUCKET_EDIT_EXAMPLE = INTENT_UMA_BUCKET(EDIT, EXAMPLE),
  BUCKET_EDIT_IMAGE = INTENT_UMA_BUCKET(EDIT, IMAGE),
  BUCKET_EDIT_MESSAGE = INTENT_UMA_BUCKET(EDIT, MESSAGE),
  BUCKET_EDIT_MODEL = INTENT_UMA_BUCKET(EDIT, MODEL),
  BUCKET_EDIT_MULTIPART = INTENT_UMA_BUCKET(EDIT, MULTIPART),
  BUCKET_EDIT_TEXT = INTENT_UMA_BUCKET(EDIT, TEXT),
  BUCKET_EDIT_VIDEO = INTENT_UMA_BUCKET(EDIT, VIDEO),
  BUCKET_PICK_CUSTOM = INTENT_UMA_BUCKET(PICK, CUSTOM),
  BUCKET_PICK_APPLICATION = INTENT_UMA_BUCKET(PICK, APPLICATION),
  BUCKET_PICK_AUDIO = INTENT_UMA_BUCKET(PICK, AUDIO),
  BUCKET_PICK_EXAMPLE = INTENT_UMA_BUCKET(PICK, EXAMPLE),
  BUCKET_PICK_IMAGE = INTENT_UMA_BUCKET(PICK, IMAGE),
  BUCKET_PICK_MESSAGE = INTENT_UMA_BUCKET(PICK, MESSAGE),
  BUCKET_PICK_MODEL = INTENT_UMA_BUCKET(PICK, MODEL),
  BUCKET_PICK_MULTIPART = INTENT_UMA_BUCKET(PICK, MULTIPART),
  BUCKET_PICK_TEXT = INTENT_UMA_BUCKET(PICK, TEXT),
  BUCKET_PICK_VIDEO = INTENT_UMA_BUCKET(PICK, VIDEO),
  BUCKET_SAVE_CUSTOM = INTENT_UMA_BUCKET(SAVE, CUSTOM),
  BUCKET_SAVE_APPLICATION = INTENT_UMA_BUCKET(SAVE, APPLICATION),
  BUCKET_SAVE_AUDIO = INTENT_UMA_BUCKET(SAVE, AUDIO),
  BUCKET_SAVE_EXAMPLE = INTENT_UMA_BUCKET(SAVE, EXAMPLE),
  BUCKET_SAVE_IMAGE = INTENT_UMA_BUCKET(SAVE, IMAGE),
  BUCKET_SAVE_MESSAGE = INTENT_UMA_BUCKET(SAVE, MESSAGE),
  BUCKET_SAVE_MODEL = INTENT_UMA_BUCKET(SAVE, MODEL),
  BUCKET_SAVE_MULTIPART = INTENT_UMA_BUCKET(SAVE, MULTIPART),
  BUCKET_SAVE_TEXT = INTENT_UMA_BUCKET(SAVE, TEXT),
  BUCKET_SAVE_VIDEO = INTENT_UMA_BUCKET(SAVE, VIDEO),
  BUCKET_SHARE_CUSTOM = INTENT_UMA_BUCKET(SHARE, CUSTOM),
  BUCKET_SHARE_APPLICATION = INTENT_UMA_BUCKET(SHARE, APPLICATION),
  BUCKET_SHARE_AUDIO = INTENT_UMA_BUCKET(SHARE, AUDIO),
  BUCKET_SHARE_EXAMPLE = INTENT_UMA_BUCKET(SHARE, EXAMPLE),
  BUCKET_SHARE_IMAGE = INTENT_UMA_BUCKET(SHARE, IMAGE),
  BUCKET_SHARE_MESSAGE = INTENT_UMA_BUCKET(SHARE, MESSAGE),
  BUCKET_SHARE_MODEL = INTENT_UMA_BUCKET(SHARE, MODEL),
  BUCKET_SHARE_MULTIPART = INTENT_UMA_BUCKET(SHARE, MULTIPART),
  BUCKET_SHARE_TEXT = INTENT_UMA_BUCKET(SHARE, TEXT),
  BUCKET_SHARE_VIDEO = INTENT_UMA_BUCKET(SHARE, VIDEO),
  BUCKET_SUBSCRIBE_CUSTOM = INTENT_UMA_BUCKET(SUBSCRIBE, CUSTOM),
  BUCKET_SUBSCRIBE_APPLICATION = INTENT_UMA_BUCKET(SUBSCRIBE, APPLICATION),
  BUCKET_SUBSCRIBE_AUDIO = INTENT_UMA_BUCKET(SUBSCRIBE, AUDIO),
  BUCKET_SUBSCRIBE_EXAMPLE = INTENT_UMA_BUCKET(SUBSCRIBE, EXAMPLE),
  BUCKET_SUBSCRIBE_IMAGE = INTENT_UMA_BUCKET(SUBSCRIBE, IMAGE),
  BUCKET_SUBSCRIBE_MESSAGE = INTENT_UMA_BUCKET(SUBSCRIBE, MESSAGE),
  BUCKET_SUBSCRIBE_MODEL = INTENT_UMA_BUCKET(SUBSCRIBE, MODEL),
  BUCKET_SUBSCRIBE_MULTIPART = INTENT_UMA_BUCKET(SUBSCRIBE, MULTIPART),
  BUCKET_SUBSCRIBE_TEXT = INTENT_UMA_BUCKET(SUBSCRIBE, TEXT),
  BUCKET_SUBSCRIBE_VIDEO = INTENT_UMA_BUCKET(SUBSCRIBE, VIDEO),
  BUCKET_VIEW_CUSTOM = INTENT_UMA_BUCKET(VIEW, CUSTOM),
  BUCKET_VIEW_APPLICATION = INTENT_UMA_BUCKET(VIEW, APPLICATION),
  BUCKET_VIEW_AUDIO = INTENT_UMA_BUCKET(VIEW, AUDIO),
  BUCKET_VIEW_EXAMPLE = INTENT_UMA_BUCKET(VIEW, EXAMPLE),
  BUCKET_VIEW_IMAGE = INTENT_UMA_BUCKET(VIEW, IMAGE),
  BUCKET_VIEW_MESSAGE = INTENT_UMA_BUCKET(VIEW, MESSAGE),
  BUCKET_VIEW_MODEL = INTENT_UMA_BUCKET(VIEW, MODEL),
  BUCKET_VIEW_MULTIPART = INTENT_UMA_BUCKET(VIEW, MULTIPART),
  BUCKET_VIEW_TEXT = INTENT_UMA_BUCKET(VIEW, TEXT),
  BUCKET_VIEW_VIDEO = INTENT_UMA_BUCKET(VIEW, VIDEO),
};

#undef INTENT_UMA_BUCKET

UMABucket ToUMABucket(const string16& action, const string16& type);
void RecordIntentsDispatchDisabled();
void RecordIntentDispatchRequested();
void RecordIntentDispatched(const UMABucket bucket);

// Records the fact that the picker was shown and records the
// number of services installed at the time the picker was shown
void RecordPickerShow(const UMABucket bucket, size_t installed);
void RecordPickerCancel(const UMABucket bucket);
void RecordServiceInvoke(const UMABucket bucket);
// Records the |duration| of time spent in the service. Uses |reply_type| to
// distinguish between failed and successful service usage.
void RecordServiceActiveDuration(
    webkit_glue::WebIntentReplyType reply_type,
    const base::TimeDelta& duration);
void RecordChooseAnotherService(const UMABucket bucket);
void RecordCWSExtensionInstalled(const UMABucket bucket);
}  // namespace web_intents

#endif  // CHROME_BROWSER_INTENTS_WEB_INTENTS_REPORTING_H_
