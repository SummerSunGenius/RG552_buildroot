################################################################################
#
# FUSE
#
################################################################################
# Version.: Commits on May 5, 2020
LIBRETRO_FUSE_VERSION = c2f03e6f08f3e2a03d7888fe756e0beb7979f983
LIBRETRO_FUSE_SITE = $(call github,libretro,fuse-libretro,$(LIBRETRO_FUSE_VERSION))
LIBRETRO_FUSE_LICENSE = GPLv3

LIBRETRO_FUSE_PLATFORM = $(LIBRETRO_PLATFORM)

ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_RPI3),y)
	LIBRETRO_FUSE_PLATFORM = rpi3
endif

ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_ODROIDGOA),y)
	LIBRETRO_FUSE_PLATFORM = classic_armv8_a35
endif

define LIBRETRO_FUSE_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile.libretro platform="$(LIBRETRO_FUSE_PLATFORM)"
endef

define LIBRETRO_FUSE_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/fuse_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/fuse_libretro.so
endef

$(eval $(generic-package))
