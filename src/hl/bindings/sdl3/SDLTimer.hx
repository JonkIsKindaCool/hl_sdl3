package hl.bindings.sdl3;

import haxe.Int64;

@:noCompletion
class SDLTimerNative {
	@:hlNative("sdl3", "get_ticks") public static function getTicks():Int64
		return 0;

	@:hlNative("sdl3", "get_ticks_ns") public static function getTicksNS():Int64
		return 0;

	@:hlNative("sdl3", "get_performance_counter") public static function getPerformanceCounter():Int64
		return 0;

	@:hlNative("sdl3", "get_performance_frequency") public static function getPerformanceFrequency():Int64
		return 0;

	@:hlNative("sdl3", "delay") public static function delay(ms:Int):Void {}

	@:hlNative("sdl3", "delay_ns") public static function delayNS(ns:Int64):Void {}

	@:hlNative("sdl3", "delay_precise") public static function delayPrecise(ns:Int64):Void {}

	@:hlNative("sdl3", "add_timer") public static function addTimer(intervalMs:Int, id:Int):Int
		return 0;

	@:hlNative("sdl3", "add_timer_ns") public static function addTimerNS(intervalNs:Int64, id:Int):Int
		return 0;

	@:hlNative("sdl3", "remove_timer") public static function removeTimer(timerID:Int):Bool
		return false;

	@:hlNative("sdl3", "timer_poll") public static function poll():Int
		return -1;
}

/**
 * Time measurement, precision delays, high-resolution performance counters, and timers.
 *
 * High-level Haxe bindings corresponding to SDL3 timer functions and macros.
 */
class SDLTimer {
	/**
	 * Number of milliseconds in one second.
	 *
	 * Corresponds to `SDL_MS_PER_SECOND` in SDL3.
	 */
	public static inline var MS_PER_SECOND = 1000;

	/**
	 * Number of microseconds in one second.
	 *
	 * Corresponds to `SDL_US_PER_SECOND` in SDL3.
	 */
	public static inline var US_PER_SECOND = 1000000;

	/**
	 * Number of nanoseconds in one second.
	 *
	 * Corresponds to `SDL_NS_PER_SECOND` in SDL3.
	 */
	public static inline var NS_PER_SECOND:Int64 = 1000000000;

	/**
	 * Number of nanoseconds in one millisecond.
	 *
	 * Corresponds to `SDL_NS_PER_MS` in SDL3.
	 */
	public static inline var NS_PER_MS:Int64 = 1000000;

	/**
	 * Number of nanoseconds in one microsecond.
	 *
	 * Corresponds to `SDL_NS_PER_US` in SDL3.
	 */
	public static inline var NS_PER_US:Int64 = 1000;

	static var callbacks:Map<Int, Void->Void> = new Map();
	static var nextId = 1;

	/**
	 * Converts seconds to nanoseconds.
	 *
	 * Corresponds to `SDL_SECONDS_TO_NS` in SDL3.
	 *
	 * @param s Seconds count.
	 * @return Time converted to nanoseconds as `Int64`.
	 */
	public static inline function secondsToNS(s:Int):Int64
		return Int64.mul(Int64.ofInt(s), NS_PER_SECOND);

	/**
	 * Converts milliseconds to nanoseconds.
	 *
	 * Corresponds to `SDL_MS_TO_NS` in SDL3.
	 *
	 * @param ms Milliseconds count.
	 * @return Time converted to nanoseconds as `Int64`.
	 */
	public static inline function msToNS(ms:Int):Int64
		return Int64.mul(Int64.ofInt(ms), NS_PER_MS);

	/**
	 * Converts microseconds to nanoseconds.
	 *
	 * Corresponds to `SDL_US_TO_NS` in SDL3.
	 *
	 * @param us Microseconds count.
	 * @return Time converted to nanoseconds as `Int64`.
	 */
	public static inline function usToNS(us:Int):Int64
		return Int64.mul(Int64.ofInt(us), NS_PER_US);

	/**
	 * Gets the number of milliseconds elapsed since SDL library initialization.
	 *
	 * Corresponds to `SDL_GetTicks` in SDL3.
	 *
	 * @return The elapsed time in milliseconds as an `Int64`.
	 */
	public static function getTicks():Int64
		return SDLTimerNative.getTicks();

	/**
	 * Gets the number of nanoseconds elapsed since SDL library initialization.
	 *
	 * Corresponds to `SDL_GetTicksNS` in SDL3.
	 *
	 * @return The elapsed time in nanoseconds as an `Int64`.
	 */
	public static function getTicksNS():Int64
		return SDLTimerNative.getTicksNS();

	/**
	 * Gets the current value of the high-resolution performance counter.
	 *
	 * Corresponds to `SDL_GetPerformanceCounter` in SDL3.
	 *
	 * @return The current counter value as an `Int64`.
	 */
	public static function getPerformanceCounter():Int64
		return SDLTimerNative.getPerformanceCounter();

	/**
	 * Gets the count of high-resolution performance counter ticks per second.
	 *
	 * Corresponds to `SDL_GetPerformanceFrequency` in SDL3.
	 *
	 * @return The performance counter frequency in Hz as an `Int64`.
	 */
	public static function getPerformanceFrequency():Int64
		return SDLTimerNative.getPerformanceFrequency();

	/**
	 * Pauses execution for at least the specified number of milliseconds.
	 *
	 * Corresponds to `SDL_Delay` in SDL3.
	 *
	 * @param ms Delay duration in milliseconds.
	 */
	public static function delay(ms:Int):Void
		SDLTimerNative.delay(ms);

	/**
	 * Pauses execution for at least the specified number of nanoseconds.
	 *
	 * Corresponds to `SDL_DelayNS` in SDL3.
	 *
	 * @param ns Delay duration in nanoseconds.
	 */
	public static function delayNS(ns:Int64):Void
		SDLTimerNative.delayNS(ns);

	/**
	 * Pauses execution with high precision, using spin-locking if necessary.
	 *
	 * Corresponds to `SDL_DelayPrecise` in SDL3.
	 *
	 * @param ns Delay duration in nanoseconds.
	 */
	public static function delayPrecise(ns:Int64):Void
		SDLTimerNative.delayPrecise(ns);

	/**
	 * Adds a timer that triggers a callback after a given interval in milliseconds.
	 *
	 * Corresponds to `SDL_AddTimer` in SDL3.
	 *
	 * @param intervalMs Timer interval in milliseconds.
	 * @param callback   Callback function to execute when the timer fires.
	 * @return A unique timer ID, or `null` on failure.
	 */
	public static function add(intervalMs:Int, callback:Void->Void):Null<Int> {
		var id = nextId++;
		var timerID = SDLTimerNative.addTimer(intervalMs, id);
		if (timerID == 0)
			return null;
		callbacks.set(id, callback);
		return timerID;
	}

	/**
	 * Adds a timer with nanosecond precision that triggers a callback after a given interval.
	 *
	 * Corresponds to `SDL_AddTimerNS` in SDL3.
	 *
	 * @param intervalNs Timer interval in nanoseconds.
	 * @param callback   Callback function to execute when the timer fires.
	 * @return A unique timer ID, or `null` on failure.
	 */
	public static function addNS(intervalNs:Int64, callback:Void->Void):Null<Int> {
		var id = nextId++;
		var timerID = SDLTimerNative.addTimerNS(intervalNs, id);
		if (timerID == 0)
			return null;
		callbacks.set(id, callback);
		return timerID;
	}

	/**
	 * Removes a timer created with `add` or `addNS`.
	 *
	 * Corresponds to `SDL_RemoveTimer` in SDL3.
	 *
	 * @param timerID The ID of the timer to remove.
	 * @return `true` on success, `false` if the timer was not found or already removed.
	 */
	public static function remove(timerID:Int):Bool
		return SDLTimerNative.removeTimer(timerID);

	/**
	 * Polls pending timer callbacks and executes them on the calling thread.
	 *
	 * @return The number of callbacks processed during this call.
	 */
	public static function poll():Int {
		var n = 0;
		while (true) {
			var id = SDLTimerNative.poll();
			if (id < 0)
				break;
			var cb = callbacks.get(id);
			callbacks.remove(id);
			if (cb != null)
				cb();
			n++;
		}
		return n;
	}
}
