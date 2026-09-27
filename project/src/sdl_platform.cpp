#include "hashlink_macros.h"
#include "SDL3/SDL_platform.h"
#include <string.h>

HL_PRIM vbyte* HL_NAME(get_platform)() {
	const char* s = SDL_GetPlatform();
	return hl_copy_bytes((const vbyte*)s, (int)strlen(s) + 1);
}
DEFINE_PRIM(_BYTES, get_platform, _NO_ARG);
