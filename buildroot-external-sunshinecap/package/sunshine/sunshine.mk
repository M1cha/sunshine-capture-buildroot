################################################################################
#
# sunshine
#
################################################################################

SUNSHINE_VERSION = c50c57b480ddc4bb3fc1dc7910eb047ae941a2fb
SUNSHINE_SITE = https://github.com/M1cha/sunshine-capture
SUNSHINE_SITE_METHOD = git
SUNSHINE_GIT_SUBMODULES = YES
SUNSHINE_LICENSE = GPL-3.0
SUNSHINE_LICENSE_FILES = LICENSE
SUNSHINE_DEPENDENCIES = openssl libcurl libminiupnpc opus pulseaudio ffmpeg-sunshine ffmpeg-cbs librga

SUNSHINE_EXTRA_DOWNLOADS = \
	https://github.com/boostorg/boost/releases/download/boost-1.87.0/boost-1.87.0-cmake.tar.xz \
	https://github.com/nlohmann/json/releases/download/v3.11.3/json.tar.xz

define COPY_DOWNLOADED_FILES
	mkdir -p $(@D)/_deps/boost-subbuild/boost-populate-prefix/src
	cp $(SUNSHINE_DL_DIR)/boost-1.87.0-cmake.tar.xz $(@D)/_deps/boost-subbuild/boost-populate-prefix/src/

	mkdir -p $(@D)/_deps/json-subbuild/json-populate-prefix/src
	cp $(SUNSHINE_DL_DIR)/json.tar.xz $(@D)/_deps/json-subbuild/json-populate-prefix/src/
endef
SUNSHINE_PRE_CONFIGURE_HOOKS += COPY_DOWNLOADED_FILES

SUNSHINE_PLATFORM_LIBRARIES := x264;x265
ifeq ($(BR2_PACKAGE_FFMPEG_SUNSHINE_RKMPP),y)
SUNSHINE_PLATFORM_LIBRARIES := $(SUNSHINE_PLATFORM_LIBRARIES);rockchip_mpp;drm
endif

SUNSHINE_CONF_OPTS += -DSUNSHINE_ENABLE_CUDA=OFF
SUNSHINE_CONF_OPTS += -DSUNSHINE_ENABLE_DRM=OFF
SUNSHINE_CONF_OPTS += -DSUNSHINE_ENABLE_VAAPI=OFF
SUNSHINE_CONF_OPTS += -DSUNSHINE_ENABLE_WAYLAND=OFF
SUNSHINE_CONF_OPTS += -DSUNSHINE_ENABLE_X11=OFF
SUNSHINE_CONF_OPTS += -DSUNSHINE_ENABLE_V4L2=ON
SUNSHINE_CONF_OPTS += -DSUNSHINE_ENABLE_TRAY=OFF
SUNSHINE_CONF_OPTS += -DSUNSHINE_ENABLE_EGL=OFF
SUNSHINE_CONF_OPTS += -DSUNSHINE_ENABLE_RKMPP=ON
SUNSHINE_CONF_OPTS += -DSUNSHINE_ENABLE_UDCINPUT=ON
SUNSHINE_CONF_OPTS += -DUDCINPUT_LOG_LEVEL=3
SUNSHINE_CONF_OPTS += -DFFMPEG_PREPARED_BINARIES=$(STAGING_DIR)/opt/ffmpeg-sunshine
SUNSHINE_CONF_OPTS += -DFFMPEG_PLATFORM_LIBRARIES="$(SUNSHINE_PLATFORM_LIBRARIES)"
SUNSHINE_CONF_OPTS += -DBUILD_SHARED_LIBS=OFF

$(eval $(cmake-package))


