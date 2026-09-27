#include "SDL3/SDL_dialog.h"
#include "SDL3/SDL_mutex.h"

#include <string.h>

#include "hashlink_macros.h"


struct dlg_req {
    int id;
    SDL_DialogFileFilter* filters;
    int nfilters;
};

struct dlg_result {
    int id;
    int status;
    int filter;
    char** files;
    int nfiles;
    char* error;
    dlg_result* next;
};

static SDL_Mutex* q_mutex = NULL;
static dlg_result* q_head = NULL;
static dlg_result* q_tail = NULL;

static void SDLCALL dialog_cb(void* userdata, const char* const* filelist,
                              int filter) {
    dlg_req* req = (dlg_req*)userdata;
    dlg_result* r = (dlg_result*)SDL_calloc(1, sizeof(dlg_result));
    r->id = req->id;
    r->filter = filter;

    if (!filelist) {
        r->status = 2;
        r->error = SDL_strdup(SDL_GetError());
    } else {
        int n = 0;
        while (filelist[n]) n++;
        r->nfiles = n;
        r->status = n == 0 ? 1 : 0;
        if (n > 0) {
            r->files = (char**)SDL_malloc(sizeof(char*) * n);
            for (int i = 0; i < n; i++) r->files[i] = SDL_strdup(filelist[i]);
        }
    }

    SDL_LockMutex(q_mutex);
    if (q_tail)
        q_tail->next = r;
    else
        q_head = r;
    q_tail = r;
    SDL_UnlockMutex(q_mutex);

    for (int i = 0; i < req->nfilters; i++) {
        SDL_free((void*)req->filters[i].name);
        SDL_free((void*)req->filters[i].pattern);
    }
    SDL_free(req->filters);
    SDL_free(req);
}

HL_PRIM void HL_NAME(dialog_show)(int type, int id, SDL_Window* window,
                                  varray* filters, vbyte* location, bool many,
                                  vbyte* title, vbyte* accept, vbyte* cancel) {
    if (!q_mutex) q_mutex = SDL_CreateMutex();

    dlg_req* req = (dlg_req*)SDL_calloc(1, sizeof(dlg_req));
    req->id = id;

    if (filters && filters->size >= 2) {
        int n = filters->size / 2;
        vbyte** src = hl_aptr(filters, vbyte*);
        req->filters =
            (SDL_DialogFileFilter*)SDL_calloc(n, sizeof(SDL_DialogFileFilter));
        req->nfilters = n;
        for (int i = 0; i < n; i++) {
            req->filters[i].name = SDL_strdup((const char*)src[i * 2]);
            req->filters[i].pattern = SDL_strdup((const char*)src[i * 2 + 1]);
        }
    }

    SDL_PropertiesID props = SDL_CreateProperties();
    if (req->filters) {
        SDL_SetPointerProperty(props, SDL_PROP_FILE_DIALOG_FILTERS_POINTER,
                               req->filters);
        SDL_SetNumberProperty(props, SDL_PROP_FILE_DIALOG_NFILTERS_NUMBER,
                              req->nfilters);
    }
    if (window)
        SDL_SetPointerProperty(props, SDL_PROP_FILE_DIALOG_WINDOW_POINTER,
                               window);
    if (location)
        SDL_SetStringProperty(props, SDL_PROP_FILE_DIALOG_LOCATION_STRING,
                              (const char*)location);
    SDL_SetBooleanProperty(props, SDL_PROP_FILE_DIALOG_MANY_BOOLEAN, many);
    if (title)
        SDL_SetStringProperty(props, SDL_PROP_FILE_DIALOG_TITLE_STRING,
                              (const char*)title);
    if (accept)
        SDL_SetStringProperty(props, SDL_PROP_FILE_DIALOG_ACCEPT_STRING,
                              (const char*)accept);
    if (cancel)
        SDL_SetStringProperty(props, SDL_PROP_FILE_DIALOG_CANCEL_STRING,
                              (const char*)cancel);

    SDL_ShowFileDialogWithProperties((SDL_FileDialogType)type, dialog_cb, req,
                                     props);
    SDL_DestroyProperties(props);
}
DEFINE_PRIM(_VOID, dialog_show,
            _I32 _I32 _ABSTRACT(SDL_Window)
                _ARR _BYTES _BOOL _BYTES _BYTES _BYTES);

HL_PRIM dlg_result* HL_NAME(dialog_poll)() {
    if (!q_mutex) return NULL;
    SDL_LockMutex(q_mutex);
    dlg_result* r = q_head;
    if (r) {
        q_head = r->next;
        if (!q_head) q_tail = NULL;
        r->next = NULL;
    }
    SDL_UnlockMutex(q_mutex);
    return r;
}
DEFINE_PRIM(_ABSTRACT(SDL_DialogResult), dialog_poll, _NO_ARG);

HL_PRIM int HL_NAME(dialog_result_id)(dlg_result* r) { return r->id; }
DEFINE_PRIM(_I32, dialog_result_id, _ABSTRACT(SDL_DialogResult));

HL_PRIM int HL_NAME(dialog_result_status)(dlg_result* r) { return r->status; }
DEFINE_PRIM(_I32, dialog_result_status, _ABSTRACT(SDL_DialogResult));

HL_PRIM int HL_NAME(dialog_result_filter)(dlg_result* r) { return r->filter; }
DEFINE_PRIM(_I32, dialog_result_filter, _ABSTRACT(SDL_DialogResult));

HL_PRIM vbyte* HL_NAME(dialog_result_error)(dlg_result* r) {
    return (vbyte*)r->error;
}
DEFINE_PRIM(_BYTES, dialog_result_error, _ABSTRACT(SDL_DialogResult));

HL_PRIM varray* HL_NAME(dialog_result_files)(dlg_result* r) {
    varray* a = hl_alloc_array(&hlt_bytes, r->nfiles);
    vbyte** p = hl_aptr(a, vbyte*);
    for (int i = 0; i < r->nfiles; i++)
        p[i] = hl_copy_bytes((const vbyte*)r->files[i],
                             (int)strlen(r->files[i]) + 1);
    return a;
}
DEFINE_PRIM(_ARR, dialog_result_files, _ABSTRACT(SDL_DialogResult));

HL_PRIM void HL_NAME(dialog_result_free)(dlg_result* r) {
    if (!r) return;
    for (int i = 0; i < r->nfiles; i++) SDL_free(r->files[i]);
    SDL_free(r->files);
    SDL_free(r->error);
    SDL_free(r);
}
DEFINE_PRIM(_VOID, dialog_result_free, _ABSTRACT(SDL_DialogResult));