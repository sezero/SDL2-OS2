/*
  Simple DirectMedia Layer
  Copyright (C) 1997-2016 Sam Lantinga <slouken@libsdl.org>

  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.
*/

#ifndef _SDL_os2util_h
#define _SDL_os2util_h

#include "SDL_log.h"
#include "../SDL_sysvideo.h"
#include "../../core/os2/SDL_os2.h"

#define INCL_WIN
#define INCL_GPI
#include <os2.h>

/*#define debug(s,...) SDL_LogDebug( SDL_LOG_CATEGORY_VIDEO, \
                                   __func__"(): "##s, ##__VA_ARGS__ )*/

HPOINTER utilCreatePointer(SDL_Surface *surface, ULONG ulHotX, ULONG ulHotY);

#endif // _SDL_os2util_h