package hl.bindings.sdl3;

import haxe.Int64;
import haxe.io.Bytes;

typedef SDLCameraPtr = hl.Abstract<"SDL_Camera">;
typedef SDLCameraSpecPtr = hl.Abstract<"SDL_CameraSpec">;
typedef SDLCameraTimestampPtr = hl.Abstract<"SDL_CameraTimestamp">;
typedef SDLCameraSurfacePtr = hl.Abstract<"SDL_Surface">;

/**
 * The physical position of a camera.
 * Corresponds to `SDL_CameraPosition` in SDL3.
 */
enum abstract SDLCameraPosition(Int) from Int to Int {
	/** The camera position is unknown. */
	var UNKNOWN = 0;

	/** The camera is front-facing (e.g. on a phone). */
	var FRONT_FACING = 1;

	/** The camera is back-facing (e.g. on a phone). */
	var BACK_FACING = 2;
}

/**
 * The permission state of a camera.
 * Corresponds to `SDL_CameraPermissionState` in SDL3.
 */
enum abstract SDLCameraPermission(Int) from Int to Int {
	/** Permission was denied. */
	var DENIED = -1;

	/** Permission is pending user approval. */
	var PENDING = 0;

	/** Permission was granted. */
	var APPROVED = 1;
}

/**
 * Describes the format of a camera's output.
 * Corresponds to `SDL_CameraSpec` in SDL3.
 */
class SDLCameraSpec {
	/** Pixel format (SDL_PixelFormatEnum). */
	public var format:Int;

	/** Colorspace (SDL_Colorspace). */
	public var colorspace:Int;

	/** Frame width in pixels. */
	public var width:Int;

	/** Frame height in pixels. */
	public var height:Int;

	/** Frame rate numerator. */
	public var fpsNumerator:Int;

	/** Frame rate denominator. */
	public var fpsDenominator:Int;

	/**
	 * Creates a new camera specification.
	 * @param format Pixel format.
	 * @param colorspace Colorspace.
	 * @param width Frame width.
	 * @param height Frame height.
	 * @param fpsNumerator Frame rate numerator.
	 * @param fpsDenominator Frame rate denominator.
	 */
	public function new(format:Int, colorspace:Int, width:Int, height:Int, fpsNumerator:Int, fpsDenominator:Int) {
		this.format = format;
		this.colorspace = colorspace;
		this.width = width;
		this.height = height;
		this.fpsNumerator = fpsNumerator;
		this.fpsDenominator = fpsDenominator;
	}

	/** The computed frame rate (fpsNumerator / fpsDenominator). */
	public var fps(get, never):Float;

	inline function get_fps()
		return fpsDenominator == 0 ? 0 : fpsNumerator / fpsDenominator;

	public function toString():String
		return 'SDLCameraSpec(${width}x${height} @ ${fps}fps, fmt=0x${StringTools.hex(format)})';

	@:allow(hl.bindings.sdl3)
	function toNative():SDLCameraSpecPtr
		return SDLCameraNative.specAlloc(format, colorspace, width, height, fpsNumerator, fpsDenominator);

	@:allow(hl.bindings.sdl3)
	static function fromNative(p:SDLCameraSpecPtr):SDLCameraSpec
		return new SDLCameraSpec(SDLCameraNative.specFormat(p), SDLCameraNative.specColorspace(p), SDLCameraNative.specWidth(p),
			SDLCameraNative.specHeight(p), SDLCameraNative.specFpsNum(p), SDLCameraNative.specFpsDen(p));

	@:allow(hl.bindings.sdl3)
	static inline function nativeOrNull(s:Null<SDLCameraSpec>):SDLCameraSpecPtr
		return s == null ? null : s.toNative();
}

@:noCompletion
class SDLCameraNative {
	@:hlNative("sdl3", "camera_spec_alloc") public static function specAlloc(fmt:Int, cs:Int, w:Int, h:Int, n:Int, d:Int):SDLCameraSpecPtr
		return null;

	@:hlNative("sdl3", "camera_spec_format") public static function specFormat(s:SDLCameraSpecPtr):Int
		return 0;

	@:hlNative("sdl3", "camera_spec_colorspace") public static function specColorspace(s:SDLCameraSpecPtr):Int
		return 0;

	@:hlNative("sdl3", "camera_spec_width") public static function specWidth(s:SDLCameraSpecPtr):Int
		return 0;

	@:hlNative("sdl3", "camera_spec_height") public static function specHeight(s:SDLCameraSpecPtr):Int
		return 0;

	@:hlNative("sdl3", "camera_spec_fps_num") public static function specFpsNum(s:SDLCameraSpecPtr):Int
		return 0;

	@:hlNative("sdl3", "camera_spec_fps_den") public static function specFpsDen(s:SDLCameraSpecPtr):Int
		return 0;

	@:hlNative("sdl3", "get_num_camera_drivers") public static function getNumDrivers():Int
		return 0;

	@:hlNative("sdl3", "get_camera_driver") public static function getDriver(i:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_current_camera_driver") public static function getCurrentDriver():hl.Bytes
		return null;

	@:hlNative("sdl3", "get_cameras") public static function getCameras():hl.NativeArray<Int>
		return null;

	@:hlNative("sdl3", "get_camera_supported_formats") public static function getSupportedFormats(id:Int):hl.NativeArray<Int>
		return null;

	@:hlNative("sdl3", "get_camera_name") public static function getName(id:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_camera_position") public static function getPosition(id:Int):Int
		return 0;

	@:hlNative("sdl3", "open_camera") public static function open(id:Int, spec:SDLCameraSpecPtr):SDLCameraPtr
		return null;

	@:hlNative("sdl3", "get_camera_permission_state") public static function permission(c:SDLCameraPtr):Int
		return 0;

	@:hlNative("sdl3", "get_camera_id") public static function getId(c:SDLCameraPtr):Int
		return 0;

	@:hlNative("sdl3", "get_camera_format") public static function getFormat(c:SDLCameraPtr, spec:SDLCameraSpecPtr):Bool
		return false;

	@:hlNative("sdl3", "close_camera") public static function close(c:SDLCameraPtr):Void {}

	@:hlNative("sdl3", "camera_timestamp_alloc") public static function tsAlloc():SDLCameraTimestampPtr
		return null;

	@:hlNative("sdl3", "camera_timestamp_get") public static function tsGet(t:SDLCameraTimestampPtr):Int64
		return 0;

	@:hlNative("sdl3", "acquire_camera_frame") public static function acquire(c:SDLCameraPtr, ts:SDLCameraTimestampPtr):SDLCameraSurfacePtr
		return null;

	@:hlNative("sdl3", "release_camera_frame") public static function release(c:SDLCameraPtr, f:SDLCameraSurfacePtr):Void {}

	@:hlNative("sdl3", "camera_frame_width") public static function frameWidth(s:SDLCameraSurfacePtr):Int
		return 0;

	@:hlNative("sdl3", "camera_frame_height") public static function frameHeight(s:SDLCameraSurfacePtr):Int
		return 0;

	@:hlNative("sdl3", "camera_frame_pitch") public static function framePitch(s:SDLCameraSurfacePtr):Int
		return 0;

	@:hlNative("sdl3", "camera_frame_format") public static function frameFormat(s:SDLCameraSurfacePtr):Int
		return 0;

	@:hlNative("sdl3", "camera_frame_pixels") public static function framePixels(s:SDLCameraSurfacePtr):hl.Bytes
		return null;

	@:hlNative("sdl3", "camera_frame_copy") public static function frameCopy(s:SDLCameraSurfacePtr, dst:hl.Bytes):Void {}
}

/**
 * A camera frame captured as a raw image.
 * Contains pixel data and metadata.
 */
typedef SDLCameraImage = {
	/** Frame width in pixels. */
	var width:Int;

	/** Frame height in pixels. */
	var height:Int;

	/** Number of bytes per row. */
	var pitch:Int;

	/** Pixel format. */
	var format:Int;

	/** Timestamp in nanoseconds. */
	var timestampNS:Int64;

	/** Raw pixel data. */
	var pixels:Bytes;
}

/**
 * Represents a single frame acquired from a camera.
 * Must be released back to the camera when done.
 */
class SDLCameraFrame {
	var camera:SDLCamera;
	var ptr:SDLCameraSurfacePtr;

	/** Timestamp of the frame in nanoseconds. */
	public var timestampNS(default, null):Int64;

	/** Frame width in pixels. */
	public var width(default, null):Int;

	/** Frame height in pixels. */
	public var height(default, null):Int;

	/** Number of bytes per row. */
	public var pitch(default, null):Int;

	/** Pixel format. */
	public var format(default, null):Int;

	@:allow(hl.bindings.sdl3.SDLCamera)
	function new(camera:SDLCamera, ptr:SDLCameraSurfacePtr, ts:Int64) {
		this.camera = camera;
		this.ptr = ptr;
		this.timestampNS = ts;
		width = SDLCameraNative.frameWidth(ptr);
		height = SDLCameraNative.frameHeight(ptr);
		pitch = SDLCameraNative.framePitch(ptr);
		format = SDLCameraNative.frameFormat(ptr);
	}

	/** Returns a direct pointer to the frame's pixel data. */
	public function pixels():hl.Bytes
		return SDLCameraNative.framePixels(ptr);

	/** Returns a copy of the frame's pixel data as a `Bytes` object. */
	public function copyPixels():Bytes {
		var b = Bytes.alloc(pitch * height);
		SDLCameraNative.frameCopy(ptr, hl.Bytes.fromBytes(b));
		return b;
	}

	/** Releases the frame back to the camera. Must be called when done. */
	public function release():Void {
		if (ptr != null)
			SDLCameraNative.release(@:privateAccess camera.ptr, ptr);
		ptr = null;
	}
}

/**
 * Represents an opened camera device.
 * Corresponds to `SDL_Camera` in SDL3.
 */
class SDLCamera {
	var ptr:SDLCameraPtr;
	var ts:SDLCameraTimestampPtr;

	function new(ptr:SDLCameraPtr) {
		this.ptr = ptr;
		ts = SDLCameraNative.tsAlloc();
	}

	static inline function str(b:hl.Bytes):Null<String>
		@:privateAccess return b == null ? null : String.fromUTF8(b);

	/** Returns a list of available camera driver names. */
	public static function getDrivers():Array<String>
		return [for (i in 0...SDLCameraNative.getNumDrivers()) str(SDLCameraNative.getDriver(i))];

	/** Returns the name of the currently initialized camera driver, or `null`. */
	public static function getCurrentDriver():Null<String>
		return str(SDLCameraNative.getCurrentDriver());

	/** Returns a list of connected camera device IDs. */
	public static function getCameras():Array<Int> {
		var a = SDLCameraNative.getCameras();
		return a == null ? [] : [for (i in 0...a.length) a[i]];
	}

	/** Returns the human-readable name of a camera, or `null`. */
	public static function getName(id:Int):Null<String>
		return str(SDLCameraNative.getName(id));

	/** Returns the physical position of a camera. */
	public static function getPosition(id:Int):SDLCameraPosition
		return SDLCameraNative.getPosition(id);

	/** Returns a list of supported formats for a camera. */
	public static function getSupportedFormats(id:Int):Array<SDLCameraSpec> {
		var a = SDLCameraNative.getSupportedFormats(id);
		var r = [];
		if (a != null) {
			var i = 0;
			while (i + 5 < a.length) {
				r.push(new SDLCameraSpec(a[i], a[i + 1], a[i + 2], a[i + 3], a[i + 4], a[i + 5]));
				i += 6;
			}
		}
		return r;
	}

	/**
	 * Opens a camera device.
	 * @param id The camera device ID.
	 * @param spec Optional desired format. May be `null` for defaults.
	 * @return A new camera instance, or `null` on failure.
	 */
	public static function open(id:Int, ?spec:SDLCameraSpec):Null<SDLCamera> {
		var p = SDLCameraNative.open(id, SDLCameraSpec.nativeOrNull(spec));
		return p == null ? null : new SDLCamera(p);
	}

	/** Returns the current permission state of the camera. */
	public function permission():SDLCameraPermission
		return SDLCameraNative.permission(ptr);

	/** Returns the device ID of this camera. */
	public function getId():Int
		return SDLCameraNative.getId(ptr);

	/** Returns the current format of the camera, or `null` on error. */
	public function getFormat():Null<SDLCameraSpec> {
		var s = SDLCameraNative.specAlloc(0, 0, 0, 0, 0, 0);
		return SDLCameraNative.getFormat(ptr, s) ? SDLCameraSpec.fromNative(s) : null;
	}

	/**
	 * Acquires a frame from the camera.
	 * The frame must be released with `SDLCameraFrame.release()` when done.
	 * @return A frame, or `null` if no frame is available.
	 */
	public function acquireFrame():Null<SDLCameraFrame> {
		var f = SDLCameraNative.acquire(ptr, ts);
		@:privateAccess return f == null ? null : new SDLCameraFrame(this, f, SDLCameraNative.tsGet(ts));
	}

	/**
	 * Convenience method: acquires a frame, copies its pixels, and releases it.
	 * @return A `SDLCameraImage` with copied pixel data, or `null` on failure.
	 */
	public function readFrame():Null<SDLCameraImage> {
		var f = acquireFrame();
		if (f == null)
			return null;
		var img:SDLCameraImage = {
			width: f.width,
			height: f.height,
			pitch: f.pitch,
			format: f.format,
			timestampNS: f.timestampNS,
			pixels: f.copyPixels()
		};
		f.release();
		return img;
	}

	/** Closes the camera and releases its resources. */
	public function close():Void {
		if (ptr != null)
			SDLCameraNative.close(ptr);
		ptr = null;
	}
}
