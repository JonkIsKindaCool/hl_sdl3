#include "SDL3/SDL_clipboard.h"
#include "SDL3/SDL_log.h"

#include <string.h>

#include "hashlink_macros.h"

static vbyte* take_string(char* s) {
	if (!s)
		return (vbyte*)hl_copy_bytes((const vbyte*)"", 1);
	vbyte* r = hl_copy_bytes((const vbyte*)s, (int)strlen(s) + 1);
	SDL_free(s);
	return r;
}

HL_PRIM bool HL_NAME(set_clipboard_text)(vbyte* text) {
    return SDL_SetClipboardText((const char*)text);
}
DEFINE_PRIM(_BOOL, set_clipboard_text, _BYTES);

HL_PRIM vbyte* HL_NAME(get_clipboard_text)() {
    char* s = SDL_GetClipboardText();
    vbyte* r = take_string(s);
    return r;
}
DEFINE_PRIM(_BYTES, get_clipboard_text, _NO_ARG);

HL_PRIM bool HL_NAME(has_clipboard_text)() { return SDL_HasClipboardText(); }
DEFINE_PRIM(_BOOL, has_clipboard_text, _NO_ARG);

HL_PRIM bool HL_NAME(set_primary_selection_text)(vbyte* text) {
    return SDL_SetPrimarySelectionText((const char*)text);
}
DEFINE_PRIM(_BOOL, set_primary_selection_text, _BYTES);

HL_PRIM vbyte* HL_NAME(get_primary_selection_text)() {
    return take_string(SDL_GetPrimarySelectionText());
}
DEFINE_PRIM(_BYTES, get_primary_selection_text, _NO_ARG);

HL_PRIM bool HL_NAME(has_primary_selection_text)() {
    return SDL_HasPrimarySelectionText();
}
DEFINE_PRIM(_BOOL, has_primary_selection_text, _NO_ARG);

struct clip_item {
    char* mime;
    Uint8* data;
    size_t size;
};

struct clip_set {
    clip_item* items;
    int count;
};

static clip_set* pending = NULL;

static void clip_set_free(clip_set* s) {
    if (!s) return;
    for (int i = 0; i < s->count; i++) {
        SDL_free(s->items[i].mime);
        SDL_free(s->items[i].data);
    }
    SDL_free(s->items);
    SDL_free(s);
}

static const void* SDLCALL clip_data_cb(void* userdata, const char* mime_type,
                                        size_t* size) {
    clip_set* s = (clip_set*)userdata;
    if (size) *size = 0;
    if (!s || !mime_type) return NULL;
    for (int i = 0; i < s->count; i++) {
        if (SDL_strcmp(s->items[i].mime, mime_type) == 0) {
            if (size) *size = s->items[i].size;
            return s->items[i].data;
        }
    }
    return NULL;
}

static void SDLCALL clip_cleanup_cb(void* userdata) {
    clip_set_free((clip_set*)userdata);
}

HL_PRIM void HL_NAME(clipboard_data_begin)() {
    clip_set_free(pending);
    pending = (clip_set*)SDL_calloc(1, sizeof(clip_set));
}
DEFINE_PRIM(_VOID, clipboard_data_begin, _NO_ARG);

HL_PRIM bool HL_NAME(clipboard_data_add)(vbyte* mime, vbyte* data, int size) {
    if (!pending || !mime || size < 0) return false;
    clip_item* items = (clip_item*)SDL_realloc(
        pending->items, sizeof(clip_item) * (pending->count + 1));
    if (!items) return false;
    pending->items = items;
    clip_item* it = &items[pending->count];
    it->mime = SDL_strdup((const char*)mime);
    it->data = (Uint8*)SDL_malloc(size > 0 ? size : 1);
    it->size = (size_t)size;
    if (!it->mime || !it->data) {
        SDL_free(it->mime);
        SDL_free(it->data);
        return false;
    }
    if (size > 0) memcpy(it->data, data, size);
    pending->count++;
    return true;
}
DEFINE_PRIM(_BOOL, clipboard_data_add, _BYTES _BYTES _I32);

HL_PRIM bool HL_NAME(clipboard_data_commit)() {
    if (!pending || pending->count == 0) {
        clip_set_free(pending);
        pending = NULL;
        return false;
    }
    const char** mimes =
        (const char**)SDL_malloc(sizeof(char*) * pending->count);
    for (int i = 0; i < pending->count; i++) mimes[i] = pending->items[i].mime;
    clip_set* s = pending;
    pending = NULL;
    bool ok = SDL_SetClipboardData(clip_data_cb, clip_cleanup_cb, s, mimes,
                                   (size_t)s->count);
    SDL_free(mimes);
    if (!ok) clip_set_free(s);
    return ok;
}
DEFINE_PRIM(_BOOL, clipboard_data_commit, _NO_ARG);

HL_PRIM bool HL_NAME(clear_clipboard_data)() {
    return SDL_ClearClipboardData();
}
DEFINE_PRIM(_BOOL, clear_clipboard_data, _NO_ARG);

HL_PRIM bool HL_NAME(has_clipboard_data)(vbyte* mime) {
    return SDL_HasClipboardData((const char*)mime);
}
DEFINE_PRIM(_BOOL, has_clipboard_data, _BYTES);

struct clip_blob {
    void* data;
    size_t size;
};

HL_PRIM clip_blob* HL_NAME(clipboard_fetch)(vbyte* mime) {
    size_t size = 0;
    void* d = SDL_GetClipboardData((const char*)mime, &size);
    if (!d) return NULL;
    clip_blob* b = (clip_blob*)SDL_malloc(sizeof(clip_blob));
    if (!b) {
        SDL_free(d);
        return NULL;
    }
    b->data = d;
    b->size = size;
    return b;
}
DEFINE_PRIM(_ABSTRACT(SDL_ClipboardBlob), clipboard_fetch, _BYTES);

HL_PRIM int HL_NAME(clipboard_blob_size)(clip_blob* b) { return (int)b->size; }
DEFINE_PRIM(_I32, clipboard_blob_size, _ABSTRACT(SDL_ClipboardBlob));

HL_PRIM void HL_NAME(clipboard_blob_copy)(clip_blob* b, vbyte* dst) {
    memcpy(dst, b->data, b->size);
}
DEFINE_PRIM(_VOID, clipboard_blob_copy, _ABSTRACT(SDL_ClipboardBlob) _BYTES);

HL_PRIM void HL_NAME(clipboard_blob_free)(clip_blob* b) {
    if (!b) return;
    SDL_free(b->data);
    SDL_free(b);
}
DEFINE_PRIM(_VOID, clipboard_blob_free, _ABSTRACT(SDL_ClipboardBlob));

HL_PRIM varray* HL_NAME(get_clipboard_mime_types)() {
    size_t n = 0;
    char** types = SDL_GetClipboardMimeTypes(&n);
    if (!types) return hl_alloc_array(&hlt_bytes, 0);
    varray* a = hl_alloc_array(&hlt_bytes, (int)n);
    vbyte** p = hl_aptr(a, vbyte*);
    for (size_t i = 0; i < n; i++)
        p[i] = hl_copy_bytes((const vbyte*)types[i], (int)strlen(types[i]) + 1);
    SDL_free(types);
    return a;
}
DEFINE_PRIM(_ARR, get_clipboard_mime_types, _NO_ARG);