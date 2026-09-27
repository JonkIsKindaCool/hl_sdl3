package hl.bindings.sdl3;

@:noCompletion
class ErrorNative {
	@:hlNative("sdl3", "get_error") public static function get():hl.Bytes
		return null;

	@:hlNative("sdl3", "set_error") public static function set(msg:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "out_of_memory") public static function outOfMemory():Bool
		return false;

	@:hlNative("sdl3", "clear_error") public static function clear():Bool
		return false;
}

/**
 * Thread-local error message API, mirroring SDL's `SDL_GetError` / `SDL_SetError` family.
 * Each thread has its own error message that is set by SDL functions on failure.
 */
class SDLError {
	/**
	 * Returns the last error message set on the calling thread.
	 * @return The error message, or an empty string if no error is set.
	 */
	public static function get():String
		@:privateAccess return String.fromUTF8(ErrorNative.get());

	/**
	 * Sets the error message for the calling thread.
	 * Always returns `false`, for convenient `return set(...)` idioms.
	 * @param message The error message to set.
	 * @return Always `false`.
	 */
	public static function set(message:String):Bool
		@:privateAccess return ErrorNative.set(message.toUtf8());

	/**
	 * Clears any error message currently set on the calling thread.
	 * @return `true` on success, `false` on failure.
	 */
	public static function clear():Bool
		return ErrorNative.clear();

	/**
	 * Sets the error message to a standard "out of memory" message.
	 * @return `true` on success, `false` on failure.
	 */
	public static function outOfMemory():Bool
		return ErrorNative.outOfMemory();

	/**
	 * Sets the error message to a standard "operation not supported" message.
	 * @return Always `false` (for convenient `return unsupported()` idioms).
	 */
	public static inline function unsupported():Bool
		return set("That operation is not supported");

	/**
	 * Sets the error message to a standard "invalid parameter" message naming `param`.
	 * @param param The name of the invalid parameter.
	 * @return Always `false` (for convenient `return invalidParam(...)` idioms).
	 */
	public static inline function invalidParam(param:String):Bool
		return set("Parameter '" + param + "' is invalid");

	/**
	 * Throws a Haxe exception built from `context` and the current SDL error message if `ok` is `false`.
	 * Returns `ok` unchanged otherwise.
	 * @param ok The success flag to check.
	 * @param context Optional context string to prepend to the error message.
	 * @return The same `ok` value passed in.
	 * @throws String if `ok` is `false`, containing the context and the current SDL error.
	 */
	public static function check(ok:Bool, ?context:String):Bool {
		if (!ok)
			throw(context != null ? context + ": " : "") + get();
		return ok;
	}
}
