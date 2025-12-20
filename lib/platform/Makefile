#
# Cross Platform Makefile
# For now, build for Windows and Mac uses VSCode MSBuild and XCode tools
#
.PHONY: all deb clean

# default value for command-line arguments (like make BUILD_TYPE=Release)
BUILD_TYPE ?= Debug

##---------------------------------------------------------------------
## BUILD RULES
##---------------------------------------------------------------------

all: deb

deb:
	cd sdl3-deb/libsdl3-* && LANG=C dpkg-buildpackage -uc -us
	
clean:
	cd sdl3-deb && rm -f *.deb *.ddeb *.buildinfo *.changes *.dsc
