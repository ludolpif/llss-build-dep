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

case $1 in
    Sources)
		artifact=$progname-$version-Sources
		git ls-files | copy_to artifacts/$artifact
		echo artifact=$artifact
	;;
    Debug|Release)
		artifact=$progname-$version-$prettyos-$1
		headers="
		lib/ui/dear_bindings_generated/*.h
		lib/ui/imgui/*.h
		lib/ui/dear_bindings_generated/backends/*.h
		lib/ui/imgui/backends/*.h
		lib/ecs/flecs/*.h"
		libs="
		lib/ui/x64/$1/libdcimgui.a
		lib/ecs/x64/$1/flecs.o
		lib/platform/sdl3-deb/libsdl*.deb
		"
		ls -d $libs $headers | copy_to artifacts/$artifact
		echo artifact=$artifact
	;;
    *) echo "Usage $0 (Sources|Debug|Release)" >&2; exit 1 ;;
esac
exit 0
