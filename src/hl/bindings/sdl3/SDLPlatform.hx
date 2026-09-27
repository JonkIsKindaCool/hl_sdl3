package hl.bindings.sdl3;

@:noCompletion
class SDLPlatformNative {
	@:hlNative("sdl3", "get_platform") public static function getPlatform():hl.Bytes
		return null;
}

/**
 * Platform detection utilities.
 *
 * Exposes the name of the platform SDL was built for, plus convenience
 * predicates for the platforms that most commonly require special-case
 * behavior. The name is fixed at compile time (it reflects the SDL build,
 * not the runtime environment).
 *
 * Corresponds to `SDL_GetPlatform` in SDL3.
 */
@:access(String)
class SDLPlatform {
	/**
	 * Returns the name of the platform SDL is running on.
	 *
	 * Possible values include `"Windows"`, `"macOS"`, `"Linux"`, `"iOS"`,
	 * `"Android"`, `"WinRT"`, `"tvOS"`, `"Emscripten"`, `"FreeBSD"`,
	 * `"NetBSD"`, `"OpenBSD"`, `"Haiku"`, `"Vita"`, `"PSP"`, `"PS2"`,
	 * `"N3DS"`, `"RISCOS"`, `"Dreamcast"`, `"NGage"`, and others.
	 *
	 * @return The platform name.
	 */
	public static function getPlatform():String
		return String.fromUTF8(SDLPlatformNative.getPlatform());

	/**
	 * Checks whether the current platform is Microsoft Windows.
	 *
	 * @return `true` on Windows (including WinRT).
	 */
	public static function isWindows():Bool
		return getPlatform() == "Windows";

	/**
	 * Checks whether the current platform is macOS.
	 *
	 * @return `true` on macOS.
	 */
	public static function isMacOS():Bool
		return getPlatform() == "macOS";

	/**
	 * Checks whether the current platform is Linux.
	 *
	 * @return `true` on Linux.
	 */
	public static function isLinux():Bool
		return getPlatform() == "Linux";

	/**
	 * Checks whether the current platform is iOS.
	 *
	 * @return `true` on iOS.
	 */
	public static function isIOS():Bool
		return getPlatform() == "iOS";

	/**
	 * Checks whether the current platform is Android.
	 *
	 * @return `true` on Android.
	 */
	public static function isAndroid():Bool
		return getPlatform() == "Android";
}
