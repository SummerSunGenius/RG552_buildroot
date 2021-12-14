################################################################################
#
# ANBERNIC BLUETOOTH
#
################################################################################

ANBERNIC_BLUETOOTH_VERSION = 1.1
ANBERNIC_BLUETOOTH_LICENSE = GPL
ANBERNIC_BLUETOOTH_SOURCE=

ANBERNIC_BLUETOOTH_STACK=

ifneq ($(BR2_PACKAGE_ANBERNIC_TARGET_RPI_ANY)$(BR2_PACKAGE_ANBERNIC_TARGET_RPI4),)
	ANBERNIC_BLUETOOTH_STACK=bcm921 piscan
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_TINKERBOARD),y)
	ANBERNIC_BLUETOOTH_STACK=rfkreset rtk115
else ifeq ($(BR2_PACKAGE_ANBERNIC_TARGET_ROCKPRO64),y)
	ANBERNIC_BLUETOOTH_STACK=rfkreset bcm150
endif

define ANBERNIC_BLUETOOTH_INSTALL_TARGET_CMDS
	cp $(BR2_EXTERNAL_ANBERNIC_PATH)/package/anbernic/core/anbernic-bluetooth/S32bluetooth.template $(TARGET_DIR)/etc/init.d/S32bluetooth
	sed -i -e s+"@INTERNAL_BLUETOOTH_STACK@"+"$(ANBERNIC_BLUETOOTH_STACK)"+ $(TARGET_DIR)/etc/init.d/S32bluetooth
endef

$(eval $(generic-package))
