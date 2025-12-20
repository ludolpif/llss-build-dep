#
# Cross Platform Makefile
# For now, build for Windows and Mac uses VSCode MSBuild and XCode tools
#
DIRS := $(patsubst %/Makefile,%,$(wildcard */Makefile))

.PHONY: all clean $(DIRS)

# default value for command-line arguments (like make BUILD_TYPE=Release)
BUILD_TYPE ?= Debug

##---------------------------------------------------------------------
## BUILD RULES
##---------------------------------------------------------------------

all: $(DIRS)

$(DIRS):
	$(MAKE) -C $@ BUILD_TYPE=$(BUILD_TYPE)

clean:
	for dir in $(DIRS); do $(MAKE) -C $$dir clean BUILD_TYPE=$(BUILD_TYPE); done
