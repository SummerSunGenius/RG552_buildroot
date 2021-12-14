################################################################################
#
# anbernic pygame
#
################################################################################

ANBERNIC_PYGAME_VERSION = 1.0
ANBERNIC_PYGAME_SOURCE=

define ANBERNIC_PYGAME_INSTALL_SAMPLE
	mkdir -p $(TARGET_DIR)/usr/bin
	mkdir -p $(TARGET_DIR)/usr/share/anbernic/datainit/roms/pygame
	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/utils/anbernic-pygame/anbernic-pygame $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0644 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/utils/anbernic-pygame/evmapy.keys     $(TARGET_DIR)/usr/share/evmapy/pygame.keys
	$(INSTALL) -D -m 0644 $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/utils/anbernic-pygame/snake.pygame    $(TARGET_DIR)/usr/share/anbernic/datainit/roms/pygame

	# create an alias for pygame to be able to kill it with killall and evmapy
	(cd $(TARGET_DIR)/usr/bin && ln -sf python pygame)
endef

ANBERNIC_PYGAME_POST_INSTALL_TARGET_HOOKS = ANBERNIC_PYGAME_INSTALL_SAMPLE

$(eval $(generic-package))
