#include "SDL3/SDL_iostream.h"

#include <string.h>

#include "hashlink_macros.h"

static vbyte* copy_str(const char* s) {
    if (!s) return NULL;
    return hl_copy_bytes((const vbyte*)s, (int)strlen(s) + 1);
}

HL_PRIM SDL_IOStream* HL_NAME(io_from_file)(vbyte* path, vbyte* mode) {
    return SDL_IOFromFile((const char*)path, (const char*)mode);
}
DEFINE_PRIM(_ABSTRACT(SDL_IOStream), io_from_file, _BYTES _BYTES);

HL_PRIM SDL_IOStream* HL_NAME(io_from_mem)(vbyte* mem, int size) {
    return SDL_IOFromMem(mem, (size_t)size);
}
DEFINE_PRIM(_ABSTRACT(SDL_IOStream), io_from_mem, _BYTES _I32);

HL_PRIM SDL_IOStream* HL_NAME(io_from_const_mem)(vbyte* mem, int size) {
    return SDL_IOFromConstMem(mem, (size_t)size);
}
DEFINE_PRIM(_ABSTRACT(SDL_IOStream), io_from_const_mem, _BYTES _I32);

HL_PRIM SDL_IOStream* HL_NAME(io_from_dynamic_mem)() {
    return SDL_IOFromDynamicMem();
}
DEFINE_PRIM(_ABSTRACT(SDL_IOStream), io_from_dynamic_mem, _NO_ARG);

HL_PRIM bool HL_NAME(close_io)(SDL_IOStream* ctx) { return SDL_CloseIO(ctx); }
DEFINE_PRIM(_BOOL, close_io, _ABSTRACT(SDL_IOStream));

HL_PRIM int HL_NAME(get_io_status)(SDL_IOStream* ctx) {
    return (int)SDL_GetIOStatus(ctx);
}
DEFINE_PRIM(_I32, get_io_status, _ABSTRACT(SDL_IOStream));

HL_PRIM void HL_NAME(get_io_size)(SDL_IOStream* ctx, varray* out) {
    Sint64 s = SDL_GetIOSize(ctx);
    int* o = hl_aptr(out, int);
    o[0] = (int)(Uint32)((Uint64)s >> 32);
    o[1] = (int)(Uint32)((Uint64)s & 0xFFFFFFFFu);
}
DEFINE_PRIM(_VOID, get_io_size, _ABSTRACT(SDL_IOStream) _ARR);

HL_PRIM void HL_NAME(seek_io)(SDL_IOStream* ctx, int offHi, int offLo,
                              int whence, varray* out) {
    Sint64 off = ((Sint64)(Uint32)offHi << 32) | (Uint32)offLo;
    Sint64 r = SDL_SeekIO(ctx, off, (SDL_IOWhence)whence);
    int* o = hl_aptr(out, int);
    o[0] = (int)(Uint32)((Uint64)r >> 32);
    o[1] = (int)(Uint32)((Uint64)r & 0xFFFFFFFFu);
}
DEFINE_PRIM(_VOID, seek_io, _ABSTRACT(SDL_IOStream) _I32 _I32 _I32 _ARR);

HL_PRIM void HL_NAME(tell_io)(SDL_IOStream* ctx, varray* out) {
    Sint64 r = SDL_TellIO(ctx);
    int* o = hl_aptr(out, int);
    o[0] = (int)(Uint32)((Uint64)r >> 32);
    o[1] = (int)(Uint32)((Uint64)r & 0xFFFFFFFFu);
}
DEFINE_PRIM(_VOID, tell_io, _ABSTRACT(SDL_IOStream) _ARR);

HL_PRIM int HL_NAME(read_io)(SDL_IOStream* ctx, vbyte* ptr, int size) {
    return (int)SDL_ReadIO(ctx, ptr, (size_t)size);
}
DEFINE_PRIM(_I32, read_io, _ABSTRACT(SDL_IOStream) _BYTES _I32);

HL_PRIM int HL_NAME(write_io)(SDL_IOStream* ctx, vbyte* ptr, int size) {
    return (int)SDL_WriteIO(ctx, ptr, (size_t)size);
}
DEFINE_PRIM(_I32, write_io, _ABSTRACT(SDL_IOStream) _BYTES _I32);

HL_PRIM int HL_NAME(io_puts)(SDL_IOStream* ctx, vbyte* s) {
    return (int)SDL_IOprintf(ctx, "%s", (const char*)s);
}
DEFINE_PRIM(_I32, io_puts, _ABSTRACT(SDL_IOStream) _BYTES);

HL_PRIM bool HL_NAME(flush_io)(SDL_IOStream* ctx) { return SDL_FlushIO(ctx); }
DEFINE_PRIM(_BOOL, flush_io, _ABSTRACT(SDL_IOStream));

HL_PRIM vbyte* HL_NAME(load_file_io)(SDL_IOStream* src, bool closeio,
                                     varray* outSize) {
    size_t size = 0;
    hl_blocking(true);
    void* data = SDL_LoadFile_IO(src, &size, closeio);
    hl_blocking(false);
    if (!data) return NULL;
    vbyte* out = hl_copy_bytes((const vbyte*)data, (int)size);
    SDL_free(data);
    int* o = hl_aptr(outSize, int);
    o[0] = (int)size;
    return out;
}
DEFINE_PRIM(_BYTES, load_file_io, _ABSTRACT(SDL_IOStream) _BOOL _ARR);

HL_PRIM vbyte* HL_NAME(load_file)(vbyte* path, varray* outSize) {
    size_t size = 0;
    hl_blocking(true);
    void* data = SDL_LoadFile((const char*)path, &size);
    hl_blocking(false);
    if (!data) return NULL;
    vbyte* out = hl_copy_bytes((const vbyte*)data, (int)size);
    SDL_free(data);
    int* o = hl_aptr(outSize, int);
    o[0] = (int)size;
    return out;
}
DEFINE_PRIM(_BYTES, load_file, _BYTES _ARR);

HL_PRIM bool HL_NAME(save_file_io)(SDL_IOStream* src, vbyte* data, int size,
                                   bool closeio) {
    hl_blocking(true);
    bool r = SDL_SaveFile_IO(src, data, (size_t)size, closeio);
    hl_blocking(false);
    return r;
}
DEFINE_PRIM(_BOOL, save_file_io, _ABSTRACT(SDL_IOStream) _BYTES _I32 _BOOL);

HL_PRIM bool HL_NAME(save_file)(vbyte* path, vbyte* data, int size) {
    hl_blocking(true);
    bool r = SDL_SaveFile((const char*)path, data, (size_t)size);
    hl_blocking(false);
    return r;
}
DEFINE_PRIM(_BOOL, save_file, _BYTES _BYTES _I32);

#define READ8(name, ctype, sdlfn)                                 \
    HL_PRIM int HL_NAME(name)(SDL_IOStream * src, varray * out) { \
        ctype v = 0;                                              \
        bool ok = sdlfn(src, &v);                                 \
        hl_aptr(out, int)[0] = (int)v;                            \
        return ok ? 1 : 0;                                        \
    }                                                             \
    DEFINE_PRIM(_I32, name, _ABSTRACT(SDL_IOStream) _ARR);

READ8(read_u8, Uint8, SDL_ReadU8)
READ8(read_s8, Sint8, SDL_ReadS8)
READ8(read_u16_le, Uint16, SDL_ReadU16LE)
READ8(read_s16_le, Sint16, SDL_ReadS16LE)
READ8(read_u16_be, Uint16, SDL_ReadU16BE)
READ8(read_s16_be, Sint16, SDL_ReadS16BE)
READ8(read_u32_le, Uint32, SDL_ReadU32LE)
READ8(read_s32_le, Sint32, SDL_ReadS32LE)
READ8(read_u32_be, Uint32, SDL_ReadU32BE)
READ8(read_s32_be, Sint32, SDL_ReadS32BE)

#define READ64(name, sdlfn)                                        \
    HL_PRIM bool HL_NAME(name)(SDL_IOStream * src, varray * out) { \
        Uint64 v = 0;                                              \
        bool ok = sdlfn(src, &v);                                  \
        int* o = hl_aptr(out, int);                                \
        o[0] = (int)(Uint32)(v >> 32);                             \
        o[1] = (int)(Uint32)(v & 0xFFFFFFFFu);                     \
        return ok;                                                 \
    }                                                              \
    DEFINE_PRIM(_BOOL, name, _ABSTRACT(SDL_IOStream) _ARR);

#define READ64_X(name, sdlfn)                                        \
    HL_PRIM bool HL_NAME(name)(SDL_IOStream * src, varray * out) { \
        Sint64 v = 0;                                              \
        bool ok = sdlfn(src, &v);                                  \
        int* o = hl_aptr(out, int);                                \
        o[0] = (int)(Uint32)(v >> 32);                             \
        o[1] = (int)(Uint32)(v & 0xFFFFFFFFu);                     \
        return ok;                                                 \
    }                                                              \
    DEFINE_PRIM(_BOOL, name, _ABSTRACT(SDL_IOStream) _ARR);

READ64(read_u64_le, SDL_ReadU64LE)
READ64_X(read_s64_le, SDL_ReadS64LE)
READ64(read_u64_be, SDL_ReadU64BE)
READ64_X(read_s64_be, SDL_ReadS64BE)

#define WRITE8(name, ctype, sdlfn)                              \
    HL_PRIM bool HL_NAME(name)(SDL_IOStream * dst, int value) { \
        return sdlfn(dst, (ctype)value);                        \
    }                                                           \
    DEFINE_PRIM(_BOOL, name, _ABSTRACT(SDL_IOStream) _I32);

WRITE8(write_u8, Uint8, SDL_WriteU8)
WRITE8(write_s8, Sint8, SDL_WriteS8)
WRITE8(write_u16_le, Uint16, SDL_WriteU16LE)
WRITE8(write_s16_le, Sint16, SDL_WriteS16LE)
WRITE8(write_u16_be, Uint16, SDL_WriteU16BE)
WRITE8(write_s16_be, Sint16, SDL_WriteS16BE)
WRITE8(write_u32_le, Uint32, SDL_WriteU32LE)
WRITE8(write_s32_le, Sint32, SDL_WriteS32LE)
WRITE8(write_u32_be, Uint32, SDL_WriteU32BE)
WRITE8(write_s32_be, Sint32, SDL_WriteS32BE)

#define WRITE64(name, sdlfn)                                         \
    HL_PRIM bool HL_NAME(name)(SDL_IOStream * dst, int hi, int lo) { \
        Uint64 v = ((Uint64)(Uint32)hi << 32) | (Uint32)lo;          \
        return sdlfn(dst, v);                                        \
    }                                                                \
    DEFINE_PRIM(_BOOL, name, _ABSTRACT(SDL_IOStream) _I32 _I32);

WRITE64(write_u64_le, SDL_WriteU64LE)
WRITE64(write_s64_le, SDL_WriteS64LE)
WRITE64(write_u64_be, SDL_WriteU64BE)
WRITE64(write_s64_be, SDL_WriteS64BE)
