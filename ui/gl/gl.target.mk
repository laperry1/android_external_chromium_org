# This file is generated by gyp; do not edit.

include $(CLEAR_VARS)

LOCAL_MODULE_CLASS := STATIC_LIBRARIES
LOCAL_MODULE := ui_gl_gl_gyp
LOCAL_MODULE_SUFFIX := .a
LOCAL_MODULE_TAGS := optional
gyp_intermediate_dir := $(call local-intermediates-dir)
gyp_shared_intermediate_dir := $(call intermediates-dir-for,GYP,shared)

# Make sure our deps are built first.
GYP_TARGET_DEPENDENCIES := \
	$(call intermediates-dir-for,STATIC_LIBRARIES,skia_skia_gyp)/skia_skia_gyp.a

### Rules for action "generate_gl_bindings":
$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_egl.cc: gyp_local_path := $(LOCAL_PATH)
$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_egl.cc: gyp_intermediate_dir := $(GYP_ABS_ANDROID_TOP_DIR)/$(gyp_intermediate_dir)
$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_egl.cc: gyp_shared_intermediate_dir := $(GYP_ABS_ANDROID_TOP_DIR)/$(gyp_shared_intermediate_dir)
$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_egl.cc: $(LOCAL_PATH)/ui/gl/generate_bindings.py $(LOCAL_PATH)/third_party/khronos/GLES2/gl2ext.h $(LOCAL_PATH)/third_party/khronos/EGL/eglext.h $(LOCAL_PATH)/third_party/mesa/MesaLib/include/GL/glext.h $(LOCAL_PATH)/third_party/mesa/MesaLib/include/GL/glx.h $(LOCAL_PATH)/third_party/mesa/MesaLib/include/GL/glxext.h $(LOCAL_PATH)/third_party/mesa/MesaLib/include/GL/wglext.h $(GYP_TARGET_DEPENDENCIES)
	@echo "Gyp action: _usr_local_google_code_clank_master_ab_external_chromium_org_ui_gl_gl_gyp_gl_target_generate_gl_bindings ($@)"
	$(hide)cd $(gyp_local_path)/ui/gl; mkdir -p $(gyp_shared_intermediate_dir)/ui/gl; python generate_bindings.py "$(gyp_shared_intermediate_dir)/ui/gl"

$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_egl.h: $(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_egl.cc ;
$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_api_autogen_egl.h: $(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_egl.cc ;
$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_gl.cc: $(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_egl.cc ;
$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_gl.h: $(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_egl.cc ;
$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_api_autogen_gl.h: $(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_egl.cc ;
$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_glx.cc: $(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_egl.cc ;
$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_glx.h: $(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_egl.cc ;
$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_api_autogen_glx.h: $(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_egl.cc ;
$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_mock.cc: $(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_egl.cc ;
$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_osmesa.cc: $(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_egl.cc ;
$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_osmesa.h: $(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_egl.cc ;
$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_api_autogen_osmesa.h: $(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_egl.cc ;
$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_wgl.cc: $(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_egl.cc ;
$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_wgl.h: $(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_egl.cc ;
$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_api_autogen_wgl.h: $(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_egl.cc ;


GYP_GENERATED_OUTPUTS := \
	$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_egl.cc \
	$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_egl.h \
	$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_api_autogen_egl.h \
	$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_gl.cc \
	$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_gl.h \
	$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_api_autogen_gl.h \
	$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_glx.cc \
	$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_glx.h \
	$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_api_autogen_glx.h \
	$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_mock.cc \
	$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_osmesa.cc \
	$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_osmesa.h \
	$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_api_autogen_osmesa.h \
	$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_wgl.cc \
	$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_wgl.h \
	$(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_api_autogen_wgl.h

# Make sure our deps and generated files are built first.
LOCAL_ADDITIONAL_DEPENDENCIES := $(GYP_TARGET_DEPENDENCIES) $(GYP_GENERATED_OUTPUTS)

LOCAL_CPP_EXTENSION := .cc
$(gyp_intermediate_dir)/gl_bindings_autogen_gl.cc: $(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_gl.cc
	mkdir -p $(@D); cp $< $@
$(gyp_intermediate_dir)/gl_bindings_autogen_mock.cc: $(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_mock.cc
	mkdir -p $(@D); cp $< $@
$(gyp_intermediate_dir)/gl_bindings_autogen_osmesa.cc: $(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_osmesa.cc
	mkdir -p $(@D); cp $< $@
$(gyp_intermediate_dir)/gl_bindings_autogen_egl.cc: $(gyp_shared_intermediate_dir)/ui/gl/gl_bindings_autogen_egl.cc
	mkdir -p $(@D); cp $< $@
LOCAL_GENERATED_SOURCES := \
	$(gyp_intermediate_dir)/gl_bindings_autogen_gl.cc \
	$(gyp_intermediate_dir)/gl_bindings_autogen_mock.cc \
	$(gyp_intermediate_dir)/gl_bindings_autogen_osmesa.cc \
	$(gyp_intermediate_dir)/gl_bindings_autogen_egl.cc

GYP_COPIED_SOURCE_ORIGIN_DIRS := \
	$(gyp_shared_intermediate_dir)/ui/gl

LOCAL_SRC_FILES := \
	ui/gl/gl_bindings_skia_in_process.cc \
	ui/gl/gl_context.cc \
	ui/gl/gl_context_android.cc \
	ui/gl/gl_context_stub.cc \
	ui/gl/gl_fence.cc \
	ui/gl/gl_gl_api_implementation.cc \
	ui/gl/gl_image.cc \
	ui/gl/gl_image_android.cc \
	ui/gl/gl_image_stub.cc \
	ui/gl/gl_implementation.cc \
	ui/gl/gl_implementation_android.cc \
	ui/gl/gl_interface.cc \
	ui/gl/gl_osmesa_api_implementation.cc \
	ui/gl/gl_share_group.cc \
	ui/gl/gl_state_restorer.cc \
	ui/gl/gl_surface.cc \
	ui/gl/gl_surface_android.cc \
	ui/gl/gl_surface_stub.cc \
	ui/gl/gl_surface_osmesa.cc \
	ui/gl/gl_switches.cc \
	ui/gl/gpu_switching_manager.cc \
	ui/gl/scoped_make_current.cc \
	ui/gl/egl_util.cc \
	ui/gl/gl_context_egl.cc \
	ui/gl/gl_surface_egl.cc \
	ui/gl/gl_egl_api_implementation.cc \
	ui/gl/android_native_window.cc


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
	'-DGL_IMPLEMENTATION' \
	'-DGL_GLEXT_PROTOTYPES' \
	'-DEGL_EGLEXT_PROTOTYPES' \
	'-DSK_BUILD_NO_IMAGE_ENCODE' \
	'-DSK_DEFERRED_CANVAS_USES_GPIPE=1' \
	'-DGR_GL_CUSTOM_SETUP_HEADER="GrGLConfig_chrome.h"' \
	'-DGR_AGGRESSIVE_SHADER_OPTS=1' \
	'-DSK_USE_POSIX_THREADS' \
	'-DSK_BUILD_FOR_ANDROID_NDK' \
	'-DPOSIX_AVOID_MMAP' \
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
	$(LOCAL_PATH)/third_party/swiftshader/include \
	$(LOCAL_PATH)/third_party/mesa/MesaLib/include \
	$(gyp_shared_intermediate_dir)/ui/gl \
	$(LOCAL_PATH)/third_party/angle/include \
	$(LOCAL_PATH)/third_party/khronos \
	$(LOCAL_PATH) \
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
	$(GYP_ABS_ANDROID_TOP_DIR)/external/icu4c/common \
	$(GYP_ABS_ANDROID_TOP_DIR)/external/icu4c/i18n \
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
	skia_skia_gyp

# Enable grouping to fix circular references
LOCAL_GROUP_STATIC_LIBRARIES := true

LOCAL_SHARED_LIBRARIES := \
	libstlport \
	libdl

# Add target alias to "gyp_all_modules" target.
.PHONY: gyp_all_modules
gyp_all_modules: ui_gl_gl_gyp

# Alias gyp target name.
.PHONY: gl
gl: ui_gl_gl_gyp

include $(BUILD_STATIC_LIBRARY)
