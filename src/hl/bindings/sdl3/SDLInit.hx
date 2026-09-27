package hl.bindings.sdl3;

/**
 * Subsystem flags used by `SDLInit.init`, `SDLInit.initSubSystem`,
 * `SDLInit.quitSubSystem` and `SDLInit.wasInit`.
 *
 * Combine multiple flags with `|` (via the overloaded `or` operator).
 * Test whether a flag set contains a given subsystem with `has()`.
 *
 * Corresponds to `SDL_InitFlags` in SDL3.
 */
enum abstract SDLInitFlags(Int) from Int to Int {
	/** Audio subsystem. */
	var AUDIO = 0x00000010;

	/** Video subsystem (also implies events). */
	var VIDEO = 0x00000020;

	/** Joystick subsystem (also implies events). */
	var JOYSTICK = 0x00000200;

	/** Haptic (force feedback) subsystem. */
	var HAPTIC = 0x00001000;

	/** Gamepad subsystem (also implies joystick). */
	var GAMEPAD = 0x00002000;

	/** Events subsystem. */
	var EVENTS = 0x00004000;

	/** Sensor subsystem (also implies events). */
	var SENSOR = 0x00008000;

	/** Camera subsystem (also implies events). */
	var CAMERA = 0x00010000;

	@:op(A | B) static function or(a:SDLInitFlags, b:SDLInitFlags):SDLInitFlags;

	@:op(A & B) static function and(a:SDLInitFlags, b:SDLInitFlags):SDLInitFlags;

	/**
	 * Checks whether this flag set contains the given flag.
	 *
	 * @param flag The flag to test for.
	 * @return `true` if `flag` is present in this set.
	 */
	public inline function has(flag:SDLInitFlags):Bool
		return (this & flag) != 0;
}

/**
 * Well-known property names accepted by `SDLInit.setAppMetadataProperty`.
 *
 * Each constant is the string key that must be passed to
 * `setAppMetadataProperty()` / `getAppMetadataProperty()`.
 */
class SDLAppMetadataProperty {
	/** Human-readable application name, e.g. `"My Game"`. */
	public static inline var NAME = "SDL.app.metadata.name";

	/** Version string of the application, e.g. `"1.0.0"`. */
	public static inline var VERSION = "SDL.app.metadata.version";

	/** Unique reverse-DNS style identifier, e.g. `"com.example.mygame"`. */
	public static inline var IDENTIFIER = "SDL.app.metadata.identifier";

	/** Name of the developer/company that made the app. */
	public static inline var CREATOR = "SDL.app.metadata.creator";

	/** Copyright notice for the application. */
	public static inline var COPYRIGHT = "SDL.app.metadata.copyright";

	/** URL to the application's homepage. */
	public static inline var URL = "SDL.app.metadata.url";

	/** Application type, e.g. `"game"`, `"mediaplayer"` or `"application"`. */
	public static inline var TYPE = "SDL.app.metadata.type";
}

@:noCompletion
class SDLInitNative {
	@:hlNative("sdl3", "init") public static function init(flags:Int):Bool
		return false;

	@:hlNative("sdl3", "init_subsystem") public static function initSubSystem(flags:Int):Bool
		return false;

	@:hlNative("sdl3", "quit_subsystem") public static function quitSubSystem(flags:Int):Void {}

	@:hlNative("sdl3", "was_init") public static function wasInit(flags:Int):Int
		return 0;

	@:hlNative("sdl3", "quit") public static function quit():Void {}

	@:hlNative("sdl3", "is_main_thread") public static function isMainThread():Bool
		return false;

	@:hlNative("sdl3", "run_on_main_thread") public static function runOnMainThread(id:Int):Bool
		return false;

	@:hlNative("sdl3", "poll_main_thread_callback") public static function pollMainThreadCallback():Int
		return -1;

	@:hlNative("sdl3", "set_app_metadata") public static function setAppMetadata(name:hl.Bytes, version:hl.Bytes, identifier:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "set_app_metadata_property") public static function setAppMetadataProperty(name:hl.Bytes, value:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "get_app_metadata_property") public static function getAppMetadataProperty(name:hl.Bytes):hl.Bytes
		return null;
}

/**
 * Library initialization, shutdown, and application metadata.
 *
 * Call `init` once at startup with the subsystems your application needs,
 * and `quit` before the process exits. Most SDL functions require the
 * relevant subsystem to be initialized first.
 *
 * This class also exposes helpers for running callbacks on the main thread
 * (useful on platforms where certain operations must happen there) and for
 * setting metadata that the OS uses to describe your app (dock name, window
 * title, etc.).
 *
 * Corresponds to the SDL3 init API (`SDL_Init`, `SDL_InitSubSystem`,
 * `SDL_Quit`, `SDL_SetAppMetadata`, and related functions).
 */
class SDLInit {
	static var nextId = 1;
	static var mainThreadCallbacks:Map<Int, Void->Void> = new Map();

	static inline function str(b:hl.Bytes):Null<String>
		@:privateAccess return b == null ? null : String.fromUTF8(b);

	/**
	 * Initializes the given SDL subsystems.
	 *
	 * Subsystems may depend on each other; SDL automatically initializes any
	 * required subsystems. `init` is safe to call multiple times for the same
	 * subsystem: each successful call increments a reference count that must
	 * be balanced by a matching `quitSubSystem` (or a single `quit`).
	 *
	 * @param flags A bitwise OR of the subsystems to initialize.
	 * @return `true` on success, `false` on failure (check `SDLError.get()`).
	 */
	public static function init(flags:SDLInitFlags):Bool
		return SDLInitNative.init(flags);

	/**
	 * Initializes additional SDL subsystems on top of ones already running.
	 *
	 * Prefer this to `init` when SDL is already initialized; it only adds
	 * the subsystems listed in `flags`.
	 *
	 * @param flags A bitwise OR of the subsystems to initialize.
	 * @return `true` on success, `false` on failure.
	 */
	public static function initSubSystem(flags:SDLInitFlags):Bool
		return SDLInitNative.initSubSystem(flags);

	/**
	 * Shuts down the given SDL subsystems.
	 *
	 * Decrements the reference count of each subsystem in `flags`. A subsystem
	 * is only actually shut down when its reference count reaches zero.
	 *
	 * @param flags A bitwise OR of the subsystems to shut down.
	 */
	public static function quitSubSystem(flags:SDLInitFlags):Void
		SDLInitNative.quitSubSystem(flags);

	/**
	 * Returns the subset of the given flags that is currently initialized.
	 *
	 * @param flags A bitwise OR of the subsystems to query.
	 * @return The subset of `flags` that is currently active.
	 */
	public static function wasInit(flags:SDLInitFlags):SDLInitFlags
		return SDLInitNative.wasInit(flags);

	/**
	 * Shuts down every SDL subsystem that was initialized.
	 *
	 * Call this once before your program exits. It is safe to call even if
	 * SDL was never initialized. After this call, you must call `init` again
	 * before using any SDL API.
	 */
	public static function quit():Void
		SDLInitNative.quit();

	/**
	 * Checks whether the calling thread is the SDL "main" thread.
	 *
	 * Some operations (e.g. creating a window or a renderer) are only valid
	 * on the main thread.
	 *
	 * @return `true` if the calling thread is the main thread.
	 */
	public static function isMainThread():Bool
		return SDLInitNative.isMainThread();

	/**
	 * Schedules `callback` to run on the main thread.
	 *
	 * Returns immediately. The callback is not executed synchronously; you
	 * must call `pollMainThreadCallbacks()` (typically once per frame) to
	 * actually run scheduled callbacks.
	 *
	 * @param callback The function to run on the main thread.
	 * @return `true` if the callback was scheduled successfully.
	 */
	public static function runOnMainThread(callback:Void->Void):Bool {
		var id = nextId++;
		mainThreadCallbacks.set(id, callback);
		if (!SDLInitNative.runOnMainThread(id)) {
			mainThreadCallbacks.remove(id);
			return false;
		}
		return true;
	}

	/**
	 * Runs any callbacks scheduled with `runOnMainThread` that are ready.
	 *
	 * Call this regularly (e.g. once per frame) on the main thread.
	 *
	 * @return The number of callbacks that were executed.
	 */
	public static function pollMainThreadCallbacks():Int {
		var n = 0;
		while (true) {
			var id = SDLInitNative.pollMainThreadCallback();
			if (id < 0)
				break;
			var cb = mainThreadCallbacks.get(id);
			mainThreadCallbacks.remove(id);
			if (cb != null)
				cb();
			n++;
		}
		return n;
	}

	/**
	 * Sets basic application metadata.
	 *
	 * Equivalent to setting `NAME`, `VERSION`, and `IDENTIFIER` via
	 * `setAppMetadataProperty`. Call this early — some platforms read this
	 * information when a window is first created.
	 *
	 * @param name       Human-readable application name.
	 * @param version    Version string of the application.
	 * @param identifier Unique reverse-DNS style identifier.
	 * @return `true` on success, `false` on failure.
	 */
	public static function setAppMetadata(name:String, version:String, identifier:String):Bool
		@:privateAccess return SDLInitNative.setAppMetadata(name.toUtf8(), version.toUtf8(), identifier.toUtf8());

	/**
	 * Sets a single application metadata property.
	 *
	 * See `SDLAppMetadataProperty` for the standard property names.
	 *
	 * @param name  The metadata property key.
	 * @param value The value to assign.
	 * @return `true` on success, `false` on failure.
	 */
	public static function setAppMetadataProperty(name:String, value:String):Bool
		@:privateAccess return SDLInitNative.setAppMetadataProperty(name.toUtf8(), value.toUtf8());

	/**
	 * Returns the current value of an application metadata property.
	 *
	 * @param name The metadata property key.
	 * @return The property value, or `null` if it is not set.
	 */
	public static function getAppMetadataProperty(name:String):Null<String>
		@:privateAccess return str(SDLInitNative.getAppMetadataProperty(name.toUtf8()));
}
