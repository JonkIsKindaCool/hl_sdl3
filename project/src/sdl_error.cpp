#include "SDL3/SDL_error.h"

#include <string.h>

#include "hashlink_macros.h"

HL_PRIM vbyte* HL_NAME(get_error)() {
    const char* e = SDL_GetError();
    if (!e) e = "";
    return hl_copy_bytes((const vbyte*)e, (int)strlen(e) + 1);
}
DEFINE_PRIM(_BYTES, get_error, _NO_ARG);

HL_PRIM bool HL_NAME(set_error)(vbyte* msg) {
    return SDL_SetError("%s", (const char*)msg);
}
DEFINE_PRIM(_BOOL, set_error, _BYTES);

HL_PRIM bool HL_NAME(out_of_memory)() { return SDL_OutOfMemory(); }
DEFINE_PRIM(_BOOL, out_of_memory, _NO_ARG);

HL_PRIM bool HL_NAME(clear_error)() { return SDL_ClearError(); }
DEFINE_PRIM(_BOOL, clear_error, _NO_ARG);