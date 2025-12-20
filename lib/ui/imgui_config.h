//-----------------------------------------------------------------------------
// DEAR IMGUI COMPILE-TIME OPTIONS
// imgui, dear_bindings and  programs must be compiled with '-DIMGUI_USER_CONFIG="path/to/this/imgui_config.h"'
// if symbol visibilty is needed, add '-Dimgui_EXPORTS'
// See imgui/imconfig.h for all possible options usable here
//-----------------------------------------------------------------------------

#pragma once
#include <SDL3/SDL_assert.h>
#include <SDL3/SDL_stdinc.h>

// Symmetric construction as in "flecs.h" with flecs_EXPORTS
#if defined(imgui_EXPORTS) && (defined(_MSC_VER) || defined(__MINGW32__))
  #define CIMGUI_API __declspec(dllexport)
#elif defined(imgui_EXPORTS)
  #define CIMGUI_API __attribute__((__visibility__("default")))
#elif defined(_MSC_VER)
  #define CIMGUI_API __declspec(dllimport)
#else
  #define CIMGUI_API
#endif

#define IM_ASSERT(_EXPR)  SDL_assert_always(_EXPR)
#define IMGUI_ENABLE_OSX_DEFAULT_CLIPBOARD_FUNCTIONS
#define IMGUI_DISABLE_DEFAULT_ALLOCATORS
#define IM_DEBUG_BREAK  SDL_TriggerBreakpoint
