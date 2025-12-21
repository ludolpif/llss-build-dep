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
# For now, build for Windows and Mac uses VSCode MSBuild and XCode tools
.PHONY: all clean

# default value for command-line arguments (like make BUILD_TYPE=Release)
BUILD_TYPE ?= Debug

ODIR := x64/$(BUILD_TYPE)/

CC := gcc
CFLAGS += `./get --cflags $(BUILD_TYPE)`

##---------------------------------------------------------------------
## BUILD RULES
##---------------------------------------------------------------------
# targets: normal-prerequisites | order-only-prerequisites

all: $(ODIR)flecs.o
	@echo 'cd $(shell pwd) && `./get --cflags $(BUILD_TYPE)` result: '$(CFLAGS)

$(ODIR)flecs.o: flecs/flecs.c | $(ODIR)
	$(COMPILE.c) -o $@ $<
# COMPILE.c = $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c

$(ODIR):
	@mkdir -p $(ODIR)

clean:
	rm -f $(ODIR)flecs.o
