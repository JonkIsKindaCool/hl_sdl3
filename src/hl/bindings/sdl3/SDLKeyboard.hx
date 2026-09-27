package hl.bindings.sdl3;

/**
 * Bitmask of modifier keys (Shift, Ctrl, Alt, etc.) currently held down.
 *
 * Values can be combined with `|` (via the overloaded `or` operator) and
 * tested with `has()`. A few pre-combined constants (`CTRL`, `SHIFT`, `ALT`,
 * `GUI`) are provided for convenience.
 *
 * Corresponds to `SDL_Keymod` in SDL3.
 */
enum abstract SDLKeymod(Int) from Int to Int {
	/** No modifier is active. */
	var NONE = 0x0000;

	/** Left Shift. */
	var LSHIFT = 0x0001;

	/** Right Shift. */
	var RSHIFT = 0x0002;

	/** Level 5 shift (e.g. AltGr on some layouts). */
	var LEVEL5 = 0x0004;

	/** Left Ctrl. */
	var LCTRL = 0x0040;

	/** Right Ctrl. */
	var RCTRL = 0x0080;

	/** Left Alt. */
	var LALT = 0x0100;

	/** Right Alt (AltGr). */
	var RALT = 0x0200;

	/** Left GUI key (Windows/Command/Super). */
	var LGUI = 0x0400;

	/** Right GUI key (Windows/Command/Super). */
	var RGUI = 0x0800;

	/** Num Lock is on. */
	var NUM = 0x1000;

	/** Caps Lock is on. */
	var CAPS = 0x2000;

	/** Mode key (AltGr on some layouts). */
	var MODE = 0x4000;

	/** Scroll Lock is on. */
	var SCROLL = 0x8000;

	/** Either Ctrl key. */
	var CTRL = 0x0040 | 0x0080;

	/** Either Shift key. */
	var SHIFT = 0x0001 | 0x0002;

	/** Either Alt key. */
	var ALT = 0x0100 | 0x0200;

	/** Either GUI key. */
	var GUI = 0x0400 | 0x0800;

	@:op(A | B) static function or(a:SDLKeymod, b:SDLKeymod):SDLKeymod;

	@:op(A & B) static function and(a:SDLKeymod, b:SDLKeymod):SDLKeymod;

	/**
	 * Checks whether the given modifier bit(s) are set in this flag set.
	 *
	 * @param mod The modifier bit(s) to test for.
	 * @return `true` if all bits in `mod` are set in this value.
	 */
	public inline function has(mod:SDLKeymod):Bool
		return (this & mod) != 0;
}

/**
 * The kind of text expected in a text input field.
 *
 * This is a hint to on-screen keyboards: it does not change the text SDL
 * delivers, it only influences which virtual keyboard layout the OS shows.
 *
 * Corresponds to `SDL_TextInputType` in SDL3.
 */
enum abstract SDLTextInputType(Int) from Int to Int {
	/** Standard text. */
	var TEXT = 0;

	/** A person's name. */
	var TEXT_NAME = 1;

	/** An email address. */
	var TEXT_EMAIL = 2;

	/** A username. */
	var TEXT_USERNAME = 3;

	/** A password, with characters hidden. */
	var TEXT_PASSWORD_HIDDEN = 4;

	/** A password, with characters visible. */
	var TEXT_PASSWORD_VISIBLE = 5;

	/** A numeric value. */
	var NUMBER = 6;

	/** A numeric password, with digits hidden. */
	var NUMBER_PASSWORD_HIDDEN = 7;

	/** A numeric password, with digits visible. */
	var NUMBER_PASSWORD_VISIBLE = 8;
}

/**
 * Auto-capitalization behavior for text input, used as a hint by on-screen
 * keyboards.
 *
 * Corresponds to `SDL_Capitalization` in SDL3.
 */
enum abstract SDLCapitalization(Int) from Int to Int {
	/** No automatic capitalization. */
	var NONE = 0;

	/** Capitalize the first letter of each sentence. */
	var SENTENCES = 1;

	/** Capitalize the first letter of each word. */
	var WORDS = 2;

	/** Capitalize all letters. */
	var LETTERS = 3;
}

/**
 * Options for `SDLKeyboard.startTextInputWithProperties`.
 *
 * Every field is optional; omitted fields fall back to sensible defaults
 * (`TEXT` type, `SENTENCES` capitalization, autocorrect and multiline on).
 */
typedef SDLTextInputOptions = {
	/** The kind of text expected in the field. */
	?type:SDLTextInputType,

	/** Auto-capitalization behavior. */
	?capitalization:SDLCapitalization,

	/** Whether the on-screen keyboard should autocorrect. */
	?autocorrect:Bool,

	/** Whether the field accepts multiple lines of text. */
	?multiline:Bool,

	/** Platform-specific Android input type flags. Set to -1 to leave the default. */
	?androidInputType:Int
}

/**
 * The on-screen rectangle reserved for text input, plus the cursor offset
 * within it. Set with `SDLKeyboard.setTextInputArea`; used to position IME
 * candidate windows and on-screen keyboards.
 */
typedef SDLTextInputArea = {
	/** X coordinate of the top-left corner of the text input area. */
	x:Int,

	/** Y coordinate of the top-left corner of the text input area. */
	y:Int,

	/** Width of the text input area. */
	w:Int,

	/** Height of the text input area. */
	h:Int,

	/** Byte offset of the cursor within the text being edited. */
	cursor:Int
}

@:noCompletion
class SDLKeyboardNative {
	@:hlNative("sdl3", "has_keyboard") public static function hasKeyboard():Bool
		return false;

	@:hlNative("sdl3", "get_keyboards") public static function getKeyboards():hl.NativeArray<Int>
		return null;

	@:hlNative("sdl3", "get_keyboard_name_for_id") public static function nameForId(id:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_keyboard_focus") public static function getFocus():SDLWindowPtr
		return null;

	@:hlNative("sdl3", "get_keyboard_state") public static function getState():hl.NativeArray<Int>
		return null;

	@:hlNative("sdl3", "reset_keyboard") public static function reset():Void {}

	@:hlNative("sdl3", "get_mod_state") public static function getModState():Int
		return 0;

	@:hlNative("sdl3", "set_mod_state") public static function setModState(modstate:Int):Void {}

	@:hlNative("sdl3", "get_key_from_scancode") public static function keyFromScancode(scancode:Int, modstate:Int, keyEvent:Bool):Int
		return 0;

	@:hlNative("sdl3", "get_scancode_from_key") public static function scancodeFromKey(key:Int, outMod:hl.NativeArray<Int>):Int
		return 0;

	@:hlNative("sdl3", "set_scancode_name") public static function setScancodeName(scancode:Int, name:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "get_scancode_name") public static function getScancodeName(scancode:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_scancode_from_name") public static function scancodeFromName(name:hl.Bytes):Int
		return 0;

	@:hlNative("sdl3", "get_key_name") public static function getKeyName(key:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_key_from_name") public static function keyFromName(name:hl.Bytes):Int
		return 0;

	@:hlNative("sdl3", "start_text_input") public static function startTextInput(window:SDLWindowPtr):Bool
		return false;

	@:hlNative("sdl3", "start_text_input_with_properties") public static function startTextInputWithProperties(window:SDLWindowPtr, type:Int,
			capitalization:Int, autocorrect:Bool, multiline:Bool, androidInputType:Int):Bool
		return false;

	@:hlNative("sdl3", "text_input_active") public static function textInputActive(window:SDLWindowPtr):Bool
		return false;

	@:hlNative("sdl3", "stop_text_input") public static function stopTextInput(window:SDLWindowPtr):Bool
		return false;

	@:hlNative("sdl3", "clear_composition") public static function clearComposition(window:SDLWindowPtr):Bool
		return false;

	@:hlNative("sdl3", "set_text_input_area") public static function setTextInputArea(window:SDLWindowPtr, x:Int, y:Int, w:Int, h:Int, cursor:Int):Bool
		return false;

	@:hlNative("sdl3", "get_text_input_area") public static function getTextInputArea(window:SDLWindowPtr, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "has_screen_keyboard_support") public static function hasScreenKeyboardSupport():Bool
		return false;

	@:hlNative("sdl3", "screen_keyboard_shown") public static function screenKeyboardShown(window:SDLWindowPtr):Bool
		return false;
}

/**
 * Static keyboard input API.
 *
 * Provides device enumeration, key state queries (both by scancode and
 * keycode), scancode/keycode translation helpers, and the text input /
 * IME control functions used with on-screen keyboards.
 *
 * Corresponds to the SDL3 keyboard subsystem.
 */
class SDLKeyboard {
	static inline function str(b:hl.Bytes):Null<String>
		@:privateAccess return b == null ? null : String.fromUTF8(b);

	/**
	 * Checks whether at least one keyboard is currently connected.
	 *
	 * @return `true` if any keyboard is available.
	 */
	public static function hasKeyboard():Bool
		return SDLKeyboardNative.hasKeyboard();

	/**
	 * Returns the instance IDs of all currently connected keyboards.
	 *
	 * @return An array of keyboard instance IDs.
	 */
	public static function getKeyboards():Array<Int> {
		var a = SDLKeyboardNative.getKeyboards();
		return a == null ? [] : [for (i in 0...a.length) a[i]];
	}

	/**
	 * Returns the human-readable name of a keyboard.
	 *
	 * @param id The keyboard instance ID.
	 * @return The name, or `null` if the ID is not valid.
	 */
	public static function getNameForId(id:Int):Null<String>
		return str(SDLKeyboardNative.nameForId(id));

	/**
	 * Returns the window that currently has keyboard focus.
	 *
	 * @return The focused window, or `null` if no window has keyboard focus.
	 */
	public static function getFocus():Null<SDLWindow> {
		var p = SDLKeyboardNative.getFocus();
		return p == null ? null : @:privateAccess new SDLWindow(p);
	}

	/**
	 * Returns the full keyboard state as an array indexed by scancode.
	 *
	 * Index `i` is `true` if the key whose scancode is `i` is currently
	 * pressed. The array length is implementation-defined (typically around
	 * 512 entries).
	 *
	 * @return The keyboard state array.
	 */
	public static function getState():Array<Bool> {
		var a = SDLKeyboardNative.getState();
		return a == null ? [] : [for (i in 0...a.length) a[i] != 0];
	}

	/**
	 * Checks whether the key with the given scancode is currently pressed.
	 *
	 * This is a convenience wrapper around `getState()`; if you need to
	 * query many keys per frame, call `getState()` once and reuse the result.
	 *
	 * @param scancode The scancode of the key to query.
	 * @return `true` if the key is currently pressed.
	 */
	public static function isPressed(scancode:Int):Bool {
		var a = SDLKeyboardNative.getState();
		return a != null && scancode >= 0 && scancode < a.length && a[scancode] != 0;
	}

	/**
	 * Clears the internal keyboard state, as if every key were released.
	 *
	 * Useful when your application loses focus and you want to discard any
	 * keys that were held at that moment.
	 */
	public static function reset():Void
		SDLKeyboardNative.reset();

	/**
	 * Returns the currently active modifier key state.
	 *
	 * @return A bitmask of active modifier keys.
	 */
	public static function getModState():SDLKeymod
		return SDLKeyboardNative.getModState();

	/**
	 * Overrides the current modifier key state without generating key events.
	 *
	 * Rarely needed; primarily used by remote-desktop or automation tools.
	 *
	 * @param modstate The new modifier state to apply.
	 */
	public static function setModState(modstate:SDLKeymod):Void
		SDLKeyboardNative.setModState(modstate);

	/**
	 * Converts a scancode (physical key) to a keycode (logical key).
	 *
	 * The result depends on the current keyboard layout and on the modifiers
	 * supplied in `modstate`.
	 *
	 * @param scancode The scancode to convert.
	 * @param modstate Active modifier keys.
	 * @param keyEvent If `true`, treat `scancode` as coming from an event
	 *                 (this affects certain layout-dependent keys).
	 * @return The corresponding keycode.
	 */
	public static function getKeyFromScancode(scancode:Int, modstate:SDLKeymod = NONE, keyEvent:Bool = false):Int
		return SDLKeyboardNative.keyFromScancode(scancode, modstate, keyEvent);

	/**
	 * Converts a keycode (logical key) to the scancode and modifier state
	 * that would produce it on the current layout.
	 *
	 * @param key The keycode to convert.
	 * @return An object with the `scancode` and the required `mod` state.
	 */
	public static function getScancodeFromKey(key:Int):{scancode:Int, mod:SDLKeymod} {
		var o = new hl.NativeArray<Int>(1);
		var scancode = SDLKeyboardNative.scancodeFromKey(key, o);
		return {scancode: scancode, mod: o[0]};
	}

	/**
	 * Overrides the human-readable name reported for a scancode.
	 *
	 * Mostly useful for re-branding keys on virtual keyboards.
	 *
	 * @param scancode The scancode whose name to set.
	 * @param name     The new name.
	 * @return `true` on success, `false` on failure.
	 */
	public static function setScancodeName(scancode:Int, name:String):Bool
		@:privateAccess return SDLKeyboardNative.setScancodeName(scancode, name.toUtf8());

	/**
	 * Returns the human-readable name for a scancode (e.g. `"A"`, `"Left"`).
	 *
	 * @param scancode The scancode to look up.
	 * @return The name, or `null` if the scancode is invalid.
	 */
	public static function getScancodeName(scancode:Int):Null<String>
		return str(SDLKeyboardNative.getScancodeName(scancode));

	/**
	 * Looks up a scancode by its human-readable name.
	 *
	 * @param name The name to search for (e.g. `"A"`, `"Left"`).
	 * @return The matching scancode, or -1 if not found.
	 */
	public static function getScancodeFromName(name:String):Int
		@:privateAccess return SDLKeyboardNative.scancodeFromName(name.toUtf8());

	/**
	 * Returns the human-readable name for a keycode.
	 *
	 * Unlike scancodes, keycodes depend on the active keyboard layout.
	 *
	 * @param key The keycode to look up.
	 * @return The name, or `null` if the keycode is invalid.
	 */
	public static function getKeyName(key:Int):Null<String>
		return str(SDLKeyboardNative.getKeyName(key));

	/**
	 * Looks up a keycode by its human-readable name.
	 *
	 * @param name The name to search for.
	 * @return The matching keycode, or -1 if not found.
	 */
	public static function getKeyFromName(name:String):Int
		@:privateAccess return SDLKeyboardNative.keyFromName(name.toUtf8());

	/**
	 * Starts accepting text input (and IME composition) for `window`.
	 *
	 * After this call, SDL will deliver `TEXT_INPUT` and `TEXT_EDITING`
	 * events for the window. Stop it with `stopTextInput()`.
	 *
	 * @param window The window that should receive text input.
	 * @return `true` on success, `false` on failure.
	 */
	public static function startTextInput(window:SDLWindow):Bool
		return SDLKeyboardNative.startTextInput(@:privateAccess window.ptr);

	/**
	 * Like `startTextInput()`, but with extra hints for the platform's
	 * on-screen keyboard (input type, capitalization, autocorrect, etc.).
	 *
	 * All options are optional; unspecified fields use sensible defaults
	 * (`TEXT` type, `SENTENCES` capitalization, autocorrect and multiline on).
	 *
	 * @param window  The window that should receive text input.
	 * @param options Optional hints for the on-screen keyboard.
	 * @return `true` on success, `false` on failure.
	 */
	public static function startTextInputWithProperties(window:SDLWindow, ?options:SDLTextInputOptions):Bool {
		var o:SDLTextInputOptions = options != null ? options : {};
		return SDLKeyboardNative.startTextInputWithProperties(@:privateAccess window.ptr, o.type == null ? TEXT : o.type,
			o.capitalization == null ? SENTENCES : o.capitalization, o.autocorrect == null ? true : o.autocorrect, o.multiline == null ? true : o.multiline,
			o.androidInputType == null ? -1 : o.androidInputType);
	}

	/**
	 * Checks whether text input is currently active for `window`.
	 *
	 * @param window The window to query.
	 * @return `true` if text input is active.
	 */
	public static function textInputActive(window:SDLWindow):Bool
		return SDLKeyboardNative.textInputActive(@:privateAccess window.ptr);

	/**
	 * Stops accepting text input for `window`.
	 *
	 * @param window The window to stop receiving text input.
	 * @return `true` on success, `false` on failure.
	 */
	public static function stopTextInput(window:SDLWindow):Bool
		return SDLKeyboardNative.stopTextInput(@:privateAccess window.ptr);

	/**
	 * Dismisses the current IME composition, if any, without committing it.
	 *
	 * @param window The window whose composition should be cleared.
	 * @return `true` on success, `false` on failure.
	 */
	public static function clearComposition(window:SDLWindow):Bool
		return SDLKeyboardNative.clearComposition(@:privateAccess window.ptr);

	/**
	 * Sets the on-screen rectangle (and cursor offset) reserved for text input.
	 *
	 * The platform uses this to position IME candidate windows and, where
	 * available, the on-screen keyboard.
	 *
	 * @param window The window to configure.
	 * @param x      X coordinate of the top-left corner of the text input area.
	 * @param y      Y coordinate of the top-left corner of the text input area.
	 * @param w      Width of the text input area.
	 * @param h      Height of the text input area.
	 * @param cursor Byte offset of the cursor within the text being edited.
	 * @return `true` on success, `false` on failure.
	 */
	public static function setTextInputArea(window:SDLWindow, x:Int, y:Int, w:Int, h:Int, cursor:Int = 0):Bool
		return SDLKeyboardNative.setTextInputArea(@:privateAccess window.ptr, x, y, w, h, cursor);

	/**
	 * Returns the text input area previously set for `window`.
	 *
	 * @param window The window to query.
	 * @return The configured area, or `null` on failure.
	 */
	public static function getTextInputArea(window:SDLWindow):Null<SDLTextInputArea> {
		var o = new hl.NativeArray<Int>(5);
		if (!SDLKeyboardNative.getTextInputArea(@:privateAccess window.ptr, o))
			return null;
		return {
			x: o[0],
			y: o[1],
			w: o[2],
			h: o[3],
			cursor: o[4]
		};
	}

	/**
	 * Checks whether the current platform has an on-screen keyboard.
	 *
	 * @return `true` if on-screen keyboards are supported.
	 */
	public static function hasScreenKeyboardSupport():Bool
		return SDLKeyboardNative.hasScreenKeyboardSupport();

	/**
	 * Checks whether the on-screen keyboard is currently shown for `window`.
	 *
	 * @param window The window to query.
	 * @return `true` if the on-screen keyboard is visible.
	 */
	public static function screenKeyboardShown(window:SDLWindow):Bool
		return SDLKeyboardNative.screenKeyboardShown(@:privateAccess window.ptr);
}
