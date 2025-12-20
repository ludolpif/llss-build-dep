#
# Cross Platform Makefile
# For now, build for Windows and Mac uses VSCode MSBuild and XCode tools
#
.PHONY: all clean lib

# default value for command-line arguments (like make BUILD_TYPE=Release)
BUILD_TYPE ?= Debug

all: lib

lib:
	$(MAKE) -C lib BUILD_TYPE=$(BUILD_TYPE)

clean:
	$(MAKE) -C lib clean BUILD_TYPE=$(BUILD_TYPE)
