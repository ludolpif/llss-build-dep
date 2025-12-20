#!/bin/sh
copy_to() {
    mkdir -p "$1"
    while read -r path; do
		mkdir -p "$1/$(dirname "$path")"
		cp -r "$path" "$1/$path"
    done
}

name=$(./get --name)
version=$(./get --version)
prettyos=$(./get --prettyos)
case $1 in
    Sources)
		target=artifacts/$name-$version-Sources
		git ls-files | copy_to "$target"
	;;
    Debug|Release)
		target=artifacts/$name-$version-$prettyos-$1
		headers="./lib/ui/dear_bindings_generated/*.h
		lib/ui/imgui/*.h
		lib/ui/dear_bindings_generated/backends/*.h
		lib/ui/imgui/backends/*.h
		lib/ecs/flecs/*.h"
		libs="
		lib/ui/x64/$1/libdcimgui.a
		lib/ecs/x64/$1/flecs.o
		"
		ls $libs $headers | copy_to "$target"
	;;
    *) echo "Usage $0 (Sources|Debug|Release)" >&2; exit 1 ;;
esac
exit 0
