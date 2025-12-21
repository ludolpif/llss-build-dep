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
param (
    [Parameter(Mandatory = $false)]
    [string]$Configuration
)

if ($Configuration -ne "Debug" -and $Configuration -ne "Release") {
    [Console]::Error.WriteLine("Usage: $PSCommandPath (Debug|Release)")
    exit 1
}

$sdl_version = "3.2.10"
$sdl_url = "https://github.com/libsdl-org/SDL/releases/download/release-${sdl_version}/SDL3-devel-${sdl_version}-VC.zip"

$build_dep_version = "0.2.0.0"
$build_dep_zip = "build-dep-${build_dep_version}-Sources.zip"
$build_dep_url = "https://ludolpif.fr/pub/llss/artifacts/$build_dep_zip"

"::notice:: Push-Location "lib\platform""
Push-Location "lib\platform"

"::notice:: remove sdl3-devel-vc folder if any"
Remove-Item -Recurse -Force -Path "sdl3-devel-vc" -ErrorAction SilentlyContinue

"::notice:: re-use or download 'sdl3-devel-vc.zip'"
if (-Not (Test-Path "sdl3-devel-vc.zip")) {
    Invoke-WebRequest -Uri $sdl_url -OutFile "sdl3-devel-vc.zip"
}
"::notice:: unzip 'sdl3-devel-vc.zip'"
Expand-Archive -Path "sdl3-devel-vc.zip" -DestinationPath "." -Force

"::group::lib\platform content before renaming"
Get-ChildItem -Force # ls -a equivalent
"::endgroup::"

Rename-Item -Path "SDL3-${sdl_version}" -NewName "sdl3-devel-vc"

# Remove-Item -Path "sdl3-devel-vc.zip"
"::group::lib\platform content at end of script"
Get-ChildItem -Force # ls -a equivalent
"::endgroup::"

'::notice:: Pop-Location to git root'
Pop-Location


"::notice:: re-use or download '$build_dep_zip'"
if (-Not (Test-Path "$build_dep_zip")) {
    Invoke-WebRequest -Uri $build_dep_url -OutFile "$build_dep_zip"
}
"::notice:: unzip '$build_dep_zip'"
Expand-Archive -Path "$build_dep_zip" -DestinationPath "." -Force

# Remove-Item -Path "$build_dep_zip"
"::group::lib\platform content at end of script"
Get-ChildItem -Force # ls -a equivalent
"::endgroup::"
