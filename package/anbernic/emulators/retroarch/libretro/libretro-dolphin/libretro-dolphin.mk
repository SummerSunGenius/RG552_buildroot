################################################################################
#
# LIBRETRO-DOLPHIN
#
################################################################################
# Version.: Commits on Aug 30, 2020
LIBRETRO_DOLPHIN_VERSION = 7472308534e8a753c3d31e4a64025c72b22611a1
LIBRETRO_DOLPHIN_SITE = $(call github,libretro,dolphin,$(LIBRETRO_DOLPHIN_VERSION))
LIBRETRO_DOLPHIN_LICENSE = GPLv2

LIBRETRO_DOLPHIN_SUPPORTS_IN_SOURCE_BUILD = NO

LIBRETRO_DOLPHIN_CONF_OPTS  = -DLIBRETRO=ON
LIBRETRO_DOLPHIN_CONF_OPTS += -DLIBRETRO_STATIC=ON
LIBRETRO_DOLPHIN_CONF_OPTS += -DENABLE_NOGUI=OFF
LIBRETRO_DOLPHIN_CONF_OPTS += -DENABLE_QT=OFF
LIBRETRO_DOLPHIN_CONF_OPTS += -DENABLE_TESTS=OFF
LIBRETRO_DOLPHIN_CONF_OPTS += -DUSE_DISCORD_PRESENCE=OFF
LIBRETRO_DOLPHIN_CONF_OPTS += -DBUILD_SHARED_LIBS=OFF
LIBRETRO_DOLPHIN_CONF_OPTS += -DDISTRIBUTOR='anbernic.linux'

LIBRETRO_DOLPHIN_PLATFORM = $(LIBRETRO_PLATFORM)

define LIBRETRO_DOLPHIN_INSTALL_TARGET_CMDS
        $(INSTALL) -D $(@D)/buildroot-build/dolphin_libretro.so \
                $(TARGET_DIR)/usr/lib/libretro/dolphin_libretro.so
endef

$(eval $(cmake-package))
