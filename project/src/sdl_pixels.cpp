#include "hashlink_macros.h"
#include "SDL3/SDL_pixels.h"
#include <string.h>
#include <vector>

static vbyte* copy_str(const char* s) {
	if (!s)
		return NULL;
	return hl_copy_bytes((const vbyte*)s, (int)strlen(s) + 1);
}

HL_PRIM vbyte* HL_NAME(get_pixel_format_name)(int format) { return copy_str(SDL_GetPixelFormatName((SDL_PixelFormat)format)); }
DEFINE_PRIM(_BYTES, get_pixel_format_name, _I32);

HL_PRIM bool HL_NAME(get_masks_for_pixel_format)(int format, varray* out) {
	int bpp = 0;
	Uint32 r = 0, g = 0, b = 0, a = 0;
	bool ok = SDL_GetMasksForPixelFormat((SDL_PixelFormat)format, &bpp, &r, &g, &b, &a);
	int* o = hl_aptr(out, int);
	o[0] = bpp;
	o[1] = (int)r;
	o[2] = (int)g;
	o[3] = (int)b;
	o[4] = (int)a;
	return ok;
}
DEFINE_PRIM(_BOOL, get_masks_for_pixel_format, _I32 _ARR);

HL_PRIM int HL_NAME(get_pixel_format_for_masks)(int bpp, int rmask, int gmask, int bmask, int amask) {
	return (int)SDL_GetPixelFormatForMasks(bpp, (Uint32)rmask, (Uint32)gmask, (Uint32)bmask, (Uint32)amask);
}
DEFINE_PRIM(_I32, get_pixel_format_for_masks, _I32 _I32 _I32 _I32 _I32);

HL_PRIM bool HL_NAME(get_pixel_format_details)(int format, varray* out) {
	const SDL_PixelFormatDetails* d = SDL_GetPixelFormatDetails((SDL_PixelFormat)format);
	if (!d)
		return false;
	int* o = hl_aptr(out, int);
	o[0] = d->bits_per_pixel;
	o[1] = d->bytes_per_pixel;
	o[2] = (int)d->Rmask;
	o[3] = (int)d->Gmask;
	o[4] = (int)d->Bmask;
	o[5] = (int)d->Amask;
	o[6] = d->Rbits;
	o[7] = d->Gbits;
	o[8] = d->Bbits;
	o[9] = d->Abits;
	o[10] = d->Rshift;
	o[11] = d->Gshift;
	o[12] = d->Bshift;
	o[13] = d->Ashift;
	return true;
}
DEFINE_PRIM(_BOOL, get_pixel_format_details, _I32 _ARR);

HL_PRIM SDL_Palette* HL_NAME(create_palette)(int ncolors) { return SDL_CreatePalette(ncolors); }
DEFINE_PRIM(_ABSTRACT(SDL_Palette), create_palette, _I32);

HL_PRIM int HL_NAME(palette_ncolors)(SDL_Palette* p) { return p->ncolors; }
DEFINE_PRIM(_I32, palette_ncolors, _ABSTRACT(SDL_Palette));

HL_PRIM bool HL_NAME(get_palette_color)(SDL_Palette* p, int index, varray* out) {
	if (index < 0 || index >= p->ncolors)
		return false;
	int* o = hl_aptr(out, int);
	o[0] = p->colors[index].r;
	o[1] = p->colors[index].g;
	o[2] = p->colors[index].b;
	o[3] = p->colors[index].a;
	return true;
}
DEFINE_PRIM(_BOOL, get_palette_color, _ABSTRACT(SDL_Palette) _I32 _ARR);

HL_PRIM bool HL_NAME(set_palette_colors)(SDL_Palette* p, varray* rgba, int firstcolor, int ncolors) {
	int* c = hl_aptr(rgba, int);
	std::vector<SDL_Color> colors;
	colors.resize(ncolors);
	for (int i = 0; i < ncolors; i++) {
		colors[i].r = (Uint8)c[i * 4 + 0];
		colors[i].g = (Uint8)c[i * 4 + 1];
		colors[i].b = (Uint8)c[i * 4 + 2];
		colors[i].a = (Uint8)c[i * 4 + 3];
	}
	return SDL_SetPaletteColors(p, colors.data(), firstcolor, ncolors);
}
DEFINE_PRIM(_BOOL, set_palette_colors, _ABSTRACT(SDL_Palette) _ARR _I32 _I32);

HL_PRIM void HL_NAME(destroy_palette)(SDL_Palette* p) { SDL_DestroyPalette(p); }
DEFINE_PRIM(_VOID, destroy_palette, _ABSTRACT(SDL_Palette));

HL_PRIM int HL_NAME(map_rgb)(int format, SDL_Palette* palette, int r, int g, int b) {
	const SDL_PixelFormatDetails* d = SDL_GetPixelFormatDetails((SDL_PixelFormat)format);
	if (!d)
		return 0;
	return (int)SDL_MapRGB(d, palette, (Uint8)r, (Uint8)g, (Uint8)b);
}
DEFINE_PRIM(_I32, map_rgb, _I32 _ABSTRACT(SDL_Palette) _I32 _I32 _I32);

HL_PRIM int HL_NAME(map_rgba)(int format, SDL_Palette* palette, int r, int g, int b, int a) {
	const SDL_PixelFormatDetails* d = SDL_GetPixelFormatDetails((SDL_PixelFormat)format);
	if (!d)
		return 0;
	return (int)SDL_MapRGBA(d, palette, (Uint8)r, (Uint8)g, (Uint8)b, (Uint8)a);
}
DEFINE_PRIM(_I32, map_rgba, _I32 _ABSTRACT(SDL_Palette) _I32 _I32 _I32 _I32);

HL_PRIM void HL_NAME(get_rgb)(int pixelvalue, int format, SDL_Palette* palette, varray* out) {
	const SDL_PixelFormatDetails* d = SDL_GetPixelFormatDetails((SDL_PixelFormat)format);
	Uint8 r = 0, g = 0, b = 0;
	if (d)
		SDL_GetRGB((Uint32)pixelvalue, d, palette, &r, &g, &b);
	int* o = hl_aptr(out, int);
	o[0] = r;
	o[1] = g;
	o[2] = b;
}
DEFINE_PRIM(_VOID, get_rgb, _I32 _I32 _ABSTRACT(SDL_Palette) _ARR);

HL_PRIM void HL_NAME(get_rgba)(int pixelvalue, int format, SDL_Palette* palette, varray* out) {
	const SDL_PixelFormatDetails* d = SDL_GetPixelFormatDetails((SDL_PixelFormat)format);
	Uint8 r = 0, g = 0, b = 0, a = 0;
	if (d)
		SDL_GetRGBA((Uint32)pixelvalue, d, palette, &r, &g, &b, &a);
	int* o = hl_aptr(out, int);
	o[0] = r;
	o[1] = g;
	o[2] = b;
	o[3] = a;
}
DEFINE_PRIM(_VOID, get_rgba, _I32 _I32 _ABSTRACT(SDL_Palette) _ARR);
