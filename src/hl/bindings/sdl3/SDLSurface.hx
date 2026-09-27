package hl.bindings.sdl3;

import hl.bindings.sdl3.SDLRender.SDLColor01;
import hl.bindings.sdl3.SDLPixels.SDLColor;
import hl.bindings.sdl3.SDLRender.SDLFlipMode;
import hl.bindings.sdl3.SDLRender.SDLScaleMode;
import hl.bindings.sdl3.SDLPixels.SDLPalettePtr;
import hl.bindings.sdl3.SDLIOStream.SDLIOStreamPtr;

typedef SDLSurfacePtr = hl.Abstract<"SDL_Surface">;

@:noCompletion
class SDLSurfaceNative {
	@:hlNative("sdl3", "create_surface") public static function create(w:Int, h:Int, format:Int):SDLSurfacePtr
		return null;

	@:hlNative("sdl3", "create_surface_from") public static function createFrom(w:Int, h:Int, format:Int, pixels:hl.Bytes, pitch:Int):SDLSurfacePtr
		return null;

	@:hlNative("sdl3", "destroy_surface") public static function destroyNative(s:SDLSurfacePtr):Void {}

	@:hlNative("sdl3", "surface_w") public static function w(s:SDLSurfacePtr):Int
		return 0;

	@:hlNative("sdl3", "surface_h") public static function h(s:SDLSurfacePtr):Int
		return 0;

	@:hlNative("sdl3", "surface_pitch") public static function pitch(s:SDLSurfacePtr):Int
		return 0;

	@:hlNative("sdl3", "surface_format") public static function format(s:SDLSurfacePtr):Int
		return 0;

	@:hlNative("sdl3", "surface_pixels") public static function pixels(s:SDLSurfacePtr):hl.Bytes
		return null;

	@:hlNative("sdl3", "surface_copy_pixels") public static function copyPixels(s:SDLSurfacePtr, dst:hl.Bytes):Void {}

	@:hlNative("sdl3", "get_surface_properties") public static function getProperties(s:SDLSurfacePtr):Int
		return 0;

	@:hlNative("sdl3", "set_surface_colorspace") public static function setColorspace(s:SDLSurfacePtr, cs:Int):Bool
		return false;

	@:hlNative("sdl3", "get_surface_colorspace") public static function getColorspace(s:SDLSurfacePtr):Int
		return 0;

	@:hlNative("sdl3", "create_surface_palette") public static function createPalette(s:SDLSurfacePtr):SDLPalettePtr
		return null;

	@:hlNative("sdl3", "set_surface_palette") public static function setPalette(s:SDLSurfacePtr, p:SDLPalettePtr):Bool
		return false;

	@:hlNative("sdl3", "get_surface_palette") public static function getPalette(s:SDLSurfacePtr):SDLPalettePtr
		return null;

	@:hlNative("sdl3", "add_surface_alternate_image") public static function addAlternateImage(s:SDLSurfacePtr, image:SDLSurfacePtr):Bool
		return false;

	@:hlNative("sdl3", "surface_has_alternate_images") public static function hasAlternateImages(s:SDLSurfacePtr):Bool
		return false;

	@:hlNative("sdl3", "get_surface_images_count") public static function imagesCount(s:SDLSurfacePtr):Int
		return 0;

	@:hlNative("sdl3", "get_surface_image_at") public static function imageAt(s:SDLSurfacePtr, index:Int):SDLSurfacePtr
		return null;

	@:hlNative("sdl3", "remove_surface_alternate_images") public static function removeAlternateImages(s:SDLSurfacePtr):Void {}

	@:hlNative("sdl3", "lock_surface") public static function lock(s:SDLSurfacePtr):Bool
		return false;

	@:hlNative("sdl3", "unlock_surface") public static function unlock(s:SDLSurfacePtr):Void {}

	@:hlNative("sdl3", "load_surface_io") public static function loadSurfaceIO(src:SDLIOStreamPtr, closeio:Bool):SDLSurfacePtr
		return null;

	@:hlNative("sdl3", "load_surface") public static function loadSurface(file:hl.Bytes):SDLSurfacePtr
		return null;

	@:hlNative("sdl3", "load_bmp_io") public static function loadBMPIO(src:SDLIOStreamPtr, closeio:Bool):SDLSurfacePtr
		return null;

	@:hlNative("sdl3", "load_bmp") public static function loadBMP(file:hl.Bytes):SDLSurfacePtr
		return null;

	@:hlNative("sdl3", "save_bmp_io") public static function saveBMPIO(s:SDLSurfacePtr, dst:SDLIOStreamPtr, closeio:Bool):Bool
		return false;

	@:hlNative("sdl3", "save_bmp") public static function saveBMP(s:SDLSurfacePtr, file:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "load_png_io") public static function loadPNGIO(src:SDLIOStreamPtr, closeio:Bool):SDLSurfacePtr
		return null;

	@:hlNative("sdl3", "load_png") public static function loadPNG(file:hl.Bytes):SDLSurfacePtr
		return null;

	@:hlNative("sdl3", "save_png_io") public static function savePNGIO(s:SDLSurfacePtr, dst:SDLIOStreamPtr, closeio:Bool):Bool
		return false;

	@:hlNative("sdl3", "save_png") public static function savePNG(s:SDLSurfacePtr, file:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "set_surface_rle") public static function setRLE(s:SDLSurfacePtr, enabled:Bool):Bool
		return false;

	@:hlNative("sdl3", "surface_has_rle") public static function hasRLE(s:SDLSurfacePtr):Bool
		return false;

	@:hlNative("sdl3", "set_surface_color_key") public static function setColorKey(s:SDLSurfacePtr, enabled:Bool, key:Int):Bool
		return false;

	@:hlNative("sdl3", "surface_has_color_key") public static function hasColorKey(s:SDLSurfacePtr):Bool
		return false;

	@:hlNative("sdl3", "get_surface_color_key") public static function getColorKey(s:SDLSurfacePtr, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "set_surface_color_mod") public static function setColorMod(s:SDLSurfacePtr, r:Int, g:Int, b:Int):Bool
		return false;

	@:hlNative("sdl3", "get_surface_color_mod") public static function getColorMod(s:SDLSurfacePtr, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "set_surface_alpha_mod") public static function setAlphaMod(s:SDLSurfacePtr, a:Int):Bool
		return false;

	@:hlNative("sdl3", "get_surface_alpha_mod") public static function getAlphaMod(s:SDLSurfacePtr):Int
		return 0;

	@:hlNative("sdl3", "set_surface_blend_mode") public static function setBlendMode(s:SDLSurfacePtr, mode:Int):Bool
		return false;

	@:hlNative("sdl3", "get_surface_blend_mode") public static function getBlendMode(s:SDLSurfacePtr):Int
		return 0;

	@:hlNative("sdl3", "set_surface_clip_rect") public static function setClipRect(s:SDLSurfacePtr, rect:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "get_surface_clip_rect") public static function getClipRect(s:SDLSurfacePtr, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "flip_surface") public static function flip(s:SDLSurfacePtr, flip:Int):Bool
		return false;

	@:hlNative("sdl3", "rotate_surface") public static function rotate(s:SDLSurfacePtr, angle:Float):SDLSurfacePtr
		return null;

	@:hlNative("sdl3", "duplicate_surface") public static function duplicate(s:SDLSurfacePtr):SDLSurfacePtr
		return null;

	@:hlNative("sdl3", "scale_surface") public static function scale(s:SDLSurfacePtr, w:Int, h:Int, scaleMode:Int):SDLSurfacePtr
		return null;

	@:hlNative("sdl3", "convert_surface") public static function convert(s:SDLSurfacePtr, format:Int):SDLSurfacePtr
		return null;

	@:hlNative("sdl3", "convert_surface_and_colorspace") public static function convertAndColorspace(s:SDLSurfacePtr, format:Int, palette:SDLPalettePtr,
			colorspace:Int):SDLSurfacePtr
		return null;

	@:hlNative("sdl3", "convert_pixels") public static function convertPixels(w:Int, h:Int, srcFormat:Int, src:hl.Bytes, srcPitch:Int, dstFormat:Int,
			dst:hl.Bytes, dstPitch:Int):Bool
		return false;

	@:hlNative("sdl3", "convert_pixels_and_colorspace") public static function convertPixelsAndColorspace(w:Int, h:Int, srcFormat:Int, srcColorspace:Int,
			src:hl.Bytes, srcPitch:Int, dstFormat:Int, dstColorspace:Int, dst:hl.Bytes, dstPitch:Int):Bool
		return false;

	@:hlNative("sdl3", "premultiply_alpha") public static function premultiplyAlpha(w:Int, h:Int, srcFormat:Int, src:hl.Bytes, srcPitch:Int, dstFormat:Int,
			dst:hl.Bytes, dstPitch:Int, linear:Bool):Bool
		return false;

	@:hlNative("sdl3", "premultiply_surface_alpha") public static function premultiplySurfaceAlpha(s:SDLSurfacePtr, linear:Bool):Bool
		return false;

	@:hlNative("sdl3", "clear_surface") public static function clear(s:SDLSurfacePtr, r:Float, g:Float, b:Float, a:Float):Bool
		return false;

	@:hlNative("sdl3", "fill_surface_rect") public static function fillRect(dst:SDLSurfacePtr, rect:hl.NativeArray<Int>, color:Int):Bool
		return false;

	@:hlNative("sdl3", "fill_surface_rects") public static function fillRects(dst:SDLSurfacePtr, rectsXYWH:hl.NativeArray<Int>, color:Int):Bool
		return false;

	@:hlNative("sdl3", "blit_surface") public static function blit(src:SDLSurfacePtr, srcrect:hl.NativeArray<Int>, dst:SDLSurfacePtr,
			dstrect:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "blit_surface_unchecked") public static function blitUnchecked(src:SDLSurfacePtr, srcrect:hl.NativeArray<Int>, dst:SDLSurfacePtr,
			dstrect:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "blit_surface_scaled") public static function blitScaled(src:SDLSurfacePtr, srcrect:hl.NativeArray<Int>, dst:SDLSurfacePtr,
			dstrect:hl.NativeArray<Int>, scaleMode:Int):Bool
		return false;

	@:hlNative("sdl3", "blit_surface_unchecked_scaled") public static function blitUncheckedScaled(src:SDLSurfacePtr, srcrect:hl.NativeArray<Int>,
			dst:SDLSurfacePtr, dstrect:hl.NativeArray<Int>, scaleMode:Int):Bool
		return false;

	@:hlNative("sdl3", "stretch_surface") public static function stretch(src:SDLSurfacePtr, srcrect:hl.NativeArray<Int>, dst:SDLSurfacePtr,
			dstrect:hl.NativeArray<Int>, scaleMode:Int):Bool
		return false;

	@:hlNative("sdl3", "blit_surface_tiled") public static function blitTiled(src:SDLSurfacePtr, srcrect:hl.NativeArray<Int>, dst:SDLSurfacePtr,
			dstrect:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "blit_surface_tiled_with_scale") public static function blitTiledWithScale(src:SDLSurfacePtr, srcrect:hl.NativeArray<Int>, scale:Float,
			scaleMode:Int, dst:SDLSurfacePtr, dstrect:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "blit_surface_9grid") public static function blit9Grid(src:SDLSurfacePtr, srcrect:hl.NativeArray<Int>, leftWidth:Int, rightWidth:Int,
			topHeight:Int, bottomHeight:Int, scale:Float, scaleMode:Int, dst:SDLSurfacePtr, dstrect:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "map_surface_rgb") public static function mapRGB(s:SDLSurfacePtr, r:Int, g:Int, b:Int):Int
		return 0;

	@:hlNative("sdl3", "map_surface_rgba") public static function mapRGBA(s:SDLSurfacePtr, r:Int, g:Int, b:Int, a:Int):Int
		return 0;

	@:hlNative("sdl3", "read_surface_pixel") public static function readPixel(s:SDLSurfacePtr, x:Int, y:Int, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "read_surface_pixel_float") public static function readPixelFloat(s:SDLSurfacePtr, x:Int, y:Int, out:hl.NativeArray<Float>):Bool
		return false;

	@:hlNative("sdl3", "write_surface_pixel") public static function writePixel(s:SDLSurfacePtr, x:Int, y:Int, r:Int, g:Int, b:Int, a:Int):Bool
		return false;

	@:hlNative("sdl3", "write_surface_pixel_float") public static function writePixelFloat(s:SDLSurfacePtr, x:Int, y:Int, r:Float, g:Float, b:Float,
			a:Float):Bool
		return false;
}

/**
 * Static helpers for loading images from disk or streams, and for
 * converting raw pixel buffers between formats.
 *
 * Use these to obtain an `SDLSurface` from a file or memory buffer, or to
 * convert a raw buffer directly when you don't need a full surface.
 *
 * Corresponds to the SDL3 surface loading and pixel-conversion functions.
 */
@:access(String)
class SDLSurfaces {
	static inline function ri(r:SDLRect):hl.NativeArray<Int> {
		var a = new hl.NativeArray<Int>(4);
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

	/**
	 * Loads a BMP image file into a new surface.
	 *
	 * @param path Path to the BMP file.
	 * @return The loaded surface, or `null` on failure.
	 */
	public static function loadBMP(path:String):Null<SDLSurface> {
		var p = SDLSurfaceNative.loadBMP(path.toUtf8());
		return p == null ? null : @:privateAccess new SDLSurface(p);
	}

	/**
	 * Loads a PNG image file into a new surface.
	 *
	 * @param path Path to the PNG file.
	 * @return The loaded surface, or `null` on failure.
	 */
	public static function loadPNG(path:String):Null<SDLSurface> {
		var p = SDLSurfaceNative.loadPNG(path.toUtf8());
		return p == null ? null : @:privateAccess new SDLSurface(p);
	}

	/**
	 * Loads an image, auto-detecting its format from its content.
	 *
	 * The set of supported formats depends on how SDL was built; typically
	 * BMP and PNG are always available, and others may be added by
	 * `SDL_image`.
	 *
	 * @param path Path to the image file.
	 * @return The loaded surface, or `null` on failure.
	 */
	public static function load(path:String):Null<SDLSurface> {
		var p = SDLSurfaceNative.loadSurface(path.toUtf8());
		return p == null ? null : @:privateAccess new SDLSurface(p);
	}

	/**
	 * Loads a BMP image from an `SDLIOStream`.
	 *
	 * @param src        The source stream.
	 * @param closeAfter If `true`, `src` is closed after loading.
	 * @return The loaded surface, or `null` on failure.
	 */
	public static function loadBMPFromStream(src:SDLIOStream, closeAfter:Bool = false):Null<SDLSurface> {
		var p = SDLSurfaceNative.loadBMPIO(@:privateAccess src.ptr, closeAfter);
		return p == null ? null : @:privateAccess new SDLSurface(p);
	}

	/**
	 * Loads a PNG image from an `SDLIOStream`.
	 *
	 * @param src        The source stream.
	 * @param closeAfter If `true`, `src` is closed after loading.
	 * @return The loaded surface, or `null` on failure.
	 */
	public static function loadPNGFromStream(src:SDLIOStream, closeAfter:Bool = false):Null<SDLSurface> {
		var p = SDLSurfaceNative.loadPNGIO(@:privateAccess src.ptr, closeAfter);
		return p == null ? null : @:privateAccess new SDLSurface(p);
	}

	/**
	 * Loads an image from an `SDLIOStream`, auto-detecting its format.
	 *
	 * @param src        The source stream.
	 * @param closeAfter If `true`, `src` is closed after loading.
	 * @return The loaded surface, or `null` on failure.
	 */
	public static function loadFromStream(src:SDLIOStream, closeAfter:Bool = false):Null<SDLSurface> {
		var p = SDLSurfaceNative.loadSurfaceIO(@:privateAccess src.ptr, closeAfter);
		return p == null ? null : @:privateAccess new SDLSurface(p);
	}

	/**
	 * Converts pixel data between two formats, directly between buffers.
	 *
	 * No `SDLSurface` is involved; the operation is performed row by row.
	 *
	 * @param w        Width in pixels.
	 * @param h        Height in pixels.
	 * @param srcFormat Pixel format of the source buffer.
	 * @param src      Source pixel data.
	 * @param srcPitch Bytes per row in the source buffer.
	 * @param dstFormat Pixel format of the destination buffer.
	 * @param dst      Destination pixel data.
	 * @param dstPitch Bytes per row in the destination buffer.
	 * @return `true` on success, `false` on failure.
	 */
	public static function convertPixels(w:Int, h:Int, srcFormat:Int, src:hl.Bytes, srcPitch:Int, dstFormat:Int, dst:hl.Bytes, dstPitch:Int):Bool
		return SDLSurfaceNative.convertPixels(w, h, srcFormat, src, srcPitch, dstFormat, dst, dstPitch);

	/**
	 * Converts pixel data between two formats and colorspaces, directly
	 * between buffers.
	 *
	 * @param w             Width in pixels.
	 * @param h             Height in pixels.
	 * @param srcFormat     Pixel format of the source buffer.
	 * @param srcColorspace Colorspace of the source buffer.
	 * @param src           Source pixel data.
	 * @param srcPitch      Bytes per row in the source buffer.
	 * @param dstFormat     Pixel format of the destination buffer.
	 * @param dstColorspace Colorspace of the destination buffer.
	 * @param dst           Destination pixel data.
	 * @param dstPitch      Bytes per row in the destination buffer.
	 * @return `true` on success, `false` on failure.
	 */
	public static function convertPixelsAndColorspace(w:Int, h:Int, srcFormat:Int, srcColorspace:Int, src:hl.Bytes, srcPitch:Int, dstFormat:Int,
			dstColorspace:Int, dst:hl.Bytes, dstPitch:Int):Bool
		return SDLSurfaceNative.convertPixelsAndColorspace(w, h, srcFormat, srcColorspace, src, srcPitch, dstFormat, dstColorspace, dst, dstPitch);

	/**
	 * Premultiplies alpha into the RGB channels while converting between
	 * pixel buffers.
	 *
	 * @param w        Width in pixels.
	 * @param h        Height in pixels.
	 * @param srcFormat Pixel format of the source buffer.
	 * @param src      Source pixel data.
	 * @param srcPitch Bytes per row in the source buffer.
	 * @param dstFormat Pixel format of the destination buffer.
	 * @param dst      Destination pixel data.
	 * @param dstPitch Bytes per row in the destination buffer.
	 * @param linear   If `true`, the operation is performed in linear color
	 *                 space instead of sRGB.
	 * @return `true` on success, `false` on failure.
	 */
	public static function premultiplyAlpha(w:Int, h:Int, srcFormat:Int, src:hl.Bytes, srcPitch:Int, dstFormat:Int, dst:hl.Bytes, dstPitch:Int,
			linear:Bool = false):Bool
		return SDLSurfaceNative.premultiplyAlpha(w, h, srcFormat, src, srcPitch, dstFormat, dst, dstPitch, linear);
}

/**
 * A CPU-side image buffer.
 *
 * An `SDLSurface` stores raw pixel data plus its dimensions, pitch (row
 * stride in bytes), and pixel format. It lives in system memory, not in
 * GPU memory.
 *
 * Typical uses:
 * - Loading images from disk with `SDLSurfaces.load*`, then uploading them
 *   to a texture with `SDLRenderer.createTextureFromSurface`.
 * - Pixel-level manipulation of images before rendering.
 * - Software rendering with `SDLRenderer.createSoftware`.
 * - Reading back the contents of a render target with
 *   `SDLRenderer.readPixels`.
 *
 * Remember to `destroy()` the surface when you are done with it.
 *
 * Corresponds to `SDL_Surface` in SDL3.
 */
@:access(String)
class SDLSurface {
	var ptr:SDLSurfacePtr;

	@:allow(hl.bindings.sdl3.SDLSurfaces)
	@:allow(hl.bindings.sdl3.SDLRender)
	function new(ptr:SDLSurfacePtr)
		this.ptr = ptr;

	/**
	 * Creates a new blank surface with the given size and pixel format.
	 *
	 * The pixel data is uninitialized; clear it with `clear()` or
	 * `fillRect()` before use.
	 *
	 * @param w      Width in pixels.
	 * @param h      Height in pixels.
	 * @param format Pixel format (see `SDLPixelFormat`).
	 * @return A new surface, or `null` on failure.
	 */
	public static function create(w:Int, h:Int, format:Int):Null<SDLSurface> {
		var p = SDLSurfaceNative.create(w, h, format);
		return p == null ? null : new SDLSurface(p);
	}

	/**
	 * Wraps an existing pixel buffer in a surface without copying it.
	 *
	 * `pixels` must stay alive and unmodified for the entire lifetime of the
	 * surface; freeing or resizing it earlier will lead to undefined
	 * behavior.
	 *
	 * @param w      Width in pixels.
	 * @param h      Height in pixels.
	 * @param format Pixel format of `pixels`.
	 * @param pixels The pixel data to wrap.
	 * @param pitch  Bytes per row in `pixels`.
	 * @return A new surface, or `null` on failure.
	 */
	public static function createFrom(w:Int, h:Int, format:Int, pixels:hl.Bytes, pitch:Int):Null<SDLSurface> {
		var p = SDLSurfaceNative.createFrom(w, h, format, pixels, pitch);
		return p == null ? null : new SDLSurface(p);
	}

	/** Width of the surface, in pixels. */
	public var w(get, never):Int;

	inline function get_w()
		return SDLSurfaceNative.w(ptr);

	/** Height of the surface, in pixels. */
	public var h(get, never):Int;

	inline function get_h()
		return SDLSurfaceNative.h(ptr);

	/** Number of bytes per row of pixel data. */
	public var pitch(get, never):Int;

	inline function get_pitch()
		return SDLSurfaceNative.pitch(ptr);

	/** Pixel format of the surface (see `SDLPixelFormat`). */
	public var format(get, never):Int;

	inline function get_format()
		return SDLSurfaceNative.format(ptr);

	/**
	 * Returns a raw pointer to the pixel data.
	 *
	 * The pointer remains valid for as long as the surface exists, but if
	 * `hasRLE()` is `true` you must call `lock()` first and `unlock()` when
	 * done.
	 *
	 * @return A pointer to the surface's pixel data.
	 */
	public function pixels():hl.Bytes
		return SDLSurfaceNative.pixels(ptr);

	/**
	 * Returns a copy of the surface's pixel data.
	 *
	 * The copy is a fresh `haxe.io.Bytes` of size `pitch * h`.
	 *
	 * @return A copy of the pixel data.
	 */
	public function copyPixels():haxe.io.Bytes {
		var out = haxe.io.Bytes.alloc(pitch * h);
		SDLSurfaceNative.copyPixels(ptr, hl.Bytes.fromBytes(out));
		return out;
	}

	/**
	 * Returns the `SDLProperties` object associated with this surface.
	 *
	 * @return The surface's property set.
	 */
	public function getProperties():SDLProperties
		return SDLProperties.fromId(SDLSurfaceNative.getProperties(ptr));

	/**
	 * Sets the colorspace used to interpret this surface's pixel data.
	 *
	 * @param colorspace The new colorspace (see `SDLColorspace`).
	 * @return `true` on success, `false` on failure.
	 */
	public function setColorspace(colorspace:Int):Bool
		return SDLSurfaceNative.setColorspace(ptr, colorspace);

	/**
	 * Returns the colorspace used to interpret this surface's pixel data.
	 *
	 * @return The current colorspace.
	 */
	public function getColorspace():Int
		return SDLSurfaceNative.getColorspace(ptr);

	/**
	 * Creates a palette with `2^bpp` entries for an indexed-color surface
	 * and associates it with this surface.
	 *
	 * @return The new palette, or `null` on failure.
	 */
	public function createPalette():Null<SDLPalette>
		return SDLPalette.fromPtr(SDLSurfaceNative.createPalette(ptr));

	/**
	 * Sets the palette used to interpret this surface's indexed pixel data.
	 *
	 * @param p The palette to use.
	 * @return `true` on success, `false` on failure.
	 */
	public function setPalette(p:SDLPalette):Bool
		return SDLSurfaceNative.setPalette(ptr, @:privateAccess p.ptr);

	/**
	 * Returns the palette used to interpret this surface's indexed pixel data.
	 *
	 * @return The current palette, or `null` if the surface has none.
	 */
	public function getPalette():Null<SDLPalette>
		return SDLPalette.fromPtr(SDLSurfaceNative.getPalette(ptr));

	/**
	 * Registers an alternate version of this image at a different pixel
	 * density (for HiDPI/Retina support).
	 *
	 * @param image The alternate image to add.
	 * @return `true` on success, `false` on failure.
	 */
	public function addAlternateImage(image:SDLSurface):Bool
		return SDLSurfaceNative.addAlternateImage(ptr, image.ptr);

	/**
	 * Checks whether this surface has alternate density images registered.
	 *
	 * @return `true` if any alternate images are present.
	 */
	public function hasAlternateImages():Bool
		return SDLSurfaceNative.hasAlternateImages(ptr);

	/**
	 * Returns this surface plus all of its registered alternate density
	 * images.
	 *
	 * @return An array of surfaces (this one first).
	 */
	public function getImages():Array<SDLSurface> {
		var n = SDLSurfaceNative.imagesCount(ptr);
		var r = [];
		for (i in 0...n) {
			var p = SDLSurfaceNative.imageAt(ptr, i);
			if (p != null)
				r.push(new SDLSurface(p));
		}
		return r;
	}

	/**
	 * Removes all alternate density images registered on this surface.
	 */
	public function removeAlternateImages():Void
		SDLSurfaceNative.removeAlternateImages(ptr);

	/**
	 * Locks the surface.
	 *
	 * Required before directly accessing `pixels()` when the surface uses
	 * RLE encoding or is backed by non-CPU memory.
	 *
	 * @return `true` on success, `false` on failure.
	 */
	public function lock():Bool
		return SDLSurfaceNative.lock(ptr);

	/**
	 * Unlocks a surface previously locked with `lock()`.
	 */
	public function unlock():Void
		SDLSurfaceNative.unlock(ptr);

	/**
	 * Saves this surface as a BMP file.
	 *
	 * @param path Destination file path.
	 * @return `true` on success, `false` on failure.
	 */
	public function saveBMP(path:String):Bool
		return SDLSurfaceNative.saveBMP(ptr, path.toUtf8());

	/**
	 * Saves this surface as BMP data to an `SDLIOStream`.
	 *
	 * @param dst        Destination stream.
	 * @param closeAfter If `true`, `dst` is closed after saving.
	 * @return `true` on success, `false` on failure.
	 */
	public function saveBMPToStream(dst:SDLIOStream, closeAfter:Bool = false):Bool
		return SDLSurfaceNative.saveBMPIO(ptr, @:privateAccess dst.ptr, closeAfter);

	/**
	 * Saves this surface as a PNG file.
	 *
	 * @param path Destination file path.
	 * @return `true` on success, `false` on failure.
	 */
	public function savePNG(path:String):Bool
		return SDLSurfaceNative.savePNG(ptr, path.toUtf8());

	/**
	 * Saves this surface as PNG data to an `SDLIOStream`.
	 *
	 * @param dst        Destination stream.
	 * @param closeAfter If `true`, `dst` is closed after saving.
	 * @return `true` on success, `false` on failure.
	 */
	public function savePNGToStream(dst:SDLIOStream, closeAfter:Bool = false):Bool
		return SDLSurfaceNative.savePNGIO(ptr, @:privateAccess dst.ptr, closeAfter);

	/**
	 * Enables or disables RLE compression.
	 *
	 * RLE speeds up color-keyed blits at the cost of requiring `lock()`
	 * before reading or writing pixels directly.
	 *
	 * @param enabled `true` to enable RLE compression.
	 * @return `true` on success, `false` on failure.
	 */
	public function setRLE(enabled:Bool):Bool
		return SDLSurfaceNative.setRLE(ptr, enabled);

	/**
	 * Checks whether RLE compression is enabled on this surface.
	 *
	 * @return `true` if RLE compression is enabled.
	 */
	public function hasRLE():Bool
		return SDLSurfaceNative.hasRLE(ptr);

	/**
	 * Sets a color key treated as transparent when blitting.
	 *
	 * The color key does not affect the surface's real alpha channel; it is
	 * a cheaper alternative to per-pixel alpha for simple sprites.
	 *
	 * @param enabled `true` to enable the color key, `false` to disable it.
	 * @param key     The pixel value to treat as transparent, as returned by
	 *                `mapRGB` or `mapRGBA`.
	 * @return `true` on success, `false` on failure.
	 */
	public function setColorKey(enabled:Bool, key:Int):Bool
		return SDLSurfaceNative.setColorKey(ptr, enabled, key);

	/**
	 * Checks whether this surface has a color key set.
	 *
	 * @return `true` if a color key is set.
	 */
	public function hasColorKey():Bool
		return SDLSurfaceNative.hasColorKey(ptr);

	/**
	 * Returns the current color key.
	 *
	 * @return The color key pixel value, or `null` if none is set.
	 */
	public function getColorKey():Null<Int> {
		var o = new hl.NativeArray<Int>(1);
		return SDLSurfaceNative.getColorKey(ptr, o) ? o[0] : null;
	}

	/**
	 * Sets a color multiplier applied to this surface when blitted.
	 *
	 * @param r Red multiplier in `[0, 255]`.
	 * @param g Green multiplier in `[0, 255]`.
	 * @param b Blue multiplier in `[0, 255]`.
	 * @return `true` on success, `false` on failure.
	 */
	public function setColorMod(r:Int, g:Int, b:Int):Bool
		return SDLSurfaceNative.setColorMod(ptr, r, g, b);

	/**
	 * Returns the current color multiplier for this surface.
	 *
	 * @return An object with `r`, `g`, `b` in `[0, 255]`.
	 */
	public function getColorMod():{r:Int, g:Int, b:Int} {
		var o = new hl.NativeArray<Int>(3);
		SDLSurfaceNative.getColorMod(ptr, o);
		return {r: o[0], g: o[1], b: o[2]};
	}

	/**
	 * Sets an alpha multiplier applied to this surface when blitted.
	 *
	 * @param a Alpha multiplier in `[0, 255]`.
	 * @return `true` on success, `false` on failure.
	 */
	public function setAlphaMod(a:Int):Bool
		return SDLSurfaceNative.setAlphaMod(ptr, a);

	/**
	 * Returns the current alpha multiplier for this surface.
	 *
	 * @return The alpha multiplier in `[0, 255]`.
	 */
	public function getAlphaMod():Int
		return SDLSurfaceNative.getAlphaMod(ptr);

	/**
	 * Sets the blend mode used when this surface is blitted onto another.
	 *
	 * @param mode The blend mode (see `SDLBlendMode`).
	 * @return `true` on success, `false` on failure.
	 */
	public function setBlendMode(mode:Int):Bool
		return SDLSurfaceNative.setBlendMode(ptr, mode);

	/**
	 * Returns the current blend mode for this surface.
	 *
	 * @return The active blend mode.
	 */
	public function getBlendMode():Int
		return SDLSurfaceNative.getBlendMode(ptr);

	/**
	 * Sets the clipping rectangle used by blit operations.
	 *
	 * @param rect The rectangle to clip against, or `null` to disable
	 *             clipping.
	 * @return `true` on success, `false` on failure.
	 */
	public function setClipRect(?rect:SDLRect):Bool
		return SDLSurfaceNative.setClipRect(ptr, rect == null ? null : @:privateAccess SDLSurfaces.ri(rect));

	/**
	 * Returns the current clipping rectangle.
	 *
	 * @return The active clip rectangle.
	 */
	public function getClipRect():SDLRect {
		var o = new hl.NativeArray<Int>(4);
		SDLSurfaceNative.getClipRect(ptr, o);
		@:privateAccess return SDLSurfaces.readRi(o);
	}

	/**
	 * Flips the surface in place.
	 *
	 * @param mode The flip mode (horizontal, vertical, or both).
	 * @return `true` on success, `false` on failure.
	 */
	public function flip(mode:SDLFlipMode):Bool
		return SDLSurfaceNative.flip(ptr, mode);

	/**
	 * Rotates the surface by the given angle.
	 *
	 * @param angle The rotation angle in degrees, clockwise.
	 * @return A new rotated surface, or `null` on failure. The result may
	 *         have a different size to fit the whole rotated image.
	 */
	public function rotate(angle:Float):Null<SDLSurface> {
		var p = SDLSurfaceNative.rotate(ptr, angle);
		return p == null ? null : new SDLSurface(p);
	}

	/**
	 * Creates an exact copy of this surface.
	 *
	 * @return A new surface, or `null` on failure.
	 */
	public function duplicate():Null<SDLSurface> {
		var p = SDLSurfaceNative.duplicate(ptr);
		return p == null ? null : new SDLSurface(p);
	}

	/**
	 * Creates a new surface with this surface's content scaled to the given
	 * size.
	 *
	 * @param w         Target width in pixels.
	 * @param h         Target height in pixels.
	 * @param scaleMode The scale mode (nearest or linear).
	 * @return A new surface, or `null` on failure.
	 */
	public function scaleTo(w:Int, h:Int, scaleMode:SDLScaleMode):Null<SDLSurface> {
		var p = SDLSurfaceNative.scale(ptr, w, h, scaleMode);
		return p == null ? null : new SDLSurface(p);
	}

	/**
	 * Creates a copy of this surface converted to a different pixel format.
	 *
	 * @param format The destination pixel format.
	 * @return A new surface, or `null` on failure.
	 */
	public function convertTo(format:Int):Null<SDLSurface> {
		var p = SDLSurfaceNative.convert(ptr, format);
		return p == null ? null : new SDLSurface(p);
	}

	/**
	 * Creates a copy of this surface converted to a different pixel format
	 * and colorspace, optionally re-indexed using a palette.
	 *
	 * @param format     The destination pixel format.
	 * @param colorspace The destination colorspace.
	 * @param palette    Optional palette for indexed destination formats.
	 * @return A new surface, or `null` on failure.
	 */
	public function convertToWithColorspace(format:Int, colorspace:Int, ?palette:SDLPalette):Null<SDLSurface> {
		var p = SDLSurfaceNative.convertAndColorspace(ptr, format, palette == null ? null : @:privateAccess palette.ptr, colorspace);
		return p == null ? null : new SDLSurface(p);
	}

	/**
	 * Premultiplies this surface's alpha into its RGB channels, in place.
	 *
	 * @param linear If `true`, the operation is performed in linear color
	 *               space instead of sRGB.
	 * @return `true` on success, `false` on failure.
	 */
	public function premultiplyAlpha(linear:Bool = false):Bool
		return SDLSurfaceNative.premultiplySurfaceAlpha(ptr, linear);

	/**
	 * Clears the entire surface with a color.
	 *
	 * Note: components are floats in `[0, 1]`, not `[0, 255]`.
	 *
	 * @param r Red component, in `[0, 1]`.
	 * @param g Green component, in `[0, 1]`.
	 * @param b Blue component, in `[0, 1]`.
	 * @param a Alpha component, in `[0, 1]`.
	 * @return `true` on success, `false` on failure.
	 */
	public function clear(r:Float, g:Float, b:Float, a:Float):Bool
		return SDLSurfaceNative.clear(ptr, r, g, b, a);

	/**
	 * Fills a rectangle with a color.
	 *
	 * `color` is a pixel value already mapped into this surface's format
	 * (see `mapRGB`/`mapRGBA`), not an `SDLColor`.
	 *
	 * @param rect  The rectangle to fill, or `null` for the whole surface.
	 * @param color The pixel value to fill with.
	 * @return `true` on success, `false` on failure.
	 */
	public function fillRect(?rect:SDLRect, color:Int):Bool
		return SDLSurfaceNative.fillRect(ptr, rect == null ? null : @:privateAccess SDLSurfaces.ri(rect), color);

	/**
	 * Fills multiple rectangles with a color.
	 *
	 * @param rects The rectangles to fill.
	 * @param color The pixel value to fill with (as mapped by `mapRGB`).
	 * @return `true` on success, `false` on failure.
	 */
	public function fillRects(rects:Array<SDLRect>, color:Int):Bool {
		var a = new hl.NativeArray<Int>(rects.length * 4);
		for (i in 0...rects.length) {
			a[i * 4] = rects[i].x;
			a[i * 4 + 1] = rects[i].y;
			a[i * 4 + 2] = rects[i].w;
			a[i * 4 + 3] = rects[i].h;
		}
		return SDLSurfaceNative.fillRects(ptr, a, color);
	}

	/**
	 * Blits (copies) this surface onto `dst`.
	 *
	 * @param dst     The destination surface.
	 * @param srcrect Source rectangle on this surface, or `null` for the
	 *                whole surface.
	 * @param dstrect Destination rectangle on `dst`, or `null` for position
	 *                `(0, 0)`.
	 * @return `true` on success, `false` on failure.
	 */
	public function blitTo(dst:SDLSurface, ?srcrect:SDLRect, ?dstrect:SDLRect):Bool
		return SDLSurfaceNative.blit(ptr, srcrect == null ? null : @:privateAccess SDLSurfaces.ri(srcrect), dst.ptr,
			dstrect == null ? null : @:privateAccess SDLSurfaces.ri(dstrect));

	/**
	 * Like `blitTo`, but without SDL's automatic validation and clipping.
	 *
	 * Faster, but easier to misuse: the caller must ensure all rectangles
	 * and formats are valid.
	 *
	 * @param dst     The destination surface.
	 * @param srcrect Source rectangle, or `null` for the whole surface.
	 * @param dstrect Destination rectangle, or `null` for `(0, 0)`.
	 * @return `true` on success, `false` on failure.
	 */
	public function blitToUnchecked(dst:SDLSurface, ?srcrect:SDLRect, ?dstrect:SDLRect):Bool
		return SDLSurfaceNative.blitUnchecked(ptr, srcrect == null ? null : @:privateAccess SDLSurfaces.ri(srcrect), dst.ptr,
			dstrect == null ? null : @:privateAccess SDLSurfaces.ri(dstrect));

	/**
	 * Blits this surface onto `dst`, scaling to fit `dstrect`.
	 *
	 * @param dst       The destination surface.
	 * @param srcrect   Source rectangle, or `null` for the whole surface.
	 * @param dstrect   Destination rectangle, or `null` for the whole
	 *                  destination.
	 * @param scaleMode The scale mode (nearest or linear).
	 * @return `true` on success, `false` on failure.
	 */
	public function blitToScaled(dst:SDLSurface, ?srcrect:SDLRect, ?dstrect:SDLRect, scaleMode:SDLScaleMode = LINEAR):Bool
		return SDLSurfaceNative.blitScaled(ptr, srcrect == null ? null : @:privateAccess SDLSurfaces.ri(srcrect), dst.ptr,
			dstrect == null ? null : @:privateAccess SDLSurfaces.ri(dstrect), scaleMode);

	/**
	 * Like `blitToScaled` but without SDL's automatic validation and
	 * clipping.
	 *
	 * @param dst       The destination surface.
	 * @param srcrect   Source rectangle, or `null` for the whole surface.
	 * @param dstrect   Destination rectangle, or `null` for the whole
	 *                  destination.
	 * @param scaleMode The scale mode (nearest or linear).
	 * @return `true` on success, `false` on failure.
	 */
	public function blitToUncheckedScaled(dst:SDLSurface, ?srcrect:SDLRect, ?dstrect:SDLRect, scaleMode:SDLScaleMode = LINEAR):Bool
		return SDLSurfaceNative.blitUncheckedScaled(ptr, srcrect == null ? null : @:privateAccess SDLSurfaces.ri(srcrect), dst.ptr,
			dstrect == null ? null : @:privateAccess SDLSurfaces.ri(dstrect), scaleMode);

	/**
	 * Blits this surface onto `dst`, stretching to exactly fill `dstrect`.
	 *
	 * @param dst       The destination surface.
	 * @param srcrect   Source rectangle, or `null` for the whole surface.
	 * @param dstrect   Destination rectangle, or `null` for the whole
	 *                  destination.
	 * @param scaleMode The scale mode (nearest or linear).
	 * @return `true` on success, `false` on failure.
	 */
	public function stretchTo(dst:SDLSurface, ?srcrect:SDLRect, ?dstrect:SDLRect, scaleMode:SDLScaleMode = LINEAR):Bool
		return SDLSurfaceNative.stretch(ptr, srcrect == null ? null : @:privateAccess SDLSurfaces.ri(srcrect), dst.ptr,
			dstrect == null ? null : @:privateAccess SDLSurfaces.ri(dstrect), scaleMode);

	/**
	 * Blits this surface onto `dst`, tiled (repeated) to fill `dstrect`.
	 *
	 * @param dst     The destination surface.
	 * @param srcrect Source rectangle, or `null` for the whole surface.
	 * @param dstrect Destination rectangle, or `null` for the whole
	 *                destination.
	 * @return `true` on success, `false` on failure.
	 */
	public function blitToTiled(dst:SDLSurface, ?srcrect:SDLRect, ?dstrect:SDLRect):Bool
		return SDLSurfaceNative.blitTiled(ptr, srcrect == null ? null : @:privateAccess SDLSurfaces.ri(srcrect), dst.ptr,
			dstrect == null ? null : @:privateAccess SDLSurfaces.ri(dstrect));

	/**
	 * Blits this surface onto `dst`, tiled and scaled to fill `dstrect`.
	 *
	 * @param dst       The destination surface.
	 * @param srcrect   Source rectangle, or `null` for the whole surface.
	 * @param scale     Scale factor applied to each tile.
	 * @param scaleMode The scale mode (nearest or linear).
	 * @param dstrect   Destination rectangle, or `null` for the whole
	 *                  destination.
	 * @return `true` on success, `false` on failure.
	 */
	public function blitToTiledWithScale(dst:SDLSurface, ?srcrect:SDLRect, scale:Float = 1, scaleMode:SDLScaleMode = LINEAR, ?dstrect:SDLRect):Bool
		return SDLSurfaceNative.blitTiledWithScale(ptr, srcrect == null ? null : @:privateAccess SDLSurfaces.ri(srcrect), scale, scaleMode, dst.ptr,
			dstrect == null ? null : @:privateAccess SDLSurfaces.ri(dstrect));

	/**
	 * Blits using 9-slice scaling.
	 *
	 * The four edges of `srcrect` are kept at fixed pixel sizes
	 * (`leftWidth`, `rightWidth`, `topHeight`, `bottomHeight`), and only
	 * the center is stretched. Ideal for resizable CPU-drawn UI panels.
	 *
	 * @param dst          The destination surface.
	 * @param srcrect      Source rectangle, or `null` for the whole surface.
	 * @param leftWidth    Width of the left fixed border, in pixels.
	 * @param rightWidth   Width of the right fixed border, in pixels.
	 * @param topHeight    Height of the top fixed border, in pixels.
	 * @param bottomHeight Height of the bottom fixed border, in pixels.
	 * @param scale        Overall scale factor.
	 * @param scaleMode    The scale mode (nearest or linear).
	 * @param dstrect      Destination rectangle, or `null` for the whole
	 *                     destination.
	 * @return `true` on success, `false` on failure.
	 */
	public function blitTo9Grid(dst:SDLSurface, ?srcrect:SDLRect, leftWidth:Int, rightWidth:Int, topHeight:Int, bottomHeight:Int, scale:Float = 1,
			scaleMode:SDLScaleMode = LINEAR, ?dstrect:SDLRect):Bool
		return SDLSurfaceNative.blit9Grid(ptr, srcrect == null ? null : @:privateAccess SDLSurfaces.ri(srcrect), leftWidth, rightWidth, topHeight,
			bottomHeight, scale, scaleMode, dst.ptr, dstrect == null ? null : @:privateAccess SDLSurfaces.ri(dstrect));

	/**
	 * Maps an RGB color to a pixel value in this surface's format.
	 *
	 * The result can be used with `fillRect`, `setColorKey`, and other
	 * pixel-level operations.
	 *
	 * @param r Red component in `[0, 255]`.
	 * @param g Green component in `[0, 255]`.
	 * @param b Blue component in `[0, 255]`.
	 * @return The packed pixel value.
	 */
	public function mapRGB(r:Int, g:Int, b:Int):Int
		return SDLSurfaceNative.mapRGB(ptr, r, g, b);

	/**
	 * Maps an RGBA color to a pixel value in this surface's format.
	 *
	 * @param r Red component in `[0, 255]`.
	 * @param g Green component in `[0, 255]`.
	 * @param b Blue component in `[0, 255]`.
	 * @param a Alpha component in `[0, 255]`.
	 * @return The packed pixel value.
	 */
	public function mapRGBA(r:Int, g:Int, b:Int, a:Int):Int
		return SDLSurfaceNative.mapRGBA(ptr, r, g, b, a);

	/**
	 * Reads the color of the pixel at `(x, y)`.
	 *
	 * @param x X coordinate of the pixel.
	 * @param y Y coordinate of the pixel.
	 * @return An `SDLColor` with components in `[0, 255]`, or `null` if
	 *         `(x, y)` is out of bounds.
	 */
	public function readPixel(x:Int, y:Int):Null<SDLColor> {
		var o = new hl.NativeArray<Int>(4);
		return SDLSurfaceNative.readPixel(ptr, x, y, o) ? {
			r: o[0],
			g: o[1],
			b: o[2],
			a: o[3]
		} : null;
	}

	/**
	 * Reads the color of the pixel at `(x, y)` with float components.
	 *
	 * @param x X coordinate of the pixel.
	 * @param y Y coordinate of the pixel.
	 * @return An `SDLColor01` with components in `[0, 1]`, or `null` if
	 *         `(x, y)` is out of bounds.
	 */
	public function readPixelFloat(x:Int, y:Int):Null<SDLColor01> {
		var o = new hl.NativeArray<Float>(4);
		return SDLSurfaceNative.readPixelFloat(ptr, x, y, o) ? {
			r: o[0],
			g: o[1],
			b: o[2],
			a: o[3]
		} : null;
	}

	/**
	 * Writes the color of the pixel at `(x, y)`.
	 *
	 * @param x X coordinate of the pixel.
	 * @param y Y coordinate of the pixel.
	 * @param r Red component in `[0, 255]`.
	 * @param g Green component in `[0, 255]`.
	 * @param b Blue component in `[0, 255]`.
	 * @param a Alpha component in `[0, 255]` (default 255).
	 * @return `true` on success, `false` on failure.
	 */
	public function writePixel(x:Int, y:Int, r:Int, g:Int, b:Int, a:Int = 255):Bool
		return SDLSurfaceNative.writePixel(ptr, x, y, r, g, b, a);

	/**
	 * Writes the color of the pixel at `(x, y)` with float components.
	 *
	 * @param x X coordinate of the pixel.
	 * @param y Y coordinate of the pixel.
	 * @param r Red component in `[0, 1]`.
	 * @param g Green component in `[0, 1]`.
	 * @param b Blue component in `[0, 1]`.
	 * @param a Alpha component in `[0, 1]` (default 1).
	 * @return `true` on success, `false` on failure.
	 */
	public function writePixelFloat(x:Int, y:Int, r:Float, g:Float, b:Float, a:Float = 1):Bool
		return SDLSurfaceNative.writePixelFloat(ptr, x, y, r, g, b, a);

	/**
	 * Destroys the surface and releases its resources.
	 *
	 * Safe to call multiple times; the instance becomes unusable afterwards.
	 */
	public function destroy():Void {
		if (ptr != null)
			SDLSurfaceNative.destroyNative(ptr);
		ptr = null;
	}
}
