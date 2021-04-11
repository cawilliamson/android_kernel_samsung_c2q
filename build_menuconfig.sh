#!/bin/bash

export ARCH=arm64
mkdir -p out

ANDROID_MAJOR_VERSION="r"
PLATFORM_VERSION=11
export ANDROID_MAJOR_VERSION PLATFORM_VERSION

BUILD_CROSS_COMPILE="/opt/aarch64-linux-android-4.9/bin/aarch64-linux-android-"
KERNEL_LLVM_BIN="/opt/qcom-clang-8/bin/clang"
CLANG_TRIPLE="aarch64-linux-gnu-"
KERNEL_MAKE_ENV="DTC_EXT=$(pwd)/tools/dtc CONFIG_BUILD_ARM64_DT_OVERLAY=y"

make -C $(pwd) \
  O=$(pwd)/out \
  $KERNEL_MAKE_ENV \
  CROSS_COMPILE=$BUILD_CROSS_COMPILE \
  REAL_CC=$KERNEL_LLVM_BIN \
  CLANG_TRIPLE=$CLANG_TRIPLE \
  vendor/c2q_chn_openx_defconfig

make menuconfig -C $(pwd) \
  O=$(pwd)/out \
  $KERNEL_MAKE_ENV \
  CROSS_COMPILE=$BUILD_CROSS_COMPILE \
  REAL_CC=$KERNEL_LLVM_BIN \
  CLANG_TRIPLE=$CLANG_TRIPLE
