#######################################################
## Shared definitions for all target test compilations.
#######################################################

LOCAL_CFLAGS += -DGTEST_OS_LINUX_ANDROID -DGTEST_HAS_STD_STRING

ifndef LOCAL_SDK_VERSION
    LOCAL_STATIC_LIBRARIES += libgtest_main libgtest
else
    ifneq (,$(filter c++_%,$(LOCAL_NDK_STL_VARIANT)))
        my_ndk_gtest_suffix := _libcxx
    else ifneq ($(filter stlport_,$(LOCAL_NDK_STL_VARIANT)),)
        my_ndk_gtest_suffix :=
    else ifneq ($(filter gnustl_,$(LOCAL_NDK_STL_VARIANT)),)
        my_ndk_gtest_suffix := _gnustl
    else # system STL, use stlport
        my_ndk_gtest_suffix :=
    endif
    LOCAL_STATIC_LIBRARIES += \
        libgtest_main_ndk$(my_ndk_gtest_suffix) \
        libgtest_ndk$(my_ndk_gtest_suffix)
endif

ifdef LOCAL_MODULE_PATH
$(error $(LOCAL_PATH): Do not set LOCAL_MODULE_PATH when building test $(LOCAL_MODULE))
endif

ifdef LOCAL_MODULE_PATH_32
$(error $(LOCAL_PATH): Do not set LOCAL_MODULE_PATH_32 when building test $(LOCAL_MODULE))
endif

ifdef LOCAL_MODULE_PATH_64
$(error $(LOCAL_PATH): Do not set LOCAL_MODULE_PATH_64 when building test $(LOCAL_MODULE))
endif

LOCAL_MODULE_PATH_64 := $(TARGET_OUT_DATA_NATIVE_TESTS)/$(LOCAL_MODULE)
LOCAL_MODULE_PATH_32 := $($(TARGET_2ND_ARCH_VAR_PREFIX)TARGET_OUT_DATA_NATIVE_TESTS)/$(LOCAL_MODULE)
