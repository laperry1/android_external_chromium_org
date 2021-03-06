// Copyright (c) 2012 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "extensions/browser/warning_service.h"

#include "content/public/browser/browser_thread.h"
#include "extensions/browser/extension_registry.h"
#include "extensions/browser/extension_system.h"
#include "extensions/browser/extensions_browser_client.h"
#include "extensions/common/extension_set.h"

using content::BrowserThread;

namespace extensions {

WarningService::WarningService(content::BrowserContext* browser_context)
    : browser_context_(browser_context), extension_registry_observer_(this) {
  DCHECK(CalledOnValidThread());
  if (browser_context_) {
    extension_registry_observer_.Add(ExtensionRegistry::Get(
        ExtensionsBrowserClient::Get()->GetOriginalContext(browser_context_)));
  }
}

WarningService::~WarningService() {}

void WarningService::ClearWarnings(
    const std::set<Warning::WarningType>& types) {
  DCHECK(CalledOnValidThread());
  bool deleted_anything = false;
  for (WarningSet::iterator i = warnings_.begin();
       i != warnings_.end();) {
    if (types.find(i->warning_type()) != types.end()) {
      deleted_anything = true;
      warnings_.erase(i++);
    } else {
      ++i;
    }
  }

  if (deleted_anything)
    NotifyWarningsChanged();
}

std::set<Warning::WarningType> WarningService::
    GetWarningTypesAffectingExtension(const std::string& extension_id) const {
  DCHECK(CalledOnValidThread());
  std::set<Warning::WarningType> result;
  for (WarningSet::const_iterator i = warnings_.begin();
       i != warnings_.end(); ++i) {
    if (i->extension_id() == extension_id)
      result.insert(i->warning_type());
  }
  return result;
}

std::vector<std::string> WarningService::GetWarningMessagesForExtension(
    const std::string& extension_id) const {
  DCHECK(CalledOnValidThread());
  std::vector<std::string> result;

  const ExtensionSet& extension_set =
      ExtensionRegistry::Get(browser_context_)->enabled_extensions();

  for (WarningSet::const_iterator i = warnings_.begin();
       i != warnings_.end(); ++i) {
    if (i->extension_id() == extension_id)
      result.push_back(i->GetLocalizedMessage(&extension_set));
  }
  return result;
}

void WarningService::AddWarnings(const WarningSet& warnings) {
  DCHECK(CalledOnValidThread());
  size_t old_size = warnings_.size();

  warnings_.insert(warnings.begin(), warnings.end());

  if (old_size != warnings_.size())
    NotifyWarningsChanged();
}

// static
void WarningService::NotifyWarningsOnUI(
    void* profile_id,
    const WarningSet& warnings) {
  DCHECK_CURRENTLY_ON(BrowserThread::UI);
  content::BrowserContext* browser_context =
      reinterpret_cast<content::BrowserContext*>(profile_id);

  if (!browser_context ||
      !ExtensionsBrowserClient::Get() ||
      !ExtensionsBrowserClient::Get()->IsValidContext(browser_context)) {
    return;
  }

  WarningService* warning_service =
      ExtensionSystem::Get(browser_context)->warning_service();

  warning_service->AddWarnings(warnings);
}

void WarningService::AddObserver(Observer* observer) {
  observer_list_.AddObserver(observer);
}

void WarningService::RemoveObserver(Observer* observer) {
  observer_list_.RemoveObserver(observer);
}

void WarningService::NotifyWarningsChanged() {
  FOR_EACH_OBSERVER(Observer, observer_list_, ExtensionWarningsChanged());
}

void WarningService::OnExtensionUnloaded(
    content::BrowserContext* browser_context,
    const Extension* extension,
    UnloadedExtensionInfo::Reason reason) {
  // Unloading one extension might have solved the problems of others.
  // Therefore, we clear warnings of this type for all extensions.
  std::set<Warning::WarningType> warning_types =
      GetWarningTypesAffectingExtension(extension->id());
  ClearWarnings(warning_types);
}

}  // namespace extensions
