#include "SDL3/SDL_timer.h"
#include "SDL3/SDL_mutex.h"

#include <stdint.h>

#include "hashlink_macros.h"

HL_PRIM int64 HL_NAME(get_ticks)() { return (int64)SDL_GetTicks(); }
DEFINE_PRIM(_I64, get_ticks, _NO_ARG);

HL_PRIM int64 HL_NAME(get_ticks_ns)() { return (int64)SDL_GetTicksNS(); }
DEFINE_PRIM(_I64, get_ticks_ns, _NO_ARG);

HL_PRIM int64 HL_NAME(get_performance_counter)() {
    return (int64)SDL_GetPerformanceCounter();
}
DEFINE_PRIM(_I64, get_performance_counter, _NO_ARG);

HL_PRIM int64 HL_NAME(get_performance_frequency)() {
    return (int64)SDL_GetPerformanceFrequency();
}
DEFINE_PRIM(_I64, get_performance_frequency, _NO_ARG);

HL_PRIM void HL_NAME(delay)(int ms) {
    hl_blocking(true);
    SDL_Delay((Uint32)ms);
    hl_blocking(false);
}
DEFINE_PRIM(_VOID, delay, _I32);

HL_PRIM void HL_NAME(delay_ns)(int64 ns) {
    hl_blocking(true);
    SDL_DelayNS((Uint64)ns);
    hl_blocking(false);
}
DEFINE_PRIM(_VOID, delay_ns, _I64);

HL_PRIM void HL_NAME(delay_precise)(int64 ns) {
    hl_blocking(true);
    SDL_DelayPrecise((Uint64)ns);
    hl_blocking(false);
}
DEFINE_PRIM(_VOID, delay_precise, _I64);

struct timer_event {
    int id;      
    int timerID; 
    timer_event* next;
};

static SDL_Mutex* tm_mutex = NULL;
static timer_event* tm_head = NULL;
static timer_event* tm_tail = NULL;

static void queue_timer_event(int id, SDL_TimerID timerID) {
    timer_event* e = (timer_event*)SDL_calloc(1, sizeof(timer_event));
    if (!e) return;
    e->id = id;
    e->timerID = (int)timerID;
    SDL_LockMutex(tm_mutex);
    if (tm_tail)
        tm_tail->next = e;
    else
        tm_head = e;
    tm_tail = e;
    SDL_UnlockMutex(tm_mutex);
}

static Uint32 SDLCALL timer_cb(void* userdata, SDL_TimerID timerID,
                               Uint32 interval) {
    (void)interval;
    queue_timer_event((int)(intptr_t)userdata, timerID);
    return 0;
}

static Uint64 SDLCALL ns_timer_cb(void* userdata, SDL_TimerID timerID,
                                  Uint64 interval) {
    (void)interval;
    queue_timer_event((int)(intptr_t)userdata, timerID);
    return 0;
}

HL_PRIM int HL_NAME(add_timer)(int intervalMs, int id) {
    if (!tm_mutex) tm_mutex = SDL_CreateMutex();
    return (int)SDL_AddTimer((Uint32)intervalMs, timer_cb,
                             (void*)(intptr_t)id);
}
DEFINE_PRIM(_I32, add_timer, _I32 _I32);

HL_PRIM int HL_NAME(add_timer_ns)(int64 intervalNs, int id) {
    if (!tm_mutex) tm_mutex = SDL_CreateMutex();
    return (int)SDL_AddTimerNS((Uint64)intervalNs, ns_timer_cb,
                               (void*)(intptr_t)id);
}
DEFINE_PRIM(_I32, add_timer_ns, _I64 _I32);

HL_PRIM bool HL_NAME(remove_timer)(int timerID) {
    return SDL_RemoveTimer((SDL_TimerID)timerID);
}
DEFINE_PRIM(_BOOL, remove_timer, _I32);

HL_PRIM int HL_NAME(timer_poll)() {
    if (!tm_mutex) return -1;
    SDL_LockMutex(tm_mutex);
    timer_event* e = tm_head;
    if (e) {
        tm_head = e->next;
        if (!tm_head) tm_tail = NULL;
    }
    SDL_UnlockMutex(tm_mutex);
    int id = -1;
    if (e) {
        id = e->id;
        SDL_free(e);
    }
    return id;
}
DEFINE_PRIM(_I32, timer_poll, _NO_ARG);