#include "hashlink_macros.h"
#include "SDL3/SDL_log.h"
#include "SDL3/SDL_mutex.h"
#include <string.h>

static vbyte* copy_str(const char* s) {
	if (!s)
		return NULL;
	return hl_copy_bytes((const vbyte*)s, (int)strlen(s) + 1);
}

HL_PRIM void HL_NAME(set_log_priorities)(int priority) { SDL_SetLogPriorities((SDL_LogPriority)priority); }
DEFINE_PRIM(_VOID, set_log_priorities, _I32);

HL_PRIM void HL_NAME(set_log_priority)(int category, int priority) { SDL_SetLogPriority(category, (SDL_LogPriority)priority); }
DEFINE_PRIM(_VOID, set_log_priority, _I32 _I32);

HL_PRIM int HL_NAME(get_log_priority)(int category) { return (int)SDL_GetLogPriority(category); }
DEFINE_PRIM(_I32, get_log_priority, _I32);

HL_PRIM void HL_NAME(reset_log_priorities)() { SDL_ResetLogPriorities(); }
DEFINE_PRIM(_VOID, reset_log_priorities, _NO_ARG);

HL_PRIM bool HL_NAME(set_log_priority_prefix)(int priority, vbyte* prefix) {
	return SDL_SetLogPriorityPrefix((SDL_LogPriority)priority, (const char*)prefix);
}
DEFINE_PRIM(_BOOL, set_log_priority_prefix, _I32 _BYTES);

HL_PRIM void HL_NAME(log)(vbyte* message) { SDL_Log("%s", (const char*)message); }
DEFINE_PRIM(_VOID, log, _BYTES);

HL_PRIM void HL_NAME(log_message)(int category, int priority, vbyte* message) {
	SDL_LogMessage(category, (SDL_LogPriority)priority, "%s", (const char*)message);
}
DEFINE_PRIM(_VOID, log_message, _I32 _I32 _BYTES);

struct log_entry {
	int category;
	int priority;
	char* message;
	log_entry* next;
};

static SDL_Mutex* log_mutex = NULL;
static log_entry* log_head = NULL;
static log_entry* log_tail = NULL;
static bool log_capture_enabled = false;

static void SDLCALL log_capture_cb(void* userdata, int category, SDL_LogPriority priority, const char* message) {
	log_entry* e = (log_entry*)SDL_calloc(1, sizeof(log_entry));
	e->category = category;
	e->priority = (int)priority;
	e->message = SDL_strdup(message ? message : "");

	SDL_LockMutex(log_mutex);
	if (log_tail)
		log_tail->next = e;
	else
		log_head = e;
	log_tail = e;
	SDL_UnlockMutex(log_mutex);
}

HL_PRIM void HL_NAME(start_log_capture)() {
	if (!log_mutex)
		log_mutex = SDL_CreateMutex();
	SDL_SetLogOutputFunction(log_capture_cb, NULL);
	log_capture_enabled = true;
}
DEFINE_PRIM(_VOID, start_log_capture, _NO_ARG);

HL_PRIM void HL_NAME(stop_log_capture)() {
	if (log_capture_enabled) {
		SDL_SetLogOutputFunction(NULL, NULL);
		log_capture_enabled = false;
	}
}
DEFINE_PRIM(_VOID, stop_log_capture, _NO_ARG);

HL_PRIM void HL_NAME(restore_default_log_output)() {
	SDL_SetLogOutputFunction(SDL_GetDefaultLogOutputFunction(), NULL);
	log_capture_enabled = false;
}
DEFINE_PRIM(_VOID, restore_default_log_output, _NO_ARG);

HL_PRIM log_entry* HL_NAME(log_capture_poll)() {
	if (!log_mutex)
		return NULL;
	SDL_LockMutex(log_mutex);
	log_entry* e = log_head;
	if (e) {
		log_head = e->next;
		if (!log_head)
			log_tail = NULL;
		e->next = NULL;
	}
	SDL_UnlockMutex(log_mutex);
	return e;
}
DEFINE_PRIM(_ABSTRACT(SDLLogEntry), log_capture_poll, _NO_ARG);

HL_PRIM int HL_NAME(log_entry_category)(log_entry* e) { return e->category; }
DEFINE_PRIM(_I32, log_entry_category, _ABSTRACT(SDLLogEntry));

HL_PRIM int HL_NAME(log_entry_priority)(log_entry* e) { return e->priority; }
DEFINE_PRIM(_I32, log_entry_priority, _ABSTRACT(SDLLogEntry));

HL_PRIM vbyte* HL_NAME(log_entry_message)(log_entry* e) { return copy_str(e->message); }
DEFINE_PRIM(_BYTES, log_entry_message, _ABSTRACT(SDLLogEntry));

HL_PRIM void HL_NAME(log_entry_free)(log_entry* e) {
	if (!e)
		return;
	SDL_free(e->message);
	SDL_free(e);
}
DEFINE_PRIM(_VOID, log_entry_free, _ABSTRACT(SDLLogEntry));
