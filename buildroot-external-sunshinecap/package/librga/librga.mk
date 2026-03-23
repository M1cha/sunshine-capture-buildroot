################################################################################
#
# librga
#
################################################################################

LIBRGA_VERSION = 2.1.0
LIBRGA_SITE = $(call github,JeffyCN,mirrors,57a1067a246c71fa6c9a355d1668884fda155dd5)
LIBRGA_LICENSE = Apache-2.0
LIBRGA_LICENSE_FILES = COPYING
LIBRGA_DEPENDENCIES = libdrm
LIBRGA_INSTALL_STAGING = YES

$(eval $(meson-package))
