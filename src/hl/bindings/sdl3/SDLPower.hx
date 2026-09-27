package hl.bindings.sdl3;

/**
 * The current power/battery status of the system.
 *
 * Used by `SDLPower.getPowerInfo` to report the state of the host device's
 * battery. When the platform does not expose battery information, `state`
 * will be `UNKNOWN`.
 */
typedef SDLPowerInfo = {
	/** The current power/battery state. */
	state:SDLPowerState,

	/** Estimated remaining battery life in seconds, or -1 if unknown. */
	seconds:Int,

	/** Estimated remaining battery percentage in `[0, 100]`, or -1 if unknown. */
	percent:Int
}

/**
 * The power/battery state.
 * Corresponds to `SDL_PowerState` in SDL3.
 */
enum abstract SDLPowerState(Int) from Int to Int {
	/** The power state could not be determined. */
	var ERROR = -1;

	/** The power state is unknown. */
	var UNKNOWN = 0;

	/** The device is running on battery. */
	var ON_BATTERY = 1;

	/** The device has no battery (e.g. it is wired). */
	var NO_BATTERY = 2;

	/** The battery is charging. */
	var CHARGING = 3;

	/** The battery is fully charged. */
	var CHARGED = 4;
}

@:noCompletion
class SDLPowerNative {
	@:hlNative("sdl3", "get_power_info") public static function getPowerInfo(out:hl.NativeArray<Int>):Int
		return 0;
}

/**
 * Power/battery information API.
 *
 * Reports the host system's battery state when available. Useful for
 * applications that want to reduce their workload on low battery or pause
 * background work while the device is discharging.
 *
 * Corresponds to `SDL_GetPowerInfo` in SDL3.
 */
class SDLPower {
	/**
	 * Returns the current power/battery information for the host system.
	 *
	 * On platforms that do not expose battery information, the returned
	 * `state` will be `UNKNOWN` and both `seconds` and `percent` will be -1.
	 *
	 * @return The current `SDLPowerInfo`.
	 */
	public static function getPowerInfo():SDLPowerInfo {
		var o = new hl.NativeArray<Int>(2);
		var state = SDLPowerNative.getPowerInfo(o);
		return {state: state, seconds: o[0], percent: o[1]};
	}
}
