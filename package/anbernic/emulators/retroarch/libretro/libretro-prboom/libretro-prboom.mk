################################################################################
#
# PRBOOM
#
################################################################################
# Version.: Commits on Jun 17, 2020
LIBRETRO_PRBOOM_VERSION = 9cbbebe4023230881e3c22dde25c251deacfdbbf
LIBRETRO_PRBOOM_SITE = $(call github,libretro,libretro-prboom,$(LIBRETRO_PRBOOM_VERSION))
LIBRETRO_PRBOOM_LICENSE = GPLv2

LIBRETRO_PRBOOM_PLATFORM = $(LIBRETRO_PLATFORM)

ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_RPI3),y)
	LIBRETRO_PRBOOM_PLATFORM = armv neon
endif

ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_ODROIDGOA),y)
	LIBRETRO_PRBOOM_PLATFORM = classic_armv8_a35
endif

define LIBRETRO_PRBOOM_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(LIBRETRO_PRBOOM_PLATFORM)"
endef

define LIBRETRO_PRBOOM_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/prboom_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/prboom_libretro.so
endef

$(eval $(generic-package))
