GROWPART_VERSION = 0.33
GROWPART_SITE = $(call github,canonical,cloud-utils,646ab04dcc275565608af3acc2f27ad8ca79dcfe)
GROWPART_LICENSE = GPL-3.0
GROWPART_LICENSE_FILES = LICENSE

define GROWPART_BUILD_CMDS
endef

define GROWPART_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/bin/growpart $(TARGET_DIR)/bin/growpart
	$(INSTALL) -m 0755 -D $(GROWPART_PKGDIR)/growpart-systemd $(TARGET_DIR)/usr/lib/growpart/growpart-systemd
endef

$(eval $(generic-package))
