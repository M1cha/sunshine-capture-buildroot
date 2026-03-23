################################################################################
#
# rkmpp
#
################################################################################

RKMPP_VERSION = 1.3.9
RKMPP_SITE = $(call github,rockchip-linux,mpp,c2c1ee502b3a26efebcf843f7a0aeb4d172c6237)
RKMPP_LICENSE = Apache-2.0
RKMPP_INSTALL_STAGING = YES

$(eval $(cmake-package))

