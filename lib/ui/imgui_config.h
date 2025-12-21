#pragma once
/*
 * This file is part of LLSS.
 *
 * LLSS is free software: you can redistribute it and/or modify it under the terms of the
 * Affero GNU General Public License as published by the Free Software Foundation,
 * either version 3 of the License, or (at your option) any later version.
 *
 * LLSS is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 * without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with LLSS.
 * If not, see <https://www.gnu.org/licenses/>. See LICENSE file at root of this git repo.
 *
 * Copyright 2025 ludolpif <ludolpif@gmail.com>
 */
//-----------------------------------------------------------------------------
// DEAR IMGUI COMPILE-TIME OPTIONS
// imgui, dear_bindings and  programs must be compiled with:
// '-DIMGUI_USER_CONFIG="imgui_config.h"' -I./path/to/this
// if symbol visibilty is needed, add '-Dimgui_EXPORTS'
// See imgui/imconfig.h for all possible options usable here
//-----------------------------------------------------------------------------
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
