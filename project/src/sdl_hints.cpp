#include "hashlink_macros.h"
#include "SDL3/SDL_hints.h"
#include "SDL3/SDL_mutex.h"
#include <string.h>

static vbyte* copy_str(const char* s) {
	if (!s)
		return NULL;
	return hl_copy_bytes((const vbyte*)s, (int)strlen(s) + 1);
}

HL_PRIM bool HL_NAME(set_hint_with_priority)(vbyte* name, vbyte* value, int priority) {
	return SDL_SetHintWithPriority((const char*)name, (const char*)value, (SDL_HintPriority)priority);
}
DEFINE_PRIM(_BOOL, set_hint_with_priority, _BYTES _BYTES _I32);

HL_PRIM bool HL_NAME(set_hint)(vbyte* name, vbyte* value) { return SDL_SetHint((const char*)name, (const char*)value); }
DEFINE_PRIM(_BOOL, set_hint, _BYTES _BYTES);

HL_PRIM bool HL_NAME(reset_hint)(vbyte* name) { return SDL_ResetHint((const char*)name); }
DEFINE_PRIM(_BOOL, reset_hint, _BYTES);

HL_PRIM void HL_NAME(reset_hints)() { SDL_ResetHints(); }
DEFINE_PRIM(_VOID, reset_hints, _NO_ARG);

HL_PRIM vbyte* HL_NAME(get_hint)(vbyte* name) { return copy_str(SDL_GetHint((const char*)name)); }
DEFINE_PRIM(_BYTES, get_hint, _BYTES);

HL_PRIM bool HL_NAME(get_hint_boolean)(vbyte* name, bool defaultValue) { return SDL_GetHintBoolean((const char*)name, defaultValue); }
DEFINE_PRIM(_BOOL, get_hint_boolean, _BYTES _BOOL);

struct hint_change {
	char* name;
	char* oldValue;
	char* newValue;
	hint_change* next;
};

static SDL_Mutex* hc_mutex = NULL;
static hint_change* hc_head = NULL;
static hint_change* hc_tail = NULL;

static void SDLCALL hint_cb(void* userdata, const char* name, const char* oldValue, const char* newValue) {
	hint_change* c = (hint_change*)SDL_calloc(1, sizeof(hint_change));
	c->name = SDL_strdup(name ? name : "");
	c->oldValue = oldValue ? SDL_strdup(oldValue) : NULL;
	c->newValue = newValue ? SDL_strdup(newValue) : NULL;

	SDL_LockMutex(hc_mutex);
	if (hc_tail)
		hc_tail->next = c;
	else
		hc_head = c;
	hc_tail = c;
	SDL_UnlockMutex(hc_mutex);
}

HL_PRIM bool HL_NAME(add_hint_callback)(vbyte* name) {
	if (!hc_mutex)
		hc_mutex = SDL_CreateMutex();
	return SDL_AddHintCallback((const char*)name, hint_cb, NULL);
}
DEFINE_PRIM(_BOOL, add_hint_callback, _BYTES);

HL_PRIM void HL_NAME(remove_hint_callback)(vbyte* name) { SDL_RemoveHintCallback((const char*)name, hint_cb, NULL); }
DEFINE_PRIM(_VOID, remove_hint_callback, _BYTES);

HL_PRIM hint_change* HL_NAME(hint_callback_poll)() {
	if (!hc_mutex)
		return NULL;
	SDL_LockMutex(hc_mutex);
	hint_change* c = hc_head;
	if (c) {
		hc_head = c->next;
		if (!hc_head)
			hc_tail = NULL;
		c->next = NULL;
	}
	SDL_UnlockMutex(hc_mutex);
	return c;
}
DEFINE_PRIM(_ABSTRACT(SDLHintChange), hint_callback_poll, _NO_ARG);

HL_PRIM vbyte* HL_NAME(hint_change_name)(hint_change* c) { return copy_str(c->name); }
DEFINE_PRIM(_BYTES, hint_change_name, _ABSTRACT(SDLHintChange));

HL_PRIM vbyte* HL_NAME(hint_change_old_value)(hint_change* c) { return copy_str(c->oldValue); }
DEFINE_PRIM(_BYTES, hint_change_old_value, _ABSTRACT(SDLHintChange));

HL_PRIM vbyte* HL_NAME(hint_change_new_value)(hint_change* c) { return copy_str(c->newValue); }
DEFINE_PRIM(_BYTES, hint_change_new_value, _ABSTRACT(SDLHintChange));

HL_PRIM void HL_NAME(hint_change_free)(hint_change* c) {
	if (!c)
		return;
	SDL_free(c->name);
	SDL_free(c->oldValue);
	SDL_free(c->newValue);
	SDL_free(c);
}
DEFINE_PRIM(_VOID, hint_change_free, _ABSTRACT(SDLHintChange));
