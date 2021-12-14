################################################################################
#
# pacman Package Manager
#
################################################################################

PACMAN_VERSION = 5.2.1
PACMAN_SITE = https://sources.archlinux.org/other/pacman
PACMAN_SOURCES = pacman-$(PACMAN_VERSION).tar.gz
PACMAN_LICENSE = GPLv2
PACMAN_DEPENDENCIES = glibc libarchive libcurl libgpgme openssl

define ANBERNIC_PACMAN_INSTALL_CONF
	mkdir -p $(TARGET_DIR)/usr/share/anbernic/datainit/system/pacman
	rm -f $(TARGET_DIR)/usr/bin/makepkg
	$(INSTALL) -D -m 0644 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/utils/pacman/pacman.conf $(TARGET_DIR)/etc/pacman.conf
	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/utils/pacman/anbernic-makepkg $(TARGET_DIR)/usr/bin/anbernic-makepkg
	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/utils/pacman/anbernic-pacman-batoexec $(TARGET_DIR)/usr/bin/anbernic-pacman-batoexec
	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/utils/pacman/anbernic-install.hook $(TARGET_DIR)/etc/pacman/hooks/anbernic-install.hook
	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/utils/pacman/anbernic-uninstall.hook $(TARGET_DIR)/etc/pacman/hooks/anbernic-uninstall.hook
	$(INSTALL) -D -m 0644 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/utils/pacman/userdata_pacman.conf $(TARGET_DIR)/usr/share/anbernic/datainit/system/pacman/pacman.conf
	sed -i -e s+"{ANBERNIC_ARCHITECTURE}"+"$(ANBERNIC_SYSTEM_ARCH)"+ $(TARGET_DIR)/etc/pacman.conf
	sed -i -e s+/usr/bin/bash+/bin/bash+ $(TARGET_DIR)/usr/bin/repo-add
endef

PACMAN_POST_INSTALL_TARGET_HOOKS = ANBERNIC_PACMAN_INSTALL_CONF

$(eval $(autotools-package))
