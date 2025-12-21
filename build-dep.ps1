param (
    [Parameter(Mandatory = $false)]
    [string]$Configuration
)

if ($Configuration -ne "Debug" -and $Configuration -ne "Release") {
    [Console]::Error.WriteLine("Usage: $PSCommandPath (Debug|Release)")
    exit 1
}

$version = "3.2.10"
$url = "https://github.com/libsdl-org/SDL/releases/download/release-$version/SDL3-devel-$version-VC.zip"

'::notice Push-Location "lib\platform"'
Push-Location "lib\platform"
Remove-Item -Recurse -Force -Path "sdl3-devel-vc" -ErrorAction SilentlyContinue

'::notice re-use or download "sdl3-devel-vc.zip'
if (-Not (Test-Path "sdl3-devel-vc.zip")) {
    Invoke-WebRequest -Uri $url -OutFile "sdl3-devel-vc.zip"
}
Expand-Archive -Path "sdl3-devel-vc.zip" -DestinationPath "." -Force
'::group::lib\platform content'
Get-ChildItem -Force # ls -a equivalent
'::endgroup::'
Rename-Item -Path "SDL3-${version}" -NewName "sdl3-devel-vc"
Remove-Item -Path "sdl3-devel-vc.zip"
Pop-Location