# AERA Recovery — Xiaomi marble (POCO F5 / Redmi Note 12 Turbo)

Device tree port of [AERA Recovery](https://aera-recovery.com) (aera-16.0, Android 16)
to **marble** (SM7475 / ukee).

## Build

```bash
export AERA_BUILD_DEVICE=marble
source build/envsetup.sh
lunch twrp_marble-bp2a-eng
mka adbd recoveryimage
```

The tree must be cloned to `device/xiaomi/marble` (it is not part of the
public AERA manifest).

## Origin / credits

- Structure follows `AERA-Recovery/android_device_xiaomi_peridot-AERA` (aera-16.0).
- Device-specific recovery content transplanted from
  `Ctapchuk/android_device_xiaomi_marble-OFRP` (fox_16.0, OrangeFox, GPL-3.0):
  prebuilt kernel (`prebuilt/kernel`, a.k.a. kernel-melt), `recovery/root/`
  (init rc, vendor libs, keystore/display/vibrator components, modules, firmware),
  `recovery.fstab`, `vendor.prop`.
- Board values cross-checked against LineageOS `device/xiaomi/marble` +
  `device/xiaomi/sm8450-common` (lineage-24.0) and
  `AviderMin/ofrp_device_xiaomi_marble` (fox_12.1).

## Status

- [x] Skeleton (makefiles + transplanted content)
- [x] First build (`mka adbd recoveryimage`, 2026-10-16, 8m01s): `AERA-R1.0-Beta-Unofficial-marble.img` (100MiB) + signed zip
- [ ] Flash & device test
- [ ] TBD: GPU userspace libs / flashlight daemon / WLAN modules / board-info
