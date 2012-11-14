# This file is generated by gyp; do not edit.

include $(CLEAR_VARS)

LOCAL_MODULE_CLASS := STATIC_LIBRARIES
LOCAL_MODULE := content_content_browser_gyp
LOCAL_MODULE_SUFFIX := .a
LOCAL_MODULE_TAGS := optional
gyp_intermediate_dir := $(call local-intermediates-dir)
gyp_shared_intermediate_dir := $(call intermediates-dir-for,GYP,shared)

# Make sure our deps are built first.
GYP_TARGET_DEPENDENCIES := \
	$(call intermediates-dir-for,GYP,content_content_resources_gyp)/content_resources.stamp \
	$(call intermediates-dir-for,STATIC_LIBRARIES,content_browser_speech_proto_speech_proto_gyp)/content_browser_speech_proto_speech_proto_gyp.a \
	$(call intermediates-dir-for,STATIC_LIBRARIES,skia_skia_gyp)/skia_skia_gyp.a \
	$(call intermediates-dir-for,GYP,ui_ui_resources_gyp)/ui_resources.stamp \
	$(call intermediates-dir-for,GYP,content_browser_debugger_devtools_resources_gyp)/devtools_resources.stamp \
	$(call intermediates-dir-for,GYP,webkit_support_webkit_resources_gyp)/webkit_resources.stamp \
	$(call intermediates-dir-for,GYP,webkit_support_webkit_strings_gyp)/webkit_strings.stamp \
	$(call intermediates-dir-for,GYP,sandbox_sandbox_gyp)/sandbox.stamp \
	$(call intermediates-dir-for,GYP,content_content_jni_headers_gyp)/content_jni_headers.stamp

GYP_GENERATED_OUTPUTS :=

# Make sure our deps and generated files are built first.
LOCAL_ADDITIONAL_DEPENDENCIES := $(GYP_TARGET_DEPENDENCIES) $(GYP_GENERATED_OUTPUTS)

LOCAL_CPP_EXTENSION := .cc
$(gyp_intermediate_dir)/devtools_resources_map.cc: $(gyp_shared_intermediate_dir)/webkit/grit/devtools_resources_map.cc
	mkdir -p $(@D); cp $< $@
LOCAL_GENERATED_SOURCES := \
	$(gyp_intermediate_dir)/devtools_resources_map.cc

GYP_COPIED_SOURCE_ORIGIN_DIRS := \
	$(gyp_shared_intermediate_dir)/webkit/grit

LOCAL_SRC_FILES := \
	content/public/browser/browser_child_process_host_delegate.cc \
	content/public/browser/browser_child_process_host_iterator.cc \
	content/public/browser/browser_main_parts.cc \
	content/public/browser/browser_message_filter.cc \
	content/public/browser/content_browser_client.cc \
	content/public/browser/download_manager_delegate.cc \
	content/public/browser/download_persistent_store_info.cc \
	content/public/browser/download_save_info.cc \
	content/public/browser/download_url_parameters.cc \
	content/public/browser/favicon_status.cc \
	content/public/browser/load_from_memory_cache_details.cc \
	content/public/browser/navigation_controller.cc \
	content/public/browser/navigation_details.cc \
	content/public/browser/notification_registrar.cc \
	content/public/browser/page_navigator.cc \
	content/public/browser/render_view_host_observer.cc \
	content/public/browser/resource_dispatcher_host_delegate.cc \
	content/public/browser/resource_request_details.cc \
	content/public/browser/speech_recognition_session_config.cc \
	content/public/browser/speech_recognition_session_context.cc \
	content/public/browser/web_contents_delegate.cc \
	content/public/browser/web_contents_observer.cc \
	content/public/browser/web_ui_controller.cc \
	content/browser/accessibility/browser_accessibility.cc \
	content/browser/accessibility/browser_accessibility_manager.cc \
	content/browser/accessibility/browser_accessibility_state_impl.cc \
	content/browser/android/android_browser_process.cc \
	content/browser/android/browser_jni_registrar.cc \
	content/browser/android/content_settings.cc \
	content/browser/android/content_startup_flags.cc \
	content/browser/android/content_video_view.cc \
	content/browser/android/content_view_core_impl.cc \
	content/browser/android/content_view_render_view.cc \
	content/browser/android/content_view_statics.cc \
	content/browser/android/cookie_getter_impl.cc \
	content/browser/android/download_controller_android_impl.cc \
	content/browser/android/devtools_auth.cc \
	content/browser/android/draw_delegate_impl.cc \
	content/browser/android/load_url_params.cc \
	content/browser/android/media_player_manager_android.cc \
	content/browser/android/sandboxed_process_launcher.cc \
	content/browser/android/surface_texture_peer_browser_impl.cc \
	content/browser/android/touch_point.cc \
	content/browser/android/web_contents_observer_android.cc \
	content/browser/appcache/appcache_dispatcher_host.cc \
	content/browser/appcache/appcache_frontend_proxy.cc \
	content/browser/appcache/chrome_appcache_service.cc \
	content/browser/browser_child_process_host_impl.cc \
	content/browser/browser_context.cc \
	content/browser/browser_main.cc \
	content/browser/browser_main_loop.cc \
	content/browser/browser_main_runner.cc \
	content/browser/browser_plugin/browser_plugin_embedder.cc \
	content/browser/browser_plugin/browser_plugin_embedder_helper.cc \
	content/browser/browser_plugin/browser_plugin_guest.cc \
	content/browser/browser_plugin/browser_plugin_guest_helper.cc \
	content/browser/browser_process_sub_thread.cc \
	content/browser/browser_thread_impl.cc \
	content/browser/browser_url_handler_impl.cc \
	content/browser/browsing_instance.cc \
	content/browser/cert_store_impl.cc \
	content/browser/child_process_launcher.cc \
	content/browser/child_process_security_policy_impl.cc \
	content/browser/content_ipc_logging.cc \
	content/browser/cross_site_request_manager.cc \
	content/browser/debugger/devtools_agent_host.cc \
	content/browser/debugger/devtools_frontend_host.cc \
	content/browser/debugger/devtools_http_handler_impl.cc \
	content/browser/debugger/devtools_manager_impl.cc \
	content/browser/debugger/devtools_netlog_observer.cc \
	content/browser/debugger/render_view_devtools_agent_host.cc \
	content/browser/debugger/worker_devtools_manager.cc \
	content/browser/debugger/worker_devtools_message_filter.cc \
	content/browser/device_orientation/data_fetcher_impl_android.cc \
	content/browser/device_orientation/message_filter.cc \
	content/browser/device_orientation/motion.cc \
	content/browser/device_orientation/motion_message_filter.cc \
	content/browser/device_orientation/observer_delegate.cc \
	content/browser/device_orientation/orientation.cc \
	content/browser/device_orientation/orientation_message_filter.cc \
	content/browser/device_orientation/provider.cc \
	content/browser/device_orientation/provider_impl.cc \
	content/browser/dom_storage/dom_storage_context_impl.cc \
	content/browser/dom_storage/dom_storage_message_filter.cc \
	content/browser/dom_storage/session_storage_namespace_impl.cc \
	content/browser/download/base_file.cc \
	content/browser/download/base_file_posix.cc \
	content/browser/download/byte_stream.cc \
	content/browser/download/download_create_info.cc \
	content/browser/download/download_file_factory.cc \
	content/browser/download/download_file_impl.cc \
	content/browser/download/download_interrupt_reasons_impl.cc \
	content/browser/download/download_item_impl.cc \
	content/browser/download/download_item_impl_delegate.cc \
	content/browser/download/download_manager_impl.cc \
	content/browser/download/download_net_log_parameters.cc \
	content/browser/download/download_request_handle.cc \
	content/browser/download/download_resource_handler.cc \
	content/browser/download/download_stats.cc \
	content/browser/download/drag_download_file.cc \
	content/browser/download/drag_download_util.cc \
	content/browser/download/mhtml_generation_manager.cc \
	content/browser/download/save_file.cc \
	content/browser/download/save_file_manager.cc \
	content/browser/download/save_file_resource_handler.cc \
	content/browser/download/save_item.cc \
	content/browser/download/save_package.cc \
	content/browser/download/save_types.cc \
	content/browser/fileapi/browser_file_system_helper.cc \
	content/browser/fileapi/chrome_blob_storage_context.cc \
	content/browser/fileapi/fileapi_message_filter.cc \
	content/browser/font_list_async.cc \
	content/browser/gamepad/gamepad_provider.cc \
	content/browser/gamepad/gamepad_service.cc \
	content/browser/geolocation/arbitrator_dependency_factory.cc \
	content/browser/geolocation/device_data_provider.cc \
	content/browser/geolocation/empty_device_data_provider.cc \
	content/browser/geolocation/geolocation.cc \
	content/browser/geolocation/geolocation_dispatcher_host.cc \
	content/browser/geolocation/geolocation_provider.cc \
	content/browser/geolocation/location_api_adapter_android.cc \
	content/browser/geolocation/location_arbitrator.cc \
	content/browser/geolocation/location_provider_android.cc \
	content/browser/geolocation/location_provider.cc \
	content/browser/geolocation/wifi_data_provider_common.cc \
	content/browser/gpu/browser_gpu_channel_host_factory.cc \
	content/browser/gpu/compositor_util.cc \
	content/browser/gpu/gpu_blacklist.cc \
	content/browser/gpu/gpu_data_manager_impl.cc \
	content/browser/gpu/gpu_process_host.cc \
	content/browser/gpu/gpu_process_host_ui_shim.cc \
	content/browser/gpu/gpu_surface_tracker.cc \
	content/browser/gpu/gpu_util.cc \
	content/browser/histogram_controller.cc \
	content/browser/histogram_internals_request_job.cc \
	content/browser/histogram_message_filter.cc \
	content/browser/histogram_synchronizer.cc \
	content/browser/host_zoom_map_impl.cc \
	content/browser/hyphenator/hyphenator_message_filter.cc \
	content/browser/in_process_webkit/browser_webkitplatformsupport_impl.cc \
	content/browser/in_process_webkit/indexed_db_callbacks.cc \
	content/browser/in_process_webkit/indexed_db_context_impl.cc \
	content/browser/in_process_webkit/indexed_db_database_callbacks.cc \
	content/browser/in_process_webkit/indexed_db_dispatcher_host.cc \
	content/browser/in_process_webkit/indexed_db_quota_client.cc \
	content/browser/in_process_webkit/indexed_db_transaction_callbacks.cc \
	content/browser/in_process_webkit/webkit_thread.cc \
	content/browser/intents/intent_injector.cc \
	content/browser/intents/internal_web_intents_dispatcher.cc \
	content/browser/intents/web_intents_dispatcher_impl.cc \
	content/browser/mime_registry_message_filter.cc \
	content/browser/net/browser_online_state_observer.cc \
	content/browser/net/view_blob_internals_job_factory.cc \
	content/browser/net/view_http_cache_job_factory.cc \
	content/browser/notification_service_impl.cc \
	content/browser/pepper_flash_settings_helper_impl.cc \
	content/browser/plugin_data_remover_impl.cc \
	content/browser/plugin_loader_posix.cc \
	content/browser/plugin_process_host.cc \
	content/browser/plugin_service_impl.cc \
	content/browser/power_save_blocker_android.cc \
	content/browser/ppapi_plugin_process_host.cc \
	content/browser/profiler_controller_impl.cc \
	content/browser/profiler_message_filter.cc \
	content/browser/renderer_host/async_resource_handler.cc \
	content/browser/renderer_host/backing_store.cc \
	content/browser/renderer_host/backing_store_manager.cc \
	content/browser/renderer_host/buffered_resource_handler.cc \
	content/browser/renderer_host/clipboard_message_filter.cc \
	content/browser/renderer_host/compositor_impl_android.cc \
	content/browser/renderer_host/cross_site_resource_handler.cc \
	content/browser/renderer_host/database_message_filter.cc \
	content/browser/renderer_host/dip_util.cc \
	content/browser/renderer_host/doomed_resource_handler.cc \
	content/browser/renderer_host/file_utilities_message_filter.cc \
	content/browser/renderer_host/gamepad_browser_message_filter.cc \
	content/browser/renderer_host/gesture_event_filter.cc \
	content/browser/renderer_host/gpu_message_filter.cc \
	content/browser/renderer_host/image_transport_factory_android.cc \
	content/browser/renderer_host/ime_adapter_android.cc \
	content/browser/renderer_host/java/java_bound_object.cc \
	content/browser/renderer_host/java/java_bridge_channel_host.cc \
	content/browser/renderer_host/java/java_bridge_dispatcher_host.cc \
	content/browser/renderer_host/java/java_bridge_dispatcher_host_manager.cc \
	content/browser/renderer_host/java/java_method.cc \
	content/browser/renderer_host/java/java_type.cc \
	content/browser/renderer_host/layered_resource_handler.cc \
	content/browser/renderer_host/media/audio_input_device_manager.cc \
	content/browser/renderer_host/media/audio_input_renderer_host.cc \
	content/browser/renderer_host/media/audio_input_sync_writer.cc \
	content/browser/renderer_host/media/audio_renderer_host.cc \
	content/browser/renderer_host/media/audio_sync_reader.cc \
	content/browser/renderer_host/media/media_stream_dispatcher_host.cc \
	content/browser/renderer_host/media/media_stream_manager.cc \
	content/browser/renderer_host/media/media_stream_ui_controller.cc \
	content/browser/renderer_host/media/video_capture_controller.cc \
	content/browser/renderer_host/media/video_capture_controller_event_handler.cc \
	content/browser/renderer_host/media/video_capture_host.cc \
	content/browser/renderer_host/media/video_capture_manager.cc \
	content/browser/renderer_host/media/web_contents_video_capture_device.cc \
	content/browser/renderer_host/native_web_keyboard_event_android.cc \
	content/browser/renderer_host/native_web_keyboard_event.cc \
	content/browser/renderer_host/pepper/browser_ppapi_host_impl.cc \
	content/browser/renderer_host/pepper/content_browser_pepper_host_factory.cc \
	content/browser/renderer_host/pepper/pepper_file_message_filter.cc \
	content/browser/renderer_host/pepper/pepper_gamepad_host.cc \
	content/browser/renderer_host/pepper/pepper_message_filter.cc \
	content/browser/renderer_host/pepper/pepper_print_settings_manager.cc \
	content/browser/renderer_host/pepper/pepper_printing_host.cc \
	content/browser/renderer_host/pepper/pepper_tcp_server_socket.cc \
	content/browser/renderer_host/pepper/pepper_tcp_socket.cc \
	content/browser/renderer_host/pepper/pepper_udp_socket.cc \
	content/browser/renderer_host/quota_dispatcher_host.cc \
	content/browser/renderer_host/redirect_to_file_resource_handler.cc \
	content/browser/renderer_host/render_message_filter.cc \
	content/browser/renderer_host/render_process_host_impl.cc \
	content/browser/renderer_host/render_view_host_delegate.cc \
	content/browser/renderer_host/render_view_host_factory.cc \
	content/browser/renderer_host/render_view_host_impl.cc \
	content/browser/renderer_host/render_widget_helper.cc \
	content/browser/renderer_host/render_widget_host_delegate.cc \
	content/browser/renderer_host/render_widget_host_impl.cc \
	content/browser/renderer_host/render_widget_host_impl_android.cc \
	content/browser/renderer_host/render_widget_host_view_android.cc \
	content/browser/renderer_host/render_widget_host_view_base.cc \
	content/browser/renderer_host/resource_buffer.cc \
	content/browser/renderer_host/resource_dispatcher_host_impl.cc \
	content/browser/renderer_host/resource_handler.cc \
	content/browser/renderer_host/resource_loader.cc \
	content/browser/renderer_host/resource_message_filter.cc \
	content/browser/renderer_host/resource_request_info_impl.cc \
	content/browser/renderer_host/socket_stream_dispatcher_host.cc \
	content/browser/renderer_host/socket_stream_host.cc \
	content/browser/renderer_host/sync_resource_handler.cc \
	content/browser/renderer_host/tap_suppression_controller.cc \
	content/browser/renderer_host/throttling_resource_handler.cc \
	content/browser/renderer_host/touch_event_queue.cc \
	content/browser/renderer_host/transfer_navigation_resource_throttle.cc \
	content/browser/renderer_host/x509_user_cert_resource_handler.cc \
	content/browser/resolve_proxy_msg_helper.cc \
	content/browser/resource_context_impl.cc \
	content/browser/site_instance_impl.cc \
	content/browser/ssl/ssl_cert_error_handler.cc \
	content/browser/ssl/ssl_client_auth_handler.cc \
	content/browser/ssl/ssl_error_handler.cc \
	content/browser/ssl/ssl_host_state.cc \
	content/browser/ssl/ssl_manager.cc \
	content/browser/ssl/ssl_policy_backend.cc \
	content/browser/ssl/ssl_policy.cc \
	content/browser/ssl/ssl_request_info.cc \
	content/browser/storage_partition_impl.cc \
	content/browser/storage_partition_impl_map.cc \
	content/browser/tcmalloc_internals_request_job.cc \
	content/browser/web_contents/debug_urls.cc \
	content/browser/web_contents/interstitial_page_impl.cc \
	content/browser/web_contents/navigation_controller_impl.cc \
	content/browser/web_contents/navigation_entry_impl.cc \
	content/browser/web_contents/render_view_host_manager.cc \
	content/browser/web_contents/web_contents_impl.cc \
	content/browser/web_contents/web_contents_view_android.cc \
	content/browser/trace_controller_impl.cc \
	content/browser/trace_message_filter.cc \
	content/browser/trace_subscriber_stdio.cc \
	content/browser/user_metrics.cc \
	content/browser/utility_process_host_impl.cc \
	content/browser/webui/web_ui_impl.cc \
	content/browser/webui/web_ui_message_handler.cc \
	content/browser/worker_host/message_port_service.cc \
	content/browser/worker_host/worker_document_set.cc \
	content/browser/worker_host/worker_message_filter.cc \
	content/browser/worker_host/worker_process_host.cc \
	content/browser/worker_host/worker_service_impl.cc \
	content/browser/worker_host/worker_storage_partition.cc \
	content/browser/gamepad/gamepad_platform_data_fetcher.cc


# Flags passed to both C and C++ files.
MY_CFLAGS := \
	-Werror \
	-fno-exceptions \
	-fno-strict-aliasing \
	-Wall \
	-Wno-unused-parameter \
	-Wno-missing-field-initializers \
	-fvisibility=hidden \
	-pipe \
	-fPIC \
	-mthumb \
	-march=armv7-a \
	-mtune=cortex-a8 \
	-mfloat-abi=softfp \
	-mfpu=vfpv3-d16 \
	-fno-tree-sra \
	-fuse-ld=gold \
	-Wno-psabi \
	-mthumb-interwork \
	-ffunction-sections \
	-funwind-tables \
	-g \
	-fstack-protector \
	-fno-short-enums \
	-finline-limit=64 \
	-Wa,--noexecstack \
	-Wno-error=extra \
	-Wno-error=ignored-qualifiers \
	-Wno-error=type-limits \
	-Wno-error=non-virtual-dtor \
	-Wno-error=sign-promo \
	-Os \
	-g \
	-fomit-frame-pointer \
	-fdata-sections \
	-ffunction-sections

MY_CFLAGS_C :=

MY_DEFS := \
	'-DCONTENT_IMPLEMENTATION' \
	'-D_FILE_OFFSET_BITS=64' \
	'-DNO_TCMALLOC' \
	'-DDISABLE_NACL' \
	'-DCHROMIUM_BUILD' \
	'-DUSE_LIBJPEG_TURBO=1' \
	'-DUSE_PROPRIETARY_CODECS' \
	'-DENABLE_PEPPER_THREADING' \
	'-DENABLE_GPU=1' \
	'-DUSE_OPENSSL=1' \
	'-DENABLE_EGLIMAGE=1' \
	'-DUSE_SKIA=1' \
	'-DENABLE_JAVA_BRIDGE' \
	'-DGOOGLE_PROTOBUF_NO_RTTI' \
	'-DGOOGLE_PROTOBUF_NO_STATIC_INITIALIZER' \
	'-DPOSIX_AVOID_MMAP' \
	'-DSK_BUILD_NO_IMAGE_ENCODE' \
	'-DSK_DEFERRED_CANVAS_USES_GPIPE=1' \
	'-DGR_GL_CUSTOM_SETUP_HEADER="GrGLConfig_chrome.h"' \
	'-DGR_AGGRESSIVE_SHADER_OPTS=1' \
	'-DSK_USE_POSIX_THREADS' \
	'-DSK_BUILD_FOR_ANDROID_NDK' \
	'-DU_USING_ICU_NAMESPACE=0' \
	'-DUSE_SYSTEM_ICU' \
	'-D__STDC_CONSTANT_MACROS' \
	'-D__STDC_FORMAT_MACROS' \
	'-DANDROID' \
	'-D__GNU_SOURCE=1' \
	'-DUSE_STLPORT=1' \
	'-D_STLP_USE_PTR_SPECIALIZATIONS=1' \
	'-DCHROME_SYMBOLS_ID=""' \
	'-DANDROID_UPSTREAM_BRINGUP=1' \
	'-DDYNAMIC_ANNOTATIONS_ENABLED=1' \
	'-DWTF_USE_DYNAMIC_ANNOTATIONS=1' \
	'-D_DEBUG'

LOCAL_CFLAGS := $(MY_CFLAGS_C) $(MY_CFLAGS) $(MY_DEFS)

# Include paths placed before CFLAGS/CPPFLAGS
LOCAL_C_INCLUDES := \
	$(LOCAL_PATH) \
	$(gyp_intermediate_dir) \
	$(gyp_shared_intermediate_dir)/content \
	$(LOCAL_PATH)/third_party/khronos \
	$(gyp_shared_intermediate_dir)/protoc_out \
	$(LOCAL_PATH)/third_party/protobuf \
	$(LOCAL_PATH)/third_party/protobuf/src \
	$(LOCAL_PATH)/skia/config \
	$(LOCAL_PATH)/third_party/skia/src/core \
	$(LOCAL_PATH)/third_party/skia/include/config \
	$(LOCAL_PATH)/third_party/skia/include/core \
	$(LOCAL_PATH)/third_party/skia/include/effects \
	$(LOCAL_PATH)/third_party/skia/include/pdf \
	$(LOCAL_PATH)/third_party/skia/include/gpu \
	$(LOCAL_PATH)/third_party/skia/include/gpu/gl \
	$(LOCAL_PATH)/third_party/skia/include/pipe \
	$(LOCAL_PATH)/third_party/skia/include/ports \
	$(LOCAL_PATH)/third_party/skia/include/utils \
	$(LOCAL_PATH)/skia/ext \
	$(LOCAL_PATH)/third_party/harfbuzz/contrib \
	$(LOCAL_PATH)/third_party/harfbuzz/src \
	$(LOCAL_PATH)/third_party/zlib \
	$(GYP_ABS_ANDROID_TOP_DIR)/external/icu4c/common \
	$(GYP_ABS_ANDROID_TOP_DIR)/external/icu4c/i18n \
	$(gyp_shared_intermediate_dir)/ui/ui_resources \
	$(gyp_shared_intermediate_dir)/webkit \
	$(LOCAL_PATH)/third_party/WebKit/Source/Platform/chromium \
	$(gyp_shared_intermediate_dir)/webcore_headers \
	$(LOCAL_PATH)/third_party/npapi \
	$(LOCAL_PATH)/third_party/npapi/bindings \
	$(LOCAL_PATH)/v8/include \
	$(GYP_ABS_ANDROID_TOP_DIR)/frameworks/wilhelm/include \
	$(GYP_ABS_ANDROID_TOP_DIR)/bionic \
	$(GYP_ABS_ANDROID_TOP_DIR)/external/stlport/stlport

LOCAL_C_INCLUDES := $(GYP_COPIED_SOURCE_ORIGIN_DIRS) $(LOCAL_C_INCLUDES)

# Flags passed to only C++ (and not C) files.
LOCAL_CPPFLAGS := \
	-fno-rtti \
	-fno-threadsafe-statics \
	-fvisibility-inlines-hidden \
	-Wsign-compare \
	-Wno-abi \
	-Wno-error=c++0x-compat

### Rules for final target.

LOCAL_LDFLAGS := \
	-Wl,-z,noexecstack \
	-fPIC \
	-Wl,-z,relro \
	-Wl,-z,now \
	-fuse-ld=gold \
	-nostdlib \
	-Wl,--no-undefined \
	-Wl,--exclude-libs=ALL \
	-Wl,--icf=safe \
	-Wl,-O1 \
	-Wl,--as-needed \
	-Wl,--gc-sections


LOCAL_STATIC_LIBRARIES := \
	content_browser_speech_proto_speech_proto_gyp \
	skia_skia_gyp

# Enable grouping to fix circular references
LOCAL_GROUP_STATIC_LIBRARIES := true

LOCAL_SHARED_LIBRARIES := \
	libstlport \
	libdl

# Add target alias to "gyp_all_modules" target.
.PHONY: gyp_all_modules
gyp_all_modules: content_content_browser_gyp

# Alias gyp target name.
.PHONY: content_browser
content_browser: content_content_browser_gyp

include $(BUILD_STATIC_LIBRARY)
