################################################################################
#
# Anbernic splash
#
################################################################################
ANBERNIC_SPLASH_VERSION = 2.0
ANBERNIC_SPLASH_SOURCE=

ANBERNIC_SPLASH_TGVERSION=$(ANBERNIC_SYSTEM_VERSION) $(ANBERNIC_SYSTEM_DATE_TIME)

ifeq ($(BR2_PACKAGE_ANBERNIC_SPLASH_OMXPLAYER),y)
	ANBERNIC_SPLASH_SCRIPT=S03splash-omx
	ANBERNIC_SPLASH_MEDIA=video
else ifeq ($(BR2_PACKAGE_ANBERNIC_SPLASH_FFPLAY),y)
	ANBERNIC_SPLASH_SCRIPT=S03splash-ffplay
	ANBERNIC_SPLASH_MEDIA=video
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_ODROIDGOA),y)
	ANBERNIC_SPLASH_SCRIPT=S03splash-image
	ANBERNIC_SPLASH_MEDIA=rotate-oga-image
else ifeq ($(BR2_PACKAGE_ANBERNIC_SPLASH_ROTATE_IMAGE),y)
	ANBERNIC_SPLASH_SCRIPT=S03splash-image
	ANBERNIC_SPLASH_MEDIA=rotate-image
else ifeq ($(BR2_PACKAGE_ANBERNIC_SPLASH_MPV),y)
	ANBERNIC_SPLASH_SCRIPT=S03splash-mpv
	ANBERNIC_SPLASH_MEDIA=video
else
	ANBERNIC_SPLASH_SCRIPT=S03splash-image
	ANBERNIC_SPLASH_MEDIA=image
endif

ANBERNIC_SPLASH_POST_INSTALL_TARGET_HOOKS += ANBERNIC_SPLASH_INSTALL_SCRIPT

ifeq ($(ANBERNIC_SPLASH_MEDIA),image)
	ANBERNIC_SPLASH_POST_INSTALL_TARGET_HOOKS += ANBERNIC_SPLASH_INSTALL_IMAGE
endif

ifeq ($(ANBERNIC_SPLASH_MEDIA),rotate-oga-image)
	ANBERNIC_SPLASH_POST_INSTALL_TARGET_HOOKS += ANBERNIC_SPLASH_INSTALL_ROTATE_OGA_IMAGE
endif

ifeq ($(ANBERNIC_SPLASH_MEDIA),rotate-image)
	ANBERNIC_SPLASH_POST_INSTALL_TARGET_HOOKS += ANBERNIC_SPLASH_INSTALL_ROTATE_IMAGE
endif

ifeq ($(ANBERNIC_SPLASH_MEDIA),video)
	ANBERNIC_SPLASH_POST_INSTALL_TARGET_HOOKS += ANBERNIC_SPLASH_INSTALL_VIDEO
endif

define ANBERNIC_SPLASH_INSTALL_SCRIPT
	mkdir -p $(TARGET_DIR)/etc/init.d
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-splash/S29splashscreencontrol	$(TARGET_DIR)/etc/init.d/ 
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-splash/$(ANBERNIC_SPLASH_SCRIPT)	$(TARGET_DIR)/etc/init.d/S03splash
endef

define ANBERNIC_SPLASH_INSTALL_VIDEO
	mkdir -p $(TARGET_DIR)/usr/share/anbernic/splash
	cp $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-splash/splash.mp4 $(TARGET_DIR)/usr/share/anbernic/splash
	cp $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-splash/splash_1280_720.mp4 $(TARGET_DIR)/usr/share/anbernic/splash
	cp $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-splash/logo_boot.png $(TARGET_DIR)/usr/share/anbernic/splash
	cp $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-splash/logo_hdmi.png $(TARGET_DIR)/usr/share/anbernic/splash
	echo -e "1\n00:00:00,000 --> 00:00:02,000\n$(ANBERNIC_SPLASH_TGVERSION)" > "${TARGET_DIR}/usr/share/anbernic/splash/splash.srt"
endef

define ANBERNIC_SPLASH_INSTALL_IMAGE
	mkdir -p $(TARGET_DIR)/usr/share/anbernic/splash
	convert "$(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-splash/logo.png" -fill white -pointsize 30 -annotate +50+1020 "$(ANBERNIC_SPLASH_TGVERSION)" "${TARGET_DIR}/usr/share/anbernic/splash/logo-version.png"
endef

define ANBERNIC_SPLASH_INSTALL_ROTATE_OGA_IMAGE
	mkdir -p $(TARGET_DIR)/usr/share/anbernic/splash
	convert "$(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-splash/logo.png" -shave 150x0 -resize 480x320 -fill white -pointsize 15 -annotate +40+300 "$(ANBERNIC_SPLASH_TGVERSION)" -rotate -90 "${TARGET_DIR}/usr/share/anbernic/splash/logo-version.png"
endef

define ANBERNIC_SPLASH_INSTALL_ROTATE_IMAGE
	mkdir -p $(TARGET_DIR)/usr/share/anbernic/splash
	convert "$(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-splash/logo.png" -fill white -pointsize 30 -annotate +50+1020 "$(ANBERNIC_SPLASH_TGVERSION)" -rotate -90 "${TARGET_DIR}/usr/share/anbernic/splash/logo-version.png"
endef

$(eval $(generic-package))
