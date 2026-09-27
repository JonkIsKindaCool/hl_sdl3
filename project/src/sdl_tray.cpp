#include "SDL3/SDL_tray.h"
#include "SDL3/SDL_mutex.h"

#include <string.h>

#include "hashlink_macros.h"

static vbyte* copy_str(const char* s) {
    if (!s) return NULL;
    return hl_copy_bytes((const vbyte*)s, (int)strlen(s) + 1);
}

HL_PRIM SDL_Tray* HL_NAME(create_tray)(SDL_Surface* icon, vbyte* tooltip) {
    return SDL_CreateTray(icon, (const char*)tooltip);
}
DEFINE_PRIM(_ABSTRACT(SDL_Tray), create_tray, _ABSTRACT(SDL_Surface) _BYTES);

HL_PRIM void HL_NAME(set_tray_icon)(SDL_Tray* tray, SDL_Surface* icon) {
    SDL_SetTrayIcon(tray, icon);
}
DEFINE_PRIM(_VOID, set_tray_icon, _ABSTRACT(SDL_Tray) _ABSTRACT(SDL_Surface));

HL_PRIM void HL_NAME(set_tray_tooltip)(SDL_Tray* tray, vbyte* tooltip) {
    SDL_SetTrayTooltip(tray, (const char*)tooltip);
}
DEFINE_PRIM(_VOID, set_tray_tooltip, _ABSTRACT(SDL_Tray) _BYTES);

HL_PRIM void HL_NAME(destroy_tray)(SDL_Tray* tray) { SDL_DestroyTray(tray); }
DEFINE_PRIM(_VOID, destroy_tray, _ABSTRACT(SDL_Tray));

HL_PRIM void HL_NAME(update_trays)() { SDL_UpdateTrays(); }
DEFINE_PRIM(_VOID, update_trays, _NO_ARG);

HL_PRIM SDL_TrayMenu* HL_NAME(create_tray_menu)(SDL_Tray* tray) {
    return SDL_CreateTrayMenu(tray);
}
DEFINE_PRIM(_ABSTRACT(SDL_TrayMenu), create_tray_menu, _ABSTRACT(SDL_Tray));

HL_PRIM SDL_TrayMenu* HL_NAME(create_tray_submenu)(SDL_TrayEntry* entry) {
    return SDL_CreateTraySubmenu(entry);
}
DEFINE_PRIM(_ABSTRACT(SDL_TrayMenu), create_tray_submenu,
            _ABSTRACT(SDL_TrayEntry));

HL_PRIM SDL_TrayMenu* HL_NAME(get_tray_menu)(SDL_Tray* tray) {
    return SDL_GetTrayMenu(tray);
}
DEFINE_PRIM(_ABSTRACT(SDL_TrayMenu), get_tray_menu, _ABSTRACT(SDL_Tray));

HL_PRIM SDL_TrayMenu* HL_NAME(get_tray_submenu)(SDL_TrayEntry* entry) {
    return SDL_GetTraySubmenu(entry);
}
DEFINE_PRIM(_ABSTRACT(SDL_TrayMenu), get_tray_submenu,
            _ABSTRACT(SDL_TrayEntry));

HL_PRIM SDL_Tray* HL_NAME(get_tray_menu_parent_tray)(SDL_TrayMenu* menu) {
    return SDL_GetTrayMenuParentTray(menu);
}
DEFINE_PRIM(_ABSTRACT(SDL_Tray), get_tray_menu_parent_tray,
            _ABSTRACT(SDL_TrayMenu));

HL_PRIM SDL_TrayEntry* HL_NAME(get_tray_menu_parent_entry)(SDL_TrayMenu* menu) {
    return SDL_GetTrayMenuParentEntry(menu);
}
DEFINE_PRIM(_ABSTRACT(SDL_TrayEntry), get_tray_menu_parent_entry,
            _ABSTRACT(SDL_TrayMenu));

HL_PRIM SDL_TrayMenu* HL_NAME(get_tray_entry_parent)(SDL_TrayEntry* entry) {
    return SDL_GetTrayEntryParent(entry);
}
DEFINE_PRIM(_ABSTRACT(SDL_TrayMenu), get_tray_entry_parent,
            _ABSTRACT(SDL_TrayEntry));

HL_PRIM int HL_NAME(get_tray_entries_count)(SDL_TrayMenu* menu) {
    int count = 0;
    SDL_GetTrayEntries(menu, &count);
    return count;
}
DEFINE_PRIM(_I32, get_tray_entries_count, _ABSTRACT(SDL_TrayMenu));

HL_PRIM SDL_TrayEntry* HL_NAME(get_tray_entry_at)(SDL_TrayMenu* menu,
                                                  int index) {
    int count = 0;
    const SDL_TrayEntry** entries = SDL_GetTrayEntries(menu, &count);
    if (!entries || index < 0 || index >= count) return NULL;
    return (SDL_TrayEntry*)entries[index];
}
DEFINE_PRIM(_ABSTRACT(SDL_TrayEntry), get_tray_entry_at,
            _ABSTRACT(SDL_TrayMenu) _I32);

HL_PRIM SDL_TrayEntry* HL_NAME(insert_tray_entry_at)(SDL_TrayMenu* menu,
                                                     int pos, vbyte* label,
                                                     int flags) {
    return SDL_InsertTrayEntryAt(menu, pos, (const char*)label,
                                 (SDL_TrayEntryFlags)(Uint32)flags);
}
DEFINE_PRIM(_ABSTRACT(SDL_TrayEntry), insert_tray_entry_at,
            _ABSTRACT(SDL_TrayMenu) _I32 _BYTES _I32);

HL_PRIM void HL_NAME(remove_tray_entry)(SDL_TrayEntry* entry) {
    SDL_RemoveTrayEntry(entry);
}
DEFINE_PRIM(_VOID, remove_tray_entry, _ABSTRACT(SDL_TrayEntry));

HL_PRIM void HL_NAME(set_tray_entry_label)(SDL_TrayEntry* entry,
                                           vbyte* label) {
    SDL_SetTrayEntryLabel(entry, (const char*)label);
}
DEFINE_PRIM(_VOID, set_tray_entry_label, _ABSTRACT(SDL_TrayEntry) _BYTES);

HL_PRIM vbyte* HL_NAME(get_tray_entry_label)(SDL_TrayEntry* entry) {
    return copy_str(SDL_GetTrayEntryLabel(entry));
}
DEFINE_PRIM(_BYTES, get_tray_entry_label, _ABSTRACT(SDL_TrayEntry));

HL_PRIM void HL_NAME(set_tray_entry_checked)(SDL_TrayEntry* entry,
                                             bool checked) {
    SDL_SetTrayEntryChecked(entry, checked);
}
DEFINE_PRIM(_VOID, set_tray_entry_checked, _ABSTRACT(SDL_TrayEntry) _BOOL);

HL_PRIM bool HL_NAME(get_tray_entry_checked)(SDL_TrayEntry* entry) {
    return SDL_GetTrayEntryChecked(entry);
}
DEFINE_PRIM(_BOOL, get_tray_entry_checked, _ABSTRACT(SDL_TrayEntry));

HL_PRIM void HL_NAME(set_tray_entry_enabled)(SDL_TrayEntry* entry,
                                             bool enabled) {
    SDL_SetTrayEntryEnabled(entry, enabled);
}
DEFINE_PRIM(_VOID, set_tray_entry_enabled, _ABSTRACT(SDL_TrayEntry) _BOOL);

HL_PRIM bool HL_NAME(get_tray_entry_enabled)(SDL_TrayEntry* entry) {
    return SDL_GetTrayEntryEnabled(entry);
}
DEFINE_PRIM(_BOOL, get_tray_entry_enabled, _ABSTRACT(SDL_TrayEntry));

HL_PRIM void HL_NAME(click_tray_entry)(SDL_TrayEntry* entry) {
    SDL_ClickTrayEntry(entry);
}
DEFINE_PRIM(_VOID, click_tray_entry, _ABSTRACT(SDL_TrayEntry));

struct tray_event {
    int id;
    tray_event* next;
};

static SDL_Mutex* tray_mutex = NULL;
static tray_event* tray_head = NULL;
static tray_event* tray_tail = NULL;

static void SDLCALL tray_cb(void* userdata, SDL_TrayEntry* entry) {
    (void)entry;
    int id = (int)(intptr_t)userdata;
    tray_event* e = (tray_event*)SDL_calloc(1, sizeof(tray_event));
    if (!e) return;
    e->id = id;
    SDL_LockMutex(tray_mutex);
    if (tray_tail)
        tray_tail->next = e;
    else
        tray_head = e;
    tray_tail = e;
    SDL_UnlockMutex(tray_mutex);
}

HL_PRIM void HL_NAME(set_tray_entry_callback)(SDL_TrayEntry* entry, int id) {
    if (!tray_mutex) tray_mutex = SDL_CreateMutex();
    SDL_SetTrayEntryCallback(entry, tray_cb, (void*)(intptr_t)id);
}
DEFINE_PRIM(_VOID, set_tray_entry_callback, _ABSTRACT(SDL_TrayEntry) _I32);

HL_PRIM void HL_NAME(clear_tray_entry_callback)(SDL_TrayEntry* entry) {
    SDL_SetTrayEntryCallback(entry, NULL, NULL);
}
DEFINE_PRIM(_VOID, clear_tray_entry_callback, _ABSTRACT(SDL_TrayEntry));

HL_PRIM int HL_NAME(tray_poll)() {
    if (!tray_mutex) return -1;
    SDL_LockMutex(tray_mutex);
    tray_event* e = tray_head;
    if (e) {
        tray_head = e->next;
        if (!tray_head) tray_tail = NULL;
    }
    SDL_UnlockMutex(tray_mutex);
    int r = -1;
    if (e) {
        r = e->id;
        SDL_free(e);
    }
    return r;
}
DEFINE_PRIM(_I32, tray_poll, _NO_ARG);