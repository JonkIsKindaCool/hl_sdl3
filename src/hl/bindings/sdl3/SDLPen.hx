package hl.bindings.sdl3;

/**
 * Axes reported by a pressure-sensitive pen.
 *
 * Each value identifies one physical measurement the pen can expose via
 * `PEN_AXIS` events. Not every pen supports every axis; query the device's
 * capabilities at runtime.
 *
 * Corresponds to `SDL_PenAxis` in SDL3.
 */
enum abstract SDLPenAxis(Int) from Int to Int {
	/** Tip pressure (typically `[0, 1]`). */
	var PRESSURE = 0;

	/** Tilt along the X axis (typically `[-1, 1]`). */
	var XTILT = 1;

	/** Tilt along the Y axis (typically `[-1, 1]`). */
	var YTILT = 2;

	/** Distance between the pen and the tablet surface. */
	var DISTANCE = 3;

	/** Rotation around the pen's own axis (typically `[-1, 1]`). */
	var ROTATION = 4;

	/** Position of an auxiliary slider on the pen. */
	var SLIDER = 5;

	/** Tangential (barrel) pressure. */
	var TANGENTIAL_PRESSURE = 6;

	/** Total number of defined pen axes (not a valid axis). */
	var COUNT = 7;
}

/**
 * The kind of pen/touch device.
 *
 * Corresponds to `SDL_PenDeviceType` in SDL3.
 */
enum abstract SDLPenDeviceType(Int) from Int to Int {
	/** Invalid or unknown device. */
	var INVALID = -1;

	/** Unknown pen type. */
	var UNKNOWN = 0;

	/** Direct-input device (e.g. a stylus on a tablet screen). */
	var DIRECT = 1;

	/** Indirect-input device (e.g. a pen tablet with no built-in display). */
	var INDIRECT = 2;
}

/**
 * A bitmask of pen input flags describing the current state of the pen.
 *
 * Combines tip/button pressed states, eraser tip, and proximity. Combine
 * with the overloaded `|` operator and test with `has()`.
 *
 * Corresponds to `SDL_PenInputFlags` in SDL3.
 */
enum abstract SDLPenInputFlags(Int) from Int to Int {
	/** The pen tip is in contact with the surface. */
	var DOWN = 1 << 0;

	/** First pen button is pressed. */
	var BUTTON_1 = 1 << 1;

	/** Second pen button is pressed. */
	var BUTTON_2 = 1 << 2;

	/** Third pen button is pressed. */
	var BUTTON_3 = 1 << 3;

	/** Fourth pen button is pressed. */
	var BUTTON_4 = 1 << 4;

	/** Fifth pen button is pressed. */
	var BUTTON_5 = 1 << 5;

	/** The eraser end of the pen is in use. */
	var ERASER_TIP = 1 << 30;

	/** The pen is within range of the tablet (in proximity). */
	var IN_PROXIMITY = 1 << 31;

	@:op(A | B) static function or(a:SDLPenInputFlags, b:SDLPenInputFlags):SDLPenInputFlags;

	/**
	 * Checks whether the given flag is set in this flag set.
	 *
	 * @param flag The flag to test for.
	 * @return `true` if `flag` is present in this value.
	 */
	public inline function has(flag:SDLPenInputFlags):Bool
		return (this & flag) != 0;
}

@:noCompletion
class SDLPenNative {
	@:hlNative("sdl3", "get_pen_device_type") public static function getDeviceType(instanceId:Int):Int
		return 0;
}

/**
 * Pressure-sensitive pen API.
 *
 * Provides constants used with pen-related events and a helper to look up
 * the type of a pen device by its instance ID.
 *
 * Corresponds to the SDL3 pen subsystem.
 */
class SDLPen {
	/**
	 * The mouse ID used for mouse events emulated from pen input.
	 *
	 * Mouse events synthesized from a pen (when pen-to-mouse emulation is
	 * enabled via hints) carry this value in their `which` field so that the
	 * application can distinguish them from real mouse events.
	 *
	 * Corresponds to `SDL_PEN_MOUSEID` in SDL3.
	 */
	public static inline var MOUSEID = -2;

	/**
	 * The touch ID used for touch events emulated from pen input.
	 *
	 * Touch events synthesized from a pen (when pen-to-touch emulation is
	 * enabled via hints) carry this value in their `touchID` field.
	 *
	 * Corresponds to `SDL_PEN_TOUCHID` in SDL3.
	 */
	public static inline var TOUCHID = -2;

	/**
	 * Returns the type of a pen device given its instance ID.
	 *
	 * The instance ID is the value delivered in the `which` field of pen
	 * events (`PEN_PROXIMITY_IN`, `PEN_DOWN`, ...).
	 *
	 * @param instanceId The pen device instance ID.
	 * @return The device type (see `SDLPenDeviceType`), or `INVALID` if the
	 *         ID does not refer to a known pen device.
	 */
	public static function getDeviceType(instanceId:Int):SDLPenDeviceType
		return SDLPenNative.getDeviceType(instanceId);
}
