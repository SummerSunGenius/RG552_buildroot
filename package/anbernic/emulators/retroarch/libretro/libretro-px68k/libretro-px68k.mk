################################################################################
#
# PX68K
#
################################################################################
# Version.: Commits on Jun 23, 2020
LIBRETRO_PX68K_VERSION = 2e8cb5d0c61f1a6a21acc2343353e91344298f9a
LIBRETRO_PX68K_SITE = $(call github,libretro,px68k-libretro,$(LIBRETRO_PX68K_VERSION))
LIBRETRO_PX68K_LICENSE = Unknown

LIBRETRO_PX68K_PLATFORM = $(LIBRETRO_PLATFORM)

ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_RPI3),y)
	LIBRETRO_PX68K_PLATFORM = armv neon
endif

ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_ODROIDGOA),y)
	LIBRETRO_PX68K_PLATFORM = classic_armv8_a35
endif

define LIBRETRO_PX68K_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile.libretro platform="$(LIBRETRO_PX68K_PLATFORM)"
endef

define LIBRETRO_PX68K_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/px68k_libretro.so \
	  $(TARGET_DIR)/usr/lib/libretro/px68k_libretro.so

	# Bios
	mkdir -p $(TARGET_DIR)/usr/share/anbernic/datainit/bios/keropi
	echo "[WinX68k]" > $(TARGET_DIR)/usr/share/anbernic/datainit/bios/keropi/config
	echo "StartDir=/userdata/roms/x68000/" >> $(TARGET_DIR)/usr/share/anbernic/datainit/bios/keropi/config
endef

$(eval $(generic-package))
