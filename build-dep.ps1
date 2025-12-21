$SDL_VERSION = "3.2.10"

$url = "https://github.com/libsdl-org/SDL/releases/download/release-${SDL_VERSION}/SDL3-devel-${SDL_VERSION}-VC.zip"

Push-Location "lib\platform"
Remove-Item -Recurse -Force -Path "sdl3-devel-vc" -ErrorAction SilentlyContinue
if (-Not (Test-Path "sdl3-devel-vc.zip")) {
    Invoke-WebRequest -Uri $url -OutFile "sdl3-devel-vc.zip"
}
Expand-Archive -Path "sdl3-devel-vc.zip" -Force
Rename-Item -Path "SDL3-${SDL_VERSION}" -NewName "sdl3-devel-vc"
Remove-Item -Path "sdl3-devel-vc.zip"
Pop-Location
