################################################################################
#
# rkdeveloptool
#
################################################################################

RKDEVELOPTOOL_VERSION = 304f073752fd25c854e1bcf05d8e7f925b1f4e14
RKDEVELOPTOOL_SITE = https://github.com/rockchip-linux/rkdeveloptool
RKDEVELOPTOOL_SITE_METHOD = git
RKDEVELOPTOOL_LICENSE = GPL-2.0
RKDEVELOPTOOL_LICENSE_FILES = license.txt
HOST_RKDEVELOPTOOL_DEPENDENCIES += host-libusb
RKDEVELOPTOOL_AUTORECONF = YES

$(eval $(host-autotools-package))
