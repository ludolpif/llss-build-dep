#!/bin/sh
copy_to() {
	mkdir -p "$1"
	while read -r path; do
		mkdir -p "$1/$(dirname "$path")"
		cp -r "$path" "$1/$path"
	done
}

progname=$(./get --name)
version=$(./get --version)
prettyos=$(./get --prettyos)
artifact=$progname-$version-$prettyos-$1
logs="configure-$progname.log"

case $1 in
	Sources)
		artifact=$progname-$version-Sources
		ls -d lib $logs | copy_to artifacts/$artifact
		rm -f artifacts/$artifact/lib/platform/sdl3-deb/*.tar.xz
		;;
	Debug|Release)
		headers="
		lib/ui/dear_bindings_generated/*.h
		lib/ui/imgui/*.h
		lib/ui/dear_bindings_generated/backends/*.h
		lib/ui/imgui/backends/*.h
		lib/ecs/flecs/*.h"
		libs="
		lib/ui/x64/$1/libdcimgui.a
		lib/ecs/x64/$1/flecs.o"
		ls -d $libs $headers $logs | copy_to artifacts/$artifact
		;;
	SystemLibs)
		ls -d lib/platform/sdl3-deb/libsdl3*deb $logs | copy_to artifacts/$artifact
		rm -f artifacts/$artifact/lib/platform/sdl3-deb/libsdl3-doc*.deb
		;;
	*) echo "Usage $0 (Sources|Debug|Release|SystemLibs)" >&2; exit 1 ;;
esac
echo artifact=$artifact
