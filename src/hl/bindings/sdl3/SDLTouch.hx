package hl.bindings.sdl3;

import haxe.Int64;

/**
 * Touch device types.
 *
 * Corresponds to `SDL_TouchDeviceType` in SDL3.
 */
enum abstract SDLTouchDeviceType(Int) from Int to Int {
	/** Invalid or unknown touch device type. */
	var INVALID = -1;

	/** Touch screen with window-relative coordinates (e.g. phones, tablets). */
	var DIRECT = 0;

	/** Trackpad or touch device with absolute coordinates. */
	var INDIRECT_ABSOLUTE = 1;

	/** Trackpad or touch device with relative coordinates. */
	var INDIRECT_RELATIVE = 2;
}

/**
 * Information about a single finger currently touching a touch device.
 *
 * Corresponds to `SDL_Finger` in SDL3.
 */
typedef SDLTouchFinger = {
	/** Unique finger identifier. */
	id:Int64,

	/** Normalized X coordinate in the range `[0, 1]`. */
	x:Float,

	/** Normalized Y coordinate in the range `[0, 1]`. */
	y:Float,

	/** Touch pressure normalized in the range `[0, 1]`. */
	pressure:Float
}

@:noCompletion
class SDLTouchNative {
	@:hlNative("sdl3", "get_touch_devices") public static function getDevices():hl.NativeArray<Int>
		return null;

	@:hlNative("sdl3", "get_touch_device_name") public static function getDeviceName(touchID:Int64):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_touch_device_type") public static function getDeviceType(touchID:Int64):Int
		return 0;

	@:hlNative("sdl3", "get_touch_fingers_count") public static function getFingersCount(touchID:Int64):Int
		return 0;

	@:hlNative("sdl3", "get_touch_fingers") public static function getFingers(touchID:Int64, out:hl.NativeArray<Float>):Bool
		return false;
}

/**
 * Functions for querying touch input devices, device properties, and active touch fingers.
 *
 * Provides high-level Haxe bindings corresponding to SDL3 touch device management functions.
 */
@:access(String)
class SDLTouch {
	/**
	 * Special touch ID representing touch input synthesized from mouse events.
	 *
	 * Corresponds to `SDL_TOUCH_MOUSEID` in SDL3.
	 */
	public static inline var MOUSE_TOUCH_ID:Int64 = -1;

	/**
	 * Gets a list of registered touch device IDs.
	 *
	 * Corresponds to `SDL_GetTouchDevices` in SDL3.
	 *
	 * @return An array of touch device identifiers (`Int64`).
	 */
	public static function getDevices():Array<Int64> {
		var a = SDLTouchNative.getDevices();
		if (a == null)
			return [];
		var r = [];
		var i = 0;
		while (i + 1 < a.length) {
			r.push(Int64.make(a[i], a[i + 1]));
			i += 2;
		}
		return r;
	}

	/**
	 * Gets the human-readable name of a touch device.
	 *
	 * Corresponds to `SDL_GetTouchDeviceName` in SDL3.
	 *
	 * @param touchID The touch device identifier.
	 * @return The device name, or `null` on failure or if unsupported.
	 */
	public static function getDeviceName(touchID:Int64):Null<String> {
		var b = SDLTouchNative.getDeviceName(touchID);
		return b == null ? null : String.fromUTF8(b);
	}

	/**
	 * Gets the type of a touch device.
	 *
	 * Corresponds to `SDL_GetTouchDeviceType` in SDL3.
	 *
	 * @param touchID The touch device identifier.
	 * @return The device type as an `SDLTouchDeviceType`.
	 */
	public static function getDeviceType(touchID:Int64):SDLTouchDeviceType
		return SDLTouchNative.getDeviceType(touchID);

	/**
	 * Gets the number of active fingers currently touching a device.
	 *
	 * Corresponds to `SDL_GetTouchFingers` in SDL3.
	 *
	 * @param touchID The touch device identifier.
	 * @return The count of active fingers.
	 */
	public static function getFingersCount(touchID:Int64):Int
		return SDLTouchNative.getFingersCount(touchID);

	/**
	 * Gets an array of active fingers on a touch device.
	 *
	 * Corresponds to `SDL_GetTouchFingers` in SDL3.
	 *
	 * @param touchID The touch device identifier.
	 * @return An array of `SDLTouchFinger` structures representing active touches.
	 */
	public static function getFingers(touchID:Int64):Array<SDLTouchFinger> {
		var n = getFingersCount(touchID);
		if (n <= 0)
			return [];
		var o = new hl.NativeArray<Float>(n * 4);
		if (!SDLTouchNative.getFingers(touchID, o))
			return [];
		return [
			for (i in 0...n)
				{
					id: Int64.ofInt(Std.int(o[i * 4])),
					x: o[i * 4 + 1],
					y: o[i * 4 + 2],
					pressure: o[i * 4 + 3]
				}
		];
	}
}
