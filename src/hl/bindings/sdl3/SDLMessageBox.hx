package hl.bindings.sdl3;

/**
 * Flags describing the severity and layout of a message box.
 *
 * Combine flags with `|` (via the overloaded `or` operator). Exactly one
 * severity flag should be used; the button-order flags are optional.
 *
 * Corresponds to `SDL_MessageBoxFlags` in SDL3.
 */
enum abstract SDLMessageBoxFlags(Int) from Int to Int {
	/** The message box represents an error. */
	var ERROR = 0x00000010;

	/** The message box represents a warning. */
	var WARNING = 0x00000020;

	/** The message box represents informational content. */
	var INFORMATION = 0x00000040;

	/** Buttons are laid out left-to-right regardless of platform convention. */
	var BUTTONS_LEFT_TO_RIGHT = 0x00000080;

	/** Buttons are laid out right-to-left regardless of platform convention. */
	var BUTTONS_RIGHT_TO_LEFT = 0x00000100;

	@:op(A | B) static function or(a:SDLMessageBoxFlags, b:SDLMessageBoxFlags):SDLMessageBoxFlags;
}

/**
 * Flags that can be attached to a single button in a custom message box.
 *
 * Combine flags with `|` (via the overloaded `or` operator).
 *
 * Corresponds to `SDL_MessageBoxButtonFlags` in SDL3.
 */
enum abstract SDLMessageBoxButtonFlags(Int) from Int to Int {
	/** No special behavior. */
	var NONE = 0x00000000;

	/** This button is the default when the user presses Enter. */
	var RETURNKEY_DEFAULT = 0x00000001;

	/** This button is the default when the user presses Escape. */
	var ESCAPEKEY_DEFAULT = 0x00000002;

	@:op(A | B) static function or(a:SDLMessageBoxButtonFlags, b:SDLMessageBoxButtonFlags):SDLMessageBoxButtonFlags;
}

/**
 * A single button in a custom message box.
 */
typedef SDLMessageBoxButton = {
	/** An application-defined ID returned when the button is clicked. */
	buttonId:Int,

	/** The label shown on the button. */
	text:String,

	/** Optional button behavior flags (e.g. default on Enter/Escape). */
	?flags:SDLMessageBoxButtonFlags
}

/**
 * A single RGB color used in a message box color scheme.
 * Each component is in `[0, 255]`.
 */
typedef SDLMessageBoxColor = {
	/** Red component. */
	r:Int,

	/** Green component. */
	g:Int,

	/** Blue component. */
	b:Int
}

/**
 * A full color scheme for a custom message box.
 *
 * Used by `SDLMessageBox.show` on platforms (or with backends) that allow
 * theming the dialog.
 */
typedef SDLMessageBoxColorScheme = {
	/** Background color of the dialog. */
	background:SDLMessageBoxColor,

	/** Color of the message text. */
	text:SDLMessageBoxColor,

	/** Color of the border around buttons. */
	buttonBorder:SDLMessageBoxColor,

	/** Background color of unselected buttons. */
	buttonBackground:SDLMessageBoxColor,

	/** Color of a button while it is being pressed or hovered. */
	buttonSelected:SDLMessageBoxColor
}

@:noCompletion
class SDLMessageBoxNative {
	@:hlNative("sdl3", "show_simple_message_box") public static function showSimple(flags:Int, title:hl.Bytes, message:hl.Bytes, window:SDLWindowPtr):Bool
		return false;

	@:hlNative("sdl3", "show_message_box") public static function show(flags:Int, window:SDLWindowPtr, title:hl.Bytes, message:hl.Bytes,
			buttonFlags:hl.NativeArray<Int>, buttonIds:hl.NativeArray<Int>, buttonTexts:hl.NativeArray<hl.Bytes>, colors:hl.NativeArray<Int>,
			outButtonId:hl.NativeArray<Int>):Bool
		return false;
}

/**
 * Modal message box dialogs.
 *
 * These dialogs are shown by the platform's native dialog API (if any) or
 * by SDL's built-in fallback. They are **modal and blocking**: the call
 * returns only after the user dismisses the dialog.
 *
 * Prefer the `showError`, `showWarning`, and `showInfo` convenience helpers
 * unless you need to customize buttons, colors, or ordering.
 *
 * Corresponds to `SDL_ShowSimpleMessageBox` and `SDL_ShowMessageBox` in SDL3.
 */
class SDLMessageBox {
	/**
	 * Shows a simple message box with a single dismiss button.
	 *
	 * @param flags  The severity and layout flags (e.g. `ERROR`, `INFORMATION`).
	 * @param title  Title text of the dialog.
	 * @param message Body text of the dialog.
	 * @param window Optional parent window. When provided, the dialog is
	 *               centered over it and typically behaves as a true modal.
	 * @return `true` on success, `false` on failure (check `SDLError.get()`).
	 */
	public static function showSimple(flags:SDLMessageBoxFlags, title:String, message:String, ?window:SDLWindow):Bool
		@:privateAccess return SDLMessageBoxNative.showSimple(flags, title.toUtf8(), message.toUtf8(), window == null ? null : window.ptr);

	/**
	 * Convenience wrapper for `showSimple(ERROR, ...)`.
	 *
	 * @param title   Title of the dialog.
	 * @param message Body text of the dialog.
	 * @param window  Optional parent window.
	 * @return `true` on success, `false` on failure.
	 */
	public static function showError(title:String, message:String, ?window:SDLWindow):Bool
		return showSimple(ERROR, title, message, window);

	/**
	 * Convenience wrapper for `showSimple(WARNING, ...)`.
	 *
	 * @param title   Title of the dialog.
	 * @param message Body text of the dialog.
	 * @param window  Optional parent window.
	 * @return `true` on success, `false` on failure.
	 */
	public static function showWarning(title:String, message:String, ?window:SDLWindow):Bool
		return showSimple(WARNING, title, message, window);

	/**
	 * Convenience wrapper for `showSimple(INFORMATION, ...)`.
	 *
	 * @param title   Title of the dialog.
	 * @param message Body text of the dialog.
	 * @param window  Optional parent window.
	 * @return `true` on success, `false` on failure.
	 */
	public static function showInfo(title:String, message:String, ?window:SDLWindow):Bool
		return showSimple(INFORMATION, title, message, window);

	static function colorsToArray(scheme:Null<SDLMessageBoxColorScheme>):hl.NativeArray<Int> {
		if (scheme == null)
			return null;
		var order = [
			scheme.background,
			scheme.text,
			scheme.buttonBorder,
			scheme.buttonBackground,
			scheme.buttonSelected
		];
		var a = new hl.NativeArray<Int>(15);
		for (i in 0...5) {
			a[i * 3] = order[i].r;
			a[i * 3 + 1] = order[i].g;
			a[i * 3 + 2] = order[i].b;
		}
		return a;
	}

	/**
	 * Shows a modal message box with custom buttons.
	 *
	 * The order in which `buttons` are listed is preserved (subject to the
	 * `BUTTONS_LEFT_TO_RIGHT` / `BUTTONS_RIGHT_TO_LEFT` flags). On platforms
	 * that do not support custom buttons or color schemes, SDL falls back to
	 * its built-in dialog.
	 *
	 * @param flags       Severity and layout flags for the dialog.
	 * @param title       Title text of the dialog.
	 * @param message     Body text of the dialog.
	 * @param buttons     The buttons to display. At least one is required.
	 * @param window      Optional parent window.
	 * @param colorScheme Optional custom color scheme (ignored on platforms
	 *                    that use native dialogs).
	 * @return The `buttonId` of the chosen button, or `null` if the user
	 *         dismissed the dialog without choosing one or an error occurred
	 *         (check `SDLError.get()`).
	 */
	public static function show(flags:SDLMessageBoxFlags, title:String, message:String, buttons:Array<SDLMessageBoxButton>, ?window:SDLWindow,
			?colorScheme:SDLMessageBoxColorScheme):Null<Int> {
		var n = buttons.length;
		var bFlags = new hl.NativeArray<Int>(n);
		var bIds = new hl.NativeArray<Int>(n);
		var bTexts = new hl.NativeArray<hl.Bytes>(n);
		for (i in 0...n) {
			bFlags[i] = buttons[i].flags == null ? 0 : buttons[i].flags;
			bIds[i] = buttons[i].buttonId;
			@:privateAccess bTexts[i] = buttons[i].text.toUtf8();
		}
		var outId = new hl.NativeArray<Int>(1);
		outId[0] = -1;
		@:privateAccess var ok = SDLMessageBoxNative.show(flags, window == null ? null : window.ptr, title.toUtf8(), message.toUtf8(), bFlags, bIds, bTexts,
			colorsToArray(colorScheme), outId);
		if (!ok)
			return null;
		return outId[0];
	}
}
