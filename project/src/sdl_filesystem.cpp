#include "SDL3/SDL_filesystem.h"

#include <string.h>

#include "hashlink_macros.h"

static vbyte* copy_str(const char* s) {
    if (!s) return NULL;
    return hl_copy_bytes((const vbyte*)s, (int)strlen(s) + 1);
}

static vbyte* take_str(char* s) {
    vbyte* r = copy_str(s);
    SDL_free(s);
    return r;
}

static varray* take_string_list(char** list, int count) {
    varray* a = hl_alloc_array(&hlt_bytes, count);
    vbyte** p = hl_aptr(a, vbyte*);
    for (int i = 0; i < count; i++) p[i] = copy_str(list[i]);
    SDL_free(list);
    return a;
}

HL_PRIM vbyte* HL_NAME(get_base_path)() { return copy_str(SDL_GetBasePath()); }
DEFINE_PRIM(_BYTES, get_base_path, _NO_ARG);

HL_PRIM vbyte* HL_NAME(get_pref_path)(vbyte* org, vbyte* app) {
    return take_str(SDL_GetPrefPath((const char*)org, (const char*)app));
}
DEFINE_PRIM(_BYTES, get_pref_path, _BYTES _BYTES);

HL_PRIM vbyte* HL_NAME(get_user_folder)(int folder) {
    return copy_str(SDL_GetUserFolder((SDL_Folder)folder));
}
DEFINE_PRIM(_BYTES, get_user_folder, _I32);

HL_PRIM vbyte* HL_NAME(get_current_directory)() {
    return take_str(SDL_GetCurrentDirectory());
}
DEFINE_PRIM(_BYTES, get_current_directory, _NO_ARG);

HL_PRIM bool HL_NAME(create_directory)(vbyte* path) {
    return SDL_CreateDirectory((const char*)path);
}
DEFINE_PRIM(_BOOL, create_directory, _BYTES);

HL_PRIM bool HL_NAME(remove_path)(vbyte* path) {
    return SDL_RemovePath((const char*)path);
}
DEFINE_PRIM(_BOOL, remove_path, _BYTES);

HL_PRIM bool HL_NAME(rename_path)(vbyte* oldpath, vbyte* newpath) {
    return SDL_RenamePath((const char*)oldpath, (const char*)newpath);
}
DEFINE_PRIM(_BOOL, rename_path, _BYTES _BYTES);

HL_PRIM bool HL_NAME(copy_file)(vbyte* oldpath, vbyte* newpath) {
    hl_blocking(true);
    bool r = SDL_CopyFile((const char*)oldpath, (const char*)newpath);
    hl_blocking(false);
    return r;
}
DEFINE_PRIM(_BOOL, copy_file, _BYTES _BYTES);

HL_PRIM bool HL_NAME(path_exists)(vbyte* path) {
    return SDL_GetPathInfo((const char*)path, NULL);
}
DEFINE_PRIM(_BOOL, path_exists, _BYTES);

HL_PRIM bool HL_NAME(get_path_info)(vbyte* path, varray* out) {
    SDL_PathInfo info;
    SDL_zero(info);
    if (!SDL_GetPathInfo((const char*)path, &info)) return false;
    int* o = hl_aptr(out, int);
    o[0] = (int)info.type;
    o[1] = (int)(Uint32)(info.size >> 32);
    o[2] = (int)(Uint32)(info.size & 0xFFFFFFFFu);
    Uint64 t[3] = {(Uint64)info.create_time, (Uint64)info.modify_time,
                   (Uint64)info.access_time};
    for (int i = 0; i < 3; i++) {
        o[3 + i * 2] = (int)(Uint32)(t[i] >> 32);
        o[4 + i * 2] = (int)(Uint32)(t[i] & 0xFFFFFFFFu);
    }
    return true;
}
DEFINE_PRIM(_BOOL, get_path_info, _BYTES _ARR);

struct name_list {
    char** items;
    int count;
    bool failed;
};

static SDL_EnumerationResult SDLCALL enum_cb(void* userdata,
                                             const char* dirname,
                                             const char* fname) {
    name_list* l = (name_list*)userdata;
    char** items =
        (char**)SDL_realloc(l->items, sizeof(char*) * (l->count + 1));
    if (!items) {
        l->failed = true;
        return SDL_ENUM_FAILURE;
    }
    l->items = items;
    l->items[l->count] = SDL_strdup(fname);
    if (!l->items[l->count]) {
        l->failed = true;
        return SDL_ENUM_FAILURE;
    }
    l->count++;
    return SDL_ENUM_CONTINUE;
}

HL_PRIM varray* HL_NAME(enumerate_directory)(vbyte* path) {
    name_list l = {NULL, 0, false};
    hl_blocking(true);
    bool ok = SDL_EnumerateDirectory((const char*)path, enum_cb, &l);
    hl_blocking(false);

    varray* a = NULL;
    if (ok && !l.failed) {
        a = hl_alloc_array(&hlt_bytes, l.count);
        vbyte** p = hl_aptr(a, vbyte*);
        for (int i = 0; i < l.count; i++) p[i] = copy_str(l.items[i]);
    }
    for (int i = 0; i < l.count; i++) SDL_free(l.items[i]);
    SDL_free(l.items);
    return a;
}
DEFINE_PRIM(_ARR, enumerate_directory, _BYTES);

HL_PRIM varray* HL_NAME(glob_directory)(vbyte* path, vbyte* pattern,
                                        int flags) {
    int count = 0;
    hl_blocking(true);
    char** list = SDL_GlobDirectory((const char*)path, (const char*)pattern,
                                    (SDL_GlobFlags)flags, &count);
    hl_blocking(false);
    if (!list) return NULL;
    return take_string_list(list, count);
}
DEFINE_PRIM(_ARR, glob_directory, _BYTES _BYTES _I32);