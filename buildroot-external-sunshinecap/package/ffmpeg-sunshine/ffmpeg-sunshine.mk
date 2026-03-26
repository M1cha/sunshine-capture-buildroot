################################################################################
#
# ffmpeg-sunshine
#
################################################################################

FFMPEG_SUNSHINE_VERSION = 8.1
FFMPEG_SUNSHINE_SOURCE = ffmpeg-$(FFMPEG_SUNSHINE_VERSION).tar.xz
FFMPEG_SUNSHINE_SITE = https://ffmpeg.org/releases
FFMPEG_SUNSHINE_INSTALL_STAGING = YES
FFMPEG_SUNSHINE_INSTALL_TARGET = NO

ifeq ($(BR2_PACKAGE_FFMPEG_SUNSHINE_VERSION3),y)

FFMPEG_SUNSHINE_LICENSE = LGPL-3.0+, libjpeg license
FFMPEG_SUNSHINE_LICENSE_FILES = LICENSE.md COPYING.LGPLv3
ifeq ($(BR2_PACKAGE_FFMPEG_SUNSHINE_GPL),y)
FFMPEG_SUNSHINE_LICENSE += and GPL-3.0+
FFMPEG_SUNSHINE_LICENSE_FILES += COPYING.GPLv3
endif

else

FFMPEG_SUNSHINE_LICENSE = LGPL-2.1+, libjpeg license
FFMPEG_SUNSHINE_LICENSE_FILES = LICENSE.md COPYING.LGPLv2.1
ifeq ($(BR2_PACKAGE_FFMPEG_SUNSHINE_GPL),y)
FFMPEG_SUNSHINE_LICENSE += and GPL-2.0+
FFMPEG_SUNSHINE_LICENSE_FILES += COPYING.GPLv2
endif

endif

FFMPEG_SUNSHINE_CPE_ID_VENDOR = ffmpeg

FFMPEG_SUNSHINE_CONF_OPTS = \
	--prefix=/opt/ffmpeg-sunshine \
	--enable-avfilter \
	--enable-logging \
	--enable-optimizations \
	--disable-extra-warnings \
	--enable-avdevice \
	--enable-avcodec \
	--enable-avformat \
	--enable-network \
	--disable-gray \
	--enable-swscale-alpha \
	--disable-small \
	--disable-dxva2 \
	--enable-runtime-cpudetect \
	--disable-hardcoded-tables \
	--disable-mipsdsp \
	--disable-mipsdspr2 \
	--disable-msa \
	--enable-hwaccels \
	--disable-cuda \
	--disable-cuvid \
	--disable-nvenc \
	--disable-avisynth \
	--disable-frei0r \
	--disable-libopencore-amrnb \
	--disable-libopencore-amrwb \
	--disable-libdc1394 \
	--disable-libgsm \
	--disable-libilbc \
	--disable-libvo-amrwbenc \
	--disable-symver \
	--disable-doc \
	--disable-mmal \
	--disable-omx \
	--disable-omx-rpi

FFMPEG_SUNSHINE_DEPENDENCIES += host-pkgconf

ifeq ($(BR2_PACKAGE_FFMPEG_SUNSHINE_GPL),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-gpl
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-gpl
endif

ifeq ($(BR2_PACKAGE_FFMPEG_SUNSHINE_VERSION3),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-version3
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-version3
endif

ifeq ($(BR2_PACKAGE_FFMPEG_SUNSHINE_NONFREE),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-nonfree
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-nonfree
endif

ifeq ($(BR2_PACKAGE_FFMPEG_SUNSHINE_FFMPEG),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-ffmpeg
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-ffmpeg
endif

ifeq ($(BR2_PACKAGE_FFMPEG_SUNSHINE_FFPLAY),y)
FFMPEG_SUNSHINE_DEPENDENCIES += sdl2
FFMPEG_SUNSHINE_CONF_OPTS += --enable-ffplay
FFMPEG_SUNSHINE_CONF_ENV += SDL_CONFIG=$(STAGING_DIR)/usr/bin/sdl2-config
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-ffplay
endif

ifeq ($(BR2_PACKAGE_JACK1),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-libjack
FFMPEG_SUNSHINE_DEPENDENCIES += jack1
else ifeq ($(BR2_PACKAGE_JACK2),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-libjack
FFMPEG_SUNSHINE_DEPENDENCIES += jack2
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libjack
endif

ifeq ($(BR2_PACKAGE_PULSEAUDIO),y)
FFMPEG_SUNSHINE_DEPENDENCIES += pulseaudio
FFMPEG_SUNSHINE_CONF_OPTS += --enable-libpulse
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libpulse
endif

ifeq ($(BR2_PACKAGE_LIBV4L),y)
FFMPEG_SUNSHINE_DEPENDENCIES += libv4l
FFMPEG_SUNSHINE_CONF_OPTS += --enable-libv4l2
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libv4l2
endif

ifeq ($(BR2_PACKAGE_FFMPEG_SUNSHINE_FFPROBE),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-ffprobe
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-ffprobe
endif

ifeq ($(BR2_PACKAGE_FFMPEG_SUNSHINE_XCBGRAB),y)
FFMPEG_SUNSHINE_CONF_OPTS += \
	--enable-libxcb \
	--enable-libxcb-shape \
	--enable-libxcb-shm \
	--enable-libxcb-xfixes
FFMPEG_SUNSHINE_DEPENDENCIES += libxcb
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libxcb
endif

ifeq ($(BR2_PACKAGE_FFMPEG_SUNSHINE_SWSCALE),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-swscale
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-swscale
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG_SUNSHINE_ENCODERS)),all)
FFMPEG_SUNSHINE_CONF_OPTS += --disable-encoders \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG_SUNSHINE_ENCODERS)),--enable-encoder=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG_SUNSHINE_DECODERS)),all)
FFMPEG_SUNSHINE_CONF_OPTS += --disable-decoders \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG_SUNSHINE_DECODERS)),--enable-decoder=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG_SUNSHINE_MUXERS)),all)
FFMPEG_SUNSHINE_CONF_OPTS += --disable-muxers \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG_SUNSHINE_MUXERS)),--enable-muxer=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG_SUNSHINE_DEMUXERS)),all)
FFMPEG_SUNSHINE_CONF_OPTS += --disable-demuxers \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG_SUNSHINE_DEMUXERS)),--enable-demuxer=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG_SUNSHINE_PARSERS)),all)
FFMPEG_SUNSHINE_CONF_OPTS += --disable-parsers \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG_SUNSHINE_PARSERS)),--enable-parser=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG_SUNSHINE_BSFS)),all)
FFMPEG_SUNSHINE_CONF_OPTS += --disable-bsfs \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG_SUNSHINE_BSFS)),--enable-bsf=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG_SUNSHINE_PROTOCOLS)),all)
FFMPEG_SUNSHINE_CONF_OPTS += --disable-protocols \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG_SUNSHINE_PROTOCOLS)),--enable-protocol=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG_SUNSHINE_FILTERS)),all)
FFMPEG_SUNSHINE_CONF_OPTS += --disable-filters \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG_SUNSHINE_FILTERS)),--enable-filter=$(x))
endif

ifeq ($(BR2_PACKAGE_FFMPEG_SUNSHINE_INDEVS),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-indevs
ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-alsa
FFMPEG_SUNSHINE_DEPENDENCIES += alsa-lib
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-alsa
endif
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-indevs
endif

ifeq ($(BR2_PACKAGE_FFMPEG_SUNSHINE_OUTDEVS),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-outdevs
ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
FFMPEG_SUNSHINE_DEPENDENCIES += alsa-lib
endif
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-outdevs
endif

ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-pthreads
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-pthreads
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-zlib
FFMPEG_SUNSHINE_DEPENDENCIES += zlib
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-zlib
endif

ifeq ($(BR2_PACKAGE_BZIP2),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-bzlib
FFMPEG_SUNSHINE_DEPENDENCIES += bzip2
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-bzlib
endif

ifeq ($(BR2_PACKAGE_FDK_AAC)$(BR2_PACKAGE_FFMPEG_SUNSHINE_NONFREE),yy)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-libfdk-aac
FFMPEG_SUNSHINE_DEPENDENCIES += fdk-aac
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libfdk-aac
endif

ifeq ($(BR2_PACKAGE_FFMPEG_SUNSHINE_GPL)$(BR2_PACKAGE_LIBCDIO_PARANOIA),yy)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-libcdio
FFMPEG_SUNSHINE_DEPENDENCIES += libcdio-paranoia
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libcdio
endif

ifeq ($(BR2_PACKAGE_GNUTLS),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-gnutls --disable-openssl
FFMPEG_SUNSHINE_DEPENDENCIES += gnutls
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-gnutls
ifeq ($(BR2_PACKAGE_OPENSSL),y)
# openssl isn't license compatible with GPL
ifeq ($(BR2_PACKAGE_FFMPEG_SUNSHINE_GPL)x$(BR2_PACKAGE_FFMPEG_SUNSHINE_NONFREE),yx)
FFMPEG_SUNSHINE_CONF_OPTS += --disable-openssl
else
FFMPEG_SUNSHINE_CONF_OPTS += --enable-openssl
FFMPEG_SUNSHINE_DEPENDENCIES += openssl
endif
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-openssl
endif
endif

ifeq ($(BR2_PACKAGE_LIBDRM),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-libdrm
FFMPEG_SUNSHINE_DEPENDENCIES += libdrm
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libdrm
endif

ifeq ($(BR2_PACKAGE_LIBOPENH264),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-libopenh264
FFMPEG_SUNSHINE_DEPENDENCIES += libopenh264
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libopenh264
endif

ifeq ($(BR2_PACKAGE_LIBVORBIS),y)
FFMPEG_SUNSHINE_DEPENDENCIES += libvorbis
FFMPEG_SUNSHINE_CONF_OPTS += \
	--enable-libvorbis \
	--enable-muxer=ogg \
	--enable-encoder=libvorbis
endif

ifeq ($(BR2_PACKAGE_LIBVA),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-vaapi
FFMPEG_SUNSHINE_DEPENDENCIES += libva
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-vaapi
endif

ifeq ($(BR2_PACKAGE_LIBVDPAU),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-vdpau
FFMPEG_SUNSHINE_DEPENDENCIES += libvdpau
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-vdpau
endif

# To avoid a circular dependency only use opencv if opencv itself does
# not depend on ffmpeg.
ifeq ($(BR2_PACKAGE_OPENCV4_LIB_IMGPROC)x$(BR2_PACKAGE_OPENCV4_WITH_FFMPEG),yx)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-libopencv \
	--extra-cflags=-I$(STAGING_DIR)/usr/include/opencv4
FFMPEG_SUNSHINE_DEPENDENCIES += opencv4
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libopencv
endif

ifeq ($(BR2_PACKAGE_OPUS),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-libopus
FFMPEG_SUNSHINE_DEPENDENCIES += opus
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libopus
endif

ifeq ($(BR2_PACKAGE_LIBVPX),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-libvpx
FFMPEG_SUNSHINE_DEPENDENCIES += libvpx
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libvpx
endif

ifeq ($(BR2_PACKAGE_LIBASS),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-libass
FFMPEG_SUNSHINE_DEPENDENCIES += libass
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libass
endif

ifeq ($(BR2_PACKAGE_LIBBLURAY),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-libbluray
FFMPEG_SUNSHINE_DEPENDENCIES += libbluray
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libbluray
endif

ifeq ($(BR2_PACKAGE_LIBVPL),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-libvpl --disable-libmfx
FFMPEG_SUNSHINE_DEPENDENCIES += libvpl
else ifeq ($(BR2_PACKAGE_INTEL_MEDIASDK),y)
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libvpl --enable-libmfx
FFMPEG_SUNSHINE_DEPENDENCIES += intel-mediasdk
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libvpl --disable-libmfx
endif

ifeq ($(BR2_PACKAGE_RTMPDUMP),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-librtmp
FFMPEG_SUNSHINE_DEPENDENCIES += rtmpdump
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-librtmp
endif

ifeq ($(BR2_PACKAGE_LAME),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-libmp3lame
FFMPEG_SUNSHINE_DEPENDENCIES += lame
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libmp3lame
endif

ifeq ($(BR2_PACKAGE_LIBMODPLUG),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-libmodplug
FFMPEG_SUNSHINE_DEPENDENCIES += libmodplug
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libmodplug
endif

ifeq ($(BR2_PACKAGE_LIBOPENMPT),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-libopenmpt
FFMPEG_SUNSHINE_DEPENDENCIES += libopenmpt
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libopenmpt
endif

ifeq ($(BR2_PACKAGE_LIBSOXR),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-libsoxr
FFMPEG_SUNSHINE_DEPENDENCIES += libsoxr
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libsoxr
endif

ifeq ($(BR2_PACKAGE_SPEEX),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-libspeex
FFMPEG_SUNSHINE_DEPENDENCIES += speex
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libspeex
endif

ifeq ($(BR2_PACKAGE_LIBTHEORA),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-libtheora
FFMPEG_SUNSHINE_DEPENDENCIES += libtheora
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libtheora
endif

ifeq ($(BR2_PACKAGE_LIBICONV),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-iconv
FFMPEG_SUNSHINE_DEPENDENCIES += libiconv
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-iconv
endif

ifeq ($(BR2_PACKAGE_LIBXML2),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-libxml2
FFMPEG_SUNSHINE_DEPENDENCIES += libxml2
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libxml2
endif

# ffmpeg freetype support require fenv.h which is only
# available/working on glibc.
# The microblaze variant doesn't provide the needed exceptions
ifeq ($(BR2_PACKAGE_FREETYPE)$(BR2_TOOLCHAIN_USES_GLIBC)x$(BR2_microblaze),yyx)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-libfreetype
FFMPEG_SUNSHINE_DEPENDENCIES += freetype
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libfreetype
endif

ifeq ($(BR2_PACKAGE_FONTCONFIG),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-fontconfig
FFMPEG_SUNSHINE_DEPENDENCIES += fontconfig
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-fontconfig
endif

ifeq ($(BR2_PACKAGE_HARFBUZZ),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-libharfbuzz
FFMPEG_SUNSHINE_DEPENDENCIES += harfbuzz
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libharfbuzz
endif

ifeq ($(BR2_PACKAGE_LIBFRIBIDI),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-libfribidi
FFMPEG_SUNSHINE_DEPENDENCIES += libfribidi
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libfribidi
endif

ifeq ($(BR2_PACKAGE_OPENJPEG),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-libopenjpeg
FFMPEG_SUNSHINE_DEPENDENCIES += openjpeg
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libopenjpeg
endif

ifeq ($(BR2_PACKAGE_X264)$(BR2_PACKAGE_FFMPEG_SUNSHINE_GPL),yy)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-libx264
FFMPEG_SUNSHINE_DEPENDENCIES += x264
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libx264
endif

ifeq ($(BR2_PACKAGE_X265)$(BR2_PACKAGE_FFMPEG_SUNSHINE_GPL),yy)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-libx265
FFMPEG_SUNSHINE_DEPENDENCIES += x265
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libx265
endif

ifeq ($(BR2_PACKAGE_DAV1D),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-libdav1d
FFMPEG_SUNSHINE_DEPENDENCIES += dav1d
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-libdav1d
endif

ifeq ($(BR2_X86_CPU_HAS_MMX),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-x86asm
FFMPEG_SUNSHINE_DEPENDENCIES += host-nasm
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-x86asm
FFMPEG_SUNSHINE_CONF_OPTS += --disable-mmx
endif

ifeq ($(BR2_X86_CPU_HAS_SSE),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-sse
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-sse
endif

ifeq ($(BR2_X86_CPU_HAS_SSE2),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-sse2
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-sse2
endif

ifeq ($(BR2_X86_CPU_HAS_SSE3),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-sse3
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-sse3
endif

ifeq ($(BR2_X86_CPU_HAS_SSSE3),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-ssse3
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-ssse3
endif

ifeq ($(BR2_X86_CPU_HAS_SSE4),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-sse4
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-sse4
endif

ifeq ($(BR2_X86_CPU_HAS_SSE42),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-sse42
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-sse42
endif

ifeq ($(BR2_X86_CPU_HAS_AVX),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-avx
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-avx
endif

ifeq ($(BR2_X86_CPU_HAS_AVX2),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-avx2
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-avx2
endif

# Explicitly disable everything that doesn't match for ARM
# FFMPEG "autodetects" by compiling an extended instruction via AS
# This works on compilers that aren't built for generic by default
ifeq ($(BR2_ARM_CPU_ARMV4),y)
FFMPEG_SUNSHINE_CONF_OPTS += --disable-armv5te
endif
ifeq ($(BR2_ARM_CPU_ARMV6)$(BR2_ARM_CPU_ARMV7A),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-armv6
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-armv6 --disable-armv6t2
endif
ifeq ($(BR2_ARM_CPU_HAS_VFPV2),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-vfp
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-vfp
endif
ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-neon
else ifeq ($(BR2_aarch64),y)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-neon
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-neon
endif

ifeq ($(BR2_mips)$(BR2_mipsel)$(BR2_mips64)$(BR2_mips64el),y)
ifeq ($(BR2_MIPS_SOFT_FLOAT),y)
FFMPEG_SUNSHINE_CONF_OPTS += --disable-mipsfpu
else
FFMPEG_SUNSHINE_CONF_OPTS += --enable-mipsfpu
endif

# Fix build failure on several missing assembly instructions
FFMPEG_SUNSHINE_CONF_OPTS += --disable-asm
endif # MIPS

ifeq ($(BR2_POWERPC_CPU_HAS_ALTIVEC):$(BR2_powerpc64le),y:)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-altivec
else ifeq ($(BR2_POWERPC_CPU_HAS_VSX):$(BR2_powerpc64le),y:y)
# On LE, ffmpeg AltiVec support needs VSX intrinsics, and VSX
# is an extension to AltiVec.
FFMPEG_SUNSHINE_CONF_OPTS += --enable-altivec
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-altivec
endif

# Fix build failure on several missing assembly instructions
ifeq ($(BR2_RISCV_32),y)
FFMPEG_SUNSHINE_CONF_OPTS += --disable-rvv --disable-asm
endif

# Uses __atomic_fetch_add_4
ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
FFMPEG_SUNSHINE_CONF_OPTS += --extra-libs=-latomic
endif

ifeq ($(BR2_STATIC_LIBS),)
FFMPEG_SUNSHINE_CONF_OPTS += --enable-pic
else
FFMPEG_SUNSHINE_CONF_OPTS += --disable-pic
endif

# Default to --cpu=generic for MIPS architecture, in order to avoid a
# warning from ffmpeg's configure script.
ifeq ($(BR2_mips)$(BR2_mipsel)$(BR2_mips64)$(BR2_mips64el),y)
FFMPEG_SUNSHINE_CONF_OPTS += --cpu=generic
else ifneq ($(GCC_TARGET_CPU),)
FFMPEG_SUNSHINE_CONF_OPTS += --cpu="$(GCC_TARGET_CPU)"
else ifneq ($(GCC_TARGET_ARCH),)
FFMPEG_SUNSHINE_CONF_OPTS += --cpu="$(GCC_TARGET_ARCH)"
endif

FFMPEG_SUNSHINE_CFLAGS = $(TARGET_CFLAGS)

ifeq ($(BR2_TOOLCHAIN_HAS_GCC_BUG_85180),y)
FFMPEG_SUNSHINE_CONF_OPTS += --disable-optimizations
FFMPEG_SUNSHINE_CFLAGS += -O0
endif

ifeq ($(BR2_TOOLCHAIN_HAS_GCC_BUG_68485),y)
FFMPEG_SUNSHINE_CONF_OPTS += --disable-optimizations
FFMPEG_SUNSHINE_CFLAGS += -O0
endif

ifeq ($(BR2_ARM_INSTRUCTIONS_THUMB),y)
FFMPEG_SUNSHINE_CFLAGS += -marm
endif

FFMPEG_SUNSHINE_CONF_ENV += CFLAGS="$(FFMPEG_CFLAGS)"
FFMPEG_SUNSHINE_CONF_OPTS += $(call qstrip,$(BR2_PACKAGE_FFMPEG_SUNSHINE_EXTRACONF))

# Override FFMPEG_SUNSHINE_CONFIGURE_CMDS: FFmpeg does not support --target and others
define FFMPEG_SUNSHINE_CONFIGURE_CMDS
	(cd $(FFMPEG_SUNSHINE_SRCDIR) && rm -rf config.cache && \
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_CONFIGURE_ARGS) \
	$(FFMPEG_SUNSHINE_CONF_ENV) \
	./configure \
		--enable-cross-compile \
		--cross-prefix=$(TARGET_CROSS) \
		--sysroot=$(STAGING_DIR) \
		--host-cc="$(HOSTCC)" \
		--arch=$(BR2_ARCH) \
		--target-os="linux" \
		--disable-stripping \
		--pkg-config="$(PKG_CONFIG_HOST_BINARY)" \
		$(SHARED_STATIC_LIBS_OPTS) \
		$(FFMPEG_SUNSHINE_CONF_OPTS) \
	)
endef

define FFMPEG_SUNSHINE_REMOVE_EXAMPLE_SRC_FILES
	rm -rf $(TARGET_DIR)/usr/share/ffmpeg/examples
endef
FFMPEG_SUNSHINE_POST_INSTALL_TARGET_HOOKS += FFMPEG_REMOVE_EXAMPLE_SRC_FILES

$(eval $(autotools-package))
