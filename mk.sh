#!/bin/bash
export CROSS_COMPILE=/home/kernel/gcc-linaro-arm-linux-gnueabi-2012.03-20120326_linux/bin/arm-linux-gnueabi-

find ../initramfs -name ".git*" -exec rm -rf {} \;
find ../initramfs -name EMPTY_DIRECTORY -exec rm -rf {} \;
find -name '*.ko' -exec cp -av {} ../initramfs/lib/modules/ \;
chmod 644 ../initramfs/lib/modules/*
${CROSS_COMPILE}strip --strip-unneeded ../initramfs/lib/modules/*
chmod g-w ../initramfs/*.rc ../initramfs/default.prop && \

rm zImage
# make clean
make -j16 arch=arm
cp arch/arm/boot/zImage zImage_in
./mkshbootimg.py zImage zImage_in payload.tar recovery.tar.xz


