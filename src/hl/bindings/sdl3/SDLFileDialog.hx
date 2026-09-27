package hl.bindings.sdl3;

typedef SDLDialogResultPtr = hl.Abstract<"SDL_DialogResult">;

/**
 * The kind of file dialog to display.
 * Corresponds to `SDL_FileDialogType` in SDL3.
 */
enum abstract SDLFileDialogType(Int) from Int to Int {
	/** Open a single file, or multiple files if `allowMany` is set. */
	var OPEN_FILE = 0;

	/** Choose a destination file for saving. */
	var SAVE_FILE = 1;

	/** Choose a directory. */
	var OPEN_FOLDER = 2;
}

/**
 * The outcome of a file dialog.
 * Corresponds to `SDL_DialogResult` in SDL3.
 */
enum abstract SDLDialogStatus(Int) from Int to Int {
	/** The user selected one or more files/folders. */
	var SELECTED = 0;

	/** The user canceled the dialog. */
	var CANCELED = 1;

	/** An error occurred while the dialog was open. */
	var ERROR = 2;
}

/**
 * A single filter entry shown in a file dialog.
 *
 * `pattern` is a semicolon‑separated list of file globs, e.g. `"*.png;*.jpg"`.
 * `name` is the human‑readable label shown to the user, e.g. `"Images"`.
 */
typedef SDLDialogFilter = {
	/** Human-readable name shown to the user, e.g. `"Images"`. */
	name:String,

	/** Semicolon-separated list of file globs, e.g. `"*.png;*.jpg"`. */
	pattern:String
}

/**
 * Optional parameters for a file dialog.
 *
 * All fields are optional; omitted fields use SDL's defaults.
 */
typedef SDLDialogOptions = {
	/** Parent window for the dialog, if any. */
	?window:SDLWindow,

	/** List of file filters. Ignored for `OPEN_FOLDER`. */
	?filters:Array<SDLDialogFilter>,

	/** Initial directory the dialog should start in. */
	?location:String,

	/** If `true`, allow selecting multiple files. Ignored for `SAVE_FILE` and `OPEN_FOLDER`. */
	?allowMany:Bool,

	/** Title shown in the dialog's title bar. */
	?title:String,

	/** Custom label for the accept button. */
	?acceptLabel:String,

	/** Custom label for the cancel button. */
	?cancelLabel:String
}

/**
 * The result of a completed file dialog.
 */
typedef SDLDialogResult = {
	/** Whether the user selected files, canceled, or an error occurred. */
	status:SDLDialogStatus,

	/** The selected file(s) or folder(s). Empty when `status != SELECTED`. */
	files:Array<String>,

	/** Index of the filter that was active, or -1 if none. */
	filter:Int,

	/** Error message if `status == ERROR`; otherwise `null`. */
	error:Null<String>
}

@:noCompletion
class SDLDialogNative {
	@:hlNative("sdl3", "dialog_show") public static function show(type:Int, id:Int, window:SDLWindowPtr, filters:hl.NativeArray<hl.Bytes>, location:hl.Bytes,
		many:Bool, title:hl.Bytes, accept:hl.Bytes, cancel:hl.Bytes):Void {}

	@:hlNative("sdl3", "dialog_poll") public static function poll():SDLDialogResultPtr
		return null;

	@:hlNative("sdl3", "dialog_result_id") public static function resultId(r:SDLDialogResultPtr):Int
		return 0;

	@:hlNative("sdl3", "dialog_result_status") public static function resultStatus(r:SDLDialogResultPtr):Int
		return 0;

	@:hlNative("sdl3", "dialog_result_filter") public static function resultFilter(r:SDLDialogResultPtr):Int
		return 0;

	@:hlNative("sdl3", "dialog_result_error") public static function resultError(r:SDLDialogResultPtr):hl.Bytes
		return null;

	@:hlNative("sdl3", "dialog_result_files") public static function resultFiles(r:SDLDialogResultPtr):hl.NativeArray<hl.Bytes>
		return null;

	@:hlNative("sdl3", "dialog_result_free") public static function resultFree(r:SDLDialogResultPtr):Void {}
}

/**
 * Asynchronous file and folder dialogs.
 *
 * A dialog is shown with `show()` (or one of the convenience wrappers
 * `openFile`, `saveFile`, `openFolder`) and the result is delivered by
 * calling `poll()` regularly. Each call to `poll()` may dispatch the
 * callback of zero or more completed dialogs.
 *
 * The dialog is entirely non‑blocking: it can remain open while your game
 * continues to render. On platforms where native dialogs are unavailable,
 * SDL will fall back to a built‑in dialog implementation.
 *
 * Corresponds to the SDL3 file dialog API (`SDL_ShowOpenFileDialog`,
 * `SDL_ShowSaveFileDialog`, `SDL_ShowOpenFolderDialog`, and the
 * `SDL_DialogResult` machinery).
 */
class SDLFileDialog {
	static var nextId = 1;
	static var pending:Map<Int, SDLDialogResult->Void> = new Map();

	static inline function utf8(s:Null<String>):hl.Bytes
		@:privateAccess return s == null ? null : s.toUtf8();

	/**
	 * Shows a file dialog of the given `type`.
	 *
	 * `cb` is invoked when the dialog closes, from within a subsequent call
	 * to `poll()`. `options` is optional; omitted fields use SDL defaults.
	 *
	 * @param type    One of `OPEN_FILE`, `SAVE_FILE`, or `OPEN_FOLDER`.
	 * @param cb      Callback receiving the dialog result.
	 * @param options Optional dialog configuration.
	 */
	public static function show(type:SDLFileDialogType, cb:SDLDialogResult->Void, ?options:SDLDialogOptions):Void {
		var o:SDLDialogOptions = options != null ? options : {};
		var id = nextId++;
		pending.set(id, cb);

		var filters:hl.NativeArray<hl.Bytes> = null;
		if (o.filters != null && o.filters.length > 0 && type != OPEN_FOLDER) {
			filters = new hl.NativeArray<hl.Bytes>(o.filters.length * 2);

			@:privateAccess
			for (i in 0...o.filters.length) {
				filters[i * 2] = o.filters[i].name.toUtf8();
				filters[i * 2 + 1] = o.filters[i].pattern.toUtf8();
			}
		}

		@:privateAccess
		SDLDialogNative.show(type, id, o.window.ptr, filters, utf8(o.location), o.allowMany == true, utf8(o.title), utf8(o.acceptLabel), utf8(o.cancelLabel));
	}

	/**
	 * Convenience wrapper for `show(OPEN_FILE, ...)`.
	 * Allows selecting one file, or many if `options.allowMany == true`.
	 *
	 * @param cb      Callback receiving the dialog result.
	 * @param options Optional dialog configuration.
	 */
	public static inline function openFile(cb:SDLDialogResult->Void, ?options:SDLDialogOptions):Void
		show(OPEN_FILE, cb, options);

	/**
	 * Convenience wrapper for `show(SAVE_FILE, ...)`.
	 * Allows the user to pick a destination file for saving.
	 *
	 * @param cb      Callback receiving the dialog result.
	 * @param options Optional dialog configuration.
	 */
	public static inline function saveFile(cb:SDLDialogResult->Void, ?options:SDLDialogOptions):Void
		show(SAVE_FILE, cb, options);

	/**
	 * Convenience wrapper for `show(OPEN_FOLDER, ...)`.
	 * Allows selecting a single directory.
	 *
	 * @param cb      Callback receiving the dialog result.
	 * @param options Optional dialog configuration.
	 */
	public static inline function openFolder(cb:SDLDialogResult->Void, ?options:SDLDialogOptions):Void
		show(OPEN_FOLDER, cb, options);

	/**
	 * Processes any completed dialogs and invokes their callbacks.
	 *
	 * Call this regularly (e.g. once per frame) while any dialog is open,
	 * otherwise the result callback will never fire.
	 *
	 * @return The number of dialogs whose callbacks were dispatched.
	 */
	public static function poll():Int {
		var n = 0;
		while (true) {
			var r = SDLDialogNative.poll();
			if (r == null)
				break;
			var id = SDLDialogNative.resultId(r);
			var files = SDLDialogNative.resultFiles(r);
			var err = SDLDialogNative.resultError(r);

			@:privateAccess
			var res:SDLDialogResult = {
				status: SDLDialogNative.resultStatus(r),
				files: files == null ? [] : [for (i in 0...files.length) String.fromUTF8(files[i])],
				filter: SDLDialogNative.resultFilter(r),
				error: err == null ? null : String.fromUTF8(err)
			};
			SDLDialogNative.resultFree(r);

			var cb = pending.get(id);
			pending.remove(id);
			if (cb != null)
				cb(res);
			n++;
		}
		return n;
	}
}
