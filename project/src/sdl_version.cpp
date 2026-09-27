#include "SDL3/SDL_version.h"

#include <string.h>

#include "hashlink_macros.h"

HL_PRIM int HL_NAME(get_version)() { return SDL_GetVersion(); }
DEFINE_PRIM(_I32, get_version, _NO_ARG);

HL_PRIM int HL_NAME(get_compiled_version)() { return SDL_VERSION; }
DEFINE_PRIM(_I32, get_compiled_version, _NO_ARG);

HL_PRIM vbyte* HL_NAME(get_revision)() {
    const char* r = SDL_GetRevision();
    if (!r) return NULL;
    return hl_copy_bytes((const vbyte*)r, (int)strlen(r) + 1);
}
DEFINE_PRIM(_BYTES, get_revision, _NO_ARG);