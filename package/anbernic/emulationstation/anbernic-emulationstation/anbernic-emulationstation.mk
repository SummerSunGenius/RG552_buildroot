################################################################################
#
# Anbernic Emulation Station
#
################################################################################

ANBERNIC_EMULATIONSTATION_VERSION = ffd36c4f64fcaf9e3786fc574ba18381ad345269
ANBERNIC_EMULATIONSTATION_SITE = https://github.com/batocera-linux/batocera-emulationstation
ANBERNIC_EMULATIONSTATION_SITE_METHOD = git
ANBERNIC_EMULATIONSTATION_LICENSE = MIT
ANBERNIC_EMULATIONSTATION_GIT_SUBMODULES = YES
ANBERNIC_EMULATIONSTATION_LICENSE = MIT, Apache-2.0
ANBERNIC_EMULATIONSTATION_DEPENDENCIES = sdl2 sdl2_mixer libfreeimage freetype alsa-lib libcurl vlc rapidjson
# install in staging for debugging (gdb)
ANBERNIC_EMULATIONSTATION_INSTALL_STAGING = YES
# ANBERNIC_EMULATIONSTATION_OVERRIDE_SRCDIR = /sources/anbernic-emulationstation

ifeq ($(BR2_PACKAGE_HAS_LIBGL),y)
ANBERNIC_EMULATIONSTATION_DEPENDENCIES += libgl
ANBERNIC_EMULATIONSTATION_CONF_OPTS += -DGL=1
else
ANBERNIC_EMULATIONSTATION_CONF_OPTS += -DGL=0
endif

ifeq ($(BR2_PACKAGE_HAS_LIBGLES),y)
ANBERNIC_EMULATIONSTATION_DEPENDENCIES += libgles
ANBERNIC_EMULATIONSTATION_CONF_OPTS += -DGLES=1
else
ANBERNIC_EMULATIONSTATION_CONF_OPTS += -DGLES=0
endif

ANBERNIC_EMULATIONSTATION_CONF_OPTS += -DCMAKE_CXX_FLAGS=-D$(call UPPERCASE,$(ANBERNIC_SYSTEM_ARCH))

ifeq ($(BR2_PACKAGE_HAS_LIBGLES),y)
ANBERNIC_EMULATIONSTATION_CONF_OPTS += -DGLES=ON
endif

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
ANBERNIC_EMULATIONSTATION_CONF_OPTS += -DBCM=ON
endif

ifneq ($(BR2_PACKAGE_KODI)$(BR2_PACKAGE_KODI18),)
ANBERNIC_EMULATIONSTATION_CONF_OPTS += -DDISABLE_KODI=0
else
ANBERNIC_EMULATIONSTATION_CONF_OPTS += -DDISABLE_KODI=1
endif


ifeq ($(BR2_PACKAGE_XORG7),y)
ANBERNIC_EMULATIONSTATION_CONF_OPTS += -DENABLE_FILEMANAGER=1
else
ANBERNIC_EMULATIONSTATION_CONF_OPTS += -DENABLE_FILEMANAGER=0
endif

# cec is causing issues with es on xu4 and vim3
#ifeq ($(BR2_PACKAGE_LIBCEC_EXYNOS_API)$(BR2_PACKAGE_ANBERNIC_TARGET_VIM3),y)
ANBERNIC_EMULATIONSTATION_CONF_OPTS += -DCEC=OFF
#endif

define ANBERNIC_EMULATIONSTATION_RPI_FIXUP
	$(SED) 's|.{CMAKE_FIND_ROOT_PATH}/opt/vc|$(STAGING_DIR)/usr|g' $(@D)/CMakeLists.txt
	$(SED) 's|.{CMAKE_FIND_ROOT_PATH}/usr|$(STAGING_DIR)/usr|g'    $(@D)/CMakeLists.txt
endef

define ANBERNIC_EMULATIONSTATION_RESOURCES
	$(INSTALL) -m 0755 -d $(TARGET_DIR)/usr/share/emulationstation/resources/help
	$(INSTALL) -m 0755 -d $(TARGET_DIR)/usr/share/emulationstation/resources/flags
	$(INSTALL) -m 0755 -d $(TARGET_DIR)/usr/share/emulationstation/resources/battery
	$(INSTALL) -m 0644 -D $(@D)/resources/*.* $(TARGET_DIR)/usr/share/emulationstation/resources
	$(INSTALL) -m 0644 -D $(@D)/resources/help/*.* $(TARGET_DIR)/usr/share/emulationstation/resources/help
	$(INSTALL) -m 0644 -D $(@D)/resources/flags/*.* $(TARGET_DIR)/usr/share/emulationstation/resources/flags
	$(INSTALL) -m 0644 -D $(@D)/resources/battery/*.* $(TARGET_DIR)/usr/share/emulationstation/resources/battery

	# es_input.cfg
	mkdir -p $(TARGET_DIR)/usr/share/anbernic/datainit/system/configs/emulationstation
	cp $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/emulationstation/anbernic-emulationstation/controllers/es_input.cfg \
		$(TARGET_DIR)/usr/share/anbernic/datainit/system/configs/emulationstation
	cp $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/emulationstation/anbernic-emulationstation/controllers/es_settings.cfg \
		$(TARGET_DIR)/usr/share/anbernic/datainit/system/configs/emulationstation
endef

### S31emulationstation
# default for most of architectures
ANBERNIC_EMULATIONSTATION_PREFIX = SDL_NOMOUSE=1
ANBERNIC_EMULATIONSTATION_CMD = /usr/bin/emulationstation
ANBERNIC_EMULATIONSTATION_ARGS = --no-splash
ANBERNIC_EMULATIONSTATION_POSTFIX = \&

# on rpi1: dont load ES in background
ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_RPI1),y)
	ANBERNIC_EMULATIONSTATION_POSTFIX = \& sleep 5
endif

# on rpi 1 2 3, the splash with video + es splash is ok
ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
	ANBERNIC_EMULATIONSTATION_ARGS =
endif

# es splash is ok when there is no video
ifeq ($(BR2_PACKAGE_ANBERNIC_SPLASH_IMAGE)$(BR2_PACKAGE_ANBERNIC_SPLASH_ROTATE_IMAGE),y)
	ANBERNIC_EMULATIONSTATION_ARGS =
endif

# # on x86/x86_64: startx runs ES
ifeq ($(BR2_PACKAGE_XSERVER_XORG_SERVER),y)
	ANBERNIC_EMULATIONSTATION_PREFIX =
	ANBERNIC_EMULATIONSTATION_CMD = startx
	ANBERNIC_EMULATIONSTATION_ARGS =
endif

# # on odroidga: set resolution and EGL/GL hack
ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_ODROIDGOA),y)
	ANBERNIC_EMULATIONSTATION_PREFIX += SDL_VIDEO_GL_DRIVER=/usr/lib/libGLESv2.so SDL_VIDEO_EGL_DRIVER=/usr/lib/libGLESv2.so
	ANBERNIC_EMULATIONSTATION_ARGS += --resolution 480 320
endif

define ANBERNIC_EMULATIONSTATION_BOOT
	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/emulationstation/anbernic-emulationstation/S31emulationstation $(TARGET_DIR)/etc/init.d/S31emulationstation
	sed -i -e 's;%ANBERNIC_EMULATIONSTATION_PREFIX%;${ANBERNIC_EMULATIONSTATION_PREFIX};g' \
		-e 's;%ANBERNIC_EMULATIONSTATION_CMD%;${ANBERNIC_EMULATIONSTATION_CMD};g' \
		-e 's;%ANBERNIC_EMULATIONSTATION_ARGS%;${ANBERNIC_EMULATIONSTATION_ARGS};g' \
		-e 's;%ANBERNIC_EMULATIONSTATION_POSTFIX%;${ANBERNIC_EMULATIONSTATION_POSTFIX};g' \
		$(TARGET_DIR)/etc/init.d/S31emulationstation
endef

ANBERNIC_EMULATIONSTATION_PRE_CONFIGURE_HOOKS += ANBERNIC_EMULATIONSTATION_RPI_FIXUP
ANBERNIC_EMULATIONSTATION_POST_INSTALL_TARGET_HOOKS += ANBERNIC_EMULATIONSTATION_RESOURCES
ANBERNIC_EMULATIONSTATION_POST_INSTALL_TARGET_HOOKS += ANBERNIC_EMULATIONSTATION_BOOT

$(eval $(cmake-package))
