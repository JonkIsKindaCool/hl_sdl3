package hl.bindings.sdl3;

@:noCompletion
class SDLVersionNative {
	@:hlNative("sdl3", "get_version") public static function getVersion():Int
		return 0;

	@:hlNative("sdl3", "get_compiled_version") public static function getCompiledVersion():Int
		return 0;

	@:hlNative("sdl3", "get_revision") public static function getRevision():hl.Bytes
		return null;
}

/**
 * Information and utilities for querying the compiled and linked SDL library version.
 *
 * High-level Haxe bindings corresponding to SDL3 version macros and functions.
 */
@:access(String)
class SDLVersion {
	/** Major version number of the binding/header. Corresponds to `SDL_MAJOR_VERSION` in SDL3. */
	public static inline var MAJOR = 3;

	/** Minor version number of the binding/header. Corresponds to `SDL_MINOR_VERSION` in SDL3. */
	public static inline var MINOR = 4;

	/** Micro (patch) version number of the binding/header. Corresponds to `SDL_MICRO_VERSION` in SDL3. */
	public static inline var MICRO = 17;

	/**
	 * Encodes major, minor, and patch numbers into a single integer version number.
	 *
	 * Corresponds to `SDL_VERSIONNUM` in SDL3.
	 *
	 * @param major Major version component.
	 * @param minor Minor version component.
	 * @param patch Patch/micro version component.
	 * @return The encoded integer version number.
	 */
	public static inline function versionNum(major:Int, minor:Int, patch:Int):Int
		return major * 1000000 + minor * 1000 + patch;

	/**
	 * Extracts the major version number from an encoded version integer.
	 *
	 * Corresponds to `SDL_VERSIONNUM_MAJOR` in SDL3.
	 *
	 * @param v Encoded version integer.
	 * @return The major version component.
	 */
	public static inline function versionNumMajor(v:Int):Int
		return Std.int(v / 1000000);

	/**
	 * Extracts the minor version number from an encoded version integer.
	 *
	 * Corresponds to `SDL_VERSIONNUM_MINOR` in SDL3.
	 *
	 * @param v Encoded version integer.
	 * @return The minor version component.
	 */
	public static inline function versionNumMinor(v:Int):Int
		return Std.int(v / 1000) % 1000;

	/**
	 * Extracts the micro/patch version number from an encoded version integer.
	 *
	 * Corresponds to `SDL_VERSIONNUM_MICRO` in SDL3.
	 *
	 * @param v Encoded version integer.
	 * @return The micro/patch version component.
	 */
	public static inline function versionNumMicro(v:Int):Int
		return v % 1000;

	/**
	 * The compiled library version encoded as an integer.
	 *
	 * Corresponds to `SDL_VERSION` in SDL3.
	 */
	public static inline var COMPILED:Int = versionNum(MAJOR, MINOR, MICRO);

	/**
	 * Gets the version of the dynamically linked SDL library at runtime.
	 *
	 * Corresponds to `SDL_GetVersion` in SDL3.
	 *
	 * @return The runtime version encoded as an integer.
	 */
	public static function getVersion():Int
		return SDLVersionNative.getVersion();

	/**
	 * Gets the version of SDL that the native wrapper was compiled against.
	 *
	 * @return The compiled native version encoded as an integer.
	 */
	public static function getCompiledVersion():Int
		return SDLVersionNative.getCompiledVersion();

	/**
	 * Gets the code revision (git commit hash) of the linked SDL library.
	 *
	 * Corresponds to `SDL_GetRevision` in SDL3.
	 *
	 * @return Revision string, or `null` if unavailable.
	 */
	public static function getRevision():Null<String> {
		@:privateAccess
		var b = SDLVersionNative.getRevision();
		return b == null ? null : String.fromUTF8(b);
	}

	/**
	 * Formats the runtime SDL version as a readable semver string (e.g. "3.4.17").
	 *
	 * @return Formatted version string.
	 */
	public static function getVersionString():String {
		var v = getVersion();
		return '${versionNumMajor(v)}.${versionNumMinor(v)}.${versionNumMicro(v)}';
	}

	/**
	 * Checks if the runtime SDL library version is at least the specified version.
	 *
	 * Corresponds to `SDL_VERSION_ATLEAST` in SDL3.
	 *
	 * @param major Minimum required major version.
	 * @param minor Minimum required minor version.
	 * @param patch Minimum required patch version.
	 * @return `true` if the runtime version meets or exceeds the requirements, `false` otherwise.
	 */
	public static function isAtLeast(major:Int, minor:Int, patch:Int):Bool
		return getVersion() >= versionNum(major, minor, patch);
}
