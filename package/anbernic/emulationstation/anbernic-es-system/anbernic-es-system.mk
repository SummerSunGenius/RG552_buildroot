################################################################################
#
# ANBERNIC-ES-SYSTEM
#
################################################################################

ANBERNIC_ES_SYSTEM_DEPENDENCIES = host-python host-python-pyyaml anbernic-configgen
ANBERNIC_ES_SYSTEM_SOURCE=
ANBERNIC_ES_SYSTEM_VERSION=1.03

define ANBERNIC_ES_SYSTEM_BUILD_CMDS
	$(HOST_DIR)/bin/python \
		$(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/emulationstation/anbernic-es-system/anbernic-es-system.py \
		$(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/emulationstation/anbernic-es-system/es_systems.yml        \
		$(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/emulationstation/anbernic-es-system/es_features.yml       \
		$(CONFIG_DIR)/.config \
		$(@D)/es_systems.cfg \
		$(@D)/es_features.cfg \
		$(STAGING_DIR)/usr/share/anbernic/configgen/configgen-defaults.yml \
		$(STAGING_DIR)/usr/share/anbernic/configgen/configgen-defaults-arch.yml \
		$(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/emulationstation/anbernic-es-system/roms \
		$(@D)/roms $(ANBERNIC_SYSTEM_ARCH)
endef

define ANBERNIC_ES_SYSTEM_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0644 -D $(@D)/es_systems.cfg $(TARGET_DIR)/usr/share/emulationstation/es_systems.cfg
	$(INSTALL) -m 0644 -D $(@D)/es_features.cfg $(TARGET_DIR)/usr/share/emulationstation/es_features.cfg
        mkdir -p $(@D)/roms # in case there is no rom
	cp -pr $(@D)/roms $(TARGET_DIR)/usr/share/anbernic/datainit/
	cp -pr $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/emulationstation/anbernic-es-system/roms/inputtest $(TARGET_DIR)/usr/share/anbernic/datainit/roms
endef

$(eval $(generic-package))
