#include "hashlink_macros.h"
#include "SDL3/SDL_misc.h"

HL_PRIM bool HL_NAME(open_url)(vbyte* url) { return SDL_OpenURL((const char*)url); }
DEFINE_PRIM(_BOOL, open_url, _BYTES);
