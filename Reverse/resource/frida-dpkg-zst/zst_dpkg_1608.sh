#!/bin/bash
####################
#Description: frida安装报错，dpkg-deb --control subprocess returned error exit status 2
#             Sub-process /usr/libexec/cydia/cydo returned an error code (1)

#Author:augus
#Version:1.0
#CreateTime:2023-01-25 16:09:43
####################

# on MacOS
FRIDA_VERSION="16.0.8"
# brew reinstall wget
wget https://github.com/frida/frida/releases/download/"${FRIDA_VERSION}"/frida_"${FRIDA_VERSION}"_iphoneos-arm.deb 
frida_"${FRIDA_VERSION}"_iphoneos-arm.deb

mkdir frida_"${FRIDA_VERSION}"_iphoneos-arm
cd frida_"${FRIDA_VERSION}"_iphoneos-arm
ar -x ../frida_"${FRIDA_VERSION}"_iphoneos-arm.deb
# brew reinstall zstd
zstd -d *.zst
# brew reinstall xz
xz *.tar
ar r frida_"${FRIDA_VERSION}"_iphoneos-arm-repacked.deb debian-binary control.tar.xz data.tar.xz

# scp frida_"${FRIDA_VERSION}"_iphoneos-arm-repacked.deb iphone:/var/root

# on iOS
# FRIDA_VERSION="16.0.8"
# cd /var/root
# dpkg -i  frida_"${FRIDA_VERSION}"_iphoneos-arm-repacked.deb
