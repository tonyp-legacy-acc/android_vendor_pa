# use AOSP default sounds
PRODUCT_PROPERTY_OVERRIDES += \
  ro.config.ringtone=Themos.ogg \
  ro.config.notification_sound=Proxima.ogg \
  ro.config.alarm_alert=Cesium.ogg

# Embed Superuser
SUPERUSER_EMBEDDED := true
SUPERUSER_PACKAGE_PREFIX := com.android.settings.cyanogenmod.superuser

# Replace CM files
PRODUCT_COPY_FILES += \
    vendor/pa/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/pa/prebuilt/common/apk/GooManager.apk:system/app/GooManager.apk \
    vendor/pa/prebuilt/common/apk/PDroid.apk:system/app/PDroid.apk \
    vendor/pa/prebuilt/common/apk/KowalskiManager.apk:system/app/KowalskiManager.apk \
    vendor/pa/prebuilt/common/apk/BarcodeScanner.apk:system/app/BarcodeScanner.apk \
    vendor/pa/prebuilt/common/apk/Syslog.apk:system/app/Syslog.apk \
    vendor/pa/prebuilt/common/etc/init.d/95kowalski:system/etc/init.d/95kowalski \
    vendor/pa/prebuilt/common/xbin/alsa_amixer:system/xbin/alsa_amixer \
    vendor/pa/prebuilt/common/xbin/iwconfig:system/xbin/iwconfig \
    vendor/pa/prebuilt/common/xbin/iwlist:system/xbin/iwlist

# Exclude prebuilt paprefs from builds if the flag is set
ifneq ($(PREFS_FROM_SOURCE),true)
    PRODUCT_COPY_FILES += \
        vendor/pa/prebuilt/common/apk/ParanoidPreferences.apk:system/app/ParanoidPreferences.apk
else
    # Build paprefs from sources
    PRODUCT_PACKAGES += \
        ParanoidPreferences
endif

PRODUCT_PACKAGES += \
    PerformanceControl

ifneq ($(PARANOID_BOOTANIMATION_NAME),)
    PRODUCT_COPY_FILES += \
        vendor/pa/prebuilt/common/bootanimation/$(PARANOID_BOOTANIMATION_NAME).zip:system/media/bootanimation.zip
else
    PRODUCT_COPY_FILES += \
        vendor/pa/prebuilt/common/bootanimation/HDPI.zip:system/media/bootanimation.zip
endif

# ParanoidAndroid common packages
PRODUCT_PACKAGES += \
    ParanoidWallpapers

# device common prebuilts
ifneq ($(DEVICE_COMMON),)
    -include vendor/pa/prebuilt/$(DEVICE_COMMON)/prebuilt.mk
endif

# device specific prebuilts
-include vendor/pa/prebuilt/$(TARGET_PRODUCT)/prebuilt.mk

BOARD := $(subst pa_,,$(TARGET_PRODUCT))

# ParanoidAndroid Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/pa/overlay/common
PRODUCT_PACKAGE_OVERLAYS += vendor/pa/overlay/$(TARGET_PRODUCT)

# Allow device family to add overlays and use a same prop.conf
ifneq ($(OVERLAY_TARGET),)
    PRODUCT_PACKAGE_OVERLAYS += vendor/pa/overlay/$(OVERLAY_TARGET)
    PA_CONF_SOURCE := $(OVERLAY_TARGET)
else
    PA_CONF_SOURCE := $(TARGET_PRODUCT)
endif

PRODUCT_COPY_FILES += \
    vendor/pa/prebuilt/$(PA_CONF_SOURCE).conf:system/etc/paranoid/properties.conf \
    vendor/pa/prebuilt/$(PA_CONF_SOURCE).conf:system/etc/paranoid/backup.conf \
    vendor/pa/prebuilt/55-tonyp.sh:system/addon.d/55-tonyp.sh

# Add CM release version
CM_RELEASE := true
CM_BUILD := $(BOARD)

PA_VERSION_MAJOR = 2
PA_VERSION_MINOR = 6
TONYP_BUILD_NR = 13

TARGET_CUSTOM_RELEASETOOL := vendor/pa/tools/squisher

TONYP_VERSION := tonyp
TONYP_ANDROID := JB
VERSION := $(PA_VERSION_MAJOR).$(PA_VERSION_MINOR)
PA_VERSION := $(TARGET_PRODUCT)-$(VERSION)-$(TONYP_BUILD_NR)-$(shell date +%Y%m%d-%H%M%S)-$(TONYP_VERSION)

PRODUCT_PROPERTY_OVERRIDES += \
  ro.modversion=$(PA_VERSION) \
  ro.pa.family=$(PA_CONF_SOURCE) \
  ro.pa.build=$(TARGET_PRODUCT)-$(VERSION)-$(TONYP_BUILD_NR) \
  ro.pa.version=$(VERSION)-$(TONYP_BUILD_NR)-$(TONYP_VERSION)

PRODUCT_PROPERTY_OVERRIDES += \
  ro.goo.developerid=tonyp \
  ro.goo.board=$(BOARD) \
  ro.goo.version=$(shell date +%s)
