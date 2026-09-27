package hl.bindings.sdl3;

/**
 * Pixel format identifiers.
 *
 * Each constant encodes a specific layout of color channels in memory: order
 * of channels (RGB vs BGR, etc.), bit depth, whether there is an alpha
 * channel, and its position. SDL uses these values throughout the surface,
 * renderer, and texture APIs.
 *
 * Corresponds to `SDL_PixelFormat` in SDL3.
 */
class SDLPixelFormat {
	/** Unknown or invalid format. */
	public static inline var UNKNOWN = 0x00000000;

	/** 1-bit indexed palette, LSB first. */
	public static inline var INDEX1LSB = 0x11100100;

	/** 1-bit indexed palette, MSB first. */
	public static inline var INDEX1MSB = 0x11200100;

	/** 2-bit indexed palette, LSB first. */
	public static inline var INDEX2LSB = 0x1c100200;

	/** 2-bit indexed palette, MSB first. */
	public static inline var INDEX2MSB = 0x1c200200;

	/** 4-bit indexed palette, LSB first. */
	public static inline var INDEX4LSB = 0x12100400;

	/** 4-bit indexed palette, MSB first. */
	public static inline var INDEX4MSB = 0x12200400;

	/** 8-bit indexed palette. */
	public static inline var INDEX8 = 0x13000801;

	/** 8-bit RGB (3-3-2). */
	public static inline var RGB332 = 0x14110801;

	/** 12-bit RGB with 4 unused bits (XRGB 4-4-4). */
	public static inline var XRGB4444 = 0x15120c02;

	/** 12-bit BGR with 4 unused bits (XBGR 4-4-4). */
	public static inline var XBGR4444 = 0x15520c02;

	/** 15-bit RGB with 1 unused bit (XRGB 5-5-5). */
	public static inline var XRGB1555 = 0x15130f02;

	/** 15-bit BGR with 1 unused bit (XBGR 5-5-5). */
	public static inline var XBGR1555 = 0x15530f02;

	/** 16-bit ARGB 4-4-4-4. */
	public static inline var ARGB4444 = 0x15321002;

	/** 16-bit RGBA 4-4-4-4. */
	public static inline var RGBA4444 = 0x15421002;

	/** 16-bit ABGR 4-4-4-4. */
	public static inline var ABGR4444 = 0x15721002;

	/** 16-bit BGRA 4-4-4-4. */
	public static inline var BGRA4444 = 0x15821002;

	/** 16-bit ARGB 1-5-5-5. */
	public static inline var ARGB1555 = 0x15331002;

	/** 16-bit RGBA 5-5-5-1. */
	public static inline var RGBA5551 = 0x15441002;

	/** 16-bit ABGR 1-5-5-5. */
	public static inline var ABGR1555 = 0x15731002;

	/** 16-bit BGRA 5-5-5-1. */
	public static inline var BGRA5551 = 0x15841002;

	/** 16-bit RGB 5-6-5. */
	public static inline var RGB565 = 0x15151002;

	/** 16-bit BGR 5-6-5. */
	public static inline var BGR565 = 0x15551002;

	/** 24-bit packed RGB. */
	public static inline var RGB24 = 0x17101803;

	/** 24-bit packed BGR. */
	public static inline var BGR24 = 0x17401803;

	/** 32-bit XRGB 8-8-8-8. */
	public static inline var XRGB8888 = 0x16161804;

	/** 32-bit RGBX 8-8-8-8. */
	public static inline var RGBX8888 = 0x16261804;

	/** 32-bit XBGR 8-8-8-8. */
	public static inline var XBGR8888 = 0x16561804;

	/** 32-bit BGRX 8-8-8-8. */
	public static inline var BGRX8888 = 0x16661804;

	/** 32-bit ARGB 8-8-8-8. */
	public static inline var ARGB8888 = 0x16362004;

	/** 32-bit RGBA 8-8-8-8. */
	public static inline var RGBA8888 = 0x16462004;

	/** 32-bit ABGR 8-8-8-8. */
	public static inline var ABGR8888 = 0x16762004;

	/** 32-bit BGRA 8-8-8-8. */
	public static inline var BGRA8888 = 0x16862004;

	/** 32-bit XRGB 10-10-10-2. */
	public static inline var XRGB2101010 = 0x16172004;

	/** 32-bit XBGR 10-10-10-2. */
	public static inline var XBGR2101010 = 0x16572004;

	/** 32-bit ARGB 2-10-10-10. */
	public static inline var ARGB2101010 = 0x16372004;

	/** 32-bit ABGR 2-10-10-10. */
	public static inline var ABGR2101010 = 0x16772004;

	/** 48-bit packed RGB (16 bits per channel). */
	public static inline var RGB48 = 0x18103006;

	/** 48-bit packed BGR (16 bits per channel). */
	public static inline var BGR48 = 0x18403006;

	/** 64-bit RGBA (16 bits per channel). */
	public static inline var RGBA64 = 0x18204008;

	/** 64-bit ARGB (16 bits per channel). */
	public static inline var ARGB64 = 0x18304008;

	/** 64-bit BGRA (16 bits per channel). */
	public static inline var BGRA64 = 0x18504008;

	/** 64-bit ABGR (16 bits per channel). */
	public static inline var ABGR64 = 0x18604008;

	/** 48-bit packed RGB, float (16 bits per channel). */
	public static inline var RGB48_FLOAT = 0x1a103006;

	/** 48-bit packed BGR, float (16 bits per channel). */
	public static inline var BGR48_FLOAT = 0x1a403006;

	/** 64-bit RGBA, float (16 bits per channel). */
	public static inline var RGBA64_FLOAT = 0x1a204008;

	/** 64-bit ARGB, float (16 bits per channel). */
	public static inline var ARGB64_FLOAT = 0x1a304008;

	/** 64-bit BGRA, float (16 bits per channel). */
	public static inline var BGRA64_FLOAT = 0x1a504008;

	/** 64-bit ABGR, float (16 bits per channel). */
	public static inline var ABGR64_FLOAT = 0x1a604008;

	/** 96-bit packed RGB, float (32 bits per channel). */
	public static inline var RGB96_FLOAT = 0x1b10600c;

	/** 96-bit packed BGR, float (32 bits per channel). */
	public static inline var BGR96_FLOAT = 0x1b40600c;

	/** 128-bit RGBA, float (32 bits per channel). */
	public static inline var RGBA128_FLOAT = 0x1b208010;

	/** 128-bit ARGB, float (32 bits per channel). */
	public static inline var ARGB128_FLOAT = 0x1b308010;

	/** 128-bit BGRA, float (32 bits per channel). */
	public static inline var BGRA128_FLOAT = 0x1b508010;

	/** 128-bit ABGR, float (32 bits per channel). */
	public static inline var ABGR128_FLOAT = 0x1b608010;

	/** Planar YUV 4:2:0 (YV12, Y-V-U order). */
	public static inline var YV12 = 0x32315659;

	/** Planar YUV 4:2:0 (IYUV/I420, Y-U-V order). */
	public static inline var IYUV = 0x56555949;

	/** Packed YUV 4:2:2 (YUY2 / YUYV). */
	public static inline var YUY2 = 0x32595559;

	/** Packed YUV 4:2:2 (UYVY). */
	public static inline var UYVY = 0x59565955;

	/** Packed YUV 4:2:2 (YVYU). */
	public static inline var YVYU = 0x55595659;

	/** Semi-planar YUV 4:2:0 (NV12, Y-UV order). */
	public static inline var NV12 = 0x3231564e;

	/** Semi-planar YUV 4:2:0 (NV21, Y-VU order). */
	public static inline var NV21 = 0x3132564e;

	/** 10-bit semi-planar YUV 4:2:0 (P010). */
	public static inline var P010 = 0x30313050;

	/** Opaque external texture format (Android, OpenGL ES). */
	public static inline var EXTERNAL_OES = 0x2053454f;

	/** Motion JPEG compressed format. */
	public static inline var MJPG = 0x47504a4d;

	#if (SDL_BIG_ENDIAN)
	/** Alias for a 32-bit RGBA format with byte ordering matching the current CPU endianness. */
	public static inline var RGBA32 = RGBA8888;

	/** Alias for a 32-bit ARGB format with byte ordering matching the current CPU endianness. */
	public static inline var ARGB32 = ARGB8888;

	/** Alias for a 32-bit BGRA format with byte ordering matching the current CPU endianness. */
	public static inline var BGRA32 = BGRA8888;

	/** Alias for a 32-bit ABGR format with byte ordering matching the current CPU endianness. */
	public static inline var ABGR32 = ABGR8888;

	/** Alias for a 32-bit RGBX format with byte ordering matching the current CPU endianness. */
	public static inline var RGBX32 = RGBX8888;

	/** Alias for a 32-bit XRGB format with byte ordering matching the current CPU endianness. */
	public static inline var XRGB32 = XRGB8888;

	/** Alias for a 32-bit BGRX format with byte ordering matching the current CPU endianness. */
	public static inline var BGRX32 = BGRX8888;

	/** Alias for a 32-bit XBGR format with byte ordering matching the current CPU endianness. */
	public static inline var XBGR32 = XBGR8888;
	#else

	/** Alias for a 32-bit RGBA format with byte ordering matching the current CPU endianness. */
	public static inline var RGBA32 = ABGR8888;

	/** Alias for a 32-bit ARGB format with byte ordering matching the current CPU endianness. */
	public static inline var ARGB32 = BGRA8888;

	/** Alias for a 32-bit BGRA format with byte ordering matching the current CPU endianness. */
	public static inline var BGRA32 = ARGB8888;

	/** Alias for a 32-bit ABGR format with byte ordering matching the current CPU endianness. */
	public static inline var ABGR32 = RGBA8888;

	/** Alias for a 32-bit RGBX format with byte ordering matching the current CPU endianness. */
	public static inline var RGBX32 = XBGR8888;

	/** Alias for a 32-bit XRGB format with byte ordering matching the current CPU endianness. */
	public static inline var XRGB32 = BGRX8888;

	/** Alias for a 32-bit BGRX format with byte ordering matching the current CPU endianness. */
	public static inline var BGRX32 = XRGB8888;

	/** Alias for a 32-bit XBGR format with byte ordering matching the current CPU endianness. */
	public static inline var XBGR32 = RGBX8888;
	#end
}

/**
 * Colorspace identifiers.
 *
 * Describes how numeric color components should be interpreted (SDR sRGB,
 * HDR10, various YUV coefficients, etc.). Used alongside a `SDLPixelFormat`
 * to describe how a texture or surface should be sampled and displayed.
 *
 * Corresponds to `SDL_Colorspace` in SDL3.
 */
class SDLColorspace {
	/** Unknown or invalid colorspace. */
	public static inline var UNKNOWN = 0x00000000;

	/** Standard sRGB, non-linear. */
	public static inline var SRGB = 0x120005a0;

	/** sRGB with linear gamma. */
	public static inline var SRGB_LINEAR = 0x12000500;

	/** HDR10 (BT.2020 primaries, PQ transfer, limited range). */
	public static inline var HDR10 = 0x12002600;

	/** Full-range JPEG YUV (BT.601 full-range, YCbCr). */
	public static inline var JPEG = 0x220004c6;

	/** BT.601 limited-range YUV. */
	public static inline var BT601_LIMITED = 0x211018c6;

	/** BT.601 full-range YUV. */
	public static inline var BT601_FULL = 0x221018c6;

	/** BT.709 limited-range YUV. */
	public static inline var BT709_LIMITED = 0x21100421;

	/** BT.709 full-range YUV. */
	public static inline var BT709_FULL = 0x22100421;

	/** BT.2020 limited-range YUV. */
	public static inline var BT2020_LIMITED = 0x21102609;

	/** BT.2020 full-range YUV. */
	public static inline var BT2020_FULL = 0x22102609;

	/** Default colorspace for RGB formats (alias for `SRGB`). */
	public static inline var RGB_DEFAULT = SRGB;

	/** Default colorspace for YUV formats (alias for `BT601_LIMITED`). */
	public static inline var YUV_DEFAULT = BT601_LIMITED;
}

typedef SDLPalettePtr = hl.Abstract<"SDL_Palette">;

/**
 * An 8-bit-per-channel RGBA color.
 *
 * Each component is in `[0, 255]`.
 */
typedef SDLColor = {
	/** Red component. */
	r:Int,

	/** Green component. */
	g:Int,

	/** Blue component. */
	b:Int,

	/** Alpha component (`255` for opaque). */
	a:Int
}

/**
 * Low-level channel masks for a pixel format.
 *
 * Describes the bit position of each channel within a single pixel value.
 */
typedef SDLPixelMasks = {
	/** Bits per pixel. */
	bpp:Int,

	/** Red channel mask. */
	rmask:Int,

	/** Green channel mask. */
	gmask:Int,

	/** Blue channel mask. */
	bmask:Int,

	/** Alpha channel mask (0 if no alpha). */
	amask:Int
}

/**
 * Detailed description of a pixel format.
 *
 * In addition to the raw channel masks, this includes the bit width and
 * shift of each channel, which are convenient when manually packing or
 * unpacking pixels.
 */
typedef SDLPixelFormatDetails = {
	/** Total bits per pixel. */
	bitsPerPixel:Int,

	/** Total bytes per pixel. */
	bytesPerPixel:Int,

	/** Red channel mask. */
	rmask:Int,

	/** Green channel mask. */
	gmask:Int,

	/** Blue channel mask. */
	bmask:Int,

	/** Alpha channel mask (0 if no alpha). */
	amask:Int,

	/** Number of bits in the red channel. */
	rbits:Int,

	/** Number of bits in the green channel. */
	gbits:Int,

	/** Number of bits in the blue channel. */
	bbits:Int,

	/** Number of bits in the alpha channel. */
	abits:Int,

	/** Bit shift of the red channel. */
	rshift:Int,

	/** Bit shift of the green channel. */
	gshift:Int,

	/** Bit shift of the blue channel. */
	bshift:Int,

	/** Bit shift of the alpha channel. */
	ashift:Int
}

@:noCompletion
class SDLPixelsNative {
	@:hlNative("sdl3", "get_pixel_format_name") public static function getFormatName(format:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_masks_for_pixel_format") public static function getMasksForFormat(format:Int, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "get_pixel_format_for_masks") public static function getFormatForMasks(bpp:Int, rmask:Int, gmask:Int, bmask:Int, amask:Int):Int
		return 0;

	@:hlNative("sdl3", "get_pixel_format_details") public static function getFormatDetails(format:Int, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "create_palette") public static function createPalette(ncolors:Int):SDLPalettePtr
		return null;

	@:hlNative("sdl3", "palette_ncolors") public static function paletteNColors(p:SDLPalettePtr):Int
		return 0;

	@:hlNative("sdl3", "get_palette_color") public static function getPaletteColor(p:SDLPalettePtr, index:Int, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "set_palette_colors") public static function setPaletteColors(p:SDLPalettePtr, rgba:hl.NativeArray<Int>, firstColor:Int,
			ncolors:Int):Bool
		return false;

	@:hlNative("sdl3", "destroy_palette") public static function destroyPalette(p:SDLPalettePtr):Void {}

	@:hlNative("sdl3", "map_rgb") public static function mapRGB(format:Int, palette:SDLPalettePtr, r:Int, g:Int, b:Int):Int
		return 0;

	@:hlNative("sdl3", "map_rgba") public static function mapRGBA(format:Int, palette:SDLPalettePtr, r:Int, g:Int, b:Int, a:Int):Int
		return 0;

	@:hlNative("sdl3", "get_rgb") public static function getRGB(pixelvalue:Int, format:Int, palette:SDLPalettePtr, out:hl.NativeArray<Int>):Void {}

	@:hlNative("sdl3", "get_rgba") public static function getRGBA(pixelvalue:Int, format:Int, palette:SDLPalettePtr, out:hl.NativeArray<Int>):Void {}
}

/**
 * Static pixel format utilities.
 *
 * Provides conversions between pixel formats, raw channel values, and pixel
 * values encoded as integers. Most applications only need `mapRGBA()` and
 * `getRGBA()` when manually manipulating pixel data; the surface and
 * renderer APIs handle the rest.
 *
 * Corresponds to the SDL3 pixel format API.
 */
@:access(String)
class SDLPixels {
	static inline function str(b:hl.Bytes):Null<String>
		return b == null ? null : String.fromUTF8(b);

	/**
	 * Returns the human-readable name of a pixel format.
	 *
	 * @param format The pixel format to describe.
	 * @return The name (e.g. `"SDL_PIXELFORMAT_RGBA8888"`), or `null` on failure.
	 */
	public static function getFormatName(format:Int):Null<String>
		return str(SDLPixelsNative.getFormatName(format));

	/**
	 * Returns the channel masks for a pixel format.
	 *
	 * @param format The pixel format to query.
	 * @return The channel masks, or `null` on failure.
	 */
	public static function getMasksForFormat(format:Int):Null<SDLPixelMasks> {
		var o = new hl.NativeArray<Int>(5);
		if (!SDLPixelsNative.getMasksForFormat(format, o))
			return null;
		return {
			bpp: o[0],
			rmask: o[1],
			gmask: o[2],
			bmask: o[3],
			amask: o[4]
		};
	}

	/**
	 * Finds the pixel format that corresponds to the given channel masks.
	 *
	 * @param bpp   Bits per pixel.
	 * @param rmask Red channel mask.
	 * @param gmask Green channel mask.
	 * @param bmask Blue channel mask.
	 * @param amask Alpha channel mask (0 if no alpha).
	 * @return The matching pixel format, or `UNKNOWN` if no match is found.
	 */
	public static function getFormatForMasks(bpp:Int, rmask:Int, gmask:Int, bmask:Int, amask:Int):Int
		return SDLPixelsNative.getFormatForMasks(bpp, rmask, gmask, bmask, amask);

	/**
	 * Returns detailed information about a pixel format.
	 *
	 * @param format The pixel format to query.
	 * @return The format details, or `null` on failure.
	 */
	public static function getFormatDetails(format:Int):Null<SDLPixelFormatDetails> {
		var o = new hl.NativeArray<Int>(14);
		if (!SDLPixelsNative.getFormatDetails(format, o))
			return null;
		return {
			bitsPerPixel: o[0],
			bytesPerPixel: o[1],
			rmask: o[2],
			gmask: o[3],
			bmask: o[4],
			amask: o[5],
			rbits: o[6],
			gbits: o[7],
			bbits: o[8],
			abits: o[9],
			rshift: o[10],
			gshift: o[11],
			bshift: o[12],
			ashift: o[13]
		};
	}

	/**
	 * Maps an RGB triple to a pixel value in the given format.
	 *
	 * The alpha component is set to fully opaque. For palette-indexed formats
	 * a palette must be supplied.
	 *
	 * @param format  The pixel format of the destination.
	 * @param r       Red component in `[0, 255]`.
	 * @param g       Green component in `[0, 255]`.
	 * @param b       Blue component in `[0, 255]`.
	 * @param palette Optional palette for palette-indexed formats.
	 * @return The packed pixel value.
	 */
	public static function mapRGB(format:Int, r:Int, g:Int, b:Int, ?palette:SDLPalette):Int
		return SDLPixelsNative.mapRGB(format, palette == null ? null : @:privateAccess palette.ptr, r, g, b);

	/**
	 * Maps an RGBA quadruple to a pixel value in the given format.
	 *
	 * For palette-indexed formats a palette must be supplied.
	 *
	 * @param format  The pixel format of the destination.
	 * @param r       Red component in `[0, 255]`.
	 * @param g       Green component in `[0, 255]`.
	 * @param b       Blue component in `[0, 255]`.
	 * @param a       Alpha component in `[0, 255]`.
	 * @param palette Optional palette for palette-indexed formats.
	 * @return The packed pixel value.
	 */
	public static function mapRGBA(format:Int, r:Int, g:Int, b:Int, a:Int, ?palette:SDLPalette):Int
		return SDLPixelsNative.mapRGBA(format, palette == null ? null : @:privateAccess palette.ptr, r, g, b, a);

	/**
	 * Extracts the RGB components from a pixel value.
	 *
	 * The alpha component is not extracted; the returned `SDLColor` always
	 * has `a = 255`.
	 *
	 * @param pixelvalue The raw pixel value.
	 * @param format     The pixel format the value is encoded in.
	 * @param palette    Optional palette for palette-indexed formats.
	 * @return The decoded `SDLColor`.
	 */
	public static function getRGB(pixelvalue:Int, format:Int, ?palette:SDLPalette):SDLColor {
		var o = new hl.NativeArray<Int>(4);
		o[3] = 255;
		SDLPixelsNative.getRGB(pixelvalue, format, palette == null ? null : @:privateAccess palette.ptr, o);
		return {
			r: o[0],
			g: o[1],
			b: o[2],
			a: 255
		};
	}

	/**
	 * Extracts the RGBA components from a pixel value.
	 *
	 * @param pixelvalue The raw pixel value.
	 * @param format     The pixel format the value is encoded in.
	 * @param palette    Optional palette for palette-indexed formats.
	 * @return The decoded `SDLColor`, including its alpha channel.
	 */
	public static function getRGBA(pixelvalue:Int, format:Int, ?palette:SDLPalette):SDLColor {
		var o = new hl.NativeArray<Int>(4);
		SDLPixelsNative.getRGBA(pixelvalue, format, palette == null ? null : @:privateAccess palette.ptr, o);
		return {
			r: o[0],
			g: o[1],
			b: o[2],
			a: o[3]
		};
	}
}

/**
 * A palette of colors, used by palette-indexed pixel formats.
 *
 * Corresponds to `SDL_Palette` in SDL3.
 */
class SDLPalette {
	var ptr:SDLPalettePtr;

	/**
	 * Creates a new palette with the given number of colors.
	 *
	 * @param ncolors The number of color entries the palette should hold.
	 */
	public function new(ncolors:Int)
		ptr = SDLPixelsNative.createPalette(ncolors);

	@:allow(hl.bindings.sdl3)
	static function fromPtr(p:SDLPalettePtr):Null<SDLPalette> {
		if (p == null)
			return null;
		var pal:SDLPalette = std.Type.createEmptyInstance(SDLPalette);
		@:privateAccess pal.ptr = p;
		return pal;
	}

	/** The number of color entries in the palette. */
	public var ncolors(get, never):Int;

	inline function get_ncolors()
		return SDLPixelsNative.paletteNColors(ptr);

	/**
	 * Returns the color at the given palette index.
	 *
	 * @param index The palette index.
	 * @return The color at that index, or `null` on failure.
	 */
	public function getColor(index:Int):Null<SDLColor> {
		var o = new hl.NativeArray<Int>(4);
		if (!SDLPixelsNative.getPaletteColor(ptr, index, o))
			return null;
		return {
			r: o[0],
			g: o[1],
			b: o[2],
			a: o[3]
		};
	}

	/**
	 * Replaces a range of colors in the palette.
	 *
	 * @param colors     The new colors, applied starting at `firstColor`.
	 * @param firstColor The first palette index to overwrite (default 0).
	 * @return `true` on success, `false` on failure.
	 */
	public function setColors(colors:Array<SDLColor>, firstColor:Int = 0):Bool {
		var a = new hl.NativeArray<Int>(colors.length * 4);
		for (i in 0...colors.length) {
			a[i * 4] = colors[i].r;
			a[i * 4 + 1] = colors[i].g;
			a[i * 4 + 2] = colors[i].b;
			a[i * 4 + 3] = colors[i].a;
		}
		return SDLPixelsNative.setPaletteColors(ptr, a, firstColor, colors.length);
	}

	/**
	 * Destroys the palette and releases its resources.
	 *
	 * Safe to call multiple times; the instance becomes unusable afterwards.
	 * Do not destroy a palette while a surface still references it.
	 */
	public function destroy():Void {
		if (ptr != null)
			SDLPixelsNative.destroyPalette(ptr);
		ptr = null;
	}
}
