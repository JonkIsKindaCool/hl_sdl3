#include "hashlink_macros.h"
#include "SDL3/SDL_mutex.h"

HL_PRIM SDL_Mutex* HL_NAME(create_mutex)() { return SDL_CreateMutex(); }
DEFINE_PRIM(_ABSTRACT(SDL_Mutex), create_mutex, _NO_ARG);

HL_PRIM void HL_NAME(lock_mutex)(SDL_Mutex* m) {
	hl_blocking(true);
	SDL_LockMutex(m);
	hl_blocking(false);
}
DEFINE_PRIM(_VOID, lock_mutex, _ABSTRACT(SDL_Mutex));

HL_PRIM bool HL_NAME(try_lock_mutex)(SDL_Mutex* m) { return SDL_TryLockMutex(m); }
DEFINE_PRIM(_BOOL, try_lock_mutex, _ABSTRACT(SDL_Mutex));

HL_PRIM void HL_NAME(unlock_mutex)(SDL_Mutex* m) { SDL_UnlockMutex(m); }
DEFINE_PRIM(_VOID, unlock_mutex, _ABSTRACT(SDL_Mutex));

HL_PRIM void HL_NAME(destroy_mutex)(SDL_Mutex* m) { SDL_DestroyMutex(m); }
DEFINE_PRIM(_VOID, destroy_mutex, _ABSTRACT(SDL_Mutex));

HL_PRIM SDL_RWLock* HL_NAME(create_rwlock)() { return SDL_CreateRWLock(); }
DEFINE_PRIM(_ABSTRACT(SDL_RWLock), create_rwlock, _NO_ARG);

HL_PRIM void HL_NAME(lock_rwlock_for_reading)(SDL_RWLock* l) {
	hl_blocking(true);
	SDL_LockRWLockForReading(l);
	hl_blocking(false);
}
DEFINE_PRIM(_VOID, lock_rwlock_for_reading, _ABSTRACT(SDL_RWLock));

HL_PRIM void HL_NAME(lock_rwlock_for_writing)(SDL_RWLock* l) {
	hl_blocking(true);
	SDL_LockRWLockForWriting(l);
	hl_blocking(false);
}
DEFINE_PRIM(_VOID, lock_rwlock_for_writing, _ABSTRACT(SDL_RWLock));

HL_PRIM bool HL_NAME(try_lock_rwlock_for_reading)(SDL_RWLock* l) { return SDL_TryLockRWLockForReading(l); }
DEFINE_PRIM(_BOOL, try_lock_rwlock_for_reading, _ABSTRACT(SDL_RWLock));

HL_PRIM bool HL_NAME(try_lock_rwlock_for_writing)(SDL_RWLock* l) { return SDL_TryLockRWLockForWriting(l); }
DEFINE_PRIM(_BOOL, try_lock_rwlock_for_writing, _ABSTRACT(SDL_RWLock));

HL_PRIM void HL_NAME(unlock_rwlock)(SDL_RWLock* l) { SDL_UnlockRWLock(l); }
DEFINE_PRIM(_VOID, unlock_rwlock, _ABSTRACT(SDL_RWLock));

HL_PRIM void HL_NAME(destroy_rwlock)(SDL_RWLock* l) { SDL_DestroyRWLock(l); }
DEFINE_PRIM(_VOID, destroy_rwlock, _ABSTRACT(SDL_RWLock));

HL_PRIM SDL_Semaphore* HL_NAME(create_semaphore)(int initialValue) { return SDL_CreateSemaphore((Uint32)initialValue); }
DEFINE_PRIM(_ABSTRACT(SDL_Semaphore), create_semaphore, _I32);

HL_PRIM void HL_NAME(destroy_semaphore)(SDL_Semaphore* s) { SDL_DestroySemaphore(s); }
DEFINE_PRIM(_VOID, destroy_semaphore, _ABSTRACT(SDL_Semaphore));

HL_PRIM void HL_NAME(wait_semaphore)(SDL_Semaphore* s) {
	hl_blocking(true);
	SDL_WaitSemaphore(s);
	hl_blocking(false);
}
DEFINE_PRIM(_VOID, wait_semaphore, _ABSTRACT(SDL_Semaphore));

HL_PRIM bool HL_NAME(try_wait_semaphore)(SDL_Semaphore* s) { return SDL_TryWaitSemaphore(s); }
DEFINE_PRIM(_BOOL, try_wait_semaphore, _ABSTRACT(SDL_Semaphore));

HL_PRIM bool HL_NAME(wait_semaphore_timeout)(SDL_Semaphore* s, int timeoutMs) {
	hl_blocking(true);
	bool r = SDL_WaitSemaphoreTimeout(s, (Sint32)timeoutMs);
	hl_blocking(false);
	return r;
}
DEFINE_PRIM(_BOOL, wait_semaphore_timeout, _ABSTRACT(SDL_Semaphore) _I32);

HL_PRIM void HL_NAME(signal_semaphore)(SDL_Semaphore* s) { SDL_SignalSemaphore(s); }
DEFINE_PRIM(_VOID, signal_semaphore, _ABSTRACT(SDL_Semaphore));

HL_PRIM int HL_NAME(get_semaphore_value)(SDL_Semaphore* s) { return (int)SDL_GetSemaphoreValue(s); }
DEFINE_PRIM(_I32, get_semaphore_value, _ABSTRACT(SDL_Semaphore));

HL_PRIM SDL_Condition* HL_NAME(create_condition)() { return SDL_CreateCondition(); }
DEFINE_PRIM(_ABSTRACT(SDL_Condition), create_condition, _NO_ARG);

HL_PRIM void HL_NAME(destroy_condition)(SDL_Condition* c) { SDL_DestroyCondition(c); }
DEFINE_PRIM(_VOID, destroy_condition, _ABSTRACT(SDL_Condition));

HL_PRIM void HL_NAME(signal_condition)(SDL_Condition* c) { SDL_SignalCondition(c); }
DEFINE_PRIM(_VOID, signal_condition, _ABSTRACT(SDL_Condition));

HL_PRIM void HL_NAME(broadcast_condition)(SDL_Condition* c) { SDL_BroadcastCondition(c); }
DEFINE_PRIM(_VOID, broadcast_condition, _ABSTRACT(SDL_Condition));

HL_PRIM void HL_NAME(wait_condition)(SDL_Condition* c, SDL_Mutex* m) {
	hl_blocking(true);
	SDL_WaitCondition(c, m);
	hl_blocking(false);
}
DEFINE_PRIM(_VOID, wait_condition, _ABSTRACT(SDL_Condition) _ABSTRACT(SDL_Mutex));

HL_PRIM bool HL_NAME(wait_condition_timeout)(SDL_Condition* c, SDL_Mutex* m, int timeoutMs) {
	hl_blocking(true);
	bool r = SDL_WaitConditionTimeout(c, m, (Sint32)timeoutMs);
	hl_blocking(false);
	return r;
}
DEFINE_PRIM(_BOOL, wait_condition_timeout, _ABSTRACT(SDL_Condition) _ABSTRACT(SDL_Mutex) _I32);

HL_PRIM SDL_InitState* HL_NAME(init_state_alloc)() {
	SDL_InitState* s = (SDL_InitState*)hl_gc_alloc_noptr(sizeof(SDL_InitState));
	SDL_zerop(s);
	return s;
}
DEFINE_PRIM(_ABSTRACT(SDL_InitState), init_state_alloc, _NO_ARG);

HL_PRIM bool HL_NAME(should_init)(SDL_InitState* state) { return SDL_ShouldInit(state); }
DEFINE_PRIM(_BOOL, should_init, _ABSTRACT(SDL_InitState));

HL_PRIM bool HL_NAME(should_quit)(SDL_InitState* state) { return SDL_ShouldQuit(state); }
DEFINE_PRIM(_BOOL, should_quit, _ABSTRACT(SDL_InitState));

HL_PRIM void HL_NAME(set_initialized)(SDL_InitState* state, bool initialized) { SDL_SetInitialized(state, initialized); }
DEFINE_PRIM(_VOID, set_initialized, _ABSTRACT(SDL_InitState) _BOOL);

HL_PRIM int HL_NAME(get_init_status)(SDL_InitState* state) { return (int)SDL_GetAtomicInt(&state->status); }
DEFINE_PRIM(_I32, get_init_status, _ABSTRACT(SDL_InitState));
