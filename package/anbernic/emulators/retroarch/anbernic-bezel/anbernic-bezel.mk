################################################################################
#
# anbernic bezel
#
################################################################################
# Version.: Commits on Nov 10, 2020
ANBERNIC_BEZEL_VERSION = d5e906b78060d04cbccc0ce97222707fd1f78452
ANBERNIC_BEZEL_SITE = $(call github,batocera-linux,batocera-bezel,$(ANBERNIC_BEZEL_VERSION))

define ANBERNIC_BEZEL_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/share/anbernic/datainit/decorations
	cp -r $(@D)/ambiance_broadcast 	      $(TARGET_DIR)/usr/share/anbernic/datainit/decorations
	cp -r $(@D)/ambiance_gameroom 	      $(TARGET_DIR)/usr/share/anbernic/datainit/decorations
	cp -r $(@D)/ambiance_monitor_1084s    $(TARGET_DIR)/usr/share/anbernic/datainit/decorations
	cp -r $(@D)/ambiance_night 	      $(TARGET_DIR)/usr/share/anbernic/datainit/decorations
	cp -r $(@D)/ambiance_vintage_tv	      $(TARGET_DIR)/usr/share/anbernic/datainit/decorations
	cp -r $(@D)/arcade_1980s  	      $(TARGET_DIR)/usr/share/anbernic/datainit/decorations
	cp -r $(@D)/arcade_1980s_vertical     $(TARGET_DIR)/usr/share/anbernic/datainit/decorations
	cp -r $(@D)/arcade_vertical_default   $(TARGET_DIR)/usr/share/anbernic/datainit/decorations
	cp -r $(@D)/default_unglazed          $(TARGET_DIR)/usr/share/anbernic/datainit/decorations

	(cd $(TARGET_DIR)/usr/share/anbernic/datainit/decorations && ln -sf default_unglazed default) # default bezel

	echo -e "You can find help here to find how to customize decorations: \n" \
		> $(TARGET_DIR)/usr/share/anbernic/datainit/decorations/readme.txt
	echo "https://anbernic.org/wiki/doku.php?id=en:customize_decorations_bezels" \
		>> $(TARGET_DIR)/usr/share/anbernic/datainit/decorations/readme.txt
endef

$(eval $(generic-package))
