#!/bin/sh
#
# This file is part of LLSS.
#
# LLSS is free software: you can redistribute it and/or modify it under the terms of the
# Affero GNU General Public License as published by the Free Software Foundation,
# either version 3 of the License, or (at your option) any later version.
#
# LLSS is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
# without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with LLSS.
# If not, see <https://www.gnu.org/licenses/>. See LICENSE file at root of this git repo.
#
# Copyright 2025 ludolpif <ludolpif@gmail.com>
#
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
		lib/ui/imgui_config.h
		lib/ecs/flecs/*.h"
		libs="
		lib/ui/x64/$1/libdcimgui.a
		lib/ecs/x64/$1/flecs.o"
		ls -d $libs $headers $logs | copy_to artifacts/$artifact
		;;
	SystemLibs)
		ls -d lib/platform/sdl3-deb/libsdl3*deb | copy_to artifacts/$artifact
		rm -f artifacts/$artifact/lib/platform/sdl3-deb/libsdl3-doc*.deb
		;;
	*) echo "Usage $0 (Sources|Debug|Release|SystemLibs)" >&2; exit 1 ;;
esac
echo artifact=$artifact
