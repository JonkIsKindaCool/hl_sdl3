#include "SDL3/SDL_video.h"
#include "SDL3/SDL_surface.h"
#include "SDL3/SDL_properties.h"
#include "SDL3/SDL_pixels.h"

#include <string.h>

#include "hashlink_macros.h"

static vbyte* copy_str(const char* s) {
    if (!s) return NULL;
    return hl_copy_bytes((const vbyte*)s, (int)strlen(s) + 1);
}

/* ==================== Drivers / theme ==================== */

HL_PRIM int HL_NAME(get_num_video_drivers)() { return SDL_GetNumVideoDrivers(); }
DEFINE_PRIM(_I32, get_num_video_drivers, _NO_ARG);

HL_PRIM vbyte* HL_NAME(get_video_driver)(int index) {
    return copy_str(SDL_GetVideoDriver(index));
}
DEFINE_PRIM(_BYTES, get_video_driver, _I32);

HL_PRIM vbyte* HL_NAME(get_current_video_driver)() {
    return copy_str(SDL_GetCurrentVideoDriver());
}
DEFINE_PRIM(_BYTES, get_current_video_driver, _NO_ARG);

HL_PRIM int HL_NAME(get_system_theme)() { return (int)SDL_GetSystemTheme(); }
DEFINE_PRIM(_I32, get_system_theme, _NO_ARG);

/* ==================== Displays ==================== */

HL_PRIM varray* HL_NAME(get_displays)() {
    int count = 0;
    SDL_DisplayID* ids = SDL_GetDisplays(&count);
    if (!ids) return hl_alloc_array(&hlt_i32, 0);
    varray* a = hl_alloc_array(&hlt_i32, count);
    int* p = hl_aptr(a, int);
    for (int i = 0; i < count; i++) p[i] = (int)ids[i];
    SDL_free(ids);
    return a;
}
DEFINE_PRIM(_ARR, get_displays, _NO_ARG);

HL_PRIM int HL_NAME(get_primary_display)() {
    return (int)SDL_GetPrimaryDisplay();
}
DEFINE_PRIM(_I32, get_primary_display, _NO_ARG);

HL_PRIM int HL_NAME(get_display_properties)(int displayID) {
    return (int)SDL_GetDisplayProperties((SDL_DisplayID)displayID);
}
DEFINE_PRIM(_I32, get_display_properties, _I32);

HL_PRIM vbyte* HL_NAME(get_display_name)(int displayID) {
    return copy_str(SDL_GetDisplayName((SDL_DisplayID)displayID));
}
DEFINE_PRIM(_BYTES, get_display_name, _I32);

HL_PRIM bool HL_NAME(get_display_bounds)(int displayID, varray* out) {
    SDL_Rect r;
    bool ok = SDL_GetDisplayBounds((SDL_DisplayID)displayID, &r);
    int* o = hl_aptr(out, int);
    o[0] = r.x; o[1] = r.y; o[2] = r.w; o[3] = r.h;
    return ok;
}
DEFINE_PRIM(_BOOL, get_display_bounds, _I32 _ARR);

HL_PRIM bool HL_NAME(get_display_usable_bounds)(int displayID, varray* out) {
    SDL_Rect r;
    bool ok = SDL_GetDisplayUsableBounds((SDL_DisplayID)displayID, &r);
    int* o = hl_aptr(out, int);
    o[0] = r.x; o[1] = r.y; o[2] = r.w; o[3] = r.h;
    return ok;
}
DEFINE_PRIM(_BOOL, get_display_usable_bounds, _I32 _ARR);

HL_PRIM int HL_NAME(get_natural_display_orientation)(int displayID) {
    return (int)SDL_GetNaturalDisplayOrientation((SDL_DisplayID)displayID);
}
DEFINE_PRIM(_I32, get_natural_display_orientation, _I32);

HL_PRIM int HL_NAME(get_current_display_orientation)(int displayID) {
    return (int)SDL_GetCurrentDisplayOrientation((SDL_DisplayID)displayID);
}
DEFINE_PRIM(_I32, get_current_display_orientation, _I32);

HL_PRIM double HL_NAME(get_display_content_scale)(int displayID) {
    return (double)SDL_GetDisplayContentScale((SDL_DisplayID)displayID);
}
DEFINE_PRIM(_F64, get_display_content_scale, _I32);

HL_PRIM int HL_NAME(get_fullscreen_display_modes_count)(int displayID) {
    int count = 0;
    SDL_DisplayMode** modes =
        SDL_GetFullscreenDisplayModes((SDL_DisplayID)displayID, &count);
    if (modes) SDL_free(modes);
    return count;
}
DEFINE_PRIM(_I32, get_fullscreen_display_modes_count, _I32);

HL_PRIM SDL_DisplayMode* HL_NAME(get_fullscreen_display_mode_at)(int displayID,
                                                                  int index) {
    int count = 0;
    SDL_DisplayMode** modes =
        SDL_GetFullscreenDisplayModes((SDL_DisplayID)displayID, &count);
    if (!modes) return NULL;
    SDL_DisplayMode* r = (index >= 0 && index < count) ? modes[index] : NULL;
    SDL_free(modes);
    return r;
}
DEFINE_PRIM(_ABSTRACT(SDL_DisplayMode), get_fullscreen_display_mode_at,
            _I32 _I32);

HL_PRIM bool HL_NAME(get_closest_fullscreen_display_mode)(
    int displayID, int w, int h, double refreshRate, bool includeHighDensity,
    SDL_DisplayMode* out) {
    return SDL_GetClosestFullscreenDisplayMode((SDL_DisplayID)displayID, w, h,
                                               (float)refreshRate,
                                               includeHighDensity, out);
}
DEFINE_PRIM(_BOOL, get_closest_fullscreen_display_mode,
            _I32 _I32 _I32 _F64 _BOOL _ABSTRACT(SDL_DisplayMode));

HL_PRIM SDL_DisplayMode* HL_NAME(get_desktop_display_mode)(int displayID) {
    return (SDL_DisplayMode*)SDL_GetDesktopDisplayMode((SDL_DisplayID)displayID);
}
DEFINE_PRIM(_ABSTRACT(SDL_DisplayMode), get_desktop_display_mode, _I32);

HL_PRIM SDL_DisplayMode* HL_NAME(get_current_display_mode)(int displayID) {
    return (SDL_DisplayMode*)SDL_GetCurrentDisplayMode((SDL_DisplayID)displayID);
}
DEFINE_PRIM(_ABSTRACT(SDL_DisplayMode), get_current_display_mode, _I32);

HL_PRIM int HL_NAME(get_display_for_point)(int x, int y) {
    SDL_Point p = {x, y};
    return (int)SDL_GetDisplayForPoint(&p);
}
DEFINE_PRIM(_I32, get_display_for_point, _I32 _I32);

HL_PRIM int HL_NAME(get_display_for_rect)(int x, int y, int w, int h) {
    SDL_Rect r = {x, y, w, h};
    return (int)SDL_GetDisplayForRect(&r);
}
DEFINE_PRIM(_I32, get_display_for_rect, _I32 _I32 _I32 _I32);

HL_PRIM int HL_NAME(get_display_for_window)(SDL_Window* w) {
    return (int)SDL_GetDisplayForWindow(w);
}
DEFINE_PRIM(_I32, get_display_for_window, _ABSTRACT(SDL_Window));

/* ==================== DisplayMode struct ==================== */

HL_PRIM SDL_DisplayMode* HL_NAME(display_mode_alloc)() {
    SDL_DisplayMode* m =
        (SDL_DisplayMode*)hl_gc_alloc_noptr(sizeof(SDL_DisplayMode));
    memset(m, 0, sizeof(SDL_DisplayMode));
    return m;
}
DEFINE_PRIM(_ABSTRACT(SDL_DisplayMode), display_mode_alloc, _NO_ARG);

HL_PRIM int HL_NAME(display_mode_display_id)(SDL_DisplayMode* m) {
    return (int)m->displayID;
}
DEFINE_PRIM(_I32, display_mode_display_id, _ABSTRACT(SDL_DisplayMode));

HL_PRIM int HL_NAME(display_mode_format)(SDL_DisplayMode* m) {
    return (int)m->format;
}
DEFINE_PRIM(_I32, display_mode_format, _ABSTRACT(SDL_DisplayMode));

HL_PRIM int HL_NAME(display_mode_w)(SDL_DisplayMode* m) { return m->w; }
DEFINE_PRIM(_I32, display_mode_w, _ABSTRACT(SDL_DisplayMode));

HL_PRIM int HL_NAME(display_mode_h)(SDL_DisplayMode* m) { return m->h; }
DEFINE_PRIM(_I32, display_mode_h, _ABSTRACT(SDL_DisplayMode));

HL_PRIM double HL_NAME(display_mode_pixel_density)(SDL_DisplayMode* m) {
    return (double)m->pixel_density;
}
DEFINE_PRIM(_F64, display_mode_pixel_density, _ABSTRACT(SDL_DisplayMode));

HL_PRIM double HL_NAME(display_mode_refresh_rate)(SDL_DisplayMode* m) {
    return (double)m->refresh_rate;
}
DEFINE_PRIM(_F64, display_mode_refresh_rate, _ABSTRACT(SDL_DisplayMode));

HL_PRIM int HL_NAME(display_mode_refresh_rate_numerator)(SDL_DisplayMode* m) {
    return m->refresh_rate_numerator;
}
DEFINE_PRIM(_I32, display_mode_refresh_rate_numerator,
            _ABSTRACT(SDL_DisplayMode));

HL_PRIM int HL_NAME(display_mode_refresh_rate_denominator)(SDL_DisplayMode* m) {
    return m->refresh_rate_denominator;
}
DEFINE_PRIM(_I32, display_mode_refresh_rate_denominator,
            _ABSTRACT(SDL_DisplayMode));

/* ==================== Window pixel density / scale ==================== */

HL_PRIM double HL_NAME(get_window_pixel_density)(SDL_Window* w) {
    return (double)SDL_GetWindowPixelDensity(w);
}
DEFINE_PRIM(_F64, get_window_pixel_density, _ABSTRACT(SDL_Window));

HL_PRIM double HL_NAME(get_window_display_scale)(SDL_Window* w) {
    return (double)SDL_GetWindowDisplayScale(w);
}
DEFINE_PRIM(_F64, get_window_display_scale, _ABSTRACT(SDL_Window));

/* ==================== Fullscreen mode ==================== */

HL_PRIM bool HL_NAME(set_window_fullscreen_mode)(SDL_Window* w,
                                                 SDL_DisplayMode* m) {
    return SDL_SetWindowFullscreenMode(w, m);
}
DEFINE_PRIM(_BOOL, set_window_fullscreen_mode,
            _ABSTRACT(SDL_Window) _ABSTRACT(SDL_DisplayMode));

HL_PRIM SDL_DisplayMode* HL_NAME(get_window_fullscreen_mode)(SDL_Window* w) {
    return (SDL_DisplayMode*)SDL_GetWindowFullscreenMode(w);
}
DEFINE_PRIM(_ABSTRACT(SDL_DisplayMode), get_window_fullscreen_mode,
            _ABSTRACT(SDL_Window));

/* ==================== ICC profile / pixel format ==================== */

HL_PRIM vbyte* HL_NAME(get_window_icc_profile)(SDL_Window* w, varray* outSize) {
    size_t size = 0;
    void* data = SDL_GetWindowICCProfile(w, &size);
    hl_aptr(outSize, int)[0] = (int)size;
    if (!data) return NULL;
    vbyte* r = hl_copy_bytes((const vbyte*)data, (int)size);
    SDL_free(data);
    return r;
}
DEFINE_PRIM(_BYTES, get_window_icc_profile, _ABSTRACT(SDL_Window) _ARR);

HL_PRIM int HL_NAME(get_window_pixel_format)(SDL_Window* w) {
    return (int)SDL_GetWindowPixelFormat(w);
}
DEFINE_PRIM(_I32, get_window_pixel_format, _ABSTRACT(SDL_Window));

/* ==================== Window list ==================== */

HL_PRIM int HL_NAME(get_windows_count)() {
    int count = 0;
    SDL_Window** ws = SDL_GetWindows(&count);
    if (ws) SDL_free(ws);
    return count;
}
DEFINE_PRIM(_I32, get_windows_count, _NO_ARG);

HL_PRIM SDL_Window* HL_NAME(get_window_at)(int index) {
    int count = 0;
    SDL_Window** ws = SDL_GetWindows(&count);
    if (!ws) return NULL;
    SDL_Window* r = (index >= 0 && index < count) ? ws[index] : NULL;
    SDL_free(ws);
    return r;
}
DEFINE_PRIM(_ABSTRACT(SDL_Window), get_window_at, _I32);

/* ==================== Window creation ==================== */

HL_PRIM SDL_Window* HL_NAME(create_window)(vbyte* title, int w, int h,
                                           int64 flags) {
    return SDL_CreateWindow((const char*)title, w, h, (SDL_WindowFlags)flags);
}
DEFINE_PRIM(_ABSTRACT(SDL_Window), create_window, _BYTES _I32 _I32 _I64);

HL_PRIM SDL_Window* HL_NAME(create_popup_window)(SDL_Window* parent, int ox,
                                                 int oy, int w, int h,
                                                 int64 flags) {
    return SDL_CreatePopupWindow(parent, ox, oy, w, h, (SDL_WindowFlags)flags);
}
DEFINE_PRIM(_ABSTRACT(SDL_Window), create_popup_window,
            _ABSTRACT(SDL_Window) _I32 _I32 _I32 _I32 _I64);

HL_PRIM SDL_Window* HL_NAME(create_window_with_properties)(int props) {
    return SDL_CreateWindowWithProperties((SDL_PropertiesID)props);
}
DEFINE_PRIM(_ABSTRACT(SDL_Window), create_window_with_properties, _I32);

HL_PRIM void HL_NAME(destroy_window)(SDL_Window* w) { SDL_DestroyWindow(w); }
DEFINE_PRIM(_VOID, destroy_window, _ABSTRACT(SDL_Window));

/* ==================== IDs / parents ==================== */

HL_PRIM int HL_NAME(get_window_id)(SDL_Window* w) {
    return (int)SDL_GetWindowID(w);
}
DEFINE_PRIM(_I32, get_window_id, _ABSTRACT(SDL_Window));

HL_PRIM SDL_Window* HL_NAME(get_window_from_id)(int id) {
    return SDL_GetWindowFromID((SDL_WindowID)id);
}
DEFINE_PRIM(_ABSTRACT(SDL_Window), get_window_from_id, _I32);

HL_PRIM SDL_Window* HL_NAME(get_window_parent)(SDL_Window* w) {
    return SDL_GetWindowParent(w);
}
DEFINE_PRIM(_ABSTRACT(SDL_Window), get_window_parent, _ABSTRACT(SDL_Window));

HL_PRIM int HL_NAME(get_window_properties)(SDL_Window* w) {
    return (int)SDL_GetWindowProperties(w);
}
DEFINE_PRIM(_I32, get_window_properties, _ABSTRACT(SDL_Window));

/* ==================== Flags / title / icon ==================== */

HL_PRIM int64 HL_NAME(get_window_flags)(SDL_Window* w) {
    return (int64)SDL_GetWindowFlags(w);
}
DEFINE_PRIM(_I64, get_window_flags, _ABSTRACT(SDL_Window));

HL_PRIM bool HL_NAME(set_window_title)(SDL_Window* w, vbyte* title) {
    return SDL_SetWindowTitle(w, (const char*)title);
}
DEFINE_PRIM(_BOOL, set_window_title, _ABSTRACT(SDL_Window) _BYTES);

HL_PRIM vbyte* HL_NAME(get_window_title)(SDL_Window* w) {
    return copy_str(SDL_GetWindowTitle(w));
}
DEFINE_PRIM(_BYTES, get_window_title, _ABSTRACT(SDL_Window));

HL_PRIM bool HL_NAME(set_window_icon)(SDL_Window* w, SDL_Surface* icon) {
    return SDL_SetWindowIcon(w, icon);
}
DEFINE_PRIM(_BOOL, set_window_icon,
            _ABSTRACT(SDL_Window) _ABSTRACT(SDL_Surface));

/* ==================== Position / size ==================== */

HL_PRIM bool HL_NAME(set_window_position)(SDL_Window* w, int x, int y) {
    return SDL_SetWindowPosition(w, x, y);
}
DEFINE_PRIM(_BOOL, set_window_position, _ABSTRACT(SDL_Window) _I32 _I32);

HL_PRIM bool HL_NAME(get_window_position)(SDL_Window* w, varray* out) {
    int x = 0, y = 0;
    bool ok = SDL_GetWindowPosition(w, &x, &y);
    int* o = hl_aptr(out, int);
    o[0] = x; o[1] = y;
    return ok;
}
DEFINE_PRIM(_BOOL, get_window_position, _ABSTRACT(SDL_Window) _ARR);

HL_PRIM bool HL_NAME(set_window_size)(SDL_Window* w, int cw, int ch) {
    return SDL_SetWindowSize(w, cw, ch);
}
DEFINE_PRIM(_BOOL, set_window_size, _ABSTRACT(SDL_Window) _I32 _I32);

HL_PRIM bool HL_NAME(get_window_size)(SDL_Window* w, varray* out) {
    int cw = 0, ch = 0;
    bool ok = SDL_GetWindowSize(w, &cw, &ch);
    int* o = hl_aptr(out, int);
    o[0] = cw; o[1] = ch;
    return ok;
}
DEFINE_PRIM(_BOOL, get_window_size, _ABSTRACT(SDL_Window) _ARR);

HL_PRIM bool HL_NAME(get_window_safe_area)(SDL_Window* w, varray* out) {
    SDL_Rect r;
    bool ok = SDL_GetWindowSafeArea(w, &r);
    int* o = hl_aptr(out, int);
    o[0] = r.x; o[1] = r.y; o[2] = r.w; o[3] = r.h;
    return ok;
}
DEFINE_PRIM(_BOOL, get_window_safe_area, _ABSTRACT(SDL_Window) _ARR);

HL_PRIM bool HL_NAME(set_window_aspect_ratio)(SDL_Window* w, double mn,
                                              double mx) {
    return SDL_SetWindowAspectRatio(w, (float)mn, (float)mx);
}
DEFINE_PRIM(_BOOL, set_window_aspect_ratio,
            _ABSTRACT(SDL_Window) _F64 _F64);

HL_PRIM bool HL_NAME(get_window_aspect_ratio)(SDL_Window* w, varray* out) {
    float mn = 0, mx = 0;
    bool ok = SDL_GetWindowAspectRatio(w, &mn, &mx);
    double* o = hl_aptr(out, double);
    o[0] = mn; o[1] = mx;
    return ok;
}
DEFINE_PRIM(_BOOL, get_window_aspect_ratio, _ABSTRACT(SDL_Window) _ARR);

HL_PRIM bool HL_NAME(get_window_borders_size)(SDL_Window* w, varray* out) {
    int t = 0, l = 0, b = 0, r = 0;
    bool ok = SDL_GetWindowBordersSize(w, &t, &l, &b, &r);
    int* o = hl_aptr(out, int);
    o[0] = t; o[1] = l; o[2] = b; o[3] = r;
    return ok;
}
DEFINE_PRIM(_BOOL, get_window_borders_size, _ABSTRACT(SDL_Window) _ARR);

HL_PRIM bool HL_NAME(get_window_size_in_pixels)(SDL_Window* w, varray* out) {
    int cw = 0, ch = 0;
    bool ok = SDL_GetWindowSizeInPixels(w, &cw, &ch);
    int* o = hl_aptr(out, int);
    o[0] = cw; o[1] = ch;
    return ok;
}
DEFINE_PRIM(_BOOL, get_window_size_in_pixels, _ABSTRACT(SDL_Window) _ARR);

HL_PRIM bool HL_NAME(set_window_minimum_size)(SDL_Window* w, int mnw,
                                              int mnh) {
    return SDL_SetWindowMinimumSize(w, mnw, mnh);
}
DEFINE_PRIM(_BOOL, set_window_minimum_size, _ABSTRACT(SDL_Window) _I32 _I32);

HL_PRIM bool HL_NAME(get_window_minimum_size)(SDL_Window* w, varray* out) {
    int mnw = 0, mnh = 0;
    bool ok = SDL_GetWindowMinimumSize(w, &mnw, &mnh);
    int* o = hl_aptr(out, int);
    o[0] = mnw; o[1] = mnh;
    return ok;
}
DEFINE_PRIM(_BOOL, get_window_minimum_size, _ABSTRACT(SDL_Window) _ARR);

HL_PRIM bool HL_NAME(set_window_maximum_size)(SDL_Window* w, int mxw,
                                              int mxh) {
    return SDL_SetWindowMaximumSize(w, mxw, mxh);
}
DEFINE_PRIM(_BOOL, set_window_maximum_size, _ABSTRACT(SDL_Window) _I32 _I32);

HL_PRIM bool HL_NAME(get_window_maximum_size)(SDL_Window* w, varray* out) {
    int mxw = 0, mxh = 0;
    bool ok = SDL_GetWindowMaximumSize(w, &mxw, &mxh);
    int* o = hl_aptr(out, int);
    o[0] = mxw; o[1] = mxh;
    return ok;
}
DEFINE_PRIM(_BOOL, get_window_maximum_size, _ABSTRACT(SDL_Window) _ARR);

/* ==================== Window state ==================== */

HL_PRIM bool HL_NAME(set_window_bordered)(SDL_Window* w, bool bordered) {
    return SDL_SetWindowBordered(w, bordered);
}
DEFINE_PRIM(_BOOL, set_window_bordered, _ABSTRACT(SDL_Window) _BOOL);

HL_PRIM bool HL_NAME(set_window_resizable)(SDL_Window* w, bool resizable) {
    return SDL_SetWindowResizable(w, resizable);
}
DEFINE_PRIM(_BOOL, set_window_resizable, _ABSTRACT(SDL_Window) _BOOL);

HL_PRIM bool HL_NAME(set_window_always_on_top)(SDL_Window* w, bool onTop) {
    return SDL_SetWindowAlwaysOnTop(w, onTop);
}
DEFINE_PRIM(_BOOL, set_window_always_on_top, _ABSTRACT(SDL_Window) _BOOL);

HL_PRIM bool HL_NAME(set_window_fill_document)(SDL_Window* w, bool fill) {
    return SDL_SetWindowFillDocument(w, fill);
}
DEFINE_PRIM(_BOOL, set_window_fill_document, _ABSTRACT(SDL_Window) _BOOL);

HL_PRIM bool HL_NAME(show_window)(SDL_Window* w) { return SDL_ShowWindow(w); }
DEFINE_PRIM(_BOOL, show_window, _ABSTRACT(SDL_Window));

HL_PRIM bool HL_NAME(hide_window)(SDL_Window* w) { return SDL_HideWindow(w); }
DEFINE_PRIM(_BOOL, hide_window, _ABSTRACT(SDL_Window));

HL_PRIM bool HL_NAME(raise_window)(SDL_Window* w) { return SDL_RaiseWindow(w); }
DEFINE_PRIM(_BOOL, raise_window, _ABSTRACT(SDL_Window));

HL_PRIM bool HL_NAME(maximize_window)(SDL_Window* w) {
    return SDL_MaximizeWindow(w);
}
DEFINE_PRIM(_BOOL, maximize_window, _ABSTRACT(SDL_Window));

HL_PRIM bool HL_NAME(minimize_window)(SDL_Window* w) {
    return SDL_MinimizeWindow(w);
}
DEFINE_PRIM(_BOOL, minimize_window, _ABSTRACT(SDL_Window));

HL_PRIM bool HL_NAME(restore_window)(SDL_Window* w) {
    return SDL_RestoreWindow(w);
}
DEFINE_PRIM(_BOOL, restore_window, _ABSTRACT(SDL_Window));

HL_PRIM bool HL_NAME(set_window_fullscreen)(SDL_Window* w, bool fullscreen) {
    hl_blocking(true);
    bool r = SDL_SetWindowFullscreen(w, fullscreen);
    hl_blocking(false);
    return r;
}
DEFINE_PRIM(_BOOL, set_window_fullscreen, _ABSTRACT(SDL_Window) _BOOL);

HL_PRIM bool HL_NAME(sync_window)(SDL_Window* w) {
    hl_blocking(true);
    bool r = SDL_SyncWindow(w);
    hl_blocking(false);
    return r;
}
DEFINE_PRIM(_BOOL, sync_window, _ABSTRACT(SDL_Window));

/* ==================== Window surface ==================== */

HL_PRIM bool HL_NAME(window_has_surface)(SDL_Window* w) {
    return SDL_WindowHasSurface(w);
}
DEFINE_PRIM(_BOOL, window_has_surface, _ABSTRACT(SDL_Window));

HL_PRIM SDL_Surface* HL_NAME(get_window_surface)(SDL_Window* w) {
    return SDL_GetWindowSurface(w);
}
DEFINE_PRIM(_ABSTRACT(SDL_Surface), get_window_surface, _ABSTRACT(SDL_Window));

HL_PRIM bool HL_NAME(set_window_surface_vsync)(SDL_Window* w, int vsync) {
    return SDL_SetWindowSurfaceVSync(w, vsync);
}
DEFINE_PRIM(_BOOL, set_window_surface_vsync, _ABSTRACT(SDL_Window) _I32);

HL_PRIM bool HL_NAME(get_window_surface_vsync)(SDL_Window* w, varray* out) {
    int vsync = 0;
    bool ok = SDL_GetWindowSurfaceVSync(w, &vsync);
    hl_aptr(out, int)[0] = vsync;
    return ok;
}
DEFINE_PRIM(_BOOL, get_window_surface_vsync, _ABSTRACT(SDL_Window) _ARR);

HL_PRIM bool HL_NAME(update_window_surface)(SDL_Window* w) {
    return SDL_UpdateWindowSurface(w);
}
DEFINE_PRIM(_BOOL, update_window_surface, _ABSTRACT(SDL_Window));

HL_PRIM bool HL_NAME(update_window_surface_rects)(SDL_Window* w,
                                                  varray* rectsXYWH) {
    int count = rectsXYWH->size / 4;
    int* a = hl_aptr(rectsXYWH, int);
    SDL_Rect* rects = (SDL_Rect*)SDL_malloc(sizeof(SDL_Rect) * count);
    if (!rects) return false;
    for (int i = 0; i < count; i++) {
        rects[i].x = a[i * 4];
        rects[i].y = a[i * 4 + 1];
        rects[i].w = a[i * 4 + 2];
        rects[i].h = a[i * 4 + 3];
    }
    bool ok = SDL_UpdateWindowSurfaceRects(w, rects, count);
    SDL_free(rects);
    return ok;
}
DEFINE_PRIM(_BOOL, update_window_surface_rects, _ABSTRACT(SDL_Window) _ARR);

HL_PRIM bool HL_NAME(destroy_window_surface)(SDL_Window* w) {
    return SDL_DestroyWindowSurface(w);
}
DEFINE_PRIM(_BOOL, destroy_window_surface, _ABSTRACT(SDL_Window));

/* ==================== Grab / mouse rect / opacity ==================== */

HL_PRIM bool HL_NAME(set_window_keyboard_grab)(SDL_Window* w, bool grabbed) {
    return SDL_SetWindowKeyboardGrab(w, grabbed);
}
DEFINE_PRIM(_BOOL, set_window_keyboard_grab, _ABSTRACT(SDL_Window) _BOOL);

HL_PRIM bool HL_NAME(set_window_mouse_grab)(SDL_Window* w, bool grabbed) {
    return SDL_SetWindowMouseGrab(w, grabbed);
}
DEFINE_PRIM(_BOOL, set_window_mouse_grab, _ABSTRACT(SDL_Window) _BOOL);

HL_PRIM bool HL_NAME(get_window_keyboard_grab)(SDL_Window* w) {
    return SDL_GetWindowKeyboardGrab(w);
}
DEFINE_PRIM(_BOOL, get_window_keyboard_grab, _ABSTRACT(SDL_Window));

HL_PRIM bool HL_NAME(get_window_mouse_grab)(SDL_Window* w) {
    return SDL_GetWindowMouseGrab(w);
}
DEFINE_PRIM(_BOOL, get_window_mouse_grab, _ABSTRACT(SDL_Window));

HL_PRIM SDL_Window* HL_NAME(get_grabbed_window)() {
    return SDL_GetGrabbedWindow();
}
DEFINE_PRIM(_ABSTRACT(SDL_Window), get_grabbed_window, _NO_ARG);

HL_PRIM bool HL_NAME(set_window_mouse_rect)(SDL_Window* w, int x, int y,
                                            int rw, int rh) {
    SDL_Rect r = {x, y, rw, rh};
    bool has = rw > 0 && rh > 0;
    return SDL_SetWindowMouseRect(w, has ? &r : NULL);
}
DEFINE_PRIM(_BOOL, set_window_mouse_rect,
            _ABSTRACT(SDL_Window) _I32 _I32 _I32 _I32);

HL_PRIM bool HL_NAME(get_window_mouse_rect)(SDL_Window* w, varray* out) {
    const SDL_Rect* r = SDL_GetWindowMouseRect(w);
    int* o = hl_aptr(out, int);
    if (!r) {
        o[0] = o[1] = o[2] = o[3] = 0;
        return false;
    }
    o[0] = r->x; o[1] = r->y; o[2] = r->w; o[3] = r->h;
    return true;
}
DEFINE_PRIM(_BOOL, get_window_mouse_rect, _ABSTRACT(SDL_Window) _ARR);

HL_PRIM bool HL_NAME(set_window_opacity)(SDL_Window* w, double opacity) {
    return SDL_SetWindowOpacity(w, (float)opacity);
}
DEFINE_PRIM(_BOOL, set_window_opacity, _ABSTRACT(SDL_Window) _F64);

HL_PRIM double HL_NAME(get_window_opacity)(SDL_Window* w) {
    return (double)SDL_GetWindowOpacity(w);
}
DEFINE_PRIM(_F64, get_window_opacity, _ABSTRACT(SDL_Window));

/* ==================== Parenting / modality / misc ==================== */

HL_PRIM bool HL_NAME(set_window_parent)(SDL_Window* w, SDL_Window* parent) {
    return SDL_SetWindowParent(w, parent);
}
DEFINE_PRIM(_BOOL, set_window_parent,
            _ABSTRACT(SDL_Window) _ABSTRACT(SDL_Window));

HL_PRIM bool HL_NAME(set_window_modal)(SDL_Window* w, bool modal) {
    return SDL_SetWindowModal(w, modal);
}
DEFINE_PRIM(_BOOL, set_window_modal, _ABSTRACT(SDL_Window) _BOOL);

HL_PRIM bool HL_NAME(set_window_focusable)(SDL_Window* w, bool focusable) {
    return SDL_SetWindowFocusable(w, focusable);
}
DEFINE_PRIM(_BOOL, set_window_focusable, _ABSTRACT(SDL_Window) _BOOL);

HL_PRIM bool HL_NAME(show_window_system_menu)(SDL_Window* w, int x, int y) {
    return SDL_ShowWindowSystemMenu(w, x, y);
}
DEFINE_PRIM(_BOOL, show_window_system_menu,
            _ABSTRACT(SDL_Window) _I32 _I32);

HL_PRIM bool HL_NAME(set_window_shape)(SDL_Window* w, SDL_Surface* shape) {
    return SDL_SetWindowShape(w, shape);
}
DEFINE_PRIM(_BOOL, set_window_shape,
            _ABSTRACT(SDL_Window) _ABSTRACT(SDL_Surface));

HL_PRIM bool HL_NAME(flash_window)(SDL_Window* w, int operation) {
    return SDL_FlashWindow(w, (SDL_FlashOperation)operation);
}
DEFINE_PRIM(_BOOL, flash_window, _ABSTRACT(SDL_Window) _I32);

HL_PRIM bool HL_NAME(set_window_progress_state)(SDL_Window* w, int state) {
    return SDL_SetWindowProgressState(w, (SDL_ProgressState)state);
}
DEFINE_PRIM(_BOOL, set_window_progress_state, _ABSTRACT(SDL_Window) _I32);

HL_PRIM int HL_NAME(get_window_progress_state)(SDL_Window* w) {
    return (int)SDL_GetWindowProgressState(w);
}
DEFINE_PRIM(_I32, get_window_progress_state, _ABSTRACT(SDL_Window));

HL_PRIM bool HL_NAME(set_window_progress_value)(SDL_Window* w, double value) {
    return SDL_SetWindowProgressValue(w, (float)value);
}
DEFINE_PRIM(_BOOL, set_window_progress_value, _ABSTRACT(SDL_Window) _F64);

HL_PRIM double HL_NAME(get_window_progress_value)(SDL_Window* w) {
    return (double)SDL_GetWindowProgressValue(w);
}
DEFINE_PRIM(_F64, get_window_progress_value, _ABSTRACT(SDL_Window));

/* ==================== Screensaver ==================== */

HL_PRIM bool HL_NAME(screen_saver_enabled)() {
    return SDL_ScreenSaverEnabled();
}
DEFINE_PRIM(_BOOL, screen_saver_enabled, _NO_ARG);

HL_PRIM bool HL_NAME(enable_screen_saver)() { return SDL_EnableScreenSaver(); }
DEFINE_PRIM(_BOOL, enable_screen_saver, _NO_ARG);

HL_PRIM bool HL_NAME(disable_screen_saver)() {
    return SDL_DisableScreenSaver();
}
DEFINE_PRIM(_BOOL, disable_screen_saver, _NO_ARG);

/* ==================== OpenGL / EGL ==================== */

HL_PRIM bool HL_NAME(gl_load_library)(vbyte* path) {
    return SDL_GL_LoadLibrary((const char*)path);
}
DEFINE_PRIM(_BOOL, gl_load_library, _BYTES);

HL_PRIM void* HL_NAME(gl_get_proc_address)(vbyte* proc) {
    return (void*)SDL_GL_GetProcAddress((const char*)proc);
}
DEFINE_PRIM(_ABSTRACT(SDL_FunctionPointer), gl_get_proc_address, _BYTES);

HL_PRIM void* HL_NAME(egl_get_proc_address)(vbyte* proc) {
    return (void*)SDL_EGL_GetProcAddress((const char*)proc);
}
DEFINE_PRIM(_ABSTRACT(SDL_FunctionPointer), egl_get_proc_address, _BYTES);

HL_PRIM void HL_NAME(gl_unload_library)() { SDL_GL_UnloadLibrary(); }
DEFINE_PRIM(_VOID, gl_unload_library, _NO_ARG);

HL_PRIM bool HL_NAME(gl_extension_supported)(vbyte* extension) {
    return SDL_GL_ExtensionSupported((const char*)extension);
}
DEFINE_PRIM(_BOOL, gl_extension_supported, _BYTES);

HL_PRIM void HL_NAME(gl_reset_attributes)() { SDL_GL_ResetAttributes(); }
DEFINE_PRIM(_VOID, gl_reset_attributes, _NO_ARG);

HL_PRIM bool HL_NAME(gl_set_attribute)(int attr, int value) {
    return SDL_GL_SetAttribute((SDL_GLAttr)attr, value);
}
DEFINE_PRIM(_BOOL, gl_set_attribute, _I32 _I32);

HL_PRIM bool HL_NAME(gl_get_attribute)(int attr, varray* out) {
    int value = 0;
    bool ok = SDL_GL_GetAttribute((SDL_GLAttr)attr, &value);
    hl_aptr(out, int)[0] = value;
    return ok;
}
DEFINE_PRIM(_BOOL, gl_get_attribute, _I32 _ARR);

HL_PRIM SDL_GLContext HL_NAME(gl_create_context)(SDL_Window* w) {
    return SDL_GL_CreateContext(w);
}
DEFINE_PRIM(_ABSTRACT(SDL_GLContext), gl_create_context, _ABSTRACT(SDL_Window));

HL_PRIM bool HL_NAME(gl_make_current)(SDL_Window* w, SDL_GLContext ctx) {
    return SDL_GL_MakeCurrent(w, ctx);
}
DEFINE_PRIM(_BOOL, gl_make_current,
            _ABSTRACT(SDL_Window) _ABSTRACT(SDL_GLContext));

HL_PRIM SDL_Window* HL_NAME(gl_get_current_window)() {
    return SDL_GL_GetCurrentWindow();
}
DEFINE_PRIM(_ABSTRACT(SDL_Window), gl_get_current_window, _NO_ARG);

HL_PRIM SDL_GLContext HL_NAME(gl_get_current_context)() {
    return SDL_GL_GetCurrentContext();
}
DEFINE_PRIM(_ABSTRACT(SDL_GLContext), gl_get_current_context, _NO_ARG);

HL_PRIM void* HL_NAME(egl_get_current_display)() {
    return (void*)SDL_EGL_GetCurrentDisplay();
}
DEFINE_PRIM(_ABSTRACT(SDL_EGLDisplay), egl_get_current_display, _NO_ARG);

HL_PRIM void* HL_NAME(egl_get_current_config)() {
    return (void*)SDL_EGL_GetCurrentConfig();
}
DEFINE_PRIM(_ABSTRACT(SDL_EGLConfig), egl_get_current_config, _NO_ARG);

HL_PRIM void* HL_NAME(egl_get_window_surface)(SDL_Window* w) {
    return (void*)SDL_EGL_GetWindowSurface(w);
}
DEFINE_PRIM(_ABSTRACT(SDL_EGLSurface), egl_get_window_surface,
            _ABSTRACT(SDL_Window));

HL_PRIM bool HL_NAME(gl_set_swap_interval)(int interval) {
    return SDL_GL_SetSwapInterval(interval);
}
DEFINE_PRIM(_BOOL, gl_set_swap_interval, _I32);

HL_PRIM bool HL_NAME(gl_get_swap_interval)(varray* out) {
    int interval = 0;
    bool ok = SDL_GL_GetSwapInterval(&interval);
    hl_aptr(out, int)[0] = interval;
    return ok;
}
DEFINE_PRIM(_BOOL, gl_get_swap_interval, _ARR);

HL_PRIM bool HL_NAME(gl_swap_window)(SDL_Window* w) {
    return SDL_GL_SwapWindow(w);
}
DEFINE_PRIM(_BOOL, gl_swap_window, _ABSTRACT(SDL_Window));

HL_PRIM bool HL_NAME(gl_destroy_context)(SDL_GLContext ctx) {
    return SDL_GL_DestroyContext(ctx);
}
DEFINE_PRIM(_BOOL, gl_destroy_context, _ABSTRACT(SDL_GLContext));