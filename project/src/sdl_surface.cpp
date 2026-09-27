#include "hashlink_macros.h"
#include "SDL3/SDL_surface.h"
#include <string.h>
#include <vector>

static inline SDL_Rect* opt_rect(varray* a, SDL_Rect* storage) {
	if (!a)
		return NULL;
	int* v = hl_aptr(a, int);
	storage->x = v[0];
	storage->y = v[1];
	storage->w = v[2];
	storage->h = v[3];
	return storage;
}

HL_PRIM SDL_Surface* HL_NAME(create_surface)(int w, int h, int format) { return SDL_CreateSurface(w, h, (SDL_PixelFormat)format); }
DEFINE_PRIM(_ABSTRACT(SDL_Surface), create_surface, _I32 _I32 _I32);

HL_PRIM SDL_Surface* HL_NAME(create_surface_from)(int w, int h, int format, vbyte* pixels, int pitch) {
	return SDL_CreateSurfaceFrom(w, h, (SDL_PixelFormat)format, pixels, pitch);
}
DEFINE_PRIM(_ABSTRACT(SDL_Surface), create_surface_from, _I32 _I32 _I32 _BYTES _I32);

HL_PRIM void HL_NAME(destroy_surface)(SDL_Surface* s) { SDL_DestroySurface(s); }
DEFINE_PRIM(_VOID, destroy_surface, _ABSTRACT(SDL_Surface));

HL_PRIM int HL_NAME(surface_w)(SDL_Surface* s) { return s->w; }
DEFINE_PRIM(_I32, surface_w, _ABSTRACT(SDL_Surface));
HL_PRIM int HL_NAME(surface_h)(SDL_Surface* s) { return s->h; }
DEFINE_PRIM(_I32, surface_h, _ABSTRACT(SDL_Surface));
HL_PRIM int HL_NAME(surface_pitch)(SDL_Surface* s) { return s->pitch; }
DEFINE_PRIM(_I32, surface_pitch, _ABSTRACT(SDL_Surface));
HL_PRIM int HL_NAME(surface_format)(SDL_Surface* s) { return (int)s->format; }
DEFINE_PRIM(_I32, surface_format, _ABSTRACT(SDL_Surface));
HL_PRIM vbyte* HL_NAME(surface_pixels)(SDL_Surface* s) { return (vbyte*)s->pixels; }
DEFINE_PRIM(_BYTES, surface_pixels, _ABSTRACT(SDL_Surface));

HL_PRIM void HL_NAME(surface_copy_pixels)(SDL_Surface* s, vbyte* dst) { memcpy(dst, s->pixels, (size_t)s->pitch * (size_t)s->h); }
DEFINE_PRIM(_VOID, surface_copy_pixels, _ABSTRACT(SDL_Surface) _BYTES);

HL_PRIM int HL_NAME(get_surface_properties)(SDL_Surface* s) { return (int)SDL_GetSurfaceProperties(s); }
DEFINE_PRIM(_I32, get_surface_properties, _ABSTRACT(SDL_Surface));

HL_PRIM bool HL_NAME(set_surface_colorspace)(SDL_Surface* s, int cs) { return SDL_SetSurfaceColorspace(s, (SDL_Colorspace)cs); }
DEFINE_PRIM(_BOOL, set_surface_colorspace, _ABSTRACT(SDL_Surface) _I32);

HL_PRIM int HL_NAME(get_surface_colorspace)(SDL_Surface* s) { return (int)SDL_GetSurfaceColorspace(s); }
DEFINE_PRIM(_I32, get_surface_colorspace, _ABSTRACT(SDL_Surface));

HL_PRIM SDL_Palette* HL_NAME(create_surface_palette)(SDL_Surface* s) { return SDL_CreateSurfacePalette(s); }
DEFINE_PRIM(_ABSTRACT(SDL_Palette), create_surface_palette, _ABSTRACT(SDL_Surface));

HL_PRIM bool HL_NAME(set_surface_palette)(SDL_Surface* s, SDL_Palette* p) { return SDL_SetSurfacePalette(s, p); }
DEFINE_PRIM(_BOOL, set_surface_palette, _ABSTRACT(SDL_Surface) _ABSTRACT(SDL_Palette));

HL_PRIM SDL_Palette* HL_NAME(get_surface_palette)(SDL_Surface* s) { return SDL_GetSurfacePalette(s); }
DEFINE_PRIM(_ABSTRACT(SDL_Palette), get_surface_palette, _ABSTRACT(SDL_Surface));

HL_PRIM bool HL_NAME(add_surface_alternate_image)(SDL_Surface* s, SDL_Surface* image) { return SDL_AddSurfaceAlternateImage(s, image); }
DEFINE_PRIM(_BOOL, add_surface_alternate_image, _ABSTRACT(SDL_Surface) _ABSTRACT(SDL_Surface));

HL_PRIM bool HL_NAME(surface_has_alternate_images)(SDL_Surface* s) { return SDL_SurfaceHasAlternateImages(s); }
DEFINE_PRIM(_BOOL, surface_has_alternate_images, _ABSTRACT(SDL_Surface));

HL_PRIM int HL_NAME(get_surface_images_count)(SDL_Surface* s) {
	int count = 0;
	SDL_Surface** images = SDL_GetSurfaceImages(s, &count);
	if (images)
		SDL_free(images);
	return count;
}
DEFINE_PRIM(_I32, get_surface_images_count, _ABSTRACT(SDL_Surface));

HL_PRIM SDL_Surface* HL_NAME(get_surface_image_at)(SDL_Surface* s, int index) {
	int count = 0;
	SDL_Surface** images = SDL_GetSurfaceImages(s, &count);
	SDL_Surface* r = (images && index >= 0 && index < count) ? images[index] : NULL;
	if (images)
		SDL_free(images);
	return r;
}
DEFINE_PRIM(_ABSTRACT(SDL_Surface), get_surface_image_at, _ABSTRACT(SDL_Surface) _I32);

HL_PRIM void HL_NAME(remove_surface_alternate_images)(SDL_Surface* s) { SDL_RemoveSurfaceAlternateImages(s); }
DEFINE_PRIM(_VOID, remove_surface_alternate_images, _ABSTRACT(SDL_Surface));

HL_PRIM bool HL_NAME(lock_surface)(SDL_Surface* s) { return SDL_LockSurface(s); }
DEFINE_PRIM(_BOOL, lock_surface, _ABSTRACT(SDL_Surface));

HL_PRIM void HL_NAME(unlock_surface)(SDL_Surface* s) { SDL_UnlockSurface(s); }
DEFINE_PRIM(_VOID, unlock_surface, _ABSTRACT(SDL_Surface));

HL_PRIM SDL_Surface* HL_NAME(load_surface_io)(SDL_IOStream* src, bool closeio) { return SDL_LoadSurface_IO(src, closeio); }
DEFINE_PRIM(_ABSTRACT(SDL_Surface), load_surface_io, _ABSTRACT(SDL_IOStream) _BOOL);

HL_PRIM SDL_Surface* HL_NAME(load_surface)(vbyte* file) { return SDL_LoadSurface((const char*)file); }
DEFINE_PRIM(_ABSTRACT(SDL_Surface), load_surface, _BYTES);

HL_PRIM SDL_Surface* HL_NAME(load_bmp_io)(SDL_IOStream* src, bool closeio) { return SDL_LoadBMP_IO(src, closeio); }
DEFINE_PRIM(_ABSTRACT(SDL_Surface), load_bmp_io, _ABSTRACT(SDL_IOStream) _BOOL);

HL_PRIM SDL_Surface* HL_NAME(load_bmp)(vbyte* file) { return SDL_LoadBMP((const char*)file); }
DEFINE_PRIM(_ABSTRACT(SDL_Surface), load_bmp, _BYTES);

HL_PRIM bool HL_NAME(save_bmp_io)(SDL_Surface* s, SDL_IOStream* dst, bool closeio) { return SDL_SaveBMP_IO(s, dst, closeio); }
DEFINE_PRIM(_BOOL, save_bmp_io, _ABSTRACT(SDL_Surface) _ABSTRACT(SDL_IOStream) _BOOL);

HL_PRIM bool HL_NAME(save_bmp)(SDL_Surface* s, vbyte* file) { return SDL_SaveBMP(s, (const char*)file); }
DEFINE_PRIM(_BOOL, save_bmp, _ABSTRACT(SDL_Surface) _BYTES);

HL_PRIM SDL_Surface* HL_NAME(load_png_io)(SDL_IOStream* src, bool closeio) { return SDL_LoadPNG_IO(src, closeio); }
DEFINE_PRIM(_ABSTRACT(SDL_Surface), load_png_io, _ABSTRACT(SDL_IOStream) _BOOL);

HL_PRIM SDL_Surface* HL_NAME(load_png)(vbyte* file) { return SDL_LoadPNG((const char*)file); }
DEFINE_PRIM(_ABSTRACT(SDL_Surface), load_png, _BYTES);

HL_PRIM bool HL_NAME(save_png_io)(SDL_Surface* s, SDL_IOStream* dst, bool closeio) { return SDL_SavePNG_IO(s, dst, closeio); }
DEFINE_PRIM(_BOOL, save_png_io, _ABSTRACT(SDL_Surface) _ABSTRACT(SDL_IOStream) _BOOL);

HL_PRIM bool HL_NAME(save_png)(SDL_Surface* s, vbyte* file) { return SDL_SavePNG(s, (const char*)file); }
DEFINE_PRIM(_BOOL, save_png, _ABSTRACT(SDL_Surface) _BYTES);

HL_PRIM bool HL_NAME(set_surface_rle)(SDL_Surface* s, bool enabled) { return SDL_SetSurfaceRLE(s, enabled); }
DEFINE_PRIM(_BOOL, set_surface_rle, _ABSTRACT(SDL_Surface) _BOOL);

HL_PRIM bool HL_NAME(surface_has_rle)(SDL_Surface* s) { return SDL_SurfaceHasRLE(s); }
DEFINE_PRIM(_BOOL, surface_has_rle, _ABSTRACT(SDL_Surface));

HL_PRIM bool HL_NAME(set_surface_color_key)(SDL_Surface* s, bool enabled, int key) { return SDL_SetSurfaceColorKey(s, enabled, (Uint32)key); }
DEFINE_PRIM(_BOOL, set_surface_color_key, _ABSTRACT(SDL_Surface) _BOOL _I32);

HL_PRIM bool HL_NAME(surface_has_color_key)(SDL_Surface* s) { return SDL_SurfaceHasColorKey(s); }
DEFINE_PRIM(_BOOL, surface_has_color_key, _ABSTRACT(SDL_Surface));

HL_PRIM bool HL_NAME(get_surface_color_key)(SDL_Surface* s, varray* out) {
	Uint32 key = 0;
	bool ok = SDL_GetSurfaceColorKey(s, &key);
	hl_aptr(out, int)[0] = (int)key;
	return ok;
}
DEFINE_PRIM(_BOOL, get_surface_color_key, _ABSTRACT(SDL_Surface) _ARR);

HL_PRIM bool HL_NAME(set_surface_color_mod)(SDL_Surface* s, int r, int g, int b) { return SDL_SetSurfaceColorMod(s, (Uint8)r, (Uint8)g, (Uint8)b); }
DEFINE_PRIM(_BOOL, set_surface_color_mod, _ABSTRACT(SDL_Surface) _I32 _I32 _I32);

HL_PRIM bool HL_NAME(get_surface_color_mod)(SDL_Surface* s, varray* out) {
	Uint8 r = 0, g = 0, b = 0;
	bool ok = SDL_GetSurfaceColorMod(s, &r, &g, &b);
	int* o = hl_aptr(out, int);
	o[0] = r;
	o[1] = g;
	o[2] = b;
	return ok;
}
DEFINE_PRIM(_BOOL, get_surface_color_mod, _ABSTRACT(SDL_Surface) _ARR);

HL_PRIM bool HL_NAME(set_surface_alpha_mod)(SDL_Surface* s, int a) { return SDL_SetSurfaceAlphaMod(s, (Uint8)a); }
DEFINE_PRIM(_BOOL, set_surface_alpha_mod, _ABSTRACT(SDL_Surface) _I32);

HL_PRIM int HL_NAME(get_surface_alpha_mod)(SDL_Surface* s) {
	Uint8 a = 255;
	SDL_GetSurfaceAlphaMod(s, &a);
	return a;
}
DEFINE_PRIM(_I32, get_surface_alpha_mod, _ABSTRACT(SDL_Surface));

HL_PRIM bool HL_NAME(set_surface_blend_mode)(SDL_Surface* s, int mode) { return SDL_SetSurfaceBlendMode(s, (SDL_BlendMode)mode); }
DEFINE_PRIM(_BOOL, set_surface_blend_mode, _ABSTRACT(SDL_Surface) _I32);

HL_PRIM int HL_NAME(get_surface_blend_mode)(SDL_Surface* s) {
	SDL_BlendMode m = SDL_BLENDMODE_NONE;
	SDL_GetSurfaceBlendMode(s, &m);
	return (int)m;
}
DEFINE_PRIM(_I32, get_surface_blend_mode, _ABSTRACT(SDL_Surface));

HL_PRIM bool HL_NAME(set_surface_clip_rect)(SDL_Surface* s, varray* rect) {
	SDL_Rect r;
	return SDL_SetSurfaceClipRect(s, opt_rect(rect, &r));
}
DEFINE_PRIM(_BOOL, set_surface_clip_rect, _ABSTRACT(SDL_Surface) _ARR);

HL_PRIM bool HL_NAME(get_surface_clip_rect)(SDL_Surface* s, varray* out) {
	SDL_Rect r;
	bool ok = SDL_GetSurfaceClipRect(s, &r);
	int* o = hl_aptr(out, int);
	o[0] = r.x;
	o[1] = r.y;
	o[2] = r.w;
	o[3] = r.h;
	return ok;
}
DEFINE_PRIM(_BOOL, get_surface_clip_rect, _ABSTRACT(SDL_Surface) _ARR);

HL_PRIM bool HL_NAME(flip_surface)(SDL_Surface* s, int flip) { return SDL_FlipSurface(s, (SDL_FlipMode)flip); }
DEFINE_PRIM(_BOOL, flip_surface, _ABSTRACT(SDL_Surface) _I32);

HL_PRIM SDL_Surface* HL_NAME(rotate_surface)(SDL_Surface* s, double angle) { return SDL_RotateSurface(s, (float)angle); }
DEFINE_PRIM(_ABSTRACT(SDL_Surface), rotate_surface, _ABSTRACT(SDL_Surface) _F64);

HL_PRIM SDL_Surface* HL_NAME(duplicate_surface)(SDL_Surface* s) { return SDL_DuplicateSurface(s); }
DEFINE_PRIM(_ABSTRACT(SDL_Surface), duplicate_surface, _ABSTRACT(SDL_Surface));

HL_PRIM SDL_Surface* HL_NAME(scale_surface)(SDL_Surface* s, int w, int h, int scaleMode) { return SDL_ScaleSurface(s, w, h, (SDL_ScaleMode)scaleMode); }
DEFINE_PRIM(_ABSTRACT(SDL_Surface), scale_surface, _ABSTRACT(SDL_Surface) _I32 _I32 _I32);

HL_PRIM SDL_Surface* HL_NAME(convert_surface)(SDL_Surface* s, int format) { return SDL_ConvertSurface(s, (SDL_PixelFormat)format); }
DEFINE_PRIM(_ABSTRACT(SDL_Surface), convert_surface, _ABSTRACT(SDL_Surface) _I32);

HL_PRIM SDL_Surface* HL_NAME(convert_surface_and_colorspace)(SDL_Surface* s, int format, SDL_Palette* palette, int colorspace) {
	return SDL_ConvertSurfaceAndColorspace(s, (SDL_PixelFormat)format, palette, (SDL_Colorspace)colorspace, 0);
}
DEFINE_PRIM(_ABSTRACT(SDL_Surface), convert_surface_and_colorspace, _ABSTRACT(SDL_Surface) _I32 _ABSTRACT(SDL_Palette) _I32);

HL_PRIM bool HL_NAME(convert_pixels)(int w, int h, int srcFormat, vbyte* src, int srcPitch, int dstFormat, vbyte* dst, int dstPitch) {
	return SDL_ConvertPixels(w, h, (SDL_PixelFormat)srcFormat, src, srcPitch, (SDL_PixelFormat)dstFormat, dst, dstPitch);
}
DEFINE_PRIM(_BOOL, convert_pixels, _I32 _I32 _I32 _BYTES _I32 _I32 _BYTES _I32);

HL_PRIM bool HL_NAME(convert_pixels_and_colorspace)(int w, int h, int srcFormat, int srcColorspace, vbyte* src, int srcPitch, int dstFormat,
	int dstColorspace, vbyte* dst, int dstPitch) {
	return SDL_ConvertPixelsAndColorspace(w, h, (SDL_PixelFormat)srcFormat, (SDL_Colorspace)srcColorspace, 0, src, srcPitch, (SDL_PixelFormat)dstFormat,
		(SDL_Colorspace)dstColorspace, 0, dst, dstPitch);
}
DEFINE_PRIM(_BOOL, convert_pixels_and_colorspace, _I32 _I32 _I32 _I32 _BYTES _I32 _I32 _I32 _BYTES _I32);

HL_PRIM bool HL_NAME(premultiply_alpha)(int w, int h, int srcFormat, vbyte* src, int srcPitch, int dstFormat, vbyte* dst, int dstPitch, bool linear) {
	return SDL_PremultiplyAlpha(w, h, (SDL_PixelFormat)srcFormat, src, srcPitch, (SDL_PixelFormat)dstFormat, dst, dstPitch, linear);
}
DEFINE_PRIM(_BOOL, premultiply_alpha, _I32 _I32 _I32 _BYTES _I32 _I32 _BYTES _I32 _BOOL);

HL_PRIM bool HL_NAME(premultiply_surface_alpha)(SDL_Surface* s, bool linear) { return SDL_PremultiplySurfaceAlpha(s, linear); }
DEFINE_PRIM(_BOOL, premultiply_surface_alpha, _ABSTRACT(SDL_Surface) _BOOL);

HL_PRIM bool HL_NAME(clear_surface)(SDL_Surface* s, double r, double g, double b, double a) {
	return SDL_ClearSurface(s, (float)r, (float)g, (float)b, (float)a);
}
DEFINE_PRIM(_BOOL, clear_surface, _ABSTRACT(SDL_Surface) _F64 _F64 _F64 _F64);

HL_PRIM bool HL_NAME(fill_surface_rect)(SDL_Surface* dst, varray* rect, int color) {
	SDL_Rect r;
	return SDL_FillSurfaceRect(dst, opt_rect(rect, &r), (Uint32)color);
}
DEFINE_PRIM(_BOOL, fill_surface_rect, _ABSTRACT(SDL_Surface) _ARR _I32);

HL_PRIM bool HL_NAME(fill_surface_rects)(SDL_Surface* dst, varray* rectsXYWH, int color) {
	int count = rectsXYWH->size / 4;
	int* a = hl_aptr(rectsXYWH, int);
	std::vector<SDL_Rect> rects;
	rects.resize(count);
	for (int i = 0; i < count; i++) {
		rects[i].x = a[i * 4];
		rects[i].y = a[i * 4 + 1];
		rects[i].w = a[i * 4 + 2];
		rects[i].h = a[i * 4 + 3];
	}
	return SDL_FillSurfaceRects(dst, rects.data(), count, (Uint32)color);
}
DEFINE_PRIM(_BOOL, fill_surface_rects, _ABSTRACT(SDL_Surface) _ARR _I32);

HL_PRIM bool HL_NAME(blit_surface)(SDL_Surface* src, varray* srcrect, SDL_Surface* dst, varray* dstrect) {
	SDL_Rect s, d;
	return SDL_BlitSurface(src, opt_rect(srcrect, &s), dst, opt_rect(dstrect, &d));
}
DEFINE_PRIM(_BOOL, blit_surface, _ABSTRACT(SDL_Surface) _ARR _ABSTRACT(SDL_Surface) _ARR);

HL_PRIM bool HL_NAME(blit_surface_unchecked)(SDL_Surface* src, varray* srcrect, SDL_Surface* dst, varray* dstrect) {
	SDL_Rect s, d;
	return SDL_BlitSurfaceUnchecked(src, opt_rect(srcrect, &s), dst, opt_rect(dstrect, &d));
}
DEFINE_PRIM(_BOOL, blit_surface_unchecked, _ABSTRACT(SDL_Surface) _ARR _ABSTRACT(SDL_Surface) _ARR);

HL_PRIM bool HL_NAME(blit_surface_scaled)(SDL_Surface* src, varray* srcrect, SDL_Surface* dst, varray* dstrect, int scaleMode) {
	SDL_Rect s, d;
	return SDL_BlitSurfaceScaled(src, opt_rect(srcrect, &s), dst, opt_rect(dstrect, &d), (SDL_ScaleMode)scaleMode);
}
DEFINE_PRIM(_BOOL, blit_surface_scaled, _ABSTRACT(SDL_Surface) _ARR _ABSTRACT(SDL_Surface) _ARR _I32);

HL_PRIM bool HL_NAME(blit_surface_unchecked_scaled)(SDL_Surface* src, varray* srcrect, SDL_Surface* dst, varray* dstrect, int scaleMode) {
	SDL_Rect s, d;
	return SDL_BlitSurfaceUncheckedScaled(src, opt_rect(srcrect, &s), dst, opt_rect(dstrect, &d), (SDL_ScaleMode)scaleMode);
}
DEFINE_PRIM(_BOOL, blit_surface_unchecked_scaled, _ABSTRACT(SDL_Surface) _ARR _ABSTRACT(SDL_Surface) _ARR _I32);

HL_PRIM bool HL_NAME(stretch_surface)(SDL_Surface* src, varray* srcrect, SDL_Surface* dst, varray* dstrect, int scaleMode) {
	SDL_Rect s, d;
	return SDL_StretchSurface(src, opt_rect(srcrect, &s), dst, opt_rect(dstrect, &d), (SDL_ScaleMode)scaleMode);
}
DEFINE_PRIM(_BOOL, stretch_surface, _ABSTRACT(SDL_Surface) _ARR _ABSTRACT(SDL_Surface) _ARR _I32);

HL_PRIM bool HL_NAME(blit_surface_tiled)(SDL_Surface* src, varray* srcrect, SDL_Surface* dst, varray* dstrect) {
	SDL_Rect s, d;
	return SDL_BlitSurfaceTiled(src, opt_rect(srcrect, &s), dst, opt_rect(dstrect, &d));
}
DEFINE_PRIM(_BOOL, blit_surface_tiled, _ABSTRACT(SDL_Surface) _ARR _ABSTRACT(SDL_Surface) _ARR);

HL_PRIM bool HL_NAME(blit_surface_tiled_with_scale)(SDL_Surface* src, varray* srcrect, double scale, int scaleMode, SDL_Surface* dst, varray* dstrect) {
	SDL_Rect s, d;
	return SDL_BlitSurfaceTiledWithScale(src, opt_rect(srcrect, &s), (float)scale, (SDL_ScaleMode)scaleMode, dst, opt_rect(dstrect, &d));
}
DEFINE_PRIM(_BOOL, blit_surface_tiled_with_scale, _ABSTRACT(SDL_Surface) _ARR _F64 _I32 _ABSTRACT(SDL_Surface) _ARR);

HL_PRIM bool HL_NAME(blit_surface_9grid)(SDL_Surface* src, varray* srcrect, int leftWidth, int rightWidth, int topHeight, int bottomHeight, double scale,
	int scaleMode, SDL_Surface* dst, varray* dstrect) {
	SDL_Rect s, d;
	return SDL_BlitSurface9Grid(src, opt_rect(srcrect, &s), leftWidth, rightWidth, topHeight, bottomHeight, (float)scale, (SDL_ScaleMode)scaleMode, dst,
		opt_rect(dstrect, &d));
}
DEFINE_PRIM(_BOOL, blit_surface_9grid, _ABSTRACT(SDL_Surface) _ARR _I32 _I32 _I32 _I32 _F64 _I32 _ABSTRACT(SDL_Surface) _ARR);

HL_PRIM int HL_NAME(map_surface_rgb)(SDL_Surface* s, int r, int g, int b) { return (int)SDL_MapSurfaceRGB(s, (Uint8)r, (Uint8)g, (Uint8)b); }
DEFINE_PRIM(_I32, map_surface_rgb, _ABSTRACT(SDL_Surface) _I32 _I32 _I32);

HL_PRIM int HL_NAME(map_surface_rgba)(SDL_Surface* s, int r, int g, int b, int a) {
	return (int)SDL_MapSurfaceRGBA(s, (Uint8)r, (Uint8)g, (Uint8)b, (Uint8)a);
}
DEFINE_PRIM(_I32, map_surface_rgba, _ABSTRACT(SDL_Surface) _I32 _I32 _I32 _I32);

HL_PRIM bool HL_NAME(read_surface_pixel)(SDL_Surface* s, int x, int y, varray* out) {
	Uint8 r = 0, g = 0, b = 0, a = 0;
	bool ok = SDL_ReadSurfacePixel(s, x, y, &r, &g, &b, &a);
	int* o = hl_aptr(out, int);
	o[0] = r;
	o[1] = g;
	o[2] = b;
	o[3] = a;
	return ok;
}
DEFINE_PRIM(_BOOL, read_surface_pixel, _ABSTRACT(SDL_Surface) _I32 _I32 _ARR);

HL_PRIM bool HL_NAME(read_surface_pixel_float)(SDL_Surface* s, int x, int y, varray* out) {
	float r = 0, g = 0, b = 0, a = 0;
	bool ok = SDL_ReadSurfacePixelFloat(s, x, y, &r, &g, &b, &a);
	double* o = hl_aptr(out, double);
	o[0] = r;
	o[1] = g;
	o[2] = b;
	o[3] = a;
	return ok;
}
DEFINE_PRIM(_BOOL, read_surface_pixel_float, _ABSTRACT(SDL_Surface) _I32 _I32 _ARR);

HL_PRIM bool HL_NAME(write_surface_pixel)(SDL_Surface* s, int x, int y, int r, int g, int b, int a) {
	return SDL_WriteSurfacePixel(s, x, y, (Uint8)r, (Uint8)g, (Uint8)b, (Uint8)a);
}
DEFINE_PRIM(_BOOL, write_surface_pixel, _ABSTRACT(SDL_Surface) _I32 _I32 _I32 _I32 _I32 _I32);

HL_PRIM bool HL_NAME(write_surface_pixel_float)(SDL_Surface* s, int x, int y, double r, double g, double b, double a) {
	return SDL_WriteSurfacePixelFloat(s, x, y, (float)r, (float)g, (float)b, (float)a);
}
DEFINE_PRIM(_BOOL, write_surface_pixel_float, _ABSTRACT(SDL_Surface) _I32 _I32 _F64 _F64 _F64 _F64);
