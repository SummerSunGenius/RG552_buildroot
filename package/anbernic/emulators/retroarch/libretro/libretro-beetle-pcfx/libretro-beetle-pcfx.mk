################################################################################
#
# BEETLE_PCFX
#
################################################################################
# Version.: Commits on Nov 3, 2020
LIBRETRO_BEETLE_PCFX_VERSION = 294ecfc09a8dc4d1a20b83ad518283e24cbdb676
LIBRETRO_BEETLE_PCFX_SITE = $(call github,libretro,beetle-pcfx-libretro,$(LIBRETRO_BEETLE_PCFX_VERSION))
LIBRETRO_BEETLE_PCFX_LICENSE = GPLv2

LIBRETRO_BEETLE_PCFX_PLATFORM = $(LIBRETRO_PLATFORM)

ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_ODROIDN2),y)
	LIBRETRO_BEETLE_PCFX_PLATFORM = CortexA73_G12B
endif

ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_ODROIDC2),y)
	LIBRETRO_BEETLE_PCFX_PLATFORM = S905
endif

ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_ODROIDC4),y)
	LIBRETRO_BEETLE_PCFX_PLATFORM = SM1
endif

define LIBRETRO_BEETLE_PCFX_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) platform="$(LIBRETRO_BEETLE_PCFX_PLATFORM)"
endef

define LIBRETRO_BEETLE_PCFX_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/mednafen_pcfx_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/pcfx_libretro.so
endef

$(eval $(generic-package))
