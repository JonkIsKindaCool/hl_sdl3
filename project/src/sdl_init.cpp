#include "hashlink_macros.h"
#include "SDL3/SDL_init.h"
#include <string.h>

static vbyte* copy_str(const char* s) {
	if (!s)
		return NULL;
	return hl_copy_bytes((const vbyte*)s, (int)strlen(s) + 1);
}

HL_PRIM bool HL_NAME(init)(int flags) { return SDL_Init((SDL_InitFlags)flags); }
DEFINE_PRIM(_BOOL, init, _I32);

HL_PRIM bool HL_NAME(init_subsystem)(int flags) { return SDL_InitSubSystem((SDL_InitFlags)flags); }
DEFINE_PRIM(_BOOL, init_subsystem, _I32);

HL_PRIM void HL_NAME(quit_subsystem)(int flags) { SDL_QuitSubSystem((SDL_InitFlags)flags); }
DEFINE_PRIM(_VOID, quit_subsystem, _I32);

HL_PRIM int HL_NAME(was_init)(int flags) { return (int)SDL_WasInit((SDL_InitFlags)flags); }
DEFINE_PRIM(_I32, was_init, _I32);

HL_PRIM void HL_NAME(quit)() { SDL_Quit(); }
DEFINE_PRIM(_VOID, quit, _NO_ARG);

HL_PRIM bool HL_NAME(is_main_thread)() { return SDL_IsMainThread(); }
DEFINE_PRIM(_BOOL, is_main_thread, _NO_ARG);

static SDL_Mutex* mt_mutex = NULL;
static int* mt_queue = NULL;
static int mt_count = 0;
static int mt_capacity = 0;

static void SDLCALL main_thread_cb(void* userdata) {
	int id = (int)(intptr_t)userdata;
	SDL_LockMutex(mt_mutex);
	if (mt_count >= mt_capacity) {
		mt_capacity = mt_capacity == 0 ? 16 : mt_capacity * 2;
		mt_queue = (int*)SDL_realloc(mt_queue, sizeof(int) * mt_capacity);
	}
	mt_queue[mt_count++] = id;
	SDL_UnlockMutex(mt_mutex);
}

HL_PRIM bool HL_NAME(run_on_main_thread)(int id) {
	if (!mt_mutex)
		mt_mutex = SDL_CreateMutex();
	return SDL_RunOnMainThread(main_thread_cb, (void*)(intptr_t)id, false);
}
DEFINE_PRIM(_BOOL, run_on_main_thread, _I32);

HL_PRIM int HL_NAME(poll_main_thread_callback)() {
	if (!mt_mutex)
		return -1;
	SDL_LockMutex(mt_mutex);
	int id = -1;
	if (mt_count > 0) {
		id = mt_queue[0];
		for (int i = 1; i < mt_count; i++)
			mt_queue[i - 1] = mt_queue[i];
		mt_count--;
	}
	SDL_UnlockMutex(mt_mutex);
	return id;
}
DEFINE_PRIM(_I32, poll_main_thread_callback, _NO_ARG);

HL_PRIM bool HL_NAME(set_app_metadata)(vbyte* name, vbyte* version, vbyte* identifier) {
	return SDL_SetAppMetadata((const char*)name, (const char*)version, (const char*)identifier);
}
DEFINE_PRIM(_BOOL, set_app_metadata, _BYTES _BYTES _BYTES);

HL_PRIM bool HL_NAME(set_app_metadata_property)(vbyte* name, vbyte* value) {
	return SDL_SetAppMetadataProperty((const char*)name, (const char*)value);
}
DEFINE_PRIM(_BOOL, set_app_metadata_property, _BYTES _BYTES);

HL_PRIM vbyte* HL_NAME(get_app_metadata_property)(vbyte* name) { return copy_str(SDL_GetAppMetadataProperty((const char*)name)); }
DEFINE_PRIM(_BYTES, get_app_metadata_property, _BYTES);
