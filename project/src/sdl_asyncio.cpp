#include "SDL3/SDL_asyncio.h"

#include <stdint.h>

#include "hashlink_macros.h"

HL_PRIM SDL_AsyncIO* HL_NAME(asyncio_from_file)(vbyte* path, vbyte* mode) {
    return SDL_AsyncIOFromFile((const char*)path, (const char*)mode);
}
DEFINE_PRIM(_ABSTRACT(SDL_AsyncIO), asyncio_from_file, _BYTES _BYTES);

HL_PRIM int64 HL_NAME(get_asyncio_size)(SDL_AsyncIO* asyncio) {
    return (int64)SDL_GetAsyncIOSize(asyncio);
}
DEFINE_PRIM(_I64, get_asyncio_size, _ABSTRACT(SDL_AsyncIO));

HL_PRIM bool HL_NAME(read_asyncio)(SDL_AsyncIO* asyncio, vbyte* ptr,
                                   int64 offset, int64 size,
                                   SDL_AsyncIOQueue* queue, int64 userdata) {
    return SDL_ReadAsyncIO(asyncio, (void*)ptr, (Uint64)offset, (Uint64)size,
                           queue, (void*)(intptr_t)userdata);
}
DEFINE_PRIM(_BOOL, read_asyncio,
            _ABSTRACT(SDL_AsyncIO) _BYTES _I64 _I64
                _ABSTRACT(SDL_AsyncIOQueue) _I64);

HL_PRIM bool HL_NAME(write_asyncio)(SDL_AsyncIO* asyncio, vbyte* ptr,
                                    int64 offset, int64 size,
                                    SDL_AsyncIOQueue* queue, int64 userdata) {
    return SDL_WriteAsyncIO(asyncio, (void*)ptr, (Uint64)offset, (Uint64)size,
                            queue, (void*)(intptr_t)userdata);
}
DEFINE_PRIM(_BOOL, write_asyncio,
            _ABSTRACT(SDL_AsyncIO) _BYTES _I64 _I64
                _ABSTRACT(SDL_AsyncIOQueue) _I64);

HL_PRIM bool HL_NAME(close_asyncio)(SDL_AsyncIO* asyncio, bool flush,
                                    SDL_AsyncIOQueue* queue, int64 userdata) {
    return SDL_CloseAsyncIO(asyncio, flush, queue, (void*)(intptr_t)userdata);
}
DEFINE_PRIM(_BOOL, close_asyncio,
            _ABSTRACT(SDL_AsyncIO) _BOOL _ABSTRACT(SDL_AsyncIOQueue) _I64);

HL_PRIM SDL_AsyncIOQueue* HL_NAME(create_asyncio_queue)() {
    return SDL_CreateAsyncIOQueue();
}
DEFINE_PRIM(_ABSTRACT(SDL_AsyncIOQueue), create_asyncio_queue, _NO_ARG);

HL_PRIM void HL_NAME(destroy_asyncio_queue)(SDL_AsyncIOQueue* queue) {
    SDL_DestroyAsyncIOQueue(queue);
}
DEFINE_PRIM(_VOID, destroy_asyncio_queue, _ABSTRACT(SDL_AsyncIOQueue));

HL_PRIM void HL_NAME(signal_asyncio_queue)(SDL_AsyncIOQueue* queue) {
    SDL_SignalAsyncIOQueue(queue);
}
DEFINE_PRIM(_VOID, signal_asyncio_queue, _ABSTRACT(SDL_AsyncIOQueue));

HL_PRIM bool HL_NAME(load_file_async)(vbyte* file, SDL_AsyncIOQueue* queue,
                                      int64 userdata) {
    return SDL_LoadFileAsync((const char*)file, queue,
                             (void*)(intptr_t)userdata);
}
DEFINE_PRIM(_BOOL, load_file_async, _BYTES _ABSTRACT(SDL_AsyncIOQueue) _I64);

/* Outcome getters and setters */

HL_PRIM SDL_AsyncIOOutcome* HL_NAME(asyncio_outcome_alloc)() {
    return (SDL_AsyncIOOutcome*)hl_gc_alloc_noptr(sizeof(SDL_AsyncIOOutcome));
}
DEFINE_PRIM(_ABSTRACT(SDL_AsyncIOOutcome), asyncio_outcome_alloc, _NO_ARG);

HL_PRIM bool HL_NAME(get_asyncio_result)(SDL_AsyncIOQueue* queue,
                                         SDL_AsyncIOOutcome* outcome) {
    return SDL_GetAsyncIOResult(queue, outcome);
}
DEFINE_PRIM(_BOOL, get_asyncio_result,
            _ABSTRACT(SDL_AsyncIOQueue) _ABSTRACT(SDL_AsyncIOOutcome));

HL_PRIM bool HL_NAME(wait_asyncio_result)(SDL_AsyncIOQueue* queue,
                                          SDL_AsyncIOOutcome* outcome,
                                          int timeoutMS) {
    hl_blocking(true);
    bool r = SDL_WaitAsyncIOResult(queue, outcome, (Sint32)timeoutMS);
    hl_blocking(false);
    return r;
}
DEFINE_PRIM(_BOOL, wait_asyncio_result,
            _ABSTRACT(SDL_AsyncIOQueue) _ABSTRACT(SDL_AsyncIOOutcome) _I32);

HL_PRIM SDL_AsyncIO* HL_NAME(outcome_asyncio)(SDL_AsyncIOOutcome* o) {
    return o->asyncio;
}
DEFINE_PRIM(_ABSTRACT(SDL_AsyncIO), outcome_asyncio,
            _ABSTRACT(SDL_AsyncIOOutcome));

HL_PRIM int HL_NAME(outcome_type)(SDL_AsyncIOOutcome* o) {
    return (int)o->type;
}
DEFINE_PRIM(_I32, outcome_type, _ABSTRACT(SDL_AsyncIOOutcome));

HL_PRIM int HL_NAME(outcome_result)(SDL_AsyncIOOutcome* o) {
    return (int)o->result;
}
DEFINE_PRIM(_I32, outcome_result, _ABSTRACT(SDL_AsyncIOOutcome));

HL_PRIM vbyte* HL_NAME(outcome_buffer)(SDL_AsyncIOOutcome* o) {
    return (vbyte*)o->buffer;
}
DEFINE_PRIM(_BYTES, outcome_buffer, _ABSTRACT(SDL_AsyncIOOutcome));

HL_PRIM int64 HL_NAME(outcome_offset)(SDL_AsyncIOOutcome* o) {
    return (int64)o->offset;
}
DEFINE_PRIM(_I64, outcome_offset, _ABSTRACT(SDL_AsyncIOOutcome));

HL_PRIM int64 HL_NAME(outcome_bytes_requested)(SDL_AsyncIOOutcome* o) {
    return (int64)o->bytes_requested;
}
DEFINE_PRIM(_I64, outcome_bytes_requested, _ABSTRACT(SDL_AsyncIOOutcome));

HL_PRIM int64 HL_NAME(outcome_bytes_transferred)(SDL_AsyncIOOutcome* o) {
    return (int64)o->bytes_transferred;
}
DEFINE_PRIM(_I64, outcome_bytes_transferred, _ABSTRACT(SDL_AsyncIOOutcome));

HL_PRIM int64 HL_NAME(outcome_userdata)(SDL_AsyncIOOutcome* o) {
    return (int64)(intptr_t)o->userdata;
}
DEFINE_PRIM(_I64, outcome_userdata, _ABSTRACT(SDL_AsyncIOOutcome));

HL_PRIM void HL_NAME(free)(vbyte* p) { SDL_free(p); }
DEFINE_PRIM(_VOID, free, _BYTES);