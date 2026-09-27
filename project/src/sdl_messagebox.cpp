#include "hashlink_macros.h"
#include "SDL3/SDL_messagebox.h"

HL_PRIM bool HL_NAME(show_simple_message_box)(int flags, vbyte* title, vbyte* message, SDL_Window* window) {
	hl_blocking(true);
	bool r = SDL_ShowSimpleMessageBox((SDL_MessageBoxFlags)flags, (const char*)title, (const char*)message, window);
	hl_blocking(false);
	return r;
}
DEFINE_PRIM(_BOOL, show_simple_message_box, _I32 _BYTES _BYTES _ABSTRACT(SDL_Window));

HL_PRIM bool HL_NAME(show_message_box)(int flags, SDL_Window* window, vbyte* title, vbyte* message, varray* buttonFlags, varray* buttonIds,
	varray* buttonTexts, varray* colors, varray* outButtonId) {
	int n = buttonFlags ? buttonFlags->size : 0;
	SDL_MessageBoxButtonData* btns = NULL;
	if (n > 0) {
		btns = (SDL_MessageBoxButtonData*)SDL_calloc(n, sizeof(SDL_MessageBoxButtonData));
		int* flagsArr = hl_aptr(buttonFlags, int);
		int* idsArr = hl_aptr(buttonIds, int);
		vbyte** textsArr = hl_aptr(buttonTexts, vbyte*);
		for (int i = 0; i < n; i++) {
			btns[i].flags = (SDL_MessageBoxButtonFlags)flagsArr[i];
			btns[i].buttonID = idsArr[i];
			btns[i].text = (const char*)textsArr[i];
		}
	}

	SDL_MessageBoxColorScheme scheme;
	SDL_MessageBoxColorScheme* schemePtr = NULL;
	if (colors && colors->size >= SDL_MESSAGEBOX_COLOR_COUNT * 3) {
		int* c = hl_aptr(colors, int);
		for (int i = 0; i < SDL_MESSAGEBOX_COLOR_COUNT; i++) {
			scheme.colors[i].r = (Uint8)c[i * 3 + 0];
			scheme.colors[i].g = (Uint8)c[i * 3 + 1];
			scheme.colors[i].b = (Uint8)c[i * 3 + 2];
		}
		schemePtr = &scheme;
	}

	SDL_MessageBoxData data;
	SDL_zero(data);
	data.flags = (SDL_MessageBoxFlags)flags;
	data.window = window;
	data.title = (const char*)title;
	data.message = (const char*)message;
	data.numbuttons = n;
	data.buttons = btns;
	data.colorScheme = schemePtr;

	int buttonid = -1;
	hl_blocking(true);
	bool ok = SDL_ShowMessageBox(&data, &buttonid);
	hl_blocking(false);

	SDL_free(btns);
	hl_aptr(outButtonId, int)[0] = buttonid;
	return ok;
}
DEFINE_PRIM(_BOOL, show_message_box, _I32 _ABSTRACT(SDL_Window) _BYTES _BYTES _ARR _ARR _ARR _ARR _ARR);
