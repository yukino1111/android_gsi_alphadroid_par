ifeq ($(TARGET_ARCH),arm64)

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := PARSystemWebView
LOCAL_MODULE_CLASS := APPS
LOCAL_PRODUCT_MODULE := true
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_SDK_VERSION := 30
LOCAL_MULTILIB := 64
LOCAL_REQUIRED_MODULES := \
    libwebviewchromium_loader \
    libwebviewchromium_plat_support
LOCAL_PREBUILT_JNI_LIBS_arm64 := \
    @lib/arm64-v8a/libwebviewchromium.so \
    @lib/arm64-v8a/libcrashpad_handler_trampoline.so
LOCAL_OVERRIDES_PACKAGES := webview
LOCAL_MODULE_TARGET_ARCH := arm64
LOCAL_SRC_FILES := arm64_SystemWebView.apk
LOCAL_DEX_PREOPT := false
LOCAL_ENFORCE_USES_LIBRARIES := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := PARChromium
LOCAL_MODULE_CLASS := APPS
LOCAL_PRODUCT_MODULE := true
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_SDK_VERSION := 30
LOCAL_MULTILIB := 64
LOCAL_PREBUILT_JNI_LIBS_arm64 := \
    @lib/arm64-v8a/libchrome.so \
    @lib/arm64-v8a/libchrome_crashpad_handler.so \
    @lib/arm64-v8a/libimpress_api_jni.so \
    @lib/arm64-v8a/libandroidx.xr.runtime.openxr.so \
    @lib/arm64-v8a/libarcore_sdk_c.so \
    @lib/arm64-v8a/libarcore_sdk_jni.so
LOCAL_OVERRIDES_PACKAGES := Browser2 QuickSearchBox
LOCAL_MODULE_TARGET_ARCH := arm64
LOCAL_SRC_FILES := arm64_VanillaChromium.apk
# Cromite intentionally compresses its crashpad handler. The APK is already
# aligned, signed and device-validated, so install the release asset verbatim
# instead of making the generic prebuilt rule rewrite its ZIP layout.
LOCAL_REPLACE_PREBUILT_APK_INSTALLED := $(LOCAL_PATH)/arm64_VanillaChromium.apk
LOCAL_DEX_PREOPT := false
LOCAL_ENFORCE_USES_LIBRARIES := false
include $(BUILD_PREBUILT)

endif
