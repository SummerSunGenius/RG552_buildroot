################################################################################
#
# EmulationStation theme "Carbon"
#
################################################################################
# Version.: Commits on Nov 1, 2020
ANBERNIC_THEME_VERSION = 3ec0d11caa1519e4042c4c967654c370cd905965
ANBERNIC_THEME_SITE = $(call github,SummerSunGenius,anbernic-theme,$(ANBERNIC_THEME_VERSION))

define ANBERNIC_THEME_INSTALL_TARGET_CMDS
    mkdir -p $(TARGET_DIR)/usr/share/emulationstation/themes/anbernic-theme
    cp -r $(@D)/* $(TARGET_DIR)/usr/share/emulationstation/themes/anbernic-theme
endef

$(eval $(generic-package))
