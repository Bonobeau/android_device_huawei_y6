#
# Copyright (C) 2015 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# config.mk
#
# Product-specific compile-time definitions.
#

LOCAL_PATH := device/huawei/y6

# Assert
TARGET_OTA_ASSERT_DEVICE := Honor4a,honor4a,Honor4A,honor4A,y6,Y6

# Platform
TARGET_BOARD_PLATFORM := msm8909
TARGET_BOARD_PLATFORM_GPU := qcom-adreno304
#add suffix variable to uniquely identify the board
TARGET_BOARD_SUFFIX := _32

# Bootloader
TARGET_NO_BOOTLOADER := true
TARGET_BOOTLOADER_BOARD_NAME := msm8909

# Architecture
TARGET_ARCH := arm
TARGET_GLOBAL_CFLAGS += -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mfpu=neon -mfloat-abi=softfp
TARGET_CPU_ABI  := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := cortex-a7
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_SMP := true
ARCH_ARM_HAVE_TLS_REGISTER := true

# ANT+
BOARD_ANT_WIRELESS_DEVICE := "vfs-prerelease"

# Audio
AUDIO_FEATURE_DEEP_BUFFER_RINGTONE := true
AUDIO_FEATURE_ENABLED_KPI_OPTIMIZE := true
AUDIO_FEATURE_LOW_LATENCY_PRIMARY := true
AUDIO_FEATURE_ENABLED_FLAC_OFFLOAD := false
BOARD_USES_ALSA_AUDIO := true
AUDIO_FEATURE_ENABLED_DS2_DOLBY_DAP := true
AUDIO_FEATURE_ENABLED_ACDB_LICENSE := true
BOARD_SUPPORTS_SOUND_TRIGGER := true
AUDIO_FEATURE_ENABLED_ANC_HEADSET := true
AUDIO_FEATURE_ENABLED_COMPRESS_CAPTURE := true
AUDIO_FEATURE_ENABLED_SSR := true
BOARD_USES_SRS_TRUEMEDIA := true
AUDIO_FEATURE_ENABLED_PM_SUPPORT := true

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_QCOM := true
BLUETOOTH_HCI_USE_MCT := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(LOCAL_PATH)/bluetooth

# Camera
USE_DEVICE_SPECIFIC_CAMERA := true
BOARD_USES_LEGACY_MMAP := true
TARGET_USE_VENDOR_CAMERA_EXT := true

# Charger
BOARD_CHARGER_ENABLE_SUSPEND := true
BOARD_CHARGER_SHOW_PERCENTAGE := true

# CMHW
BOARD_HARDWARE_CLASS := \
    device/huawei/y6/cmhw

# Enables CSVT
TARGET_USES_CSVT := true

#Enable HW based full disk encryption
TARGET_HW_DISK_ENCRYPTION := true

# FM
AUDIO_FEATURE_ENABLED_FM := true
TARGET_QCOM_NO_FM_FIRMWARE := true

# Fonts
EXTENDED_FONT_FOOTPRINT := true

# GPS
TARGET_NO_RPC := true
TARGET_GPS_HAL_PATH := $(LOCAL_PATH)/gps

# Graphics
BOARD_EGL_CFG := $(LOCAL_PATH)/egl.cfg
TARGET_USES_OVERLAY := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
TARGET_HARDWARE_3D := false
OVERRIDE_RS_DRIVER := libRSDriver_adreno.so
MAX_EGL_CACHE_KEY_SIZE := 12*1024
MAX_EGL_CACHE_SIZE := 2048*1024
TARGET_USES_ION := true
TARGET_USES_NEW_ION_API :=true
TARGET_CONTINUOUS_SPLASH_ENABLED := true
TARGET_USES_C2D_COMPOSITION := true
USE_OPENGL_RENDERER := true

# Init
TARGET_INIT_VENDOR_LIB := libinit_msm
TARGET_PLATFORM_DEVICE_BASE := /devices/soc.0/
TARGET_LIBINIT_DEFINES_FILE := $(LOCAL_PATH)/init/init_y6.c

# Kernel
BOARD_KERNEL_BASE        := 0x80000000
BOARD_KERNEL_PAGESIZE    := 2048
BOARD_KERNEL_TAGS_OFFSET := 0x01E00000
BOARD_RAMDISK_OFFSET     := 0x02000000
BOARD_KERNEL_CMDLINE := console=ttyHSL0,115200,n8 androidboot.console=ttyHSL0 androidboot.hardware=qcom user_debug=30 msm_rtb.filter=0x3F ehci-hcd.park=3 androidboot.bootdevice=7824900.sdhci lpm_levels.sleep_disabled=1 androidboot.selinux=permissive
BOARD_KERNEL_SEPARATED_DT := true
TARGET_KERNEL_SOURCE := kernel/huawei/msm8909
TARGET_KERNEL_CONFIG := rel_defconfig
BOARD_CUSTOM_BOOTIMG_MK := $(LOCAL_PATH)/mkbootimg.mk

# Lights
TARGET_PROVIDES_LIBLIGHT := true

# Logging
TARGET_USES_LOGD := false

# Partitions
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x01400000 # (20M)
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x01900000 # (25M)
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1288491008
BOARD_USERDATAIMAGE_PARTITION_SIZE := 1860648960
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_PERSISTIMAGE_PARTITION_SIZE := 33554432
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)

# Power
TARGET_POWERHAL_VARIANT := qcom

# Qualcomm support
BOARD_USES_QCOM_HARDWARE := true

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := "RGBA_8888"
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/recovery.fstab

# Ril
TARGET_RIL_VARIANT := caf

# Added to indicate that protobuf-c is supported in this build
PROTOBUF_SUPPORTED := true

# SELinux
include device/qcom/sepolicy/sepolicy.mk

BOARD_SEPOLICY_DIRS += \
    device/huawei/y6/sepolicy

BOARD_SEPOLICY_UNION += \
    bootanim.te \
    diag.te \
    file.te \
    file_contexts \
    init.te \
    mm-qcamerad.te \
    mpdecision.te \
    netd.te \
    sdcardd.te \
    system_server.te
 
# Time services
BOARD_USES_QC_TIME_SERVICES := true

#Use dlmalloc instead of jemalloc for mallocs
MALLOC_IMPL := dlmalloc

# Vold
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/platform/msm_hsusb/gadget/lun%d/file
BOARD_VOLD_DISC_HAS_MULTIPLE_MAJORS := true
BOARD_VOLD_MAX_PARTITIONS := 65

# Wifi
WIFI_DRIVER_MODULE_PATH := /system/lib/modules/wlan.ko
WIFI_DRIVER_MODULE_NAME:= wlan
BOARD_HAS_QCOM_WLAN := true
BOARD_HAS_QCOM_WLAN_SDK := true
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_qcwcn
BOARD_WLAN_DEVICE := qcwcn
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_qcwcn
TARGET_USES_WCNSS_CTRL := true
WIFI_DRIVER_FW_PATH_AP := "ap"
WIFI_DRIVER_FW_PATH_STA := "sta"
WPA_SUPPLICANT_VERSION := VER_0_8_X

# TWRP
#RECOVERY_VARIANT := twrp
TW_THEME := portrait_hdpi
BOARD_HAS_NO_REAL_SDCARD := true
RECOVERY_GRAPHICS_USE_LINELENGTH := true
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_DEVICE_DIRS += device/huawei/y6
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness
TW_INCLUDE_CRYPTO := true
TW_NO_SCREEN_TIMEOUT := true

PRIMA_ROOT := vendor/qcom/opensource/wlan/prima
PRIMA_MODULE:
	$(hide) mkdir -p $(KERNEL_OUT)/$(PRIMA_ROOT)
	$(hide) cp -f $(PRIMA_ROOT)/Kbuild $(KERNEL_OUT)/$(PRIMA_ROOT)/Makefile
	$(hide) cp -rf $(PRIMA_ROOT)/CORE $(KERNEL_OUT)/$(PRIMA_ROOT)/CORE
	$(hide) cp -rf $(PRIMA_ROOT)/riva $(KERNEL_OUT)/$(PRIMA_ROOT)/riva
	$(hide) $(MAKE) $(MAKE_FLAGS) -C $(KERNEL_OUT) M=$(KERNEL_OUT)/$(PRIMA_ROOT) ARCH=$(TARGET_ARCH) $(KERNEL_CROSS_COMPILE) MODNAME=wlan CONFIG_PRONTO_WLAN=m WLAN_ROOT=$(PRIMA_ROOT) modules
	$(hide) arm-eabi-strip --strip-debug $(KERNEL_OUT)/$(PRIMA_ROOT)/wlan.ko
	$(hide) mkdir -p $(KERNEL_MODULES_OUT)/pronto
	$(hide) cp -f $(KERNEL_OUT)/$(PRIMA_ROOT)/wlan.ko $(KERNEL_MODULES_OUT)/pronto/pronto_wlan.ko
	$(hide) if [ -L $(KERNEL_MODULES_OUT)/wlan.ko ]; then rm $(KERNEL_MODULES_OUT)/wlan.ko; fi
	$(hide) ln -s /system/lib/modules/pronto/pronto_wlan.ko  $(KERNEL_MODULES_OUT)/wlan.ko
TARGET_KERNEL_MODULES += PRIMA_MODULE

CORE_CTL_MODULE:
	$(hide) cp -rf $(LOCAL_PATH)/core_ctl.ko $(KERNEL_MODULES_OUT)/
TARGET_KERNEL_MODULES +=  CORE_CTL_MODULE


# inherit from the proprietary version
-include vendor/huawei/y6/BoardConfigVendor.mk
