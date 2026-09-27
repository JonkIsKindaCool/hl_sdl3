package hl.bindings.sdl3;

/**
 * Application sandbox environment.
 *
 * Indicates whether the application is running inside a container or sandbox.
 *
 * Corresponds to `SDL_Sandbox` in SDL3.
 */
enum abstract SDLSandbox(Int) from Int to Int {
	/** Not running inside a sandbox container. */
	var NONE = 0;

	/** Running inside an unknown or generic sandbox container. */
	var UNKNOWN_CONTAINER = 1;

	/** Running inside a Flatpak container. */
	var FLATPAK = 2;

	/** Running inside a Snap container. */
	var SNAP = 3;

	/** Running inside a macOS App Sandbox. */
	var MACOS = 4;
}

@:noCompletion
class SDLSystemNative {
	@:hlNative("sdl3", "is_tablet") public static function isTablet():Bool
		return false;

	@:hlNative("sdl3", "is_tv") public static function isTV():Bool
		return false;

	@:hlNative("sdl3", "get_sandbox") public static function getSandbox():Int
		return 0;

	@:hlNative("sdl3", "on_application_will_terminate") public static function willTerminate():Void {}

	@:hlNative("sdl3", "on_application_did_receive_memory_warning") public static function memoryWarning():Void {}

	@:hlNative("sdl3", "on_application_will_enter_background") public static function willEnterBackground():Void {}

	@:hlNative("sdl3", "on_application_did_enter_background") public static function didEnterBackground():Void {}

	@:hlNative("sdl3", "on_application_will_enter_foreground") public static function willEnterForeground():Void {}

	@:hlNative("sdl3", "on_application_did_enter_foreground") public static function didEnterForeground():Void {}
}

/**
 * System and platform utility functions for device form factor detection,
 * sandbox querying, and OS lifecycle event handling.
 *
 * Provides high-level bindings for SDL system queries and platform notification hooks.
 */
class SDLSystem {
	/**
	 * Queries whether the current device is a tablet.
	 *
	 * Corresponds to `SDL_IsTablet` in SDL3.
	 *
	 * @return `true` if the device is a tablet, `false` otherwise.
	 */
	public static function isTablet():Bool
		return SDLSystemNative.isTablet();

	/**
	 * Queries whether the current device is a TV (e.g. Android TV, Apple TV).
	 *
	 * Corresponds to `SDL_IsTV` in SDL3.
	 *
	 * @return `true` if the device is a TV, `false` otherwise.
	 */
	public static function isTV():Bool
		return SDLSystemNative.isTV();

	/**
	 * Gets the application sandbox or container environment, if any.
	 *
	 * Corresponds to `SDL_GetSandbox` in SDL3.
	 *
	 * @return The current `SDLSandbox` environment type.
	 */
	public static function getSandbox():SDLSandbox
		return SDLSystemNative.getSandbox();

	/**
	 * Notifies SDL that the application is about to terminate.
	 *
	 * Used primarily on mobile platforms (e.g. iOS) with custom/external event loops
	 * to forward OS termination events to SDL.
	 *
	 * Corresponds to `SDL_OnApplicationWillTerminate` in SDL3.
	 */
	public static function notifyWillTerminate():Void
		SDLSystemNative.willTerminate();

	/**
	 * Notifies SDL that the application received a low memory warning from the OS.
	 *
	 * Allows SDL and the application to respond to memory pressure (e.g., freeing caches).
	 *
	 * Corresponds to `SDL_OnApplicationDidReceiveMemoryWarning` in SDL3.
	 */
	public static function notifyMemoryWarning():Void
		SDLSystemNative.memoryWarning();

	/**
	 * Notifies SDL that the application is preparing to enter the background.
	 *
	 * Corresponds to `SDL_OnApplicationWillEnterBackground` in SDL3.
	 */
	public static function notifyWillEnterBackground():Void
		SDLSystemNative.willEnterBackground();

	/**
	 * Notifies SDL that the application has entered the background.
	 *
	 * Corresponds to `SDL_OnApplicationDidEnterBackground` in SDL3.
	 */
	public static function notifyDidEnterBackground():Void
		SDLSystemNative.didEnterBackground();

	/**
	 * Notifies SDL that the application is preparing to enter the foreground.
	 *
	 * Corresponds to `SDL_OnApplicationWillEnterForeground` in SDL3.
	 */
	public static function notifyWillEnterForeground():Void
		SDLSystemNative.willEnterForeground();

	/**
	 * Notifies SDL that the application has entered the foreground and is active.
	 *
	 * Corresponds to `SDL_OnApplicationDidEnterForeground` in SDL3.
	 */
	public static function notifyDidEnterForeground():Void
		SDLSystemNative.didEnterForeground();
}
