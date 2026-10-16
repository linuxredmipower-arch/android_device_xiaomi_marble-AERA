#
# Copyright (C) 2026 The AERA Recovery Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/marble

# Inherit from common AOSP config
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression_with_xor.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# AERA recovery config
$(call inherit-product, vendor/twrp/config/common.mk)
$(call inherit-product, $(DEVICE_PATH)/aera_marble.mk)

# Platform (marble = SM7475 / ukee)
QCOM_BOARD_PLATFORMS += $(PRODUCT_PLATFORM)
TARGET_BOARD_PLATFORM := $(PRODUCT_PLATFORM)
TARGET_BOOTLOADER_BOARD_NAME := $(TARGET_BOARD_PLATFORM)

# A/B support
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += boot vendor_boot recovery vendor_dlkm dtbo vbmeta super

# Shipping API (marble shipped Android 13)
PRODUCT_SHIPPING_API_LEVEL := 32
BOARD_SHIPPING_API_LEVEL := 31
SHIPPING_API_LEVEL := 31

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# VNDK
PRODUCT_TARGET_VNDK_VERSION := 31

# A/B packages (from the proven OrangeFox marble tree)
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_client \
    update_verifier \
    update_engine_sideload \
    android.hardware.boot@1.2-impl-qti \
    android.hardware.boot@1.2-impl-qti.recovery \
    android.hardware.boot@1.2-service \
    checkpoint_gc

# fastbootd
PRODUCT_PACKAGES += fastbootd
PRODUCT_PACKAGES += android.hardware.fastboot@1.1-impl-mock

# qcom decryption
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# f2fs utilities
PRODUCT_PACKAGES += \
    sg_write_buffer \
    f2fs_io \
    check_f2fs

# Properties
PRODUCT_VENDOR_PROPERTIES += ro.hardware.egl=adreno
PRODUCT_SOONG_NAMESPACES += $(DEVICE_PATH)

# Emulated storage fuse passthrough
PRODUCT_PRODUCT_PROPERTIES += persist.sys.fuse.passthrough.enable=true

# OEM otacert
PRODUCT_EXTRA_RECOVERY_KEYS += $(DEVICE_PATH)/security/otacert

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true
