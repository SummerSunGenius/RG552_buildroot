################################################################################
#
# anbernic wine
#
################################################################################

ANBERNIC_WINE_VERSION = 1.0
ANBERNIC_WINE_LICENSE = GPL
ANBERNIC_WINE_SOURCE=

define ANBERNIC_WINE_INSTALL_TARGET_CMDS
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/utils/anbernic-wine/anbernic-wine $(TARGET_DIR)/usr/bin/anbernic-wine
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/utils/anbernic-wine/bsod.py       $(TARGET_DIR)/usr/bin/bsod-wine
	ln -fs /userdata/system/99-nvidia.conf $(TARGET_DIR)/etc/X11/xorg.conf.d/99-nvidia.conf
endef

$(eval $(generic-package))
