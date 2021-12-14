################################################################################
#
# Anbernic desktop applications
#
################################################################################
ANBERNIC_DESKTOPAPPS_VERSION = 1.0
ANBERNIC_DESKTOPAPPS_SOURCE=

ANBERNIC_DESKTOPAPPS_SCRIPTS = filemanagerlauncher
ANBERNIC_DESKTOPAPPS_APPS  = xterm.desktop
ANBERNIC_DESKTOPAPPS_ICONS =

# pcsx2
ifneq ($(BR2_PACKAGE_PCSX2_X86)$(BR2_PACKAGE_PCSX2)$(BR2_PACKAGE_PCSX2_AVX2),)
  ANBERNIC_DESKTOPAPPS_SCRIPTS += anbernic-config-pcsx2
  ANBERNIC_DESKTOPAPPS_APPS    += pcsx2-config.desktop
  ANBERNIC_DESKTOPAPPS_ICONS   += pcsx2.png
endif

# dolphin
ifeq ($(BR2_PACKAGE_DOLPHIN_EMU),y)
  ANBERNIC_DESKTOPAPPS_SCRIPTS += anbernic-config-dolphin
  ANBERNIC_DESKTOPAPPS_APPS    += dolphin-config.desktop
  ANBERNIC_DESKTOPAPPS_ICONS   += dolphin.png
endif

# retroarch
ifeq ($(BR2_PACKAGE_RETROARCH),y)
  ANBERNIC_DESKTOPAPPS_SCRIPTS += anbernic-config-retroarch
  ANBERNIC_DESKTOPAPPS_APPS    += retroarch-config.desktop
  ANBERNIC_DESKTOPAPPS_ICONS   += retroarch.png
endif

# ppsspp
ifeq ($(BR2_PACKAGE_PPSSPP),y)
  ANBERNIC_DESKTOPAPPS_SCRIPTS += anbernic-config-ppsspp
  ANBERNIC_DESKTOPAPPS_APPS    += ppsspp-config.desktop
  ANBERNIC_DESKTOPAPPS_ICONS   += ppsspp.png
endif

# reicast
ifeq ($(BR2_PACKAGE_REICAST),y)
  ANBERNIC_DESKTOPAPPS_SCRIPTS += anbernic-config-reicast
  ANBERNIC_DESKTOPAPPS_APPS    += reicast-config.desktop
  ANBERNIC_DESKTOPAPPS_ICONS   += reicast.png
endif

# flycast
ifeq ($(BR2_PACKAGE_FLYCAST),y)
  ANBERNIC_DESKTOPAPPS_SCRIPTS += anbernic-config-flycast
  ANBERNIC_DESKTOPAPPS_APPS    += flycast-config.desktop
  ANBERNIC_DESKTOPAPPS_ICONS   += flycast.png
endif

# scummvm
ifeq ($(BR2_PACKAGE_SCUMMVM),y)
  ANBERNIC_DESKTOPAPPS_SCRIPTS += anbernic-config-scummvm
  ANBERNIC_DESKTOPAPPS_APPS    += scummvm-config.desktop
  ANBERNIC_DESKTOPAPPS_ICONS   += scummvm.png
endif

# citra
ifeq ($(BR2_PACKAGE_CITRA),y)
  ANBERNIC_DESKTOPAPPS_SCRIPTS += anbernic-config-citra
  ANBERNIC_DESKTOPAPPS_APPS    += citra-config.desktop
  ANBERNIC_DESKTOPAPPS_ICONS   += citra.png
endif

# rpcs3
ifeq ($(BR2_PACKAGE_RPCS3),y)
  ANBERNIC_DESKTOPAPPS_SCRIPTS += anbernic-config-rpcs3
  ANBERNIC_DESKTOPAPPS_APPS    += rpcs3-config.desktop
  ANBERNIC_DESKTOPAPPS_ICONS   += rpcs3.png
endif

# cemu
ifeq ($(BR2_PACKAGE_CEMU),y)
  ANBERNIC_DESKTOPAPPS_SCRIPTS += anbernic-config-cemu
  ANBERNIC_DESKTOPAPPS_APPS    += cemu-config.desktop
  ANBERNIC_DESKTOPAPPS_ICONS   += cemu.png
endif

define ANBERNIC_DESKTOPAPPS_INSTALL_TARGET_CMDS
	# scripts
	mkdir -p $(TARGET_DIR)/usr/bin
	$(foreach f,$(ANBERNIC_DESKTOPAPPS_SCRIPTS), cp $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-desktopapps/scripts/$(f) $(TARGET_DIR)/usr/bin/$(f)$(sep))

	# apps
	mkdir -p $(TARGET_DIR)/usr/share/applications
	$(foreach f,$(ANBERNIC_DESKTOPAPPS_APPS), cp $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-desktopapps/apps/$(f) $(TARGET_DIR)/usr/share/applications/$(f)$(sep))

	# icons
	mkdir -p $(TARGET_DIR)/usr/share/icons/anbernic
	$(foreach f,$(ANBERNIC_DESKTOPAPPS_ICONS), cp $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-desktopapps/icons/$(f) $(TARGET_DIR)/usr/share/icons/anbernic/$(f)$(sep))

	# menu
	mkdir -p $(TARGET_DIR)/etc/xdg/menus
	cp $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-desktopapps/menu/anbernic-applications.menu $(TARGET_DIR)/etc/xdg/menus/anbernic-applications.menu
endef

$(eval $(generic-package))
