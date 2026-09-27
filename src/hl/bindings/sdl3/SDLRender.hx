package hl.bindings.sdl3;

import hl.bindings.sdl3.SDLPixels.SDLColor;
import hl.bindings.sdl3.SDLPixels.SDLPalettePtr;
import hl.bindings.sdl3.SDLPixels.SDLPalette;
import hl.bindings.sdl3.SDLRect;

typedef SDLRendererPtr = hl.Abstract<"SDL_Renderer">;
typedef SDLTexturePtr = hl.Abstract<"SDL_Texture">;

/**
 * How a texture's pixel data can be accessed or modified after creation.
 *
 * Corresponds to `SDL_TextureAccess` in SDL3.
 */
enum abstract SDLTextureAccess(Int) from Int to Int {
	/** The texture is written rarely; it cannot be locked. Best for static assets. */
	var STATIC = 0;

	/** The texture is written frequently; it can be locked. Best for dynamic content. */
	var STREAMING = 1;

	/** The texture can be used as a render target. */
	var TARGET = 2;
}

/**
 * How texture coordinates outside `[0, 1]` are handled when sampling.
 *
 * Corresponds to `SDL_TextureAddressMode` in SDL3.
 */
enum abstract SDLTextureAddressMode(Int) from Int to Int {
	/** Invalid or unset address mode. */
	var INVALID = -1;

	/** Let the renderer choose an appropriate mode automatically. */
	var AUTO = 0;

	/** Clamp coordinates to the texture edge. */
	var CLAMP = 1;

	/** Wrap coordinates around, tiling the texture. */
	var WRAP = 2;
}

/**
 * How the renderer maps a fixed logical resolution onto the actual output size.
 *
 * Used by `SDLRenderer.setLogicalPresentation`.
 *
 * Corresponds to `SDL_RendererLogicalPresentation` in SDL3.
 */
enum abstract SDLRendererLogicalPresentation(Int) from Int to Int {
	/** No logical scaling; rendering happens directly at output resolution. */
	var DISABLED = 0;

	/** Stretch the logical resolution to fill the output, ignoring aspect ratio. */
	var STRETCH = 1;

	/** Scale to fit, preserving aspect ratio, with black bars filling the rest. */
	var LETTERBOX = 2;

	/** Scale to fill, preserving aspect ratio, cropping any excess. */
	var OVERSCAN = 3;

	/** Scale by the largest integer factor that fits, preserving pixel-perfect output. */
	var INTEGER_SCALE = 4;
}

/**
 * Texture scaling filter.
 *
 * Corresponds to `SDL_ScaleMode` in SDL3.
 */
enum abstract SDLScaleMode(Int) from Int to Int {
	/** Nearest-neighbor (pixelated) scaling. */
	var NEAREST = 0;

	/** Bilinear (smooth) scaling. */
	var LINEAR = 1;
}

/**
 * Flip direction used by `SDLRenderer.textureRotated`.
 *
 * Values can be combined with `|` when SDL accepts a bitmask (e.g.
 * `HORIZONTAL | VERTICAL` flips both axes).
 *
 * Corresponds to `SDL_FlipMode` in SDL3.
 */
enum abstract SDLFlipMode(Int) from Int to Int {
	/** No flip. */
	var NONE = 0;

	/** Flip horizontally. */
	var HORIZONTAL = 1;

	/** Flip vertically. */
	var VERTICAL = 2;
}

/**
 * A single vertex used by `SDLRenderer.geometry`.
 *
 * Contains the position, an RGBA color in `0..1` range, and texture
 * coordinates.
 */
typedef SDLVertex = {
	/** X coordinate, in render coordinates. */
	x:Float,

	/** Y coordinate, in render coordinates. */
	y:Float,

	/** Per-vertex color, with components in the `0..1` range. */
	color:SDLColor01,

	/** U texture coordinate (horizontal). */
	u:Float,

	/** V texture coordinate (vertical). */
	v:Float
}

/**
 * An RGBA color with components in the `0..1` range.
 *
 * Used by `SDLVertex` (as opposed to `SDLColor`, whose components are
 * `0..255`).
 */
typedef SDLColor01 = {
	/** Red component, in `0..1`. */
	r:Float,

	/** Green component, in `0..1`. */
	g:Float,

	/** Blue component, in `0..1`. */
	b:Float,

	/** Alpha component, in `0..1`. */
	a:Float
}

@:noCompletion
class SDLRenderNative {
	@:hlNative("sdl3", "get_num_render_drivers") public static function numDrivers():Int
		return 0;

	@:hlNative("sdl3", "get_render_driver") public static function driverName(index:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "create_renderer") public static function create(window:SDLWindowPtr, name:hl.Bytes):SDLRendererPtr
		return null;

	@:hlNative("sdl3", "create_renderer_with_properties") public static function createWithProperties(window:SDLWindowPtr, name:hl.Bytes,
			vsync:Int):SDLRendererPtr
		return null;

	@:hlNative("sdl3", "create_software_renderer") public static function createSoftware(surface:SDLSurfacePtr):SDLRendererPtr
		return null;

	@:hlNative("sdl3", "get_renderer") public static function getRenderer(window:SDLWindowPtr):SDLRendererPtr
		return null;

	@:hlNative("sdl3", "get_render_window") public static function getWindow(r:SDLRendererPtr):SDLWindowPtr
		return null;

	@:hlNative("sdl3", "get_renderer_name") public static function getName(r:SDLRendererPtr):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_render_output_size") public static function getOutputSize(r:SDLRendererPtr, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "get_current_render_output_size") public static function getCurrentOutputSize(r:SDLRendererPtr, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "destroy_renderer") public static function destroyNative(r:SDLRendererPtr):Void {}

	@:hlNative("sdl3", "flush_renderer") public static function flush(r:SDLRendererPtr):Bool
		return false;

	@:hlNative("sdl3", "set_render_vsync") public static function setVSync(r:SDLRendererPtr, vsync:Int):Bool
		return false;

	@:hlNative("sdl3", "get_render_vsync") public static function getVSync(r:SDLRendererPtr):Int
		return 0;

	@:hlNative("sdl3", "create_texture") public static function createTexture(r:SDLRendererPtr, format:Int, access:Int, w:Int, h:Int):SDLTexturePtr
		return null;

	@:hlNative("sdl3", "create_texture_from_surface") public static function createTextureFromSurface(r:SDLRendererPtr, surface:SDLSurfacePtr):SDLTexturePtr
		return null;

	@:hlNative("sdl3", "get_texture_size") public static function getTextureSize(t:SDLTexturePtr, out:hl.NativeArray<Float>):Bool
		return false;

	@:hlNative("sdl3", "get_texture_format") public static function getTextureFormat(t:SDLTexturePtr):Int
		return 0;

	@:hlNative("sdl3", "set_texture_palette") public static function setTexturePalette(t:SDLTexturePtr, p:SDLPalettePtr):Bool
		return false;

	@:hlNative("sdl3", "get_texture_palette") public static function getTexturePalette(t:SDLTexturePtr):SDLPalettePtr
		return null;

	@:hlNative("sdl3", "set_texture_color_mod") public static function setColorMod(t:SDLTexturePtr, r:Int, g:Int, b:Int):Bool
		return false;

	@:hlNative("sdl3", "set_texture_color_mod_float") public static function setColorModFloat(t:SDLTexturePtr, r:Float, g:Float, b:Float):Bool
		return false;

	@:hlNative("sdl3", "get_texture_color_mod") public static function getColorMod(t:SDLTexturePtr, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "set_texture_alpha_mod") public static function setAlphaMod(t:SDLTexturePtr, a:Int):Bool
		return false;

	@:hlNative("sdl3", "set_texture_alpha_mod_float") public static function setAlphaModFloat(t:SDLTexturePtr, a:Float):Bool
		return false;

	@:hlNative("sdl3", "get_texture_alpha_mod") public static function getAlphaMod(t:SDLTexturePtr):Int
		return 0;

	@:hlNative("sdl3", "set_texture_blend_mode") public static function setBlendMode(t:SDLTexturePtr, mode:Int):Bool
		return false;

	@:hlNative("sdl3", "get_texture_blend_mode") public static function getBlendMode(t:SDLTexturePtr):Int
		return 0;

	@:hlNative("sdl3", "set_texture_scale_mode") public static function setScaleMode(t:SDLTexturePtr, mode:Int):Bool
		return false;

	@:hlNative("sdl3", "get_texture_scale_mode") public static function getScaleMode(t:SDLTexturePtr):Int
		return 0;

	@:hlNative("sdl3", "update_texture") public static function updateTexture(t:SDLTexturePtr, rect:hl.NativeArray<Int>, pixels:hl.Bytes, pitch:Int):Bool
		return false;

	@:hlNative("sdl3", "update_yuv_texture") public static function updateYUVTexture(t:SDLTexturePtr, rect:hl.NativeArray<Int>, y:hl.Bytes, ypitch:Int,
			u:hl.Bytes, upitch:Int, v:hl.Bytes, vpitch:Int):Bool
		return false;

	@:hlNative("sdl3", "update_nv_texture") public static function updateNVTexture(t:SDLTexturePtr, rect:hl.NativeArray<Int>, y:hl.Bytes, ypitch:Int,
			uv:hl.Bytes, uvpitch:Int):Bool
		return false;

	@:hlNative("sdl3", "lock_texture") public static function lockTexture(t:SDLTexturePtr, rect:hl.NativeArray<Int>, outPitch:hl.NativeArray<Int>):hl.Bytes
		return null;

	@:hlNative("sdl3", "unlock_texture") public static function unlockTexture(t:SDLTexturePtr):Void {}

	@:hlNative("sdl3", "destroy_texture") public static function destroyTexture(t:SDLTexturePtr):Void {}

	@:hlNative("sdl3", "set_render_target") public static function setTarget(r:SDLRendererPtr, t:SDLTexturePtr):Bool
		return false;

	@:hlNative("sdl3", "get_render_target") public static function getTarget(r:SDLRendererPtr):SDLTexturePtr
		return null;

	@:hlNative("sdl3", "set_render_logical_presentation") public static function setLogicalPresentation(r:SDLRendererPtr, w:Int, h:Int, mode:Int):Bool
		return false;

	@:hlNative("sdl3", "get_render_logical_presentation") public static function getLogicalPresentation(r:SDLRendererPtr, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "get_render_logical_presentation_rect") public static function getLogicalPresentationRect(r:SDLRendererPtr,
			out:hl.NativeArray<Float>):Bool
		return false;

	@:hlNative("sdl3", "render_coordinates_from_window") public static function coordsFromWindow(r:SDLRendererPtr, wx:Float, wy:Float,
			out:hl.NativeArray<Float>):Bool
		return false;

	@:hlNative("sdl3", "render_coordinates_to_window") public static function coordsToWindow(r:SDLRendererPtr, x:Float, y:Float, out:hl.NativeArray<Float>):Bool
		return false;

	@:hlNative("sdl3", "convert_event_to_render_coordinates") public static function convertEvent(r:SDLRendererPtr, eventBuf:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "set_render_viewport") public static function setViewport(r:SDLRendererPtr, rect:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "get_render_viewport") public static function getViewport(r:SDLRendererPtr, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "render_viewport_set") public static function viewportSet(r:SDLRendererPtr):Bool
		return false;

	@:hlNative("sdl3", "get_render_safe_area") public static function getSafeArea(r:SDLRendererPtr, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "set_render_clip_rect") public static function setClipRect(r:SDLRendererPtr, rect:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "get_render_clip_rect") public static function getClipRect(r:SDLRendererPtr, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "render_clip_enabled") public static function clipEnabled(r:SDLRendererPtr):Bool
		return false;

	@:hlNative("sdl3", "set_render_scale") public static function setScale(r:SDLRendererPtr, sx:Float, sy:Float):Bool
		return false;

	@:hlNative("sdl3", "get_render_scale") public static function getScale(r:SDLRendererPtr, out:hl.NativeArray<Float>):Bool
		return false;

	@:hlNative("sdl3", "set_render_draw_color") public static function setDrawColor(r:SDLRendererPtr, red:Int, g:Int, b:Int, a:Int):Bool
		return false;

	@:hlNative("sdl3", "set_render_draw_color_float") public static function setDrawColorFloat(r:SDLRendererPtr, red:Float, g:Float, b:Float, a:Float):Bool
		return false;

	@:hlNative("sdl3", "get_render_draw_color") public static function getDrawColor(r:SDLRendererPtr, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "set_render_color_scale") public static function setColorScale(r:SDLRendererPtr, scale:Float):Bool
		return false;

	@:hlNative("sdl3", "get_render_color_scale") public static function getColorScale(r:SDLRendererPtr):Float
		return 0;

	@:hlNative("sdl3", "set_render_draw_blend_mode") public static function setDrawBlendMode(r:SDLRendererPtr, mode:Int):Bool
		return false;

	@:hlNative("sdl3", "get_render_draw_blend_mode") public static function getDrawBlendMode(r:SDLRendererPtr):Int
		return 0;

	@:hlNative("sdl3", "render_clear") public static function clear(r:SDLRendererPtr):Bool
		return false;

	@:hlNative("sdl3", "render_point") public static function point(r:SDLRendererPtr, x:Float, y:Float):Bool
		return false;

	@:hlNative("sdl3", "render_points") public static function points(r:SDLRendererPtr, xy:hl.NativeArray<Float>):Bool
		return false;

	@:hlNative("sdl3", "render_line") public static function line(r:SDLRendererPtr, x1:Float, y1:Float, x2:Float, y2:Float):Bool
		return false;

	@:hlNative("sdl3", "render_lines") public static function lines(r:SDLRendererPtr, xy:hl.NativeArray<Float>):Bool
		return false;

	@:hlNative("sdl3", "render_rect") public static function rect(r:SDLRendererPtr, rect:hl.NativeArray<Float>):Bool
		return false;

	@:hlNative("sdl3", "render_rects") public static function rects(r:SDLRendererPtr, rectsXYWH:hl.NativeArray<Float>):Bool
		return false;

	@:hlNative("sdl3", "render_fill_rect") public static function fillRect(r:SDLRendererPtr, rect:hl.NativeArray<Float>):Bool
		return false;

	@:hlNative("sdl3", "render_fill_rects") public static function fillRects(r:SDLRendererPtr, rectsXYWH:hl.NativeArray<Float>):Bool
		return false;

	@:hlNative("sdl3", "render_texture") public static function texture(r:SDLRendererPtr, t:SDLTexturePtr, srcrect:hl.NativeArray<Float>,
			dstrect:hl.NativeArray<Float>):Bool
		return false;

	@:hlNative("sdl3", "render_texture_rotated") public static function textureRotated(r:SDLRendererPtr, t:SDLTexturePtr, srcrect:hl.NativeArray<Float>,
			dstrect:hl.NativeArray<Float>, angle:Float, center:hl.NativeArray<Float>, flip:Int):Bool
		return false;

	@:hlNative("sdl3", "render_texture_affine") public static function textureAffine(r:SDLRendererPtr, t:SDLTexturePtr, srcrect:hl.NativeArray<Float>,
			origin:hl.NativeArray<Float>, right:hl.NativeArray<Float>, down:hl.NativeArray<Float>):Bool
		return false;

	@:hlNative("sdl3", "render_texture_tiled") public static function textureTiled(r:SDLRendererPtr, t:SDLTexturePtr, srcrect:hl.NativeArray<Float>,
			scale:Float, dstrect:hl.NativeArray<Float>):Bool
		return false;

	@:hlNative("sdl3", "render_texture_9grid") public static function texture9Grid(r:SDLRendererPtr, t:SDLTexturePtr, srcrect:hl.NativeArray<Float>,
			left:Float, right:Float, top:Float, bottom:Float, scale:Float, dstrect:hl.NativeArray<Float>):Bool
		return false;

	@:hlNative("sdl3", "render_geometry") public static function geometry(r:SDLRendererPtr, t:SDLTexturePtr, vertices:hl.NativeArray<Float>,
			indices:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "set_render_texture_address_mode") public static function setAddressMode(r:SDLRendererPtr, u:Int, v:Int):Bool
		return false;

	@:hlNative("sdl3", "get_render_texture_address_mode") public static function getAddressMode(r:SDLRendererPtr, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "render_read_pixels") public static function readPixels(r:SDLRendererPtr, rect:hl.NativeArray<Int>):SDLSurfacePtr
		return null;

	@:hlNative("sdl3", "render_present") public static function present(r:SDLRendererPtr):Bool
		return false;

	@:hlNative("sdl3", "render_debug_text") public static function debugText(r:SDLRendererPtr, x:Float, y:Float, text:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "set_default_texture_scale_mode") public static function setDefaultScaleMode(r:SDLRendererPtr, mode:Int):Bool
		return false;

	@:hlNative("sdl3", "get_default_texture_scale_mode") public static function getDefaultScaleMode(r:SDLRendererPtr):Int
		return 0;
}

/**
 * Static helpers for enumerating render drivers and looking up an existing
 * window's renderer.
 */
@:access(String)
class SDLRenderers {
	static inline function str(b:hl.Bytes):Null<String>
		return b == null ? null : String.fromUTF8(b);

	/**
	 * Returns the number of available 2D rendering drivers.
	 *
	 * @return The number of drivers SDL was built with.
	 */
	public static function getNumDrivers():Int
		return SDLRenderNative.numDrivers();

	/**
	 * Returns the name of the rendering driver at the given index.
	 *
	 * @param index The driver index, in `[0, getNumDrivers())`.
	 * @return The driver name (e.g. `"opengl"`, `"direct3d11"`), or `null`
	 *         if the index is out of range.
	 */
	public static function getDriverName(index:Int):Null<String>
		return str(SDLRenderNative.driverName(index));

	/**
	 * Returns the renderer already associated with a window, if any.
	 *
	 * @param window The window to look up.
	 * @return The renderer attached to `window`, or `null` if the window has
	 *         no renderer.
	 */
	public static function getForWindow(window:SDLWindow):Null<SDLRenderer> {
		var p = SDLRenderNative.getRenderer(@:privateAccess window.ptr);
		return p == null ? null : @:privateAccess new SDLRenderer(p);
	}
}

/**
 * A 2D hardware-accelerated (or software) rendering context bound to a window.
 *
 * Create a renderer with `SDLRenderer.create` (or one of its variants), draw
 * with the various `point`/`line`/`rect`/`texture`/`geometry` methods, then
 * call `present()` to display the finished frame.
 *
 * Remember to `destroy()` the renderer when you are done with it.
 *
 * Corresponds to `SDL_Renderer` in SDL3.
 */
@:access(String)
class SDLRenderer {
	var ptr:SDLRendererPtr;

	@:allow(hl.bindings.sdl3)
	function new(ptr:SDLRendererPtr)
		this.ptr = ptr;

	static inline function ri(r:SDLRect):hl.NativeArray<Int> {
		var a = new hl.NativeArray<Int>(4);
		a[0] = r.x;
		a[1] = r.y;
		a[2] = r.w;
		a[3] = r.h;
		return a;
	}

	static inline function rf(r:SDLFRect):hl.NativeArray<Float> {
		var a = new hl.NativeArray<Float>(4);
		a[0] = r.x;
		a[1] = r.y;
		a[2] = r.w;
		a[3] = r.h;
		return a;
	}

	static inline function readRi(a:hl.NativeArray<Int>):SDLRect
		return {
			x: a[0],
			y: a[1],
			w: a[2],
			h: a[3]
		};

	static inline function readRf(a:hl.NativeArray<Float>):SDLFRect
		return {
			x: a[0],
			y: a[1],
			w: a[2],
			h: a[3]
		};

	static inline function str(b:hl.Bytes):Null<String>
		return b == null ? null : String.fromUTF8(b);

	/**
	 * Creates a 2D renderer bound to `window`.
	 *
	 * @param window The window to render into.
	 * @param name   Optional name of a specific backend (e.g. `"opengl"`).
	 *               Pass `null` to let SDL pick the best available one.
	 * @return A new renderer, or `null` on failure.
	 */
	public static function create(window:SDLWindow, ?name:String):Null<SDLRenderer> {
		var p = SDLRenderNative.create(@:privateAccess window.ptr, name == null ? null : name.toUtf8());
		return p == null ? null : new SDLRenderer(p);
	}

	/**
	 * Creates a 2D renderer with extra creation options.
	 *
	 * @param window The window to render into.
	 * @param name   Optional backend name (see `create`).
	 * @param vsync  Vsync mode: 0 = disabled, 1 = enabled, negative = adaptive.
	 * @return A new renderer, or `null` on failure.
	 */
	public static function createWithProperties(window:SDLWindow, ?name:String, vsync:Int = 0):Null<SDLRenderer> {
		var p = SDLRenderNative.createWithProperties(@:privateAccess window.ptr, name == null ? null : name.toUtf8(), vsync);
		return p == null ? null : new SDLRenderer(p);
	}

	/**
	 * Creates a software-only renderer that draws directly into a surface.
	 *
	 * No GPU is involved; useful when hardware rendering is unavailable or
	 * undesired.
	 *
	 * @param surface The surface to draw into.
	 * @return A new renderer, or `null` on failure.
	 */
	public static function createSoftware(surface:SDLSurface):Null<SDLRenderer> {
		var p = SDLRenderNative.createSoftware(@:privateAccess surface.ptr);
		return p == null ? null : new SDLRenderer(p);
	}

	/** The window this renderer is bound to, or `null` for a software renderer. */
	public var window(get, never):Null<SDLWindow>;

	inline function get_window():Null<SDLWindow> {
		var p = SDLRenderNative.getWindow(ptr);
		return p == null ? null : @:privateAccess new SDLWindow(p);
	}

	/** The name of the rendering backend in use (e.g. `"opengl"`, `"direct3d11"`). */
	public var name(get, never):Null<String>;

	inline function get_name()
		return str(SDLRenderNative.getName(ptr));

	/**
	 * Returns the output size in pixels of the render target currently in use.
	 *
	 * @return The output width and height.
	 */
	public function getOutputSize():{w:Int, h:Int} {
		var o = new hl.NativeArray<Int>(2);
		SDLRenderNative.getOutputSize(ptr, o);
		return {w: o[0], h: o[1]};
	}

	/**
	 * Returns the current output size in pixels, accounting for any active
	 * render target and logical presentation.
	 *
	 * @return The current output width and height.
	 */
	public function getCurrentOutputSize():{w:Int, h:Int} {
		var o = new hl.NativeArray<Int>(2);
		SDLRenderNative.getCurrentOutputSize(ptr, o);
		return {w: o[0], h: o[1]};
	}

	/**
	 * Destroys the renderer and releases its resources.
	 *
	 * Safe to call multiple times; the instance becomes unusable afterwards.
	 * Any textures created by this renderer also become invalid.
	 */
	public function destroy():Void {
		if (ptr != null)
			SDLRenderNative.destroyNative(ptr);
		ptr = null;
	}

	/**
	 * Forces pending rendering commands to be submitted to the backend.
	 *
	 * Rarely needed; `present()` already flushes for you.
	 *
	 * @return `true` on success, `false` on failure.
	 */
	public function flush():Bool
		return SDLRenderNative.flush(ptr);

	/**
	 * Sets the vsync behavior.
	 *
	 * @param vsync 0 = disabled, 1 = enabled, negative = adaptive.
	 * @return `true` on success, `false` on failure.
	 */
	public function setVSync(vsync:Int):Bool
		return SDLRenderNative.setVSync(ptr, vsync);

	/**
	 * Returns the current vsync setting.
	 *
	 * @return 0 (disabled), 1 (enabled), or a negative value for adaptive.
	 */
	public function getVSync():Int
		return SDLRenderNative.getVSync(ptr);

	/**
	 * Creates a blank texture with the given format, access mode, and size.
	 *
	 * @param format The pixel format (see `SDLPixelFormat`).
	 * @param access How the texture's pixels may be accessed or updated.
	 * @param w      Width in pixels.
	 * @param h      Height in pixels.
	 * @return A new texture, or `null` on failure.
	 */
	public function createTexture(format:Int, access:SDLTextureAccess, w:Int, h:Int):Null<SDLTexture> {
		var p = SDLRenderNative.createTexture(ptr, format, access, w, h);
		return p == null ? null : new SDLTexture(p);
	}

	/**
	 * Creates a `STATIC` texture from the pixel data of a surface.
	 *
	 * @param surface The surface to copy pixels from.
	 * @return A new texture, or `null` on failure.
	 */
	public function createTextureFromSurface(surface:SDLSurface):Null<SDLTexture> {
		@:privateAccess
		var p = SDLRenderNative.createTextureFromSurface(ptr, @:privateAccess surface.ptr);
		return p == null ? null : new SDLTexture(p);
	}

	/**
	 * Sets the render target.
	 *
	 * @param texture The texture to draw into (must have been created with
	 *                `TARGET` access), or `null` to draw into the window.
	 * @return `true` on success, `false` on failure.
	 */
	public function setTarget(?texture:SDLTexture):Bool
		return SDLRenderNative.setTarget(ptr, texture == null ? null : @:privateAccess texture.ptr);

	/**
	 * Returns the texture currently used as the render target, or `null` if
	 * rendering into the window.
	 *
	 * @return The current render target texture, or `null`.
	 */
	public function getTarget():Null<SDLTexture> {
		var p = SDLRenderNative.getTarget(ptr);
		return p == null ? null : new SDLTexture(p);
	}

	/**
	 * Sets a fixed logical resolution and how it maps onto the actual output.
	 *
	 * After this call, all rendering is performed in the logical coordinate
	 * system; SDL applies the appropriate scale/letterbox transform.
	 *
	 * @param w    Logical width.
	 * @param h    Logical height.
	 * @param mode How the logical area is mapped onto the output.
	 * @return `true` on success, `false` on failure.
	 */
	public function setLogicalPresentation(w:Int, h:Int, mode:SDLRendererLogicalPresentation):Bool
		return SDLRenderNative.setLogicalPresentation(ptr, w, h, mode);

	/**
	 * Returns the current logical presentation width, height, and mode.
	 *
	 * @return An object with `w`, `h`, and `mode`.
	 */
	public function getLogicalPresentation():{w:Int, h:Int, mode:SDLRendererLogicalPresentation} {
		var o = new hl.NativeArray<Int>(3);
		SDLRenderNative.getLogicalPresentation(ptr, o);
		return {w: o[0], h: o[1], mode: o[2]};
	}

	/**
	 * Returns the final on-screen rectangle the logical presentation is drawn into.
	 *
	 * @return A rectangle in output coordinates.
	 */
	public function getLogicalPresentationRect():SDLFRect {
		var o = new hl.NativeArray<Float>(4);
		SDLRenderNative.getLogicalPresentationRect(ptr, o);
		return readRf(o);
	}

	/**
	 * Converts window coordinates to render (logical) coordinates.
	 *
	 * Useful for feeding mouse/touch events to code that works in the
	 * logical coordinate system.
	 *
	 * @param windowX The X coordinate in window space.
	 * @param windowY The Y coordinate in window space.
	 * @return The corresponding `{x, y}` in render space.
	 */
	public function coordinatesFromWindow(windowX:Float, windowY:Float):{x:Float, y:Float} {
		var o = new hl.NativeArray<Float>(2);
		SDLRenderNative.coordsFromWindow(ptr, windowX, windowY, o);
		return {x: o[0], y: o[1]};
	}

	/**
	 * Converts render (logical) coordinates to window coordinates.
	 *
	 * @param x The X coordinate in render space.
	 * @param y The Y coordinate in render space.
	 * @return The corresponding `{x, y}` in window space.
	 */
	public function coordinatesToWindow(x:Float, y:Float):{x:Float, y:Float} {
		var o = new hl.NativeArray<Float>(2);
		SDLRenderNative.coordsToWindow(ptr, x, y, o);
		return {x: o[0], y: o[1]};
	}

	/**
	 * Rewrites the coordinate fields of a raw event buffer from window space
	 * into render space, in place.
	 *
	 * @param eventBuf A raw `SDL_Event` buffer.
	 * @return `true` on success, `false` on failure.
	 */
	public function convertEventToRenderCoordinates(eventBuf:hl.Bytes):Bool
		return SDLRenderNative.convertEvent(ptr, eventBuf);

	/**
	 * Sets the drawing viewport.
	 *
	 * @param rect The viewport rectangle, or `null` to reset to the whole
	 *             render target.
	 * @return `true` on success, `false` on failure.
	 */
	public function setViewport(?rect:SDLRect):Bool
		return SDLRenderNative.setViewport(ptr, rect == null ? null : ri(rect));

	/**
	 * Returns the current drawing viewport.
	 *
	 * @return The current viewport rectangle.
	 */
	public function getViewport():SDLRect {
		var o = new hl.NativeArray<Int>(4);
		SDLRenderNative.getViewport(ptr, o);
		return readRi(o);
	}

	/**
	 * Checks whether a viewport other than the default has been set.
	 *
	 * @return `true` if a custom viewport is active.
	 */
	public function isViewportSet():Bool
		return SDLRenderNative.viewportSet(ptr);

	/**
	 * Returns the area of the current render target not obscured by notches,
	 * system bars, rounded corners, etc.
	 *
	 * @return The safe area, in pixels.
	 */
	public function getSafeArea():SDLRect {
		var o = new hl.NativeArray<Int>(4);
		SDLRenderNative.getSafeArea(ptr, o);
		return readRi(o);
	}

	/**
	 * Sets the clipping rectangle.
	 *
	 * @param rect The rectangle to clip against, or `null` to disable
	 *             clipping.
	 * @return `true` on success, `false` on failure.
	 */
	public function setClipRect(?rect:SDLRect):Bool
		return SDLRenderNative.setClipRect(ptr, rect == null ? null : ri(rect));

	/**
	 * Returns the current clipping rectangle.
	 *
	 * @return The active clip rectangle.
	 */
	public function getClipRect():SDLRect {
		var o = new hl.NativeArray<Int>(4);
		SDLRenderNative.getClipRect(ptr, o);
		return readRi(o);
	}

	/**
	 * Checks whether clipping is currently enabled.
	 *
	 * @return `true` if a clip rectangle has been set.
	 */
	public function isClipEnabled():Bool
		return SDLRenderNative.clipEnabled(ptr);

	/**
	 * Sets the drawing scale for subsequent rendering calls.
	 *
	 * @param sx Horizontal scale factor.
	 * @param sy Vertical scale factor.
	 * @return `true` on success, `false` on failure.
	 */
	public function setScale(sx:Float, sy:Float):Bool
		return SDLRenderNative.setScale(ptr, sx, sy);

	/**
	 * Returns the current drawing scale.
	 *
	 * @return An object with `x` and `y` scale factors.
	 */
	public function getScale():{x:Float, y:Float} {
		var o = new hl.NativeArray<Float>(2);
		SDLRenderNative.getScale(ptr, o);
		return {x: o[0], y: o[1]};
	}

	/**
	 * Sets the color used by drawing operations (0-255 per component).
	 *
	 * @param r Red component in `[0, 255]`.
	 * @param g Green component in `[0, 255]`.
	 * @param b Blue component in `[0, 255]`.
	 * @param a Alpha component in `[0, 255]` (default 255).
	 * @return `true` on success, `false` on failure.
	 */
	public function setDrawColor(r:Int, g:Int, b:Int, a:Int = 255):Bool
		return SDLRenderNative.setDrawColor(ptr, r, g, b, a);

	/**
	 * Sets the color used by drawing operations (0-1 per component).
	 *
	 * Values outside `[0, 1]` are allowed for HDR workflows.
	 *
	 * @param r Red component.
	 * @param g Green component.
	 * @param b Blue component.
	 * @param a Alpha component (default 1).
	 * @return `true` on success, `false` on failure.
	 */
	public function setDrawColorFloat(r:Float, g:Float, b:Float, a:Float = 1):Bool
		return SDLRenderNative.setDrawColorFloat(ptr, r, g, b, a);

	/**
	 * Returns the current drawing color.
	 *
	 * @return An `SDLColor` with components in `[0, 255]`.
	 */
	public function getDrawColor():SDLColor {
		var o = new hl.NativeArray<Int>(4);
		SDLRenderNative.getDrawColor(ptr, o);
		return {
			r: o[0],
			g: o[1],
			b: o[2],
			a: o[3]
		};
	}

	/**
	 * Sets an HDR color scale multiplier applied to all drawing colors.
	 *
	 * @param scale The multiplier. `1.0` is neutral.
	 * @return `true` on success, `false` on failure.
	 */
	public function setColorScale(scale:Float):Bool
		return SDLRenderNative.setColorScale(ptr, scale);

	/**
	 * Returns the current HDR color scale multiplier.
	 *
	 * @return The multiplier (default `1.0`).
	 */
	public function getColorScale():Float
		return SDLRenderNative.getColorScale(ptr);

	/**
	 * Sets the blend mode used by drawing operations.
	 *
	 * @param mode The blend mode (see `SDLBlendMode`).
	 * @return `true` on success, `false` on failure.
	 */
	public function setDrawBlendMode(mode:Int):Bool
		return SDLRenderNative.setDrawBlendMode(ptr, mode);

	/**
	 * Returns the current drawing blend mode.
	 *
	 * @return The active blend mode.
	 */
	public function getDrawBlendMode():Int
		return SDLRenderNative.getDrawBlendMode(ptr);

	/**
	 * Clears the current render target with the current drawing color.
	 *
	 * @return `true` on success, `false` on failure.
	 */
	public function clear():Bool
		return SDLRenderNative.clear(ptr);

	/**
	 * Draws a single point.
	 *
	 * @param x The X coordinate, in render space.
	 * @param y The Y coordinate, in render space.
	 * @return `true` on success, `false` on failure.
	 */
	public function point(x:Float, y:Float):Bool
		return SDLRenderNative.point(ptr, x, y);

	/**
	 * Draws multiple points.
	 *
	 * @param pts The points to draw.
	 * @return `true` on success, `false` on failure.
	 */
	public function points(pts:Array<SDLFPoint>):Bool {
		var a = new hl.NativeArray<Float>(pts.length * 2);
		for (i in 0...pts.length) {
			a[i * 2] = pts[i].x;
			a[i * 2 + 1] = pts[i].y;
		}
		return SDLRenderNative.points(ptr, a);
	}

	/**
	 * Draws a line between two points.
	 *
	 * @param x1 X coordinate of the start point.
	 * @param y1 Y coordinate of the start point.
	 * @param x2 X coordinate of the end point.
	 * @param y2 Y coordinate of the end point.
	 * @return `true` on success, `false` on failure.
	 */
	public function line(x1:Float, y1:Float, x2:Float, y2:Float):Bool
		return SDLRenderNative.line(ptr, x1, y1, x2, y2);

	/**
	 * Draws a series of connected line segments through the given points.
	 *
	 * @param pts The vertices, in order.
	 * @return `true` on success, `false` on failure.
	 */
	public function lines(pts:Array<SDLFPoint>):Bool {
		var a = new hl.NativeArray<Float>(pts.length * 2);
		for (i in 0...pts.length) {
			a[i * 2] = pts[i].x;
			a[i * 2 + 1] = pts[i].y;
		}
		return SDLRenderNative.lines(ptr, a);
	}

	/**
	 * Draws an outlined rectangle.
	 *
	 * @param r The rectangle to outline, or `null` to outline the entire
	 *          viewport.
	 * @return `true` on success, `false` on failure.
	 */
	public function rect(?r:SDLFRect):Bool
		return SDLRenderNative.rect(ptr, r == null ? null : rf(r));

	/**
	 * Draws multiple outlined rectangles.
	 *
	 * @param list The rectangles to outline.
	 * @return `true` on success, `false` on failure.
	 */
	public function rects(list:Array<SDLFRect>):Bool {
		var a = new hl.NativeArray<Float>(list.length * 4);
		for (i in 0...list.length) {
			a[i * 4] = list[i].x;
			a[i * 4 + 1] = list[i].y;
			a[i * 4 + 2] = list[i].w;
			a[i * 4 + 3] = list[i].h;
		}
		return SDLRenderNative.rects(ptr, a);
	}

	/**
	 * Draws a filled rectangle.
	 *
	 * @param r The rectangle to fill, or `null` to fill the entire viewport.
	 * @return `true` on success, `false` on failure.
	 */
	public function fillRect(?r:SDLFRect):Bool
		return SDLRenderNative.fillRect(ptr, r == null ? null : rf(r));

	/**
	 * Draws multiple filled rectangles.
	 *
	 * @param list The rectangles to fill.
	 * @return `true` on success, `false` on failure.
	 */
	public function fillRects(list:Array<SDLFRect>):Bool {
		var a = new hl.NativeArray<Float>(list.length * 4);
		for (i in 0...list.length) {
			a[i * 4] = list[i].x;
			a[i * 4 + 1] = list[i].y;
			a[i * 4 + 2] = list[i].w;
			a[i * 4 + 3] = list[i].h;
		}
		return SDLRenderNative.fillRects(ptr, a);
	}

	/**
	 * Draws a texture.
	 *
	 * @param t       The texture to draw.
	 * @param srcrect Source rectangle within the texture, or `null` for the
	 *                whole texture.
	 * @param dstrect Destination rectangle in render space, or `null` for
	 *                the whole viewport.
	 * @return `true` on success, `false` on failure.
	 */
	public function texture(t:SDLTexture, ?srcrect:SDLFRect, ?dstrect:SDLFRect):Bool
		return SDLRenderNative.texture(ptr, @:privateAccess t.ptr, srcrect == null ? null : rf(srcrect), dstrect == null ? null : rf(dstrect));

	/**
	 * Draws a texture rotated by `angle` degrees around `center`, optionally flipped.
	 *
	 * @param t       The texture to draw.
	 * @param srcrect Source rectangle within the texture, or `null` for the
	 *                whole texture.
	 * @param dstrect Destination rectangle, or `null` for the whole viewport.
	 * @param angle   Rotation angle, in degrees clockwise.
	 * @param center  Center of rotation, or `null` for the center of `dstrect`.
	 * @param flip    Flip mode; `NONE` draws the texture unflipped.
	 * @return `true` on success, `false` on failure.
	 */
	public function textureRotated(t:SDLTexture, ?srcrect:SDLFRect, ?dstrect:SDLFRect, angle:Float = 0, ?center:SDLFPoint, flip:SDLFlipMode = NONE):Bool {
		var c = center == null ? null : new hl.NativeArray<Float>(2);
		if (center != null) {
			c[0] = center.x;
			c[1] = center.y;
		}
		return SDLRenderNative.textureRotated(ptr, @:privateAccess t.ptr, srcrect == null ? null : rf(srcrect), dstrect == null ? null : rf(dstrect), angle, c,
			flip);
	}

	/**
	 * Draws a texture mapped onto the parallelogram defined by `origin`, `right`, and `down`.
	 *
	 * `origin` is the top-left corner of the destination; `right` is the
	 * vector along the top edge; `down` is the vector along the left edge.
	 * Any of them being `null` leaves the corresponding axis untransformed.
	 *
	 * @param t       The texture to draw.
	 * @param srcrect Source rectangle within the texture, or `null` for the
	 *                whole texture.
	 * @param origin  Top-left corner of the destination.
	 * @param right   Horizontal edge vector.
	 * @param down    Vertical edge vector.
	 * @return `true` on success, `false` on failure.
	 */
	public function textureAffine(t:SDLTexture, ?srcrect:SDLFRect, ?origin:SDLFPoint, ?right:SDLFPoint, ?down:SDLFPoint):Bool {
		function toArr(p:Null<SDLFPoint>):hl.NativeArray<Float> {
			if (p == null)
				return null;
			var a = new hl.NativeArray<Float>(2);
			a[0] = p.x;
			a[1] = p.y;
			return a;
		}
		return SDLRenderNative.textureAffine(ptr, @:privateAccess t.ptr, srcrect == null ? null : rf(srcrect), toArr(origin), toArr(right), toArr(down));
	}

	/**
	 * Draws a texture tiled (repeated) to fill `dstrect`.
	 *
	 * @param t       The texture to tile.
	 * @param srcrect Source rectangle within the texture, or `null` for the
	 *                whole texture.
	 * @param scale   Scale factor applied to each tile (default 1).
	 * @param dstrect Destination rectangle, or `null` for the whole viewport.
	 * @return `true` on success, `false` on failure.
	 */
	public function textureTiled(t:SDLTexture, ?srcrect:SDLFRect, scale:Float = 1, ?dstrect:SDLFRect):Bool
		return SDLRenderNative.textureTiled(ptr, @:privateAccess t.ptr, srcrect == null ? null : rf(srcrect), scale, dstrect == null ? null : rf(dstrect));

	/**
	 * Draws a texture using 9-slice scaling.
	 *
	 * The four edges of `srcrect` are kept at fixed pixel sizes (`left`,
	 * `right`, `top`, `bottom`), and only the center is stretched. Ideal for
	 * resizable UI panels.
	 *
	 * @param t       The texture to draw.
	 * @param srcrect Source rectangle within the texture, or `null` for the
	 *                whole texture.
	 * @param left    Width of the left fixed border, in pixels.
	 * @param right   Width of the right fixed border, in pixels.
	 * @param top     Height of the top fixed border, in pixels.
	 * @param bottom  Height of the bottom fixed border, in pixels.
	 * @param scale   Overall scale factor applied to the destination
	 *                rectangle (default 1).
	 * @param dstrect Destination rectangle, or `null` for the whole viewport.
	 * @return `true` on success, `false` on failure.
	 */
	public function texture9Grid(t:SDLTexture, ?srcrect:SDLFRect, left:Float, right:Float, top:Float, bottom:Float, scale:Float = 1, ?dstrect:SDLFRect):Bool
		return SDLRenderNative.texture9Grid(ptr, @:privateAccess t.ptr, srcrect == null ? null : rf(srcrect), left, right, top, bottom, scale,
			dstrect == null ? null : rf(dstrect));

	/**
	 * Renders arbitrary triangle geometry.
	 *
	 * If `indices` is `null`, vertices are consumed sequentially (every 3
	 * form a triangle). If `t` is `null`, the geometry is untextured and
	 * uses per-vertex colors only.
	 *
	 * @param t       The texture to sample, or `null` for untextured geometry.
	 * @param vertices The vertices to render.
	 * @param indices  Optional triangle indices into `vertices`.
	 * @return `true` on success, `false` on failure.
	 */
	public function geometry(?t:SDLTexture, vertices:Array<SDLVertex>, ?indices:Array<Int>):Bool {
		var v = new hl.NativeArray<Float>(vertices.length * 8);
		for (i in 0...vertices.length) {
			var o = i * 8;
			v[o] = vertices[i].x;
			v[o + 1] = vertices[i].y;
			v[o + 2] = vertices[i].color.r;
			v[o + 3] = vertices[i].color.g;
			v[o + 4] = vertices[i].color.b;
			v[o + 5] = vertices[i].color.a;
			v[o + 6] = vertices[i].u;
			v[o + 7] = vertices[i].v;
		}
		var ind:hl.NativeArray<Int> = null;
		if (indices != null) {
			ind = new hl.NativeArray<Int>(indices.length);
			for (i in 0...indices.length)
				ind[i] = indices[i];
		}
		return SDLRenderNative.geometry(ptr, t == null ? null : @:privateAccess t.ptr, v, ind);
	}

	/**
	 * Sets the default texture address mode for sampling outside `[0, 1]`.
	 *
	 * @param u Address mode for the horizontal axis.
	 * @param v Address mode for the vertical axis.
	 * @return `true` on success, `false` on failure.
	 */
	public function setTextureAddressMode(u:SDLTextureAddressMode, v:SDLTextureAddressMode):Bool
		return SDLRenderNative.setAddressMode(ptr, u, v);

	/**
	 * Returns the current default texture address mode for `u`/`v` sampling.
	 *
	 * @return An object with `u` and `v` address modes.
	 */
	public function getTextureAddressMode():{u:SDLTextureAddressMode, v:SDLTextureAddressMode} {
		var o = new hl.NativeArray<Int>(2);
		SDLRenderNative.getAddressMode(ptr, o);
		return {u: o[0], v: o[1]};
	}

	/**
	 * Reads pixels from the current render target into a new surface.
	 *
	 * @param rect The region to read, or `null` for the whole output area.
	 * @return A new surface containing the read pixels, or `null` on failure.
	 *         Call `destroy()` on the returned surface when done.
	 */
	public function readPixels(?rect:SDLRect):Null<SDLSurface> {
		var p = SDLRenderNative.readPixels(ptr, rect == null ? null : ri(rect));
		return p == null ? null : @:privateAccess new SDLSurface(p);
	}

	/**
	 * Presents the current frame to the screen.
	 *
	 * Call this once per frame, after all drawing calls for that frame have
	 * been issued.
	 *
	 * @return `true` on success, `false` on failure.
	 */
	public function present():Bool
		return SDLRenderNative.present(ptr);

	/**
	 * Draws debug text using SDL's built-in monospace font (8x8 pixels per
	 * character).
	 *
	 * @param x    X coordinate of the text origin.
	 * @param y    Y coordinate of the text origin.
	 * @param text The text to draw.
	 * @return `true` on success, `false` on failure.
	 */
	public function debugText(x:Float, y:Float, text:String):Bool
		return SDLRenderNative.debugText(ptr, x, y, text.toUtf8());

	/**
	 * Sets the default scale mode applied to newly created textures.
	 *
	 * @param mode The scale mode.
	 * @return `true` on success, `false` on failure.
	 */
	public function setDefaultTextureScaleMode(mode:SDLScaleMode):Bool
		return SDLRenderNative.setDefaultScaleMode(ptr, mode);

	/**
	 * Returns the default scale mode applied to newly created textures.
	 *
	 * @return The current default scale mode.
	 */
	public function getDefaultTextureScaleMode():SDLScaleMode
		return SDLRenderNative.getDefaultScaleMode(ptr);
}

/**
 * A GPU (or renderer-managed) image.
 *
 * Created with `SDLRenderer.createTexture` or
 * `SDLRenderer.createTextureFromSurface`. Call `destroy()` when done with it.
 *
 * Corresponds to `SDL_Texture` in SDL3.
 */
class SDLTexture {
	var ptr:SDLTexturePtr;

	@:allow(hl.bindings.sdl3)
	function new(ptr:SDLTexturePtr)
		this.ptr = ptr;

	/** The pixel format of this texture. */
	public var format(get, never):Int;

	inline function get_format()
		return SDLRenderNative.getTextureFormat(ptr);

	/**
	 * Returns the size of the texture in pixels.
	 *
	 * @return An object with `w` and `h` fields.
	 */
	public function getSize():{w:Float, h:Float} {
		var o = new hl.NativeArray<Float>(2);
		SDLRenderNative.getTextureSize(ptr, o);
		return {w: o[0], h: o[1]};
	}

	/**
	 * Sets the palette used by an indexed-color texture.
	 *
	 * @param p The palette to assign.
	 * @return `true` on success, `false` on failure.
	 */
	public function setPalette(p:SDLPalette):Bool
		return SDLRenderNative.setTexturePalette(ptr, @:privateAccess p.ptr);

	/**
	 * Returns the palette used by an indexed-color texture.
	 *
	 * @return The current palette, or `null` if the texture has none.
	 */
	public function getPalette():Null<SDLPalette>
		return @:privateAccess SDLPalette.fromPtr(SDLRenderNative.getTexturePalette(ptr));

	/**
	 * Sets a color multiplier applied to this texture when rendered.
	 *
	 * @param r Red multiplier in `[0, 255]`.
	 * @param g Green multiplier in `[0, 255]`.
	 * @param b Blue multiplier in `[0, 255]`.
	 * @return `true` on success, `false` on failure.
	 */
	public function setColorMod(r:Int, g:Int, b:Int):Bool
		return SDLRenderNative.setColorMod(ptr, r, g, b);

	/**
	 * Sets a color multiplier applied to this texture when rendered, as
	 * floats in `[0, 1]`.
	 *
	 * @param r Red multiplier.
	 * @param g Green multiplier.
	 * @param b Blue multiplier.
	 * @return `true` on success, `false` on failure.
	 */
	public function setColorModFloat(r:Float, g:Float, b:Float):Bool
		return SDLRenderNative.setColorModFloat(ptr, r, g, b);

	/**
	 * Returns the current color multiplier for this texture.
	 *
	 * @return An object with `r`, `g`, `b` in `[0, 255]`.
	 */
	public function getColorMod():{r:Int, g:Int, b:Int} {
		var o = new hl.NativeArray<Int>(3);
		SDLRenderNative.getColorMod(ptr, o);
		return {r: o[0], g: o[1], b: o[2]};
	}

	/**
	 * Sets an alpha multiplier applied to this texture when rendered.
	 *
	 * @param a Alpha multiplier in `[0, 255]`.
	 * @return `true` on success, `false` on failure.
	 */
	public function setAlphaMod(a:Int):Bool
		return SDLRenderNative.setAlphaMod(ptr, a);

	/**
	 * Sets an alpha multiplier applied to this texture when rendered, as a
	 * float in `[0, 1]`.
	 *
	 * @param a Alpha multiplier.
	 * @return `true` on success, `false` on failure.
	 */
	public function setAlphaModFloat(a:Float):Bool
		return SDLRenderNative.setAlphaModFloat(ptr, a);

	/**
	 * Returns the current alpha multiplier for this texture.
	 *
	 * @return The alpha multiplier in `[0, 255]`.
	 */
	public function getAlphaMod():Int
		return SDLRenderNative.getAlphaMod(ptr);

	/**
	 * Sets the blend mode used when this texture is rendered.
	 *
	 * @param mode The blend mode (see `SDLBlendMode`).
	 * @return `true` on success, `false` on failure.
	 */
	public function setBlendMode(mode:Int):Bool
		return SDLRenderNative.setBlendMode(ptr, mode);

	/**
	 * Returns the current blend mode for this texture.
	 *
	 * @return The active blend mode.
	 */
	public function getBlendMode():Int
		return SDLRenderNative.getBlendMode(ptr);

	/**
	 * Sets the scaling filter used when this texture is drawn at a size
	 * other than 1:1.
	 *
	 * @param mode The scale mode (nearest or linear).
	 * @return `true` on success, `false` on failure.
	 */
	public function setScaleMode(mode:SDLScaleMode):Bool
		return SDLRenderNative.setScaleMode(ptr, mode);

	/**
	 * Returns the current scaling filter for this texture.
	 *
	 * @return The active scale mode.
	 */
	public function getScaleMode():SDLScaleMode
		return SDLRenderNative.getScaleMode(ptr);

	/**
	 * Updates texture pixel data.
	 *
	 * `pixels` must be packed according to the texture's format, with rows
	 * `pitch` bytes apart.
	 *
	 * @param rect   Region to update, or `null` for the whole texture.
	 * @param pixels The source pixel data.
	 * @param pitch  Number of bytes per row.
	 * @return `true` on success, `false` on failure.
	 */
	public function update(?rect:SDLRect, pixels:hl.Bytes, pitch:Int):Bool {
		var a = rect == null ? null : new hl.NativeArray<Int>(4);
		if (rect != null) {
			a[0] = rect.x;
			a[1] = rect.y;
			a[2] = rect.w;
			a[3] = rect.h;
		}
		return SDLRenderNative.updateTexture(ptr, a, pixels, pitch);
	}

	/**
	 * Updates a planar YUV (YV12/IYUV) texture's pixel data from separate
	 * Y, U, and V planes.
	 *
	 * @param rect   Region to update, or `null` for the whole texture.
	 * @param y      The Y plane.
	 * @param ypitch Bytes per row in the Y plane.
	 * @param u      The U plane.
	 * @param upitch Bytes per row in the U plane.
	 * @param v      The V plane.
	 * @param vpitch Bytes per row in the V plane.
	 * @return `true` on success, `false` on failure.
	 */
	public function updateYUV(?rect:SDLRect, y:hl.Bytes, ypitch:Int, u:hl.Bytes, upitch:Int, v:hl.Bytes, vpitch:Int):Bool {
		var a = rect == null ? null : new hl.NativeArray<Int>(4);
		if (rect != null) {
			a[0] = rect.x;
			a[1] = rect.y;
			a[2] = rect.w;
			a[3] = rect.h;
		}
		return SDLRenderNative.updateYUVTexture(ptr, a, y, ypitch, u, upitch, v, vpitch);
	}

	/**
	 * Updates a semi-planar NV12/NV21 texture's pixel data from Y and
	 * interleaved UV planes.
	 *
	 * @param rect   Region to update, or `null` for the whole texture.
	 * @param y      The Y plane.
	 * @param ypitch Bytes per row in the Y plane.
	 * @param uv     The interleaved UV plane.
	 * @param uvpitch Bytes per row in the UV plane.
	 * @return `true` on success, `false` on failure.
	 */
	public function updateNV(?rect:SDLRect, y:hl.Bytes, ypitch:Int, uv:hl.Bytes, uvpitch:Int):Bool {
		var a = rect == null ? null : new hl.NativeArray<Int>(4);
		if (rect != null) {
			a[0] = rect.x;
			a[1] = rect.y;
			a[2] = rect.w;
			a[3] = rect.h;
		}
		return SDLRenderNative.updateNVTexture(ptr, a, y, ypitch, uv, uvpitch);
	}

	/**
	 * Locks a region of a `STREAMING` texture for direct pixel access.
	 *
	 * The returned pixel pointer is only valid until `unlock()` is called.
	 * Write to it directly (e.g. with `hl.Bytes.blit`) and then call `unlock()`.
	 *
	 * @param rect Region to lock, or `null` for the whole texture.
	 * @return An object with `pixels` and `pitch`, or `null` on failure.
	 */
	public function lock(?rect:SDLRect):Null<{pixels:hl.Bytes, pitch:Int}> {
		var a = rect == null ? null : new hl.NativeArray<Int>(4);
		if (rect != null) {
			a[0] = rect.x;
			a[1] = rect.y;
			a[2] = rect.w;
			a[3] = rect.h;
		}
		var o = new hl.NativeArray<Int>(1);
		var p = SDLRenderNative.lockTexture(ptr, a, o);
		return p == null ? null : {pixels: p, pitch: o[0]};
	}

	/**
	 * Unlocks a texture previously locked with `lock()`, uploading the written
	 * pixel data.
	 */
	public function unlock():Void
		SDLRenderNative.unlockTexture(ptr);

	/**
	 * Destroys the texture and releases its resources.
	 *
	 * Safe to call multiple times; the instance becomes unusable afterwards.
	 */
	public function destroy():Void {
		if (ptr != null)
			SDLRenderNative.destroyTexture(ptr);
		ptr = null;
	}
}
