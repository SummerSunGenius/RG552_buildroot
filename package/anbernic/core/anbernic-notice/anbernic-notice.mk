################################################################################
#
# Anbernic notice
#
################################################################################
ANBERNIC_NOTICE_VERSION = 456fbde1ef4462ea72f23eb8836fcfa9514c6ca9
ANBERNIC_NOTICE_SITE = $(call github,batocera-linux,batocera-notice,$(ANBERNIC_NOTICE_VERSION))

define ANBERNIC_NOTICE_INSTALL_TARGET_CMDS
    mkdir -p $(TARGET_DIR)/usr/share/anbernic/doc
    cp -r $(@D)/notice.pdf $(TARGET_DIR)/usr/share/anbernic/doc/notice.pdf
endef

$(eval $(generic-package))
