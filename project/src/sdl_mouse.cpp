#include "hashlink_macros.h"
#include "SDL3/SDL_mouse.h"
#include <string.h>
#include <vector>

static vbyte* copy_str(const char* s) {
	if (!s)
		return NULL;
	return hl_copy_bytes((const vbyte*)s, (int)strlen(s) + 1);
}

static varray* ids_to_array(SDL_MouseID* ids, int count) {
	if (!ids)
		return hl_alloc_array(&hlt_i32, 0);
	varray* a = hl_alloc_array(&hlt_i32, count);
	int* p = hl_aptr(a, int);
	for (int i = 0; i < count; i++)
		p[i] = (int)ids[i];
	SDL_free(ids);
	return a;
}

HL_PRIM bool HL_NAME(has_mouse)() { return SDL_HasMouse(); }
DEFINE_PRIM(_BOOL, has_mouse, _NO_ARG);

HL_PRIM varray* HL_NAME(get_mice)() {
	int count = 0;
	SDL_MouseID* ids = SDL_GetMice(&count);
	return ids_to_array(ids, count);
}
DEFINE_PRIM(_ARR, get_mice, _NO_ARG);

HL_PRIM vbyte* HL_NAME(get_mouse_name_for_id)(int id) { return copy_str(SDL_GetMouseNameForID((SDL_MouseID)id)); }
DEFINE_PRIM(_BYTES, get_mouse_name_for_id, _I32);

HL_PRIM SDL_Window* HL_NAME(get_mouse_focus)() { return SDL_GetMouseFocus(); }
DEFINE_PRIM(_ABSTRACT(SDL_Window), get_mouse_focus, _NO_ARG);

HL_PRIM int HL_NAME(get_mouse_state)(varray* out) {
	float x = 0, y = 0;
	SDL_MouseButtonFlags flags = SDL_GetMouseState(&x, &y);
	double* o = hl_aptr(out, double);
	o[0] = x;
	o[1] = y;
	return (int)flags;
}
DEFINE_PRIM(_I32, get_mouse_state, _ARR);

HL_PRIM int HL_NAME(get_global_mouse_state)(varray* out) {
	float x = 0, y = 0;
	SDL_MouseButtonFlags flags = SDL_GetGlobalMouseState(&x, &y);
	double* o = hl_aptr(out, double);
	o[0] = x;
	o[1] = y;
	return (int)flags;
}
DEFINE_PRIM(_I32, get_global_mouse_state, _ARR);

HL_PRIM int HL_NAME(get_relative_mouse_state)(varray* out) {
	float x = 0, y = 0;
	SDL_MouseButtonFlags flags = SDL_GetRelativeMouseState(&x, &y);
	double* o = hl_aptr(out, double);
	o[0] = x;
	o[1] = y;
	return (int)flags;
}
DEFINE_PRIM(_I32, get_relative_mouse_state, _ARR);

HL_PRIM void HL_NAME(warp_mouse_in_window)(SDL_Window* window, double x, double y) { SDL_WarpMouseInWindow(window, (float)x, (float)y); }
DEFINE_PRIM(_VOID, warp_mouse_in_window, _ABSTRACT(SDL_Window) _F64 _F64);

HL_PRIM bool HL_NAME(warp_mouse_global)(double x, double y) { return SDL_WarpMouseGlobal((float)x, (float)y); }
DEFINE_PRIM(_BOOL, warp_mouse_global, _F64 _F64);

HL_PRIM bool HL_NAME(set_window_relative_mouse_mode)(SDL_Window* window, bool enabled) { return SDL_SetWindowRelativeMouseMode(window, enabled); }
DEFINE_PRIM(_BOOL, set_window_relative_mouse_mode, _ABSTRACT(SDL_Window) _BOOL);

HL_PRIM bool HL_NAME(get_window_relative_mouse_mode)(SDL_Window* window) { return SDL_GetWindowRelativeMouseMode(window); }
DEFINE_PRIM(_BOOL, get_window_relative_mouse_mode, _ABSTRACT(SDL_Window));

HL_PRIM bool HL_NAME(capture_mouse)(bool enabled) { return SDL_CaptureMouse(enabled); }
DEFINE_PRIM(_BOOL, capture_mouse, _BOOL);

HL_PRIM SDL_Cursor* HL_NAME(create_cursor)(vbyte* data, vbyte* mask, int w, int h, int hotX, int hotY) {
	return SDL_CreateCursor((const Uint8*)data, (const Uint8*)mask, w, h, hotX, hotY);
}
DEFINE_PRIM(_ABSTRACT(SDL_Cursor), create_cursor, _BYTES _BYTES _I32 _I32 _I32 _I32);

HL_PRIM SDL_Cursor* HL_NAME(create_color_cursor)(SDL_Surface* surface, int hotX, int hotY) { return SDL_CreateColorCursor(surface, hotX, hotY); }
DEFINE_PRIM(_ABSTRACT(SDL_Cursor), create_color_cursor, _ABSTRACT(SDL_Surface) _I32 _I32);

HL_PRIM SDL_Cursor* HL_NAME(create_system_cursor)(int id) { return SDL_CreateSystemCursor((SDL_SystemCursor)id); }
DEFINE_PRIM(_ABSTRACT(SDL_Cursor), create_system_cursor, _I32);

HL_PRIM bool HL_NAME(set_cursor)(SDL_Cursor* cursor) { return SDL_SetCursor(cursor); }
DEFINE_PRIM(_BOOL, set_cursor, _ABSTRACT(SDL_Cursor));

HL_PRIM SDL_Cursor* HL_NAME(get_cursor)() { return SDL_GetCursor(); }
DEFINE_PRIM(_ABSTRACT(SDL_Cursor), get_cursor, _NO_ARG);

HL_PRIM SDL_Cursor* HL_NAME(get_default_cursor)() { return SDL_GetDefaultCursor(); }
DEFINE_PRIM(_ABSTRACT(SDL_Cursor), get_default_cursor, _NO_ARG);

HL_PRIM void HL_NAME(destroy_cursor)(SDL_Cursor* cursor) { SDL_DestroyCursor(cursor); }
DEFINE_PRIM(_VOID, destroy_cursor, _ABSTRACT(SDL_Cursor));

HL_PRIM bool HL_NAME(show_cursor)() { return SDL_ShowCursor(); }
DEFINE_PRIM(_BOOL, show_cursor, _NO_ARG);

HL_PRIM bool HL_NAME(hide_cursor)() { return SDL_HideCursor(); }
DEFINE_PRIM(_BOOL, hide_cursor, _NO_ARG);

HL_PRIM bool HL_NAME(cursor_visible)() { return SDL_CursorVisible(); }
DEFINE_PRIM(_BOOL, cursor_visible, _NO_ARG);

struct cursor_anim_builder {
	std::vector<SDL_CursorFrameInfo> frames;
};

HL_PRIM cursor_anim_builder* HL_NAME(cursor_anim_begin)() { return new cursor_anim_builder(); }
DEFINE_PRIM(_ABSTRACT(SDLCursorAnimBuilder), cursor_anim_begin, _NO_ARG);

HL_PRIM void HL_NAME(cursor_anim_add_frame)(cursor_anim_builder* b, SDL_Surface* surface, int durationMs) {
	SDL_CursorFrameInfo f;
	f.surface = surface;
	f.duration = (Uint32)durationMs;
	b->frames.push_back(f);
}
DEFINE_PRIM(_VOID, cursor_anim_add_frame, _ABSTRACT(SDLCursorAnimBuilder) _ABSTRACT(SDL_Surface) _I32);

HL_PRIM SDL_Cursor* HL_NAME(cursor_anim_create)(cursor_anim_builder* b, int hotX, int hotY) {
	SDL_Cursor* c = NULL;
	if (!b->frames.empty())
		c = SDL_CreateAnimatedCursor(b->frames.data(), (int)b->frames.size(), hotX, hotY);
	delete b;
	return c;
}
DEFINE_PRIM(_ABSTRACT(SDL_Cursor), cursor_anim_create, _ABSTRACT(SDLCursorAnimBuilder) _I32 _I32);

HL_PRIM void HL_NAME(cursor_anim_cancel)(cursor_anim_builder* b) { delete b; }
DEFINE_PRIM(_VOID, cursor_anim_cancel, _ABSTRACT(SDLCursorAnimBuilder));
