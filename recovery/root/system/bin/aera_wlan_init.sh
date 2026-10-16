#!/system/bin/sh
# AERA WLAN bring-up helper — marble (QCA6490 / cnss2)
# Called by init.recovery.wifi.rc after the post-decrypt trigger.

LOG=/dev/kmsg

echo "[wlan] aera_wlan_init: start" > $LOG

# 1) mount the firmware partition (modem) so the WLAN firmware files are available
mkdir -p /firmware
if [ ! -e /firmware/image/qca6490/amss20.bin ]; then
        for m in /dev/block/bootdevice/by-name/modem /dev/block/bootdevice/by-name/modem_a /dev/block/bootdevice/by-name/modem_b; do
                mount -t vfat -o ro $m /firmware 2>/dev/null && break
        done
fi
if [ -e /firmware/image/qca6490/amss20.bin ]; then
        echo "[wlan] firmware partition mounted" > $LOG
else
        echo "[wlan] firmware partition NOT mounted" > $LOG
fi

# 2) load the QCA6490 WLAN driver module (staged by the AERA module loader,
#    with fallbacks to the recovery's vendor module copies)
if ! lsmod | grep -q qca_cld3_qca6490; then
        for p in /tmp/post_decrypt_modules/qca_cld3_qca6490.ko /tmp/vendor/lib/modules/qca_cld3_qca6490.ko /vendor/lib/modules/qca_cld3_qca6490.ko; do
                if [ -e $p ]; then
                        if insmod $p; then
                                echo "[wlan] insmod ok: $p" > $LOG
                                break
                        else
                                echo "[wlan] insmod failed: $p" > $LOG
                        fi
                fi
        done
else
        echo "[wlan] qca_cld3 already loaded" > $LOG
fi

# 3) kick the cnss2 cold-boot-calibration / firmware boot
echo 1 > /sys/kernel/cnss/fs_ready && echo "[wlan] fs_ready written" > $LOG

exit 0
