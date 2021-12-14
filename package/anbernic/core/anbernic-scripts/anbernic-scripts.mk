################################################################################
#
# anbernic scripts
#
################################################################################

ANBERNIC_SCRIPTS_VERSION = 1.1
ANBERNIC_SCRIPTS_LICENSE = GPL
ANBERNIC_SCRIPTS_DEPENDENCIES = pciutils
ANBERNIC_SCRIPTS_SOURCE=

ANBERNIC_SCRIPT_RESOLUTION_TYPE=basic
ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
  ANBERNIC_SCRIPT_RESOLUTION_TYPE=tvservice
endif
ifeq ($(BR2_PACKAGE_LIBDRM),y)
  ANBERNIC_SCRIPT_RESOLUTION_TYPE=drm
endif
ifeq ($(BR2_PACKAGE_XORG7),y)
  ANBERNIC_SCRIPT_RESOLUTION_TYPE=xorg
endif

# doesn't work on odroidgoa with mali g31_gbm
ifeq ($(BR2_PACKAGE_MALI_G31_GBM),y)
  ANBERNIC_SCRIPT_RESOLUTION_TYPE=basic
endif

define ANBERNIC_SCRIPTS_INSTALL_TARGET_CMDS
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/bluetooth/bluezutils.py            $(TARGET_DIR)/usr/lib/python2.7/ # any variable ?
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/bluetooth/anbernic-bluetooth       $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/bluetooth/anbernic-bluetooth-agent $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-settings               $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-save-overlay           $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-es-theme               $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-retroachievements-info $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-kodilauncher           $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-usbmount               $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-encode                 $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-padsinfo               $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-info                   $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-install                $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-format                 $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-mount                  $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-overclock              $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-part                   $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-support                $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-sync                   $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-upgrade                $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-systems                $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-config                 $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-moonlight              $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-es-thebezelproject     $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-cores                  $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-hybrid-nvidia          $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-wifi                   $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-brightness             $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-es-swissknife          $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-create-collection      $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-store                  $(TARGET_DIR)/usr/bin/
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-resolution.$(ANBERNIC_SCRIPT_RESOLUTION_TYPE) $(TARGET_DIR)/usr/bin/anbernic-resolution
endef

define ANBERNIC_SCRIPTS_INSTALL_XORG
	mkdir -p $(TARGET_DIR)/etc/X11/xorg.conf.d
	ln -fs /userdata/system/99-nvidia.conf $(TARGET_DIR)/etc/X11/xorg.conf.d/99-nvidia.conf
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-record $(TARGET_DIR)/usr/bin/
endef

define ANBERNIC_SCRIPTS_INSTALL_ROCKCHIP
	install -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-scripts/scripts/anbernic-rockchip-suspend $(TARGET_DIR)/usr/bin/
endef

ifeq ($(BR2_PACKAGE_XSERVER_XORG_SERVER),y)
  ANBERNIC_SCRIPTS_POST_INSTALL_TARGET_HOOKS += ANBERNIC_SCRIPTS_INSTALL_XORG
endif

ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_ROCKCHIP_ANY),y)
  ANBERNIC_SCRIPTS_POST_INSTALL_TARGET_HOOKS += ANBERNIC_SCRIPTS_INSTALL_ROCKCHIP
endif

$(eval $(generic-package))
