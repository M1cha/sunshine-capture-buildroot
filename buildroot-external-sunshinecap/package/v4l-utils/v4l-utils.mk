################################################################################
#
# v4l-utils
#
################################################################################

V4L_UTILS_VERSION = 1.32.0
V4L_UTILS_SITE = https://linuxtv.org/downloads/v4l-utils
V4L_UTILS_SOURCE = v4l-utils-$(V4L_UTILS_VERSION).tar.xz
V4L_UTILS_LICENSE = GPL-2.0
V4L_UTILS_LICENSE_FILES = COPYING

$(eval $(meson-package))

