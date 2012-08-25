# ParanoidAndroid
PRODUCT_COPY_FILES += \
    vendor/pa/prebuilt/$(TARGET_PRODUCT)-pad.prop:system/pad.prop

# Replace CM9 files
PRODUCT_COPY_FILES += \
    vendor/pa/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh
		
# tonyp: add init.d scripts
PRODUCT_COPY_FILES += \
    vendor/pa/prebuilt/common/etc/init.d/99tune:system/etc/init.d/99tune \
	vendor/pa/prebuilt/common/etc/init.d/05tonyp:system/etc/init.d/05tonyp 

# tonyp: add JBTheme
PRODUCT_COPY_FILES += \
	vendor/pa/prebuilt/common/apps/cm9.theme.JBstock.apk:system/app/cm9.theme.JBstock.apk 	
	
# tonyp: set JBTheme as default
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	persist.sys.themeId=JBstock \
	persist.sys.themePackageName=cm9.theme.JBstock

ifneq ($(PARANOID_BOOTANIMATION_NAME),)
    PRODUCT_COPY_FILES += \
        vendor/pa/prebuilt/common/bootanimation/$(PARANOID_BOOTANIMATION_NAME).zip:system/media/bootanimation.zip
else
    PRODUCT_COPY_FILES += \
        vendor/pa/prebuilt/common/bootanimation/HDPI.zip:system/media/bootanimation.zip
endif
    
# ParanoidAndroid Packages
PRODUCT_PACKAGES += \
     ParanoidBackup

# ParanoidAndroid Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/pa/overlay/common
PRODUCT_PACKAGE_OVERLAYS += vendor/pa/overlay/$(TARGET_PRODUCT)

PA_VERSION_MAJOR = 1
PA_VERSION_MINOR = 6
PA_VERSION_MAINTENANCE = a

TARGET_CUSTOM_RELEASETOOL := vendor/pa/tools/squisher

CM_VERSION := PARANOIDANDROID
PA_VERSION := $(CM_VERSION)-$(TARGET_PRODUCT)-$(PA_VERSION_MAJOR).$(PA_VERSION_MINOR)$(PA_VERSION_MAINTENANCE)-$(shell date +%0d%^b%Y-%H%M%S)

PRODUCT_PROPERTY_OVERRIDES += \
  ro.pa.version=$(PA_VERSION)
# ro.cm.version=$(CM_VERSION)

# GooManager setup
PRODUCT_PROPERTY_OVERRIDES += \
    ro.goo.developerid=tonyp \
	ro.goo.rom=ParanoidAndroid-ICS-$(TARGET_PRODUCT) \
	ro.goo.version=$(shell date +%s)
