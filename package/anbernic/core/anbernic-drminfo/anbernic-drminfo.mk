################################################################################
#
# drminfo
#
################################################################################
# Version.: Commits on May 27, 2020
ANBERNIC_DRMINFO_VERSION = 1
ANBERNIC_DRMINFO_SOURCE =
ANBERNIC_DRMINFO_LICENSE = GPLv3+
ANBERNIC_DRMINFO_DEPENDENCIES = libdrm

define ANBERNIC_DRMINFO_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(TARGET_CC) -I$(STAGING_DIR)/usr/include/drm -ldrm $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-drminfo/anbernic-drminfo.c -o $(@D)/anbernic-drminfo
endef

define ANBERNIC_DRMINFO_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/anbernic-drminfo $(TARGET_DIR)/usr/bin/anbernic-drminfo
endef

$(eval $(generic-package))
