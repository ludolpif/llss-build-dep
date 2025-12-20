#!/bin/bash -xe
# Script usefull only in Ubuntu 24.04 because Github CI have only LTS ubuntu and libsdl3 is not in those repo yet
version=3.2.10+ds

export LANG=C
pkg=libsdl3_$version
[ -f libsdl3-dev_$version-1_amd64.deb ] && exit 0

for f in $pkg-1.dsc $pkg.orig.tar.xz $pkg-1.debian.tar.xz
do
	[ -f $f ] || curl -o $f http://deb.debian.org/debian/pool/main/libs/libsdl3/$f
done

mkdir libsdl3-$version
tar -xf $pkg.orig.tar.xz --strip-components=1 -C libsdl3-$version
tar -xf $pkg-1.debian.tar.xz -C libsdl3-$version
dpkg-source --before-build libsdl3-$version

sed --in-place -e 's/main$/main universe/g' /etc/apt/sources.list
apt update
apt install cmake debhelper fcitx-libs-dev glslang-tools libasound2-dev libdbus-1-dev libdecor-0-dev libdrm-dev libegl-dev libgbm-dev libgl-dev libgles-dev libibus-1.0-dev libpipewire-0.3-dev libpulse-dev libsndio-dev libudev-dev liburing-dev libvulkan-dev libwayland-dev libx11-dev libxcursor-dev libxext-dev libxfixes-dev libxi-dev libxinerama-dev libxkbcommon-dev libxrandr-dev libxss-dev libxt-dev libxv-dev libxxf86vm-dev pkgconf wayland-protocols xxd graphviz doxygen
# missing libusb2-dev libusbhid-dev but build don't fail

( cd libsdl3-$version && dpkg-buildpackage -uc -us )

rm -rf libsdl3-$version *.xz
