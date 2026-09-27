package hl.bindings.sdl3;

/**
 * Categories used to group log messages by subsystem.
 *
 * Each category has its own independent priority threshold, which can be set
 * with `SDLLog.setPriority`. `CUSTOM` is the first value that can be used by
 * applications for their own categories.
 *
 * Corresponds to `SDL_LogCategory` in SDL3.
 */
enum abstract SDLLogCategory(Int) from Int to Int {
	/** General application messages. */
	var APPLICATION = 0;

	/** Error messages. */
	var ERROR = 1;

	/** Assertion failures. */
	var ASSERT = 2;

	/** System-level messages (filesystem, threads, etc.). */
	var SYSTEM = 3;

	/** Audio subsystem messages. */
	var AUDIO = 4;

	/** Video subsystem messages. */
	var VIDEO = 5;

	/** Render subsystem messages. */
	var RENDER = 6;

	/** Input subsystem messages. */
	var INPUT = 7;

	/** Messages from the SDL test framework. */
	var TEST = 8;

	/** GPU subsystem messages. */
	var GPU = 9;

	/** First value available for application-defined categories. */
	var CUSTOM = 19;
}

/**
 * Severity of a log message.
 *
 * Messages are only emitted if their priority is at least as high as the
 * threshold configured for their category via `SDLLog.setPriority` /
 * `SDLLog.setPriorities`.
 *
 * Corresponds to `SDL_LogPriority` in SDL3.
 */
enum abstract SDLLogPriority(Int) from Int to Int {
	/** Invalid or unset priority. */
	var INVALID = 0;

	/** Very fine-grained tracing. */
	var TRACE = 1;

	/** Verbose diagnostic output. */
	var VERBOSE = 2;

	/** Debugging information. */
	var DEBUG = 3;

	/** Informational messages. */
	var INFO = 4;

	/** Warnings about recoverable issues. */
	var WARN = 5;

	/** Errors that affect an operation but not the whole app. */
	var ERROR = 6;

	/** Critical errors that may prevent the app from continuing. */
	var CRITICAL = 7;

	/** Number of defined priorities (not a valid priority itself). */
	var COUNT = 8;
}

/**
 * A single log message, delivered to watchers registered with
 * `SDLLog.addWatcher` and dispatched by `SDLLog.poll`.
 */
typedef SDLLogMessage = {
	/** The category the message was logged under. */
	category:Int,

	/** The severity of the message. */
	priority:SDLLogPriority,

	/** The formatted message text. */
	message:String
}

typedef SDLLogEntryPtr = hl.Abstract<"SDLLogEntry">;

@:noCompletion
class SDLLogNative {
	@:hlNative("sdl3", "set_log_priorities") public static function setPriorities(priority:Int):Void {}

	@:hlNative("sdl3", "set_log_priority") public static function setPriority(category:Int, priority:Int):Void {}

	@:hlNative("sdl3", "get_log_priority") public static function getPriority(category:Int):Int
		return 0;

	@:hlNative("sdl3", "reset_log_priorities") public static function resetPriorities():Void {}

	@:hlNative("sdl3", "set_log_priority_prefix") public static function setPriorityPrefix(priority:Int, prefix:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "log") public static function log(message:hl.Bytes):Void {}

	@:hlNative("sdl3", "log_message") public static function logMessage(category:Int, priority:Int, message:hl.Bytes):Void {}

	@:hlNative("sdl3", "start_log_capture") public static function startCapture():Void {}

	@:hlNative("sdl3", "stop_log_capture") public static function stopCapture():Void {}

	@:hlNative("sdl3", "restore_default_log_output") public static function restoreDefaultOutput():Void {}

	@:hlNative("sdl3", "log_capture_poll") public static function pollCapture():SDLLogEntryPtr
		return null;

	@:hlNative("sdl3", "log_entry_category") public static function entryCategory(e:SDLLogEntryPtr):Int
		return 0;

	@:hlNative("sdl3", "log_entry_priority") public static function entryPriority(e:SDLLogEntryPtr):Int
		return 0;

	@:hlNative("sdl3", "log_entry_message") public static function entryMessage(e:SDLLogEntryPtr):hl.Bytes
		return null;

	@:hlNative("sdl3", "log_entry_free") public static function entryFree(e:SDLLogEntryPtr):Void {}
}

/**
 * Logging API.
 *
 * SDL's logger routes messages by category (application, audio, video, ...)
 * and filters them by a per-category priority threshold. By default messages
 * are written to stderr on desktop platforms and to the platform's logging
 * facility (Logcat, os_log, ...) on mobile.
 *
 * Use the `trace` / `verbose` / `debug` / `info` / `warn` / `error` /
 * `critical` helpers to emit messages at a specific priority, or
 * `logMessage` for full control. Use `addWatcher` to intercept log messages
 * from your application (or from SDL itself) and dispatch them to a custom
 * sink such as an in-game console.
 *
 * Corresponds to the SDL3 log API (`SDL_Log`, `SDL_SetLogPriorities`,
 * `SDL_StartTextInput`, `SDL_AddLogOutputFunction`, and related functions).
 */
class SDLLog {
	static var watchers:Array<SDLLogMessage->Void> = [];
	static var capturing = false;

	/**
	 * Sets the same priority threshold for every category at once.
	 *
	 * Messages with a priority lower than `priority` are dropped.
	 *
	 * @param priority The minimum priority to emit for all categories.
	 */
	public static function setPriorities(priority:SDLLogPriority):Void
		SDLLogNative.setPriorities(priority);

	/**
	 * Sets the priority threshold for a single category.
	 *
	 * @param category The category to configure.
	 * @param priority The minimum priority to emit for this category.
	 */
	public static function setPriority(category:SDLLogCategory, priority:SDLLogPriority):Void
		SDLLogNative.setPriority(category, priority);

	/**
	 * Returns the current priority threshold for a category.
	 *
	 * @param category The category to query.
	 * @return The current minimum priority for this category.
	 */
	public static function getPriority(category:SDLLogCategory):SDLLogPriority
		return SDLLogNative.getPriority(category);

	/**
	 * Restores the default priority thresholds for all categories.
	 *
	 * The default threshold is typically `INFO` for most categories.
	 */
	public static function resetPriorities():Void
		SDLLogNative.resetPriorities();

	/**
	 * Overrides the text prefix emitted before messages of a given priority.
	 *
	 * @param priority The priority whose prefix to change.
	 * @param prefix   The new prefix string (e.g. `"[WARN] "`).
	 * @return `true` on success, `false` on failure.
	 */
	public static function setPriorityPrefix(priority:SDLLogPriority, prefix:String):Bool
		@:privateAccess return SDLLogNative.setPriorityPrefix(priority, prefix.toUtf8());

	/**
	 * Logs a message under the `APPLICATION` category at `INFO` priority.
	 *
	 * @param message The message to log.
	 */
	public static function log(message:String):Void
		@:privateAccess SDLLogNative.log(message.toUtf8());

	/**
	 * Logs a message with explicit category and priority.
	 *
	 * @param category The category to log under.
	 * @param priority The severity of the message.
	 * @param message  The message text.
	 */
	public static function logMessage(category:SDLLogCategory, priority:SDLLogPriority, message:String):Void
		@:privateAccess SDLLogNative.logMessage(category, priority, message.toUtf8());

	/**
	 * Logs a message at `TRACE` priority.
	 *
	 * @param category The category to log under.
	 * @param message  The message text.
	 */
	public static function trace(category:SDLLogCategory, message:String):Void
		logMessage(category, TRACE, message);

	/**
	 * Logs a message at `VERBOSE` priority.
	 *
	 * @param category The category to log under.
	 * @param message  The message text.
	 */
	public static function verbose(category:SDLLogCategory, message:String):Void
		logMessage(category, VERBOSE, message);

	/**
	 * Logs a message at `DEBUG` priority.
	 *
	 * @param category The category to log under.
	 * @param message  The message text.
	 */
	public static function debug(category:SDLLogCategory, message:String):Void
		logMessage(category, DEBUG, message);

	/**
	 * Logs a message at `INFO` priority.
	 *
	 * @param category The category to log under.
	 * @param message  The message text.
	 */
	public static function info(category:SDLLogCategory, message:String):Void
		logMessage(category, INFO, message);

	/**
	 * Logs a message at `WARN` priority.
	 *
	 * @param category The category to log under.
	 * @param message  The message text.
	 */
	public static function warn(category:SDLLogCategory, message:String):Void
		logMessage(category, WARN, message);

	/**
	 * Logs a message at `ERROR` priority.
	 *
	 * @param category The category to log under.
	 * @param message  The message text.
	 */
	public static function error(category:SDLLogCategory, message:String):Void
		logMessage(category, ERROR, message);

	/**
	 * Logs a message at `CRITICAL` priority.
	 *
	 * @param category The category to log under.
	 * @param message  The message text.
	 */
	public static function critical(category:SDLLogCategory, message:String):Void
		logMessage(category, CRITICAL, message);

	/**
	 * Registers a callback invoked for every captured log message.
	 *
	 * The first watcher installed implicitly enables log capture (which
	 * replaces SDL's default output). Call `poll()` regularly to dispatch
	 * pending messages to the watchers.
	 *
	 * @param callback The callback to add.
	 */
	public static function addWatcher(callback:SDLLogMessage->Void):Void {
		watchers.push(callback);
		if (!capturing) {
			SDLLogNative.startCapture();
			capturing = true;
		}
	}

	/**
	 * Removes a previously registered log watcher.
	 *
	 * When the last watcher is removed, log capture is disabled and the
	 * default output is restored.
	 *
	 * @param callback The callback to remove.
	 */
	public static function removeWatcher(callback:SDLLogMessage->Void):Void {
		watchers.remove(callback);
		if (watchers.length == 0 && capturing) {
			SDLLogNative.stopCapture();
			capturing = false;
		}
	}

	/**
	 * Restores SDL's default log output and removes all watchers.
	 *
	 * After this call, log messages are written to SDL's default sink again
	 * (stderr on desktop, platform logging on mobile).
	 */
	public static function restoreDefaultOutput():Void {
		SDLLogNative.restoreDefaultOutput();
		capturing = false;
		watchers = [];
	}

	/**
	 * Dispatches any pending captured log messages to the registered watchers.
	 *
	 * Call this regularly (e.g. once per frame) if you use `addWatcher`.
	 *
	 * @return The number of messages dispatched.
	 */
	public static function poll():Int {
		var n = 0;
		while (true) {
			var e = SDLLogNative.pollCapture();
			if (e == null)
				break;

			@:privateAccess
			var msg:SDLLogMessage = {
				category: SDLLogNative.entryCategory(e),
				priority: SDLLogNative.entryPriority(e),
				message: String.fromUTF8(SDLLogNative.entryMessage(e))
			};
			SDLLogNative.entryFree(e);
			for (cb in watchers)
				cb(msg);
			n++;
		}
		return n;
	}
}
