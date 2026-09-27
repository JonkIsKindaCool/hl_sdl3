#include "hashlink_macros.h"
#include "SDL3/SDL_keyboard.h"
#include <string.h>

static vbyte* copy_str(const char* s) {
	if (!s)
		return NULL;
	return hl_copy_bytes((const vbyte*)s, (int)strlen(s) + 1);
}

static varray* ids_to_array(SDL_KeyboardID* ids, int count) {
	if (!ids)
		return hl_alloc_array(&hlt_i32, 0);
	varray* a = hl_alloc_array(&hlt_i32, count);
	int* p = hl_aptr(a, int);
	for (int i = 0; i < count; i++)
		p[i] = (int)ids[i];
	SDL_free(ids);
	return a;
}

HL_PRIM bool HL_NAME(has_keyboard)() { return SDL_HasKeyboard(); }
DEFINE_PRIM(_BOOL, has_keyboard, _NO_ARG);

HL_PRIM varray* HL_NAME(get_keyboards)() {
	int count = 0;
	SDL_KeyboardID* ids = SDL_GetKeyboards(&count);
	return ids_to_array(ids, count);
}
DEFINE_PRIM(_ARR, get_keyboards, _NO_ARG);

HL_PRIM vbyte* HL_NAME(get_keyboard_name_for_id)(int id) { return copy_str(SDL_GetKeyboardNameForID((SDL_KeyboardID)id)); }
DEFINE_PRIM(_BYTES, get_keyboard_name_for_id, _I32);

HL_PRIM SDL_Window* HL_NAME(get_keyboard_focus)() { return SDL_GetKeyboardFocus(); }
DEFINE_PRIM(_ABSTRACT(SDL_Window), get_keyboard_focus, _NO_ARG);

HL_PRIM varray* HL_NAME(get_keyboard_state)() {
	int numkeys = 0;
	const bool* state = SDL_GetKeyboardState(&numkeys);
	varray* a = hl_alloc_array(&hlt_i32, numkeys);
	int* p = hl_aptr(a, int);
	for (int i = 0; i < numkeys; i++)
		p[i] = (state && state[i]) ? 1 : 0;
	return a;
}
DEFINE_PRIM(_ARR, get_keyboard_state, _NO_ARG);

HL_PRIM void HL_NAME(reset_keyboard)() { SDL_ResetKeyboard(); }
DEFINE_PRIM(_VOID, reset_keyboard, _NO_ARG);

HL_PRIM int HL_NAME(get_mod_state)() { return (int)SDL_GetModState(); }
DEFINE_PRIM(_I32, get_mod_state, _NO_ARG);

HL_PRIM void HL_NAME(set_mod_state)(int modstate) { SDL_SetModState((SDL_Keymod)modstate); }
DEFINE_PRIM(_VOID, set_mod_state, _I32);

HL_PRIM int HL_NAME(get_key_from_scancode)(int scancode, int modstate, bool keyEvent) {
	return (int)SDL_GetKeyFromScancode((SDL_Scancode)scancode, (SDL_Keymod)modstate, keyEvent);
}
DEFINE_PRIM(_I32, get_key_from_scancode, _I32 _I32 _BOOL);

HL_PRIM int HL_NAME(get_scancode_from_key)(int key, varray* outMod) {
	SDL_Keymod mod = SDL_KMOD_NONE;
	int r = (int)SDL_GetScancodeFromKey((SDL_Keycode)key, &mod);
	if (outMod != NULL)
		hl_aptr(outMod, int)[0] = (int)mod;
	return r;
}
DEFINE_PRIM(_I32, get_scancode_from_key, _I32 _ARR);

HL_PRIM bool HL_NAME(set_scancode_name)(int scancode, vbyte* name) { return SDL_SetScancodeName((SDL_Scancode)scancode, (const char*)name); }
DEFINE_PRIM(_BOOL, set_scancode_name, _I32 _BYTES);

HL_PRIM vbyte* HL_NAME(get_scancode_name)(int scancode) { return copy_str(SDL_GetScancodeName((SDL_Scancode)scancode)); }
DEFINE_PRIM(_BYTES, get_scancode_name, _I32);

HL_PRIM int HL_NAME(get_scancode_from_name)(vbyte* name) { return (int)SDL_GetScancodeFromName((const char*)name); }
DEFINE_PRIM(_I32, get_scancode_from_name, _BYTES);

HL_PRIM vbyte* HL_NAME(get_key_name)(int key) { return copy_str(SDL_GetKeyName((SDL_Keycode)key)); }
DEFINE_PRIM(_BYTES, get_key_name, _I32);

HL_PRIM int HL_NAME(get_key_from_name)(vbyte* name) { return (int)SDL_GetKeyFromName((const char*)name); }
DEFINE_PRIM(_I32, get_key_from_name, _BYTES);

HL_PRIM bool HL_NAME(start_text_input)(SDL_Window* window) { return SDL_StartTextInput(window); }
DEFINE_PRIM(_BOOL, start_text_input, _ABSTRACT(SDL_Window));

HL_PRIM bool HL_NAME(start_text_input_with_properties)(SDL_Window* window, int type, int capitalization, bool autocorrect, bool multiline,
	int androidInputType) {
	SDL_PropertiesID props = SDL_CreateProperties();
	SDL_SetNumberProperty(props, SDL_PROP_TEXTINPUT_TYPE_NUMBER, type);
	SDL_SetNumberProperty(props, SDL_PROP_TEXTINPUT_CAPITALIZATION_NUMBER, capitalization);
	SDL_SetBooleanProperty(props, SDL_PROP_TEXTINPUT_AUTOCORRECT_BOOLEAN, autocorrect);
	SDL_SetBooleanProperty(props, SDL_PROP_TEXTINPUT_MULTILINE_BOOLEAN, multiline);
	if (androidInputType >= 0)
		SDL_SetNumberProperty(props, SDL_PROP_TEXTINPUT_ANDROID_INPUTTYPE_NUMBER, androidInputType);
	bool r = SDL_StartTextInputWithProperties(window, props);
	SDL_DestroyProperties(props);
	return r;
}
DEFINE_PRIM(_BOOL, start_text_input_with_properties, _ABSTRACT(SDL_Window) _I32 _I32 _BOOL _BOOL _I32);

HL_PRIM bool HL_NAME(text_input_active)(SDL_Window* window) { return SDL_TextInputActive(window); }
DEFINE_PRIM(_BOOL, text_input_active, _ABSTRACT(SDL_Window));

HL_PRIM bool HL_NAME(stop_text_input)(SDL_Window* window) { return SDL_StopTextInput(window); }
DEFINE_PRIM(_BOOL, stop_text_input, _ABSTRACT(SDL_Window));

HL_PRIM bool HL_NAME(clear_composition)(SDL_Window* window) { return SDL_ClearComposition(window); }
DEFINE_PRIM(_BOOL, clear_composition, _ABSTRACT(SDL_Window));

HL_PRIM bool HL_NAME(set_text_input_area)(SDL_Window* window, int x, int y, int w, int h, int cursor) {
	SDL_Rect r = {x, y, w, h};
	return SDL_SetTextInputArea(window, &r, cursor);
}
DEFINE_PRIM(_BOOL, set_text_input_area, _ABSTRACT(SDL_Window) _I32 _I32 _I32 _I32 _I32);

HL_PRIM bool HL_NAME(get_text_input_area)(SDL_Window* window, varray* out) {
	SDL_Rect r;
	int cursor = 0;
	bool ok = SDL_GetTextInputArea(window, &r, &cursor);
	int* o = hl_aptr(out, int);
	o[0] = r.x;
	o[1] = r.y;
	o[2] = r.w;
	o[3] = r.h;
	o[4] = cursor;
	return ok;
}
DEFINE_PRIM(_BOOL, get_text_input_area, _ABSTRACT(SDL_Window) _ARR);

HL_PRIM bool HL_NAME(has_screen_keyboard_support)() { return SDL_HasScreenKeyboardSupport(); }
DEFINE_PRIM(_BOOL, has_screen_keyboard_support, _NO_ARG);

HL_PRIM bool HL_NAME(screen_keyboard_shown)(SDL_Window* window) { return SDL_ScreenKeyboardShown(window); }
DEFINE_PRIM(_BOOL, screen_keyboard_shown, _ABSTRACT(SDL_Window));
