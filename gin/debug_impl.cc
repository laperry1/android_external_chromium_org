// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "gin/debug_impl.h"

namespace gin {

namespace {
v8::FunctionEntryHook g_entry_hook = NULL;
v8::JitCodeEventHandler g_jit_code_event_handler = NULL;
}  // namespace

// static
void Debug::SetFunctionEntryHook(v8::FunctionEntryHook entry_hook) {
  g_entry_hook = entry_hook;
}

// static
void Debug::SetJitCodeEventHandler(v8::JitCodeEventHandler event_handler) {
  g_jit_code_event_handler = event_handler;
}

// static
v8::FunctionEntryHook DebugImpl::GetFunctionEntryHook() {
  return g_entry_hook;
}

// static
v8::JitCodeEventHandler DebugImpl::GetJitCodeEventHandler() {
  return g_jit_code_event_handler;
}

}  // namespace gin
