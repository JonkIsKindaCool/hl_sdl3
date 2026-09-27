package hl.bindings.sdl3;

import haxe.Int64;

typedef SDLDateTimePtr = hl.Abstract<"SDL_DateTime">;

/**
 * Preferred date format for display.
 *
 * Corresponds to `SDL_DateFormat` in SDL3.
 */
enum abstract SDLDateFormat(Int) from Int to Int {
	/** Year, month, day order (e.g. YYYY-MM-DD). */
	var YYYYMMDD = 0;

	/** Day, month, year order (e.g. DD/MM/YYYY). */
	var DDMMYYYY = 1;

	/** Month, day, year order (e.g. MM/DD/YYYY). */
	var MMDDYYYY = 2;
}

/**
 * Preferred time format for display.
 *
 * Corresponds to `SDL_TimeFormat` in SDL3.
 */
enum abstract SDLTimeFormat(Int) from Int to Int {
	/** 24-hour clock format (00:00 to 23:59). */
	var H24 = 0;

	/** 12-hour clock format (12:00 AM to 11:59 PM). */
	var H12 = 1;
}

/**
 * A structure representing broken-down calendar date and time components.
 *
 * Corresponds to `SDL_DateTime` in SDL3.
 */
class SDLDateTime {
	/** Year (e.g. 2026). */
	public var year:Int;

	/** Month of the year, from `1` (January) to `12` (December). */
	public var month:Int;

	/** Day of the month, from `1` to `31`. */
	public var day:Int;

	/** Hour of the day, from `0` to `23`. */
	public var hour:Int;

	/** Minute of the hour, from `0` to `59`. */
	public var minute:Int;

	/** Second of the minute, from `0` to `60` (allowing leap seconds). */
	public var second:Int;

	/** Nanoseconds, from `0` to `999,999,999`. */
	public var nanosecond:Int;

	/** Day of the week: `0` = Sunday, `1` = Monday, ..., `6` = Saturday. */
	public var dayOfWeek:Int;

	/** Offset from UTC in seconds. */
	public var utcOffset:Int;

	/**
	 * Creates a new `SDLDateTime` instance with specified date and time components.
	 */
	public function new(year:Int = 0, month:Int = 0, day:Int = 0, hour:Int = 0, minute:Int = 0, second:Int = 0, nanosecond:Int = 0, dayOfWeek:Int = 0,
			utcOffset:Int = 0) {
		this.year = year;
		this.month = month;
		this.day = day;
		this.hour = hour;
		this.minute = minute;
		this.second = second;
		this.nanosecond = nanosecond;
		this.dayOfWeek = dayOfWeek;
		this.utcOffset = utcOffset;
	}

	/**
	 * Returns a string representation of the date and time in ISO-like format.
	 *
	 * @return A formatted string representation.
	 */
	public function toString():String
		return 'SDLDateTime($year-${pad(month, 2)}-${pad(day, 2)} ${pad(hour, 2)}:${pad(minute, 2)}:${pad(second, 2)}.${pad(nanosecond, 9)} UTC${utcOffset >= 0 ? "+" : ""}${utcOffset}s)';

	static inline function pad(v:Int, width:Int):String {
		var s = "" + v;
		while (s.length < width)
			s = "0" + s;
		return s;
	}

	@:allow(hl.bindings.sdl3)
	function toNative():SDLDateTimePtr {
		var p = SDLTimeNative.dateTimeAlloc();
		SDLTimeNative.dateTimeSet(p, year, month, day, hour, minute, second, nanosecond, dayOfWeek, utcOffset);
		return p;
	}

	@:allow(hl.bindings.sdl3)
	static function fromNative(p:SDLDateTimePtr):SDLDateTime
		return new SDLDateTime(SDLTimeNative.dateTimeYear(p), SDLTimeNative.dateTimeMonth(p), SDLTimeNative.dateTimeDay(p), SDLTimeNative.dateTimeHour(p),
			SDLTimeNative.dateTimeMinute(p), SDLTimeNative.dateTimeSecond(p), SDLTimeNative.dateTimeNanosecond(p), SDLTimeNative.dateTimeDayOfWeek(p),
			SDLTimeNative.dateTimeUtcOffset(p));

	@:allow(hl.bindings.sdl3)
	static inline function nativeOrNull(dt:Null<SDLDateTime>):SDLDateTimePtr
		return dt == null ? null : dt.toNative();
}

@:noCompletion
class SDLTimeNative {
	@:hlNative("sdl3", "date_time_alloc") public static function dateTimeAlloc():SDLDateTimePtr
		return null;

	@:hlNative("sdl3", "date_time_year") public static function dateTimeYear(dt:SDLDateTimePtr):Int
		return 0;

	@:hlNative("sdl3", "date_time_month") public static function dateTimeMonth(dt:SDLDateTimePtr):Int
		return 0;

	@:hlNative("sdl3", "date_time_day") public static function dateTimeDay(dt:SDLDateTimePtr):Int
		return 0;

	@:hlNative("sdl3", "date_time_hour") public static function dateTimeHour(dt:SDLDateTimePtr):Int
		return 0;

	@:hlNative("sdl3", "date_time_minute") public static function dateTimeMinute(dt:SDLDateTimePtr):Int
		return 0;

	@:hlNative("sdl3", "date_time_second") public static function dateTimeSecond(dt:SDLDateTimePtr):Int
		return 0;

	@:hlNative("sdl3", "date_time_nanosecond") public static function dateTimeNanosecond(dt:SDLDateTimePtr):Int
		return 0;

	@:hlNative("sdl3", "date_time_day_of_week") public static function dateTimeDayOfWeek(dt:SDLDateTimePtr):Int
		return 0;

	@:hlNative("sdl3", "date_time_utc_offset") public static function dateTimeUtcOffset(dt:SDLDateTimePtr):Int
		return 0;

	@:hlNative("sdl3", "date_time_set") public static function dateTimeSet(dt:SDLDateTimePtr, year:Int, month:Int, day:Int, hour:Int, minute:Int, second:Int,
		nanosecond:Int, dayOfWeek:Int, utcOffset:Int):Void {}

	@:hlNative("sdl3", "get_date_time_locale_preferences") public static function getLocalePreferences(out:hl.NativeArray<Int>):Void {}

	@:hlNative("sdl3", "get_current_time") public static function getCurrentTime(out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "time_to_date_time") public static function timeToDateTime(ticks:Int64, dt:SDLDateTimePtr, localTime:Bool):Bool
		return false;

	@:hlNative("sdl3", "date_time_to_time") public static function dateTimeToTime(dt:SDLDateTimePtr, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "time_to_windows") public static function timeToWindows(ticks:Int64, out:hl.NativeArray<Int>):Void {}

	@:hlNative("sdl3", "time_from_windows") public static function timeFromWindows(lo:Int, hi:Int):Int64
		return 0;

	@:hlNative("sdl3", "get_days_in_month") public static function getDaysInMonth(year:Int, month:Int):Int
		return 0;

	@:hlNative("sdl3", "get_day_of_year") public static function getDayOfYear(year:Int, month:Int, day:Int):Int
		return 0;

	@:hlNative("sdl3", "get_day_of_week") public static function getDayOfWeek(year:Int, month:Int, day:Int):Int
		return 0;
}

/**
 * Functions for real-time clock, calendar dates, locale format preferences,
 * and time conversions.
 *
 * High-level Haxe bindings corresponding to SDL3 time functions.
 */
class SDLTime {
	/**
	 * Gets the system's preferred date and time display formats.
	 *
	 * Corresponds to `SDL_GetDateTimeLocalePreferences` in SDL3.
	 *
	 * @return An object containing `dateFormat` and `timeFormat`, or `null` on failure.
	 */
	public static function getLocalePreferences():Null<{dateFormat:SDLDateFormat, timeFormat:SDLTimeFormat}> {
		var o = new hl.NativeArray<Int>(3);
		SDLTimeNative.getLocalePreferences(o);
		if (o[0] == 0)
			return null;
		return {dateFormat: o[1], timeFormat: o[2]};
	}

	/**
	 * Gets the current real-time clock value as nanoseconds since epoch.
	 *
	 * Corresponds to `SDL_GetCurrentTime` in SDL3.
	 *
	 * @return The current timestamp in nanoseconds as an `Int64`, or `null` on failure.
	 */
	public static function getCurrentTime():Null<Int64> {
		var o = new hl.NativeArray<Int>(2);
		return SDLTimeNative.getCurrentTime(o) ? Int64.make(o[0], o[1]) : null;
	}

	/**
	 * Converts an SDL nanosecond timestamp into a structured `SDLDateTime`.
	 *
	 * Corresponds to `SDL_TimeToDateTime` in SDL3.
	 *
	 * @param ticks     The SDL nanosecond timestamp.
	 * @param localTime If `true`, converts to local system time; if `false`, converts to UTC.
	 * @return A new `SDLDateTime` instance, or `null` on failure.
	 */
	public static function toDateTime(ticks:Int64, localTime:Bool = true):Null<SDLDateTime> {
		var p = SDLTimeNative.dateTimeAlloc();
		if (!SDLTimeNative.timeToDateTime(ticks, p, localTime))
			return null;
		return SDLDateTime.fromNative(p);
	}

	/**
	 * Converts a structured `SDLDateTime` into an SDL nanosecond timestamp.
	 *
	 * Corresponds to `SDL_DateTimeToTime` in SDL3.
	 *
	 * @param dt The calendar date and time to convert.
	 * @return The nanosecond timestamp as an `Int64`, or `null` on failure.
	 */
	public static function dateTimeToTime(dt:SDLDateTime):Null<Int64> {
		var o = new hl.NativeArray<Int>(2);
		if (!SDLTimeNative.dateTimeToTime(dt.toNative(), o))
			return null;
		return Int64.make(o[0], o[1]);
	}

	/**
	 * Converts an SDL nanosecond timestamp into a 64-bit Windows FILETIME value.
	 *
	 * Corresponds to `SDL_TimeToWindows` in SDL3.
	 *
	 * @param ticks The SDL nanosecond timestamp.
	 * @return An object with `low` and `high` 32-bit unsigned integers representing the FILETIME.
	 */
	public static function toWindows(ticks:Int64):{low:Int, high:Int} {
		var o = new hl.NativeArray<Int>(2);
		SDLTimeNative.timeToWindows(ticks, o);
		return {low: o[0], high: o[1]};
	}

	/**
	 * Converts a 64-bit Windows FILETIME value into an SDL nanosecond timestamp.
	 *
	 * Corresponds to `SDL_TimeFromWindows` in SDL3.
	 *
	 * @param low  Low 32 bits of the Windows FILETIME.
	 * @param high High 32 bits of the Windows FILETIME.
	 * @return The converted SDL nanosecond timestamp as an `Int64`.
	 */
	public static function fromWindows(low:Int, high:Int):Int64
		return SDLTimeNative.timeFromWindows(low, high);

	/**
	 * Gets the number of days in a specific month for a given year.
	 *
	 * Accounts for leap years.
	 *
	 * Corresponds to `SDL_GetDaysInMonth` in SDL3.
	 *
	 * @param year  The year (e.g. 2026).
	 * @param month The month of the year `[1..12]`.
	 * @return The number of days in that month, or `0` on invalid parameters.
	 */
	public static function getDaysInMonth(year:Int, month:Int):Int
		return SDLTimeNative.getDaysInMonth(year, month);

	/**
	 * Gets the day of the year for a given date.
	 *
	 * Corresponds to `SDL_GetDayOfYear` in SDL3.
	 *
	 * @param year  The year.
	 * @param month The month `[1..12]`.
	 * @param day   The day of the month `[1..31]`.
	 * @return The day of the year in the range `[0..365]`, or `-1` on error.
	 */
	public static function getDayOfYear(year:Int, month:Int, day:Int):Int
		return SDLTimeNative.getDayOfYear(year, month, day);

	/**
	 * Gets the day of the week for a given date.
	 *
	 * Corresponds to `SDL_GetDayOfWeek` in SDL3.
	 *
	 * @param year  The year.
	 * @param month The month `[1..12]`.
	 * @param day   The day of the month `[1..31]`.
	 * @return Day of the week: `0` = Sunday, `1` = Monday, ..., `6` = Saturday, or `-1` on error.
	 */
	public static function getDayOfWeek(year:Int, month:Int, day:Int):Int
		return SDLTimeNative.getDayOfWeek(year, month, day);
}
