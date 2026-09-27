#include "hashlink_macros.h"
#include "SDL3/SDL_render.h"
#include <string.h>
#include <vector>

static vbyte* copy_str(const char* s) {
	if (!s)
		return NULL;
	return hl_copy_bytes((const vbyte*)s, (int)strlen(s) + 1);
}

HL_PRIM int HL_NAME(get_num_render_drivers)() { return SDL_GetNumRenderDrivers(); }
DEFINE_PRIM(_I32, get_num_render_drivers, _NO_ARG);

HL_PRIM vbyte* HL_NAME(get_render_driver)(int index) { return copy_str(SDL_GetRenderDriver(index)); }
DEFINE_PRIM(_BYTES, get_render_driver, _I32);

HL_PRIM SDL_Renderer* HL_NAME(create_renderer)(SDL_Window* window, vbyte* name) { return SDL_CreateRenderer(window, (const char*)name); }
DEFINE_PRIM(_ABSTRACT(SDL_Renderer), create_renderer, _ABSTRACT(SDL_Window) _BYTES);

HL_PRIM SDL_Renderer* HL_NAME(create_renderer_with_properties)(SDL_Window* window, vbyte* name, int vsync) {
	SDL_PropertiesID props = SDL_CreateProperties();
	if (window)
		SDL_SetPointerProperty(props, SDL_PROP_RENDERER_CREATE_WINDOW_POINTER, window);
	if (name)
		SDL_SetStringProperty(props, SDL_PROP_RENDERER_CREATE_NAME_STRING, (const char*)name);
	if (vsync != 0)
		SDL_SetNumberProperty(props, SDL_PROP_RENDERER_CREATE_PRESENT_VSYNC_NUMBER, vsync);
	SDL_Renderer* r = SDL_CreateRendererWithProperties(props);
	SDL_DestroyProperties(props);
	return r;
}
DEFINE_PRIM(_ABSTRACT(SDL_Renderer), create_renderer_with_properties, _ABSTRACT(SDL_Window) _BYTES _I32);

HL_PRIM SDL_Renderer* HL_NAME(create_software_renderer)(SDL_Surface* surface) { return SDL_CreateSoftwareRenderer(surface); }
DEFINE_PRIM(_ABSTRACT(SDL_Renderer), create_software_renderer, _ABSTRACT(SDL_Surface));

HL_PRIM SDL_Renderer* HL_NAME(get_renderer)(SDL_Window* window) { return SDL_GetRenderer(window); }
DEFINE_PRIM(_ABSTRACT(SDL_Renderer), get_renderer, _ABSTRACT(SDL_Window));

HL_PRIM SDL_Window* HL_NAME(get_render_window)(SDL_Renderer* r) { return SDL_GetRenderWindow(r); }
DEFINE_PRIM(_ABSTRACT(SDL_Window), get_render_window, _ABSTRACT(SDL_Renderer));

HL_PRIM vbyte* HL_NAME(get_renderer_name)(SDL_Renderer* r) { return copy_str(SDL_GetRendererName(r)); }
DEFINE_PRIM(_BYTES, get_renderer_name, _ABSTRACT(SDL_Renderer));

HL_PRIM bool HL_NAME(get_render_output_size)(SDL_Renderer* r, varray* out) {
	int w = 0, h = 0;
	bool ok = SDL_GetRenderOutputSize(r, &w, &h);
	int* o = hl_aptr(out, int);
	o[0] = w;
	o[1] = h;
	return ok;
}
DEFINE_PRIM(_BOOL, get_render_output_size, _ABSTRACT(SDL_Renderer) _ARR);

HL_PRIM bool HL_NAME(get_current_render_output_size)(SDL_Renderer* r, varray* out) {
	int w = 0, h = 0;
	bool ok = SDL_GetCurrentRenderOutputSize(r, &w, &h);
	int* o = hl_aptr(out, int);
	o[0] = w;
	o[1] = h;
	return ok;
}
DEFINE_PRIM(_BOOL, get_current_render_output_size, _ABSTRACT(SDL_Renderer) _ARR);

HL_PRIM void HL_NAME(destroy_renderer)(SDL_Renderer* r) { SDL_DestroyRenderer(r); }
DEFINE_PRIM(_VOID, destroy_renderer, _ABSTRACT(SDL_Renderer));

HL_PRIM bool HL_NAME(flush_renderer)(SDL_Renderer* r) { return SDL_FlushRenderer(r); }
DEFINE_PRIM(_BOOL, flush_renderer, _ABSTRACT(SDL_Renderer));

HL_PRIM bool HL_NAME(set_render_vsync)(SDL_Renderer* r, int vsync) { return SDL_SetRenderVSync(r, vsync); }
DEFINE_PRIM(_BOOL, set_render_vsync, _ABSTRACT(SDL_Renderer) _I32);

HL_PRIM int HL_NAME(get_render_vsync)(SDL_Renderer* r) {
	int v = 0;
	SDL_GetRenderVSync(r, &v);
	return v;
}
DEFINE_PRIM(_I32, get_render_vsync, _ABSTRACT(SDL_Renderer));

HL_PRIM SDL_Texture* HL_NAME(create_texture)(SDL_Renderer* r, int format, int access, int w, int h) {
	return SDL_CreateTexture(r, (SDL_PixelFormat)format, (SDL_TextureAccess)access, w, h);
}
DEFINE_PRIM(_ABSTRACT(SDL_Texture), create_texture, _ABSTRACT(SDL_Renderer) _I32 _I32 _I32 _I32);

HL_PRIM SDL_Texture* HL_NAME(create_texture_from_surface)(SDL_Renderer* r, SDL_Surface* surface) { return SDL_CreateTextureFromSurface(r, surface); }
DEFINE_PRIM(_ABSTRACT(SDL_Texture), create_texture_from_surface, _ABSTRACT(SDL_Renderer) _ABSTRACT(SDL_Surface));

HL_PRIM bool HL_NAME(get_texture_size)(SDL_Texture* t, varray* out) {
	float w = 0, h = 0;
	bool ok = SDL_GetTextureSize(t, &w, &h);
	double* o = hl_aptr(out, double);
	o[0] = w;
	o[1] = h;
	return ok;
}
DEFINE_PRIM(_BOOL, get_texture_size, _ABSTRACT(SDL_Texture) _ARR);

HL_PRIM int HL_NAME(get_texture_format)(SDL_Texture* t) { return (int)t->format; }
DEFINE_PRIM(_I32, get_texture_format, _ABSTRACT(SDL_Texture));

HL_PRIM bool HL_NAME(set_texture_palette)(SDL_Texture* t, SDL_Palette* p) { return SDL_SetTexturePalette(t, p); }
DEFINE_PRIM(_BOOL, set_texture_palette, _ABSTRACT(SDL_Texture) _ABSTRACT(SDL_Palette));

HL_PRIM SDL_Palette* HL_NAME(get_texture_palette)(SDL_Texture* t) { return SDL_GetTexturePalette(t); }
DEFINE_PRIM(_ABSTRACT(SDL_Palette), get_texture_palette, _ABSTRACT(SDL_Texture));

HL_PRIM bool HL_NAME(set_texture_color_mod)(SDL_Texture* t, int r, int g, int b) { return SDL_SetTextureColorMod(t, (Uint8)r, (Uint8)g, (Uint8)b); }
DEFINE_PRIM(_BOOL, set_texture_color_mod, _ABSTRACT(SDL_Texture) _I32 _I32 _I32);

HL_PRIM bool HL_NAME(set_texture_color_mod_float)(SDL_Texture* t, double r, double g, double b) {
	return SDL_SetTextureColorModFloat(t, (float)r, (float)g, (float)b);
}
DEFINE_PRIM(_BOOL, set_texture_color_mod_float, _ABSTRACT(SDL_Texture) _F64 _F64 _F64);

HL_PRIM bool HL_NAME(get_texture_color_mod)(SDL_Texture* t, varray* out) {
	Uint8 r = 0, g = 0, b = 0;
	bool ok = SDL_GetTextureColorMod(t, &r, &g, &b);
	int* o = hl_aptr(out, int);
	o[0] = r;
	o[1] = g;
	o[2] = b;
	return ok;
}
DEFINE_PRIM(_BOOL, get_texture_color_mod, _ABSTRACT(SDL_Texture) _ARR);

HL_PRIM bool HL_NAME(set_texture_alpha_mod)(SDL_Texture* t, int a) { return SDL_SetTextureAlphaMod(t, (Uint8)a); }
DEFINE_PRIM(_BOOL, set_texture_alpha_mod, _ABSTRACT(SDL_Texture) _I32);

HL_PRIM bool HL_NAME(set_texture_alpha_mod_float)(SDL_Texture* t, double a) { return SDL_SetTextureAlphaModFloat(t, (float)a); }
DEFINE_PRIM(_BOOL, set_texture_alpha_mod_float, _ABSTRACT(SDL_Texture) _F64);

HL_PRIM int HL_NAME(get_texture_alpha_mod)(SDL_Texture* t) {
	Uint8 a = 255;
	SDL_GetTextureAlphaMod(t, &a);
	return a;
}
DEFINE_PRIM(_I32, get_texture_alpha_mod, _ABSTRACT(SDL_Texture));

HL_PRIM bool HL_NAME(set_texture_blend_mode)(SDL_Texture* t, int mode) { return SDL_SetTextureBlendMode(t, (SDL_BlendMode)mode); }
DEFINE_PRIM(_BOOL, set_texture_blend_mode, _ABSTRACT(SDL_Texture) _I32);

HL_PRIM int HL_NAME(get_texture_blend_mode)(SDL_Texture* t) {
	SDL_BlendMode m = SDL_BLENDMODE_NONE;
	SDL_GetTextureBlendMode(t, &m);
	return (int)m;
}
DEFINE_PRIM(_I32, get_texture_blend_mode, _ABSTRACT(SDL_Texture));

HL_PRIM bool HL_NAME(set_texture_scale_mode)(SDL_Texture* t, int mode) { return SDL_SetTextureScaleMode(t, (SDL_ScaleMode)mode); }
DEFINE_PRIM(_BOOL, set_texture_scale_mode, _ABSTRACT(SDL_Texture) _I32);

HL_PRIM int HL_NAME(get_texture_scale_mode)(SDL_Texture* t) {
	SDL_ScaleMode m = SDL_SCALEMODE_LINEAR;
	SDL_GetTextureScaleMode(t, &m);
	return (int)m;
}
DEFINE_PRIM(_I32, get_texture_scale_mode, _ABSTRACT(SDL_Texture));

HL_PRIM bool HL_NAME(update_texture)(SDL_Texture* t, varray* rect, vbyte* pixels, int pitch) {
	SDL_Rect r;
	SDL_Rect* rp = NULL;
	if (rect) {
		int* a = hl_aptr(rect, int);
		r.x = a[0];
		r.y = a[1];
		r.w = a[2];
		r.h = a[3];
		rp = &r;
	}
	return SDL_UpdateTexture(t, rp, pixels, pitch);
}
DEFINE_PRIM(_BOOL, update_texture, _ABSTRACT(SDL_Texture) _ARR _BYTES _I32);

HL_PRIM bool HL_NAME(update_yuv_texture)(SDL_Texture* t, varray* rect, vbyte* yplane, int ypitch, vbyte* uplane, int upitch, vbyte* vplane,
	int vpitch) {
	SDL_Rect r;
	SDL_Rect* rp = NULL;
	if (rect) {
		int* a = hl_aptr(rect, int);
		r.x = a[0];
		r.y = a[1];
		r.w = a[2];
		r.h = a[3];
		rp = &r;
	}
	return SDL_UpdateYUVTexture(t, rp, yplane, ypitch, uplane, upitch, vplane, vpitch);
}
DEFINE_PRIM(_BOOL, update_yuv_texture, _ABSTRACT(SDL_Texture) _ARR _BYTES _I32 _BYTES _I32 _BYTES _I32);

HL_PRIM bool HL_NAME(update_nv_texture)(SDL_Texture* t, varray* rect, vbyte* yplane, int ypitch, vbyte* uvplane, int uvpitch) {
	SDL_Rect r;
	SDL_Rect* rp = NULL;
	if (rect) {
		int* a = hl_aptr(rect, int);
		r.x = a[0];
		r.y = a[1];
		r.w = a[2];
		r.h = a[3];
		rp = &r;
	}
	return SDL_UpdateNVTexture(t, rp, yplane, ypitch, uvplane, uvpitch);
}
DEFINE_PRIM(_BOOL, update_nv_texture, _ABSTRACT(SDL_Texture) _ARR _BYTES _I32 _BYTES _I32);

HL_PRIM vbyte* HL_NAME(lock_texture)(SDL_Texture* t, varray* rect, varray* outPitch) {
	SDL_Rect r;
	SDL_Rect* rp = NULL;
	if (rect) {
		int* a = hl_aptr(rect, int);
		r.x = a[0];
		r.y = a[1];
		r.w = a[2];
		r.h = a[3];
		rp = &r;
	}
	void* pixels = NULL;
	int pitch = 0;
	if (!SDL_LockTexture(t, rp, &pixels, &pitch))
		return NULL;
	hl_aptr(outPitch, int)[0] = pitch;
	return (vbyte*)pixels;
}
DEFINE_PRIM(_BYTES, lock_texture, _ABSTRACT(SDL_Texture) _ARR _ARR);

HL_PRIM void HL_NAME(unlock_texture)(SDL_Texture* t) { SDL_UnlockTexture(t); }
DEFINE_PRIM(_VOID, unlock_texture, _ABSTRACT(SDL_Texture));

HL_PRIM void HL_NAME(destroy_texture)(SDL_Texture* t) { SDL_DestroyTexture(t); }
DEFINE_PRIM(_VOID, destroy_texture, _ABSTRACT(SDL_Texture));

HL_PRIM bool HL_NAME(set_render_target)(SDL_Renderer* r, SDL_Texture* t) { return SDL_SetRenderTarget(r, t); }
DEFINE_PRIM(_BOOL, set_render_target, _ABSTRACT(SDL_Renderer) _ABSTRACT(SDL_Texture));

HL_PRIM SDL_Texture* HL_NAME(get_render_target)(SDL_Renderer* r) { return SDL_GetRenderTarget(r); }
DEFINE_PRIM(_ABSTRACT(SDL_Texture), get_render_target, _ABSTRACT(SDL_Renderer));

HL_PRIM bool HL_NAME(set_render_logical_presentation)(SDL_Renderer* r, int w, int h, int mode) {
	return SDL_SetRenderLogicalPresentation(r, w, h, (SDL_RendererLogicalPresentation)mode);
}
DEFINE_PRIM(_BOOL, set_render_logical_presentation, _ABSTRACT(SDL_Renderer) _I32 _I32 _I32);

HL_PRIM bool HL_NAME(get_render_logical_presentation)(SDL_Renderer* r, varray* out) {
	int w = 0, h = 0;
	SDL_RendererLogicalPresentation mode = SDL_LOGICAL_PRESENTATION_DISABLED;
	bool ok = SDL_GetRenderLogicalPresentation(r, &w, &h, &mode);
	int* o = hl_aptr(out, int);
	o[0] = w;
	o[1] = h;
	o[2] = (int)mode;
	return ok;
}
DEFINE_PRIM(_BOOL, get_render_logical_presentation, _ABSTRACT(SDL_Renderer) _ARR);

HL_PRIM bool HL_NAME(get_render_logical_presentation_rect)(SDL_Renderer* r, varray* out) {
	SDL_FRect rect;
	bool ok = SDL_GetRenderLogicalPresentationRect(r, &rect);
	double* o = hl_aptr(out, double);
	o[0] = rect.x;
	o[1] = rect.y;
	o[2] = rect.w;
	o[3] = rect.h;
	return ok;
}
DEFINE_PRIM(_BOOL, get_render_logical_presentation_rect, _ABSTRACT(SDL_Renderer) _ARR);

HL_PRIM bool HL_NAME(render_coordinates_from_window)(SDL_Renderer* r, double wx, double wy, varray* out) {
	float x = 0, y = 0;
	bool ok = SDL_RenderCoordinatesFromWindow(r, (float)wx, (float)wy, &x, &y);
	double* o = hl_aptr(out, double);
	o[0] = x;
	o[1] = y;
	return ok;
}
DEFINE_PRIM(_BOOL, render_coordinates_from_window, _ABSTRACT(SDL_Renderer) _F64 _F64 _ARR);

HL_PRIM bool HL_NAME(render_coordinates_to_window)(SDL_Renderer* r, double x, double y, varray* out) {
	float wx = 0, wy = 0;
	bool ok = SDL_RenderCoordinatesToWindow(r, (float)x, (float)y, &wx, &wy);
	double* o = hl_aptr(out, double);
	o[0] = wx;
	o[1] = wy;
	return ok;
}
DEFINE_PRIM(_BOOL, render_coordinates_to_window, _ABSTRACT(SDL_Renderer) _F64 _F64 _ARR);

HL_PRIM bool HL_NAME(convert_event_to_render_coordinates)(SDL_Renderer* r, vbyte* eventBuf) {
	return SDL_ConvertEventToRenderCoordinates(r, (SDL_Event*)eventBuf);
}
DEFINE_PRIM(_BOOL, convert_event_to_render_coordinates, _ABSTRACT(SDL_Renderer) _BYTES);

HL_PRIM bool HL_NAME(set_render_viewport)(SDL_Renderer* r, varray* rect) {
	SDL_Rect rr;
	SDL_Rect* rp = NULL;
	if (rect) {
		int* a = hl_aptr(rect, int);
		rr.x = a[0];
		rr.y = a[1];
		rr.w = a[2];
		rr.h = a[3];
		rp = &rr;
	}
	return SDL_SetRenderViewport(r, rp);
}
DEFINE_PRIM(_BOOL, set_render_viewport, _ABSTRACT(SDL_Renderer) _ARR);

HL_PRIM bool HL_NAME(get_render_viewport)(SDL_Renderer* r, varray* out) {
	SDL_Rect rr;
	bool ok = SDL_GetRenderViewport(r, &rr);
	int* o = hl_aptr(out, int);
	o[0] = rr.x;
	o[1] = rr.y;
	o[2] = rr.w;
	o[3] = rr.h;
	return ok;
}
DEFINE_PRIM(_BOOL, get_render_viewport, _ABSTRACT(SDL_Renderer) _ARR);

HL_PRIM bool HL_NAME(render_viewport_set)(SDL_Renderer* r) { return SDL_RenderViewportSet(r); }
DEFINE_PRIM(_BOOL, render_viewport_set, _ABSTRACT(SDL_Renderer));

HL_PRIM bool HL_NAME(get_render_safe_area)(SDL_Renderer* r, varray* out) {
	SDL_Rect rr;
	bool ok = SDL_GetRenderSafeArea(r, &rr);
	int* o = hl_aptr(out, int);
	o[0] = rr.x;
	o[1] = rr.y;
	o[2] = rr.w;
	o[3] = rr.h;
	return ok;
}
DEFINE_PRIM(_BOOL, get_render_safe_area, _ABSTRACT(SDL_Renderer) _ARR);

HL_PRIM bool HL_NAME(set_render_clip_rect)(SDL_Renderer* r, varray* rect) {
	SDL_Rect rr;
	SDL_Rect* rp = NULL;
	if (rect) {
		int* a = hl_aptr(rect, int);
		rr.x = a[0];
		rr.y = a[1];
		rr.w = a[2];
		rr.h = a[3];
		rp = &rr;
	}
	return SDL_SetRenderClipRect(r, rp);
}
DEFINE_PRIM(_BOOL, set_render_clip_rect, _ABSTRACT(SDL_Renderer) _ARR);

HL_PRIM bool HL_NAME(get_render_clip_rect)(SDL_Renderer* r, varray* out) {
	SDL_Rect rr;
	bool ok = SDL_GetRenderClipRect(r, &rr);
	int* o = hl_aptr(out, int);
	o[0] = rr.x;
	o[1] = rr.y;
	o[2] = rr.w;
	o[3] = rr.h;
	return ok;
}
DEFINE_PRIM(_BOOL, get_render_clip_rect, _ABSTRACT(SDL_Renderer) _ARR);

HL_PRIM bool HL_NAME(render_clip_enabled)(SDL_Renderer* r) { return SDL_RenderClipEnabled(r); }
DEFINE_PRIM(_BOOL, render_clip_enabled, _ABSTRACT(SDL_Renderer));

HL_PRIM bool HL_NAME(set_render_scale)(SDL_Renderer* r, double sx, double sy) { return SDL_SetRenderScale(r, (float)sx, (float)sy); }
DEFINE_PRIM(_BOOL, set_render_scale, _ABSTRACT(SDL_Renderer) _F64 _F64);

HL_PRIM bool HL_NAME(get_render_scale)(SDL_Renderer* r, varray* out) {
	float sx = 1, sy = 1;
	bool ok = SDL_GetRenderScale(r, &sx, &sy);
	double* o = hl_aptr(out, double);
	o[0] = sx;
	o[1] = sy;
	return ok;
}
DEFINE_PRIM(_BOOL, get_render_scale, _ABSTRACT(SDL_Renderer) _ARR);

HL_PRIM bool HL_NAME(set_render_draw_color)(SDL_Renderer* r, int red, int g, int b, int a) {
	return SDL_SetRenderDrawColor(r, (Uint8)red, (Uint8)g, (Uint8)b, (Uint8)a);
}
DEFINE_PRIM(_BOOL, set_render_draw_color, _ABSTRACT(SDL_Renderer) _I32 _I32 _I32 _I32);

HL_PRIM bool HL_NAME(set_render_draw_color_float)(SDL_Renderer* r, double red, double g, double b, double a) {
	return SDL_SetRenderDrawColorFloat(r, (float)red, (float)g, (float)b, (float)a);
}
DEFINE_PRIM(_BOOL, set_render_draw_color_float, _ABSTRACT(SDL_Renderer) _F64 _F64 _F64 _F64);

HL_PRIM bool HL_NAME(get_render_draw_color)(SDL_Renderer* r, varray* out) {
	Uint8 rr = 0, g = 0, b = 0, a = 0;
	bool ok = SDL_GetRenderDrawColor(r, &rr, &g, &b, &a);
	int* o = hl_aptr(out, int);
	o[0] = rr;
	o[1] = g;
	o[2] = b;
	o[3] = a;
	return ok;
}
DEFINE_PRIM(_BOOL, get_render_draw_color, _ABSTRACT(SDL_Renderer) _ARR);

HL_PRIM bool HL_NAME(set_render_color_scale)(SDL_Renderer* r, double scale) { return SDL_SetRenderColorScale(r, (float)scale); }
DEFINE_PRIM(_BOOL, set_render_color_scale, _ABSTRACT(SDL_Renderer) _F64);

HL_PRIM double HL_NAME(get_render_color_scale)(SDL_Renderer* r) {
	float s = 1;
	SDL_GetRenderColorScale(r, &s);
	return s;
}
DEFINE_PRIM(_F64, get_render_color_scale, _ABSTRACT(SDL_Renderer));

HL_PRIM bool HL_NAME(set_render_draw_blend_mode)(SDL_Renderer* r, int mode) { return SDL_SetRenderDrawBlendMode(r, (SDL_BlendMode)mode); }
DEFINE_PRIM(_BOOL, set_render_draw_blend_mode, _ABSTRACT(SDL_Renderer) _I32);

HL_PRIM int HL_NAME(get_render_draw_blend_mode)(SDL_Renderer* r) {
	SDL_BlendMode m = SDL_BLENDMODE_NONE;
	SDL_GetRenderDrawBlendMode(r, &m);
	return (int)m;
}
DEFINE_PRIM(_I32, get_render_draw_blend_mode, _ABSTRACT(SDL_Renderer));

HL_PRIM bool HL_NAME(render_clear)(SDL_Renderer* r) { return SDL_RenderClear(r); }
DEFINE_PRIM(_BOOL, render_clear, _ABSTRACT(SDL_Renderer));

HL_PRIM bool HL_NAME(render_point)(SDL_Renderer* r, double x, double y) { return SDL_RenderPoint(r, (float)x, (float)y); }
DEFINE_PRIM(_BOOL, render_point, _ABSTRACT(SDL_Renderer) _F64 _F64);

HL_PRIM bool HL_NAME(render_points)(SDL_Renderer* r, varray* xy) {
	int count = xy->size / 2;
	double* p = hl_aptr(xy, double);
	std::vector<SDL_FPoint> pts;
	pts.resize(count);
	for (int i = 0; i < count; i++) {
		pts[i].x = (float)p[i * 2];
		pts[i].y = (float)p[i * 2 + 1];
	}
	return SDL_RenderPoints(r, pts.data(), count);
}
DEFINE_PRIM(_BOOL, render_points, _ABSTRACT(SDL_Renderer) _ARR);

HL_PRIM bool HL_NAME(render_line)(SDL_Renderer* r, double x1, double y1, double x2, double y2) {
	return SDL_RenderLine(r, (float)x1, (float)y1, (float)x2, (float)y2);
}
DEFINE_PRIM(_BOOL, render_line, _ABSTRACT(SDL_Renderer) _F64 _F64 _F64 _F64);

HL_PRIM bool HL_NAME(render_lines)(SDL_Renderer* r, varray* xy) {
	int count = xy->size / 2;
	double* p = hl_aptr(xy, double);
	std::vector<SDL_FPoint> pts;
	pts.resize(count);
	for (int i = 0; i < count; i++) {
		pts[i].x = (float)p[i * 2];
		pts[i].y = (float)p[i * 2 + 1];
	}
	return SDL_RenderLines(r, pts.data(), count);
}
DEFINE_PRIM(_BOOL, render_lines, _ABSTRACT(SDL_Renderer) _ARR);

HL_PRIM bool HL_NAME(render_rect)(SDL_Renderer* r, varray* rect) {
	SDL_FRect rr;
	SDL_FRect* rp = NULL;
	if (rect) {
		double* a = hl_aptr(rect, double);
		rr.x = (float)a[0];
		rr.y = (float)a[1];
		rr.w = (float)a[2];
		rr.h = (float)a[3];
		rp = &rr;
	}
	return SDL_RenderRect(r, rp);
}
DEFINE_PRIM(_BOOL, render_rect, _ABSTRACT(SDL_Renderer) _ARR);

HL_PRIM bool HL_NAME(render_rects)(SDL_Renderer* r, varray* rectsXYWH) {
	int count = rectsXYWH->size / 4;
	double* a = hl_aptr(rectsXYWH, double);
	std::vector<SDL_FRect> rects;
	rects.resize(count);
	for (int i = 0; i < count; i++) {
		rects[i].x = (float)a[i * 4];
		rects[i].y = (float)a[i * 4 + 1];
		rects[i].w = (float)a[i * 4 + 2];
		rects[i].h = (float)a[i * 4 + 3];
	}
	return SDL_RenderRects(r, rects.data(), count);
}
DEFINE_PRIM(_BOOL, render_rects, _ABSTRACT(SDL_Renderer) _ARR);

HL_PRIM bool HL_NAME(render_fill_rect)(SDL_Renderer* r, varray* rect) {
	SDL_FRect rr;
	SDL_FRect* rp = NULL;
	if (rect) {
		double* a = hl_aptr(rect, double);
		rr.x = (float)a[0];
		rr.y = (float)a[1];
		rr.w = (float)a[2];
		rr.h = (float)a[3];
		rp = &rr;
	}
	return SDL_RenderFillRect(r, rp);
}
DEFINE_PRIM(_BOOL, render_fill_rect, _ABSTRACT(SDL_Renderer) _ARR);

HL_PRIM bool HL_NAME(render_fill_rects)(SDL_Renderer* r, varray* rectsXYWH) {
	int count = rectsXYWH->size / 4;
	double* a = hl_aptr(rectsXYWH, double);
	std::vector<SDL_FRect> rects;
	rects.resize(count);
	for (int i = 0; i < count; i++) {
		rects[i].x = (float)a[i * 4];
		rects[i].y = (float)a[i * 4 + 1];
		rects[i].w = (float)a[i * 4 + 2];
		rects[i].h = (float)a[i * 4 + 3];
	}
	return SDL_RenderFillRects(r, rects.data(), count);
}
DEFINE_PRIM(_BOOL, render_fill_rects, _ABSTRACT(SDL_Renderer) _ARR);

static inline SDL_FRect* opt_frect(varray* a, SDL_FRect* storage) {
	if (!a)
		return NULL;
	double* v = hl_aptr(a, double);
	storage->x = (float)v[0];
	storage->y = (float)v[1];
	storage->w = (float)v[2];
	storage->h = (float)v[3];
	return storage;
}

HL_PRIM bool HL_NAME(render_texture)(SDL_Renderer* r, SDL_Texture* t, varray* srcrect, varray* dstrect) {
	SDL_FRect s, d;
	return SDL_RenderTexture(r, t, opt_frect(srcrect, &s), opt_frect(dstrect, &d));
}
DEFINE_PRIM(_BOOL, render_texture, _ABSTRACT(SDL_Renderer) _ABSTRACT(SDL_Texture) _ARR _ARR);

HL_PRIM bool HL_NAME(render_texture_rotated)(SDL_Renderer* r, SDL_Texture* t, varray* srcrect, varray* dstrect, double angle, varray* center,
	int flip) {
	SDL_FRect s, d;
	SDL_FPoint c;
	SDL_FPoint* cp = NULL;
	if (center) {
		double* v = hl_aptr(center, double);
		c.x = (float)v[0];
		c.y = (float)v[1];
		cp = &c;
	}
	return SDL_RenderTextureRotated(r, t, opt_frect(srcrect, &s), opt_frect(dstrect, &d), angle, cp, (SDL_FlipMode)flip);
}
DEFINE_PRIM(_BOOL, render_texture_rotated, _ABSTRACT(SDL_Renderer) _ABSTRACT(SDL_Texture) _ARR _ARR _F64 _ARR _I32);

HL_PRIM bool HL_NAME(render_texture_affine)(SDL_Renderer* r, SDL_Texture* t, varray* srcrect, varray* origin, varray* right, varray* down) {
	SDL_FRect s;
	SDL_FPoint o, ri, dn;
	SDL_FPoint* op = NULL;
	SDL_FPoint* rp = NULL;
	SDL_FPoint* dp = NULL;
	if (origin) {
		double* v = hl_aptr(origin, double);
		o.x = (float)v[0];
		o.y = (float)v[1];
		op = &o;
	}
	if (right) {
		double* v = hl_aptr(right, double);
		ri.x = (float)v[0];
		ri.y = (float)v[1];
		rp = &ri;
	}
	if (down) {
		double* v = hl_aptr(down, double);
		dn.x = (float)v[0];
		dn.y = (float)v[1];
		dp = &dn;
	}
	return SDL_RenderTextureAffine(r, t, opt_frect(srcrect, &s), op, rp, dp);
}
DEFINE_PRIM(_BOOL, render_texture_affine, _ABSTRACT(SDL_Renderer) _ABSTRACT(SDL_Texture) _ARR _ARR _ARR _ARR);

HL_PRIM bool HL_NAME(render_texture_tiled)(SDL_Renderer* r, SDL_Texture* t, varray* srcrect, double scale, varray* dstrect) {
	SDL_FRect s, d;
	return SDL_RenderTextureTiled(r, t, opt_frect(srcrect, &s), (float)scale, opt_frect(dstrect, &d));
}
DEFINE_PRIM(_BOOL, render_texture_tiled, _ABSTRACT(SDL_Renderer) _ABSTRACT(SDL_Texture) _ARR _F64 _ARR);

HL_PRIM bool HL_NAME(render_texture_9grid)(SDL_Renderer* r, SDL_Texture* t, varray* srcrect, double left, double right, double top, double bottom,
	double scale, varray* dstrect) {
	SDL_FRect s, d;
	return SDL_RenderTexture9Grid(r, t, opt_frect(srcrect, &s), (float)left, (float)right, (float)top, (float)bottom, (float)scale,
		opt_frect(dstrect, &d));
}
DEFINE_PRIM(_BOOL, render_texture_9grid, _ABSTRACT(SDL_Renderer) _ABSTRACT(SDL_Texture) _ARR _F64 _F64 _F64 _F64 _F64 _ARR);

HL_PRIM bool HL_NAME(render_geometry)(SDL_Renderer* r, SDL_Texture* t, varray* vertices, varray* indices) {
	int nverts = vertices->size / 8;
	double* v = hl_aptr(vertices, double);
	std::vector<SDL_Vertex> verts;
	verts.resize(nverts);
	for (int i = 0; i < nverts; i++) {
		double* p = &v[i * 8];
		verts[i].position.x = (float)p[0];
		verts[i].position.y = (float)p[1];
		verts[i].color.r = (float)p[2];
		verts[i].color.g = (float)p[3];
		verts[i].color.b = (float)p[4];
		verts[i].color.a = (float)p[5];
		verts[i].tex_coord.x = (float)p[6];
		verts[i].tex_coord.y = (float)p[7];
	}
	int nind = indices ? indices->size : 0;
	std::vector<int> ind;
	int* indPtr = NULL;
	if (nind > 0) {
		int* src = hl_aptr(indices, int);
		ind.assign(src, src + nind);
		indPtr = ind.data();
	}
	return SDL_RenderGeometry(r, t, verts.data(), nverts, indPtr, nind);
}
DEFINE_PRIM(_BOOL, render_geometry, _ABSTRACT(SDL_Renderer) _ABSTRACT(SDL_Texture) _ARR _ARR);

HL_PRIM bool HL_NAME(set_render_texture_address_mode)(SDL_Renderer* r, int u, int v) {
	return SDL_SetRenderTextureAddressMode(r, (SDL_TextureAddressMode)u, (SDL_TextureAddressMode)v);
}
DEFINE_PRIM(_BOOL, set_render_texture_address_mode, _ABSTRACT(SDL_Renderer) _I32 _I32);

HL_PRIM bool HL_NAME(get_render_texture_address_mode)(SDL_Renderer* r, varray* out) {
	SDL_TextureAddressMode u = SDL_TEXTURE_ADDRESS_AUTO, v = SDL_TEXTURE_ADDRESS_AUTO;
	bool ok = SDL_GetRenderTextureAddressMode(r, &u, &v);
	int* o = hl_aptr(out, int);
	o[0] = (int)u;
	o[1] = (int)v;
	return ok;
}
DEFINE_PRIM(_BOOL, get_render_texture_address_mode, _ABSTRACT(SDL_Renderer) _ARR);

HL_PRIM SDL_Surface* HL_NAME(render_read_pixels)(SDL_Renderer* r, varray* rect) {
	SDL_Rect rr;
	SDL_Rect* rp = NULL;
	if (rect) {
		int* a = hl_aptr(rect, int);
		rr.x = a[0];
		rr.y = a[1];
		rr.w = a[2];
		rr.h = a[3];
		rp = &rr;
	}
	return SDL_RenderReadPixels(r, rp);
}
DEFINE_PRIM(_ABSTRACT(SDL_Surface), render_read_pixels, _ABSTRACT(SDL_Renderer) _ARR);

HL_PRIM bool HL_NAME(render_present)(SDL_Renderer* r) { return SDL_RenderPresent(r); }
DEFINE_PRIM(_BOOL, render_present, _ABSTRACT(SDL_Renderer));

HL_PRIM bool HL_NAME(render_debug_text)(SDL_Renderer* r, double x, double y, vbyte* text) {
	return SDL_RenderDebugText(r, (float)x, (float)y, (const char*)text);
}
DEFINE_PRIM(_BOOL, render_debug_text, _ABSTRACT(SDL_Renderer) _F64 _F64 _BYTES);

HL_PRIM bool HL_NAME(set_default_texture_scale_mode)(SDL_Renderer* r, int mode) { return SDL_SetDefaultTextureScaleMode(r, (SDL_ScaleMode)mode); }
DEFINE_PRIM(_BOOL, set_default_texture_scale_mode, _ABSTRACT(SDL_Renderer) _I32);

HL_PRIM int HL_NAME(get_default_texture_scale_mode)(SDL_Renderer* r) {
	SDL_ScaleMode m = SDL_SCALEMODE_LINEAR;
	SDL_GetDefaultTextureScaleMode(r, &m);
	return (int)m;
}
DEFINE_PRIM(_I32, get_default_texture_scale_mode, _ABSTRACT(SDL_Renderer));
