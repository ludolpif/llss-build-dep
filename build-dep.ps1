$version = "3.2.10"

$url = "https://github.com/libsdl-org/SDL/releases/download/release-${version}/SDL3-devel-${version}-VC.zip"

Push-Location "lib\platform"
Remove-Item -Recurse -Force -Path "sdl3-devel-vc" -ErrorAction SilentlyContinue
if (-Not (Test-Path "sdl3-devel-vc.zip")) {
    Invoke-WebRequest -Uri $url -OutFile "sdl3-devel-vc.zip"
}
Expand-Archive -Path "sdl3-devel-vc.zip" -Force
Rename-Item -Path "SDL3-${version}" -NewName "sdl3-devel-vc"
Remove-Item -Path "sdl3-devel-vc.zip"
Pop-Location
