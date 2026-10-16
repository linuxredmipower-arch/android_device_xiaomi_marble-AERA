#
#	This file is part of the AERA Recovery Project
#	(adapted from the AERA peridot tree vendorsetup.sh)
#
FDEVICE="marble"

aera_get_target_device() {
	export script_path="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
	if echo "$script_path" | grep -q "$FDEVICE"; then
		AERA_BUILD_DEVICE="$FDEVICE"
	elif echo "$0" | grep -q "$FDEVICE"; then
		AERA_BUILD_DEVICE="$FDEVICE"
	fi
}

if [ -z "$AERA_BUILD_DEVICE" ]; then
	aera_get_target_device
fi

if [ "$AERA_BUILD_DEVICE" = "$FDEVICE" ]; then
	echo "Detected build device: $AERA_BUILD_DEVICE"

	# AERA device build settings
	export AERA_BUILD_STATUS=Unofficial
	export AERA_BUILD_TYPE=Beta

	# A/B (virtual A/B with dedicated recovery partition)
	export AERA_VIRTUAL_AB_DEVICE=1
	export AERA_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
	export AERA_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"

	# Compression binaries & tools
	export AERA_USE_BASH_SHELL=1
	export AERA_USE_NANO_EDITOR=1
	export AERA_USE_TAR_BINARY=1
	export AERA_USE_LZ4_BINARY=1
	export AERA_USE_SED_BINARY=1
	export AERA_USE_XZ_UTILS=1
	export AERA_USE_ZSTD_BINARY=1
	export AERA_DELETE_AROMAFM=1
	export AERA_REMOVE_AAPT=1
	export AERA_USE_BUSYBOX_BINARY=1
	export AERA_USE_GREP_BINARY=1

	# Root manager
	export AERA_DELETE_MAGISK_ADDON=1
	export AERA_MOVE_MAGISK_INSTALLER_TO_RAMDISK=1
	export AERA_ENABLE_ROOT_MANAGER=1

	# AERA settings
	export AERA_SETTINGS_ROOT_DIRECTORY="/persist"
	unset AERA_VARIANT
	unset AERA_MAINTAINER_PATCH_VERSION
	export AERA_ALLOW_EARLY_SETTINGS_LOAD=1
	export AERA_RESET_SETTINGS="disabled"
else
	echo "I: vendorsetup.sh skipped; device mismatch or environment issue."
fi
