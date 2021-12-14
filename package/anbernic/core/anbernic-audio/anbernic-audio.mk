################################################################################
#
# ANBERNIC AUDIO
#
################################################################################

ANBERNIC_AUDIO_VERSION = 4.2
ANBERNIC_AUDIO_LICENSE = GPL
ANBERNIC_AUDIO_DEPENDENCIES = alsa-lib
ANBERNIC_AUDIO_SOURCE=
ANBERNIC_AUDIO_DEPENDENCIES += alsa-plugins

ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_RPI_ANY),y)
ALSA_SUFFIX = "-rpi"
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_ODROIDGOA),y)
ALSA_SUFFIX = "-odroidga"
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_ROCKPRO64),y)
ALSA_SUFFIX = "-rockpro64"
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_VIM3),y)
ALSA_SUFFIX = "-vim3"
else
ALSA_SUFFIX = 
endif

define ANBERNIC_AUDIO_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib/python2.7 $(TARGET_DIR)/usr/bin $(TARGET_DIR)/usr/share/sounds $(TARGET_DIR)/usr/share/anbernic/alsa
	# default alsa configurations
	cp $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-audio/alsa/asoundrc-* \
		$(TARGET_DIR)/usr/share/anbernic/alsa/
	# sample audio files
	cp $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-audio/*.wav $(TARGET_DIR)/usr/share/sounds
	# init script
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-audio/S01audio \
		$(TARGET_DIR)/etc/init.d/S01audio
	# udev script to unmute audio devices
	install -m 0644 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-audio/90-alsa-setup.rules \
		$(TARGET_DIR)/etc/udev/rules.d/90-alsa-setup.rules
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-audio/soundconfig \
		$(TARGET_DIR)/usr/bin/soundconfig
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-audio/alsa/anbernic-audio$(ALSA_SUFFIX) \
		$(TARGET_DIR)/usr/bin/anbernic-audio
endef

$(eval $(generic-package))
