################################################################################
#
# anbernic shaders
#
################################################################################

ANBERNIC_SHADERS_VERSION = 1.0
ANBERNIC_SHADERS_SOURCE=
ANBERNIC_SHADERS_DEPENDENCIES= glsl-shaders

ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_RPI1),y)
	ANBERNIC_SHADERS_SYSTEM=rpi1
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_RPI2),y)
	ANBERNIC_SHADERS_SYSTEM=rpi2
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_RPI3),y)
	ANBERNIC_SHADERS_SYSTEM=rpi3
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_XU4),y)
	ANBERNIC_SHADERS_SYSTEM=xu4
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_ODROIDC2),y)
	ANBERNIC_SHADERS_SYSTEM=c2
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_ODROIDC4),y)
	ANBERNIC_SHADERS_SYSTEM=c4
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_S905),y)
	ANBERNIC_SHADERS_SYSTEM=s905
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_S912),y)
	ANBERNIC_SHADERS_SYSTEM=s912
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_X86)$(BR2_PACKAGE_ANBERNIC_TARGET_X86_64),y)
	ANBERNIC_SHADERS_SYSTEM=x86
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_ROCKPRO64),y)
	ANBERNIC_SHADERS_SYSTEM=rockpro64
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_ODROIDN2),y)
	ANBERNIC_SHADERS_SYSTEM=odroidn2
endif

ANBERNIC_SHADERS_DIRIN=$(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/emulators/retroarch/shaders/anbernic-shaders/configs

define ANBERNIC_SHADERS_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/share/anbernic/shaders/configs

	# general
	cp $(ANBERNIC_SHADERS_DIRIN)/rendering-defaults.yml           $(TARGET_DIR)/usr/share/anbernic/shaders/configs/
	if test -e $(ANBERNIC_SHADERS_DIRIN)/rendering-defaults-$(ANBERNIC_SHADERS_SYSTEM).yml; then \
		cp $(ANBERNIC_SHADERS_DIRIN)/rendering-defaults-$(ANBERNIC_SHADERS_SYSTEM).yml $(TARGET_DIR)/usr/share/anbernic/shaders/configs/rendering-defaults-arch.yml; \
	fi

	# sets
	for set in retro scanlines enhanced curvature zfast flatten-glow; do \
		mkdir -p $(TARGET_DIR)/usr/share/anbernic/shaders/configs/$$set; \
		cp $(ANBERNIC_SHADERS_DIRIN)/$$set/rendering-defaults.yml     $(TARGET_DIR)/usr/share/anbernic/shaders/configs/$$set/; \
		if test -e $(ANBERNIC_SHADERS_DIRIN)/$$set/rendering-defaults-$(ANBERNIC_SHADERS_SYSTEM).yml; then \
			cp $(ANBERNIC_SHADERS_DIRIN)/$$set/rendering-defaults-$(ANBERNIC_SHADERS_SYSTEM).yml $(TARGET_DIR)/usr/share/anbernic/shaders/configs/$$set/rendering-defaults-arch.yml; \
		fi \
	done

endef

$(eval $(generic-package))
