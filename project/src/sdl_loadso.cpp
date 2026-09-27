#include "hashlink_macros.h"
#include "SDL3/SDL_loadso.h"

HL_PRIM SDL_SharedObject* HL_NAME(load_object)(vbyte* sofile) { return SDL_LoadObject((const char*)sofile); }
DEFINE_PRIM(_ABSTRACT(SDL_SharedObject), load_object, _BYTES);

HL_PRIM void* HL_NAME(load_function)(SDL_SharedObject* handle, vbyte* name) { return (void*)SDL_LoadFunction(handle, (const char*)name); }
DEFINE_PRIM(_ABSTRACT(SDL_FunctionPointer), load_function, _ABSTRACT(SDL_SharedObject) _BYTES);

HL_PRIM void HL_NAME(unload_object)(SDL_SharedObject* handle) { SDL_UnloadObject(handle); }
DEFINE_PRIM(_VOID, unload_object, _ABSTRACT(SDL_SharedObject));
