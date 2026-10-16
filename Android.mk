LOCAL_PATH := $(call my-dir)
ifeq ($(TARGET_DEVICE),marble)
include $(call all-subdir-makefiles,$(LOCAL_PATH))
endif
