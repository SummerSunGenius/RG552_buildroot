################################################################################
#
# POKEMINI
#
################################################################################
# Version.: Commits on Feb 07, 2020
LIBRETRO_POKEMINI_VERSION = d2ea2ef52f97ea6f7bfff57b5367d95083474414
LIBRETRO_POKEMINI_SITE = $(call github,libretro,PokeMini,$(LIBRETRO_POKEMINI_VERSION))
LIBRETRO_POKEMINI_LICENSE = GPLv3

LIBRETRO_POKEMINI_PLATFORM = $(LIBRETRO_PLATFORM)

ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_RPI3),y)
	LIBRETRO_POKEMINI_PLATFORM = rpi3
endif

ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_ODROIDGOA),y)
	LIBRETRO_POKEMINI_PLATFORM = classic_armv8_a35
endif

define LIBRETRO_POKEMINI_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(LIBRETRO_POKEMINI_PLATFORM)"
endef

define LIBRETRO_POKEMINI_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/pokemini_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/pokemini_libretro.so
endef

$(eval $(generic-package))
