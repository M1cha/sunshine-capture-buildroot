# SPDX-License-Identifier: MIT

cmake_minimum_required(VERSION 3.18)
project(libcbs)

# set architecture
string(TOLOWER ${CMAKE_SYSTEM_PROCESSOR} arch)

if(${arch} STREQUAL "aarch64" OR ${arch} STREQUAL "arm64")
    set(CBS_ARCH_PATH arm)
elseif (${arch} STREQUAL "ppc64le")
    set(CBS_ARCH_PATH ppc)
elseif (${arch} STREQUAL "amd64" OR ${arch} STREQUAL "x86_64")
    set(CBS_ARCH_PATH x86)
elseif (${arch} STREQUAL "mips")
    set(CBS_ARCH_PATH mips)
else()
    message(FATAL_ERROR "Unsupported system processor:" ${CMAKE_SYSTEM_PROCESSOR})
endif()

set(AVCODEC_GENERATED_SRC_PATH ${FFMPEG_GENERATED_SRC_PATH}/libavcodec)
set(AVUTIL_GENERATED_SRC_PATH ${FFMPEG_GENERATED_SRC_PATH}/libavutil)

set(EXTRA_FFMPEG_INCLUDE_FILES
        ${FFMPEG_GENERATED_SRC_PATH}/config.h
)
set(EXTRA_AVCODEC_INCLUDE_FILES
        ${AVCODEC_GENERATED_SRC_PATH}/av1.h
        ${AVCODEC_GENERATED_SRC_PATH}/cbs_av1.h
        ${AVCODEC_GENERATED_SRC_PATH}/cbs_bsf.h
        ${AVCODEC_GENERATED_SRC_PATH}/cbs.h
        ${AVCODEC_GENERATED_SRC_PATH}/cbs_h2645.h
        ${AVCODEC_GENERATED_SRC_PATH}/cbs_h264.h
        ${AVCODEC_GENERATED_SRC_PATH}/cbs_h265.h
        ${AVCODEC_GENERATED_SRC_PATH}/cbs_jpeg.h
        ${AVCODEC_GENERATED_SRC_PATH}/cbs_mpeg2.h
        ${AVCODEC_GENERATED_SRC_PATH}/cbs_sei.h
        ${AVCODEC_GENERATED_SRC_PATH}/cbs_vp8.h
        ${AVCODEC_GENERATED_SRC_PATH}/cbs_vp9.h
        ${AVCODEC_GENERATED_SRC_PATH}/codec_desc.h
        ${AVCODEC_GENERATED_SRC_PATH}/codec_id.h
        ${AVCODEC_GENERATED_SRC_PATH}/codec_par.h
        ${AVCODEC_GENERATED_SRC_PATH}/defs.h
        ${AVCODEC_GENERATED_SRC_PATH}/get_bits.h
        ${AVCODEC_GENERATED_SRC_PATH}/h264_levels.h
        ${AVCODEC_GENERATED_SRC_PATH}/h2645_parse.h
        ${AVCODEC_GENERATED_SRC_PATH}/h264.h
        ${AVCODEC_GENERATED_SRC_PATH}/mathops.h
        ${AVCODEC_GENERATED_SRC_PATH}/packet.h
        ${AVCODEC_GENERATED_SRC_PATH}/sei.h
        ${AVCODEC_GENERATED_SRC_PATH}/version_major.h
        ${AVCODEC_GENERATED_SRC_PATH}/vlc.h
)
set(EXTRA_AVCODEC_HEVC_INCLUDE_FILES
        ${AVCODEC_GENERATED_SRC_PATH}/hevc/hevc.h
)
set(EXTRA_AVUTIL_INCLUDE_FILES
        ${AVUTIL_GENERATED_SRC_PATH}/attributes.h
        ${AVUTIL_GENERATED_SRC_PATH}/attributes_internal.h
        ${AVUTIL_GENERATED_SRC_PATH}/intmath.h
)

set(CBS_SOURCE_FILES
        ${AVCODEC_GENERATED_SRC_PATH}/cbs.c
        ${AVCODEC_GENERATED_SRC_PATH}/cbs_h2645.c
        ${AVCODEC_GENERATED_SRC_PATH}/cbs_av1.c
        ${AVCODEC_GENERATED_SRC_PATH}/cbs_vp8.c
        ${AVCODEC_GENERATED_SRC_PATH}/cbs_vp9.c
        ${AVCODEC_GENERATED_SRC_PATH}/cbs_mpeg2.c
        ${AVCODEC_GENERATED_SRC_PATH}/cbs_jpeg.c
        ${AVCODEC_GENERATED_SRC_PATH}/cbs_sei.c
        ${AVCODEC_GENERATED_SRC_PATH}/h264_levels.c
        ${AVCODEC_GENERATED_SRC_PATH}/h2645_parse.c
        ${AVCODEC_GENERATED_SRC_PATH}/vp8data.c
        ${AVUTIL_GENERATED_SRC_PATH}/intmath.c
)

add_library(cbs STATIC ${CBS_SOURCE_FILES})
target_include_directories(cbs PRIVATE
        ${FFMPEG_GENERATED_SRC_PATH}
)
target_compile_options(cbs PRIVATE -Wall -Wno-incompatible-pointer-types -Wno-format -Wno-format-extra-args)

# install cbs target headers
install(FILES ${EXTRA_FFMPEG_INCLUDE_FILES}
        DESTINATION ${CMAKE_INSTALL_PREFIX}/include)
install(FILES ${EXTRA_AVCODEC_INCLUDE_FILES}
        DESTINATION ${CMAKE_INSTALL_PREFIX}/include/libavcodec)
install(FILES ${EXTRA_AVCODEC_HEVC_INCLUDE_FILES}
        DESTINATION ${CMAKE_INSTALL_PREFIX}/include/libavcodec/hevc)
install(FILES ${EXTRA_AVUTIL_INCLUDE_FILES}
        DESTINATION ${CMAKE_INSTALL_PREFIX}/include/libavutil)
install(TARGETS cbs
        DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)

# conditional headers based on architecture
if (EXISTS ${AVCODEC_GENERATED_SRC_PATH}/${CBS_ARCH_PATH}/mathops.h)
    install(FILES ${AVCODEC_GENERATED_SRC_PATH}/${CBS_ARCH_PATH}/mathops.h
            DESTINATION ${CMAKE_INSTALL_PREFIX}/include/libavcodec/${CBS_ARCH_PATH})
endif()
if (EXISTS ${AVUTIL_GENERATED_SRC_PATH}/${CBS_ARCH_PATH}/asm.h)
    install(FILES ${AVUTIL_GENERATED_SRC_PATH}/${CBS_ARCH_PATH}/asm.h
            DESTINATION ${CMAKE_INSTALL_PREFIX}/include/libavutil/${CBS_ARCH_PATH})
endif()
if (EXISTS ${AVUTIL_GENERATED_SRC_PATH}/${CBS_ARCH_PATH}/intmath.h)
    install(FILES ${AVUTIL_GENERATED_SRC_PATH}/${CBS_ARCH_PATH}/intmath.h
            DESTINATION ${CMAKE_INSTALL_PREFIX}/include/libavutil/${CBS_ARCH_PATH})
endif()

