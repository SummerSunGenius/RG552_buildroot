################################################################################
#
# anbernic configgen
#
################################################################################

ANBERNIC_CONFIGGEN_VERSION = 1.4
ANBERNIC_CONFIGGEN_LICENSE = GPL
ANBERNIC_CONFIGGEN_SOURCE=
ANBERNIC_CONFIGGEN_DEPENDENCIES = python python-pyyaml
ANBERNIC_CONFIGGEN_INSTALL_STAGING = YES

define ANBERNIC_CONFIGGEN_EXTRACT_CMDS
	cp -R $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-configgen/configgen/* $(@D)
endef

ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_RPI1),y)
	ANBERNIC_CONFIGGEN_SYSTEM=rpi1
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_RPI2),y)
	ANBERNIC_CONFIGGEN_SYSTEM=rpi2
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_RPI3),y)
	ANBERNIC_CONFIGGEN_SYSTEM=rpi3
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_RPI4),y)
	ANBERNIC_CONFIGGEN_SYSTEM=rpi4
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_XU4),y)
	ANBERNIC_CONFIGGEN_SYSTEM=odroidxu4
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_TINKERBOARD),y)
	ANBERNIC_CONFIGGEN_SYSTEM=tinkerboard
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_MIQI),y)
	ANBERNIC_CONFIGGEN_SYSTEM=miqi
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_ODROIDC2),y)
	ANBERNIC_CONFIGGEN_SYSTEM=odroidc2
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_ODROIDC4),y)
	ANBERNIC_CONFIGGEN_SYSTEM=odroidc4
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_S905),y)
	ANBERNIC_CONFIGGEN_SYSTEM=s905
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_S912),y)
	ANBERNIC_CONFIGGEN_SYSTEM=s912
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_X86),y)
	ANBERNIC_CONFIGGEN_SYSTEM=x86
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_X86_64),y)
	ANBERNIC_CONFIGGEN_SYSTEM=x86_64
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_ROCKPRO64),y)
	ANBERNIC_CONFIGGEN_SYSTEM=rockpro64
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_ROCK960),y)
	ANBERNIC_CONFIGGEN_SYSTEM=rock960
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_ODROIDN2),y)
	ANBERNIC_CONFIGGEN_SYSTEM=odroidn2
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_ODROIDGOA),y)
	ANBERNIC_CONFIGGEN_SYSTEM=odroidgoa
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_VIM3),y)
	ANBERNIC_CONFIGGEN_SYSTEM=vim3
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_LIBRETECH_H5),y)
	ANBERNIC_CONFIGGEN_SYSTEM=libretech-h5
endif

define ANBERNIC_CONFIGGEN_INSTALL_STAGING_CMDS
	mkdir -p $(STAGING_DIR)/usr/share/anbernic/configgen
	cp $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-configgen/configs/configgen-defaults.yml $(STAGING_DIR)/usr/share/anbernic/configgen/configgen-defaults.yml
	cp $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-configgen/configs/configgen-defaults-$(ANBERNIC_CONFIGGEN_SYSTEM).yml $(STAGING_DIR)/usr/share/anbernic/configgen/configgen-defaults-arch.yml
endef

define ANBERNIC_CONFIGGEN_CONFIGS
	mkdir -p $(TARGET_DIR)/usr/share/anbernic/configgen
	cp -pr $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-configgen/datainit $(TARGET_DIR)/usr/lib/python2.7/site-packages/configgen/
	cp $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-configgen/configs/configgen-defaults.yml $(TARGET_DIR)/usr/share/anbernic/configgen/configgen-defaults.yml
	cp $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-configgen/configs/configgen-defaults-$(ANBERNIC_CONFIGGEN_SYSTEM).yml $(TARGET_DIR)/usr/share/anbernic/configgen/configgen-defaults-arch.yml
endef
ANBERNIC_CONFIGGEN_POST_INSTALL_TARGET_HOOKS = ANBERNIC_CONFIGGEN_CONFIGS

ANBERNIC_CONFIGGEN_SETUP_TYPE = distutils

$(eval $(python-package))
