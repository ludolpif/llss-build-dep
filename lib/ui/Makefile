#
# Cross Platform Makefile
# For now, build for Windows and Mac uses VSCode MSBuild and XCode tools
#
.PHONY: all clean

# default value for command-line arguments (like make BUILD_TYPE=Release)
BUILD_TYPE ?= Debug

ODIR := x64/$(BUILD_TYPE)/

CXX := g++
#CPPFLAGS +=
CXXFLAGS += `./get --cflags $(BUILD_TYPE)`
LDFLAGS += $(shell ./get --ldflags $(BUILD_TYPE))
#LDLIBS += $(shell ./get --ldlibs $(BUILD_TYPE))
#AR := gcc-ar # old platforms needed in -lto linking mode
ARFLAGS = rcs

OBJS := imgui.o imgui_demo.o imgui_draw.o imgui_tables.o imgui_widgets.o imgui_impl_sdl3.o imgui_impl_sdlgpu3.o
OBJS += dcimgui.o dcimgui_impl_sdl3.o dcimgui_impl_sdlgpu3.o
OBJS := $(OBJS:%.o=$(ODIR)%.o)

VPATH := imgui:imgui/backends:dear_bindings_generated:dear_bindings_generated/backends

##---------------------------------------------------------------------
## BUILD RULES
##---------------------------------------------------------------------
# targets: normal-prerequisites | order-only-prerequisites

all: $(ODIR)libdcimgui.a
	@echo 'cd $(shell pwd) && `./get --cflags $(BUILD_TYPE)` result: '$(CXXFLAGS)

# https://www.gnu.org/software/make/manual/html_node/Archive-Pitfalls.html
(%): %	;
$(ODIR)libdcimgui.a: $(OBJS)
	$(AR) $(ARFLAGS) $@ $?


# Trigger full rebuild off all archive members on imgui_config.h change
$(ODIR)%.o: %.cpp imgui_config.h | $(ODIR)
	$(COMPILE.cpp) -o $@ $<

$(ODIR):
	@mkdir -p $(ODIR)

clean:
	rm -f $(ODIR)libdcimgui.a $(OBJS)
