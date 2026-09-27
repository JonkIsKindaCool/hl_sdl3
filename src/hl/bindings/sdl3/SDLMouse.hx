package hl.bindings.sdl3;

typedef SDLCursorPtr = hl.Abstract<"SDL_Cursor">;
typedef SDLCursorAnimBuilderPtr = hl.Abstract<"SDLCursorAnimBuilder">;

/**
 * Identifiers for OS-provided cursor shapes.
 *
 * Used with `SDLMouse.createSystemCursor` to build a cursor that matches
 * the platform's native appearance.
 *
 * Corresponds to `SDL_SystemCursor` in SDL3.
 */
enum abstract SDLSystemCursor(Int) from Int to Int {
	/** The platform's default arrow cursor. */
	var DEFAULT = 0;

	/** An I-beam, typically used over text. */
	var TEXT = 1;

	/** A busy/wait indicator. */
	var WAIT = 2;

	/** A crosshair. */
	var CROSSHAIR = 3;

	/** A progress indicator (arrow + busy). */
	var PROGRESS = 4;

	/** Diagonal resize cursor (top-left / bottom-right). */
	var NWSE_RESIZE = 5;

	/** Diagonal resize cursor (top-right / bottom-left). */
	var NESW_RESIZE = 6;

	/** Horizontal resize cursor. */
	var EW_RESIZE = 7;

	/** Vertical resize cursor. */
	var NS_RESIZE = 8;

	/** Move cursor. */
	var MOVE = 9;

	/** A "not allowed" cursor. */
	var NOT_ALLOWED = 10;

	/** A pointing-hand cursor. */
	var POINTER = 11;

	/** Diagonal resize cursor (north-west). */
	var NW_RESIZE = 12;

	/** Vertical resize cursor (north). */
	var N_RESIZE = 13;

	/** Diagonal resize cursor (north-east). */
	var NE_RESIZE = 14;

	/** Horizontal resize cursor (east). */
	var E_RESIZE = 15;

	/** Diagonal resize cursor (south-east). */
	var SE_RESIZE = 16;

	/** Vertical resize cursor (south). */
	var S_RESIZE = 17;

	/** Diagonal resize cursor (south-west). */
	var SW_RESIZE = 18;

	/** Horizontal resize cursor (west). */
	var W_RESIZE = 19;

	/** Total number of system cursors (not a valid cursor ID). */
	var COUNT = 20;
}

/**
 * Whether a mouse wheel event's direction is natural or flipped.
 *
 * Some platforms invert wheel direction based on the user's "natural
 * scrolling" preference; SDL reports this so applications can decide
 * whether to apply the same inversion to their own scrolling.
 *
 * Corresponds to `SDL_MouseWheelDirection` in SDL3.
 */
enum abstract SDLMouseWheelDirection(Int) from Int to Int {
	/** The wheel scrolled in the normal (non-inverted) direction. */
	var NORMAL = 0;

	/** The wheel scrolled in the inverted ("natural scrolling") direction. */
	var FLIPPED = 1;
}

/**
 * Identifies a physical mouse button.
 *
 * Corresponds to `SDL_BUTTON_*` constants in SDL3.
 */
enum abstract SDLMouseButton(Int) from Int to Int {
	/** Primary (usually left) button. */
	var LEFT = 1;

	/** Middle button. */
	var MIDDLE = 2;

	/** Secondary (usually right) button. */
	var RIGHT = 3;

	/** First extra (side) button. */
	var X1 = 4;

	/** Second extra (side) button. */
	var X2 = 5;
}

/**
 * A bitmask of currently pressed mouse buttons.
 *
 * Returned by `SDLMouse.getState()` and friends. Test individual buttons
 * with `has()`, and combine flags with the overloaded `|` operator.
 */
enum abstract SDLMouseButtonFlags(Int) from Int to Int {
	/** No buttons are pressed. */
	var NONE = 0;

	@:op(A | B) static function or(a:SDLMouseButtonFlags, b:SDLMouseButtonFlags):SDLMouseButtonFlags;

	/**
	 * Checks whether a given button is currently pressed in this flag set.
	 *
	 * @param button The button to test for.
	 * @return `true` if the button is currently pressed.
	 */
	public inline function has(button:SDLMouseButton):Bool
		return (this & (1 << (button - 1))) != 0;
}

/**
 * Mouse position and currently pressed buttons.
 *
 * Returned by `SDLMouse.getState()`, `getGlobalState()`, and
 * `getRelativeState()`.
 */
typedef SDLMouseState = {
	/** X coordinate, in window-relative or desktop coordinates depending on the call. */
	x:Float,

	/** Y coordinate, in window-relative or desktop coordinates depending on the call. */
	y:Float,

	/** Bitmask of currently pressed buttons. */
	buttons:SDLMouseButtonFlags
}

@:noCompletion
class SDLMouseNative {
	@:hlNative("sdl3", "has_mouse") public static function hasMouse():Bool
		return false;

	@:hlNative("sdl3", "get_mice") public static function getMice():hl.NativeArray<Int>
		return null;

	@:hlNative("sdl3", "get_mouse_name_for_id") public static function nameForId(id:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_mouse_focus") public static function getFocus():SDLWindowPtr
		return null;

	@:hlNative("sdl3", "get_mouse_state") public static function getState(out:hl.NativeArray<Float>):Int
		return 0;

	@:hlNative("sdl3", "get_global_mouse_state") public static function getGlobalState(out:hl.NativeArray<Float>):Int
		return 0;

	@:hlNative("sdl3", "get_relative_mouse_state") public static function getRelativeState(out:hl.NativeArray<Float>):Int
		return 0;

	@:hlNative("sdl3", "warp_mouse_in_window") public static function warpInWindow(window:SDLWindowPtr, x:Float, y:Float):Void {}

	@:hlNative("sdl3", "warp_mouse_global") public static function warpGlobal(x:Float, y:Float):Bool
		return false;

	@:hlNative("sdl3", "set_window_relative_mouse_mode") public static function setRelativeMouseMode(window:SDLWindowPtr, enabled:Bool):Bool
		return false;

	@:hlNative("sdl3", "get_window_relative_mouse_mode") public static function getRelativeMouseMode(window:SDLWindowPtr):Bool
		return false;

	@:hlNative("sdl3", "capture_mouse") public static function captureMouse(enabled:Bool):Bool
		return false;

	@:hlNative("sdl3", "create_cursor") public static function createCursor(data:hl.Bytes, mask:hl.Bytes, w:Int, h:Int, hotX:Int, hotY:Int):SDLCursorPtr
		return null;

	@:hlNative("sdl3", "create_color_cursor") public static function createColorCursor(surface:SDLSurfacePtr, hotX:Int, hotY:Int):SDLCursorPtr
		return null;

	@:hlNative("sdl3", "create_system_cursor") public static function createSystemCursor(id:Int):SDLCursorPtr
		return null;

	@:hlNative("sdl3", "set_cursor") public static function setCursor(cursor:SDLCursorPtr):Bool
		return false;

	@:hlNative("sdl3", "get_cursor") public static function getCursor():SDLCursorPtr
		return null;

	@:hlNative("sdl3", "get_default_cursor") public static function getDefaultCursor():SDLCursorPtr
		return null;

	@:hlNative("sdl3", "destroy_cursor") public static function destroyCursor(cursor:SDLCursorPtr):Void {}

	@:hlNative("sdl3", "show_cursor") public static function showCursor():Bool
		return false;

	@:hlNative("sdl3", "hide_cursor") public static function hideCursor():Bool
		return false;

	@:hlNative("sdl3", "cursor_visible") public static function cursorVisible():Bool
		return false;

	@:hlNative("sdl3", "cursor_anim_begin") public static function animBegin():SDLCursorAnimBuilderPtr
		return null;

	@:hlNative("sdl3", "cursor_anim_add_frame") public static function animAddFrame(b:SDLCursorAnimBuilderPtr, surface:SDLSurfacePtr, durationMs:Int):Void {}

	@:hlNative("sdl3", "cursor_anim_create") public static function animCreate(b:SDLCursorAnimBuilderPtr, hotX:Int, hotY:Int):SDLCursorPtr
		return null;

	@:hlNative("sdl3", "cursor_anim_cancel") public static function animCancel(b:SDLCursorAnimBuilderPtr):Void {}
}

/**
 * Static mouse input API.
 *
 * Provides device enumeration, cursor position queries (window-relative,
 * global, or relative-delta), pointer warping, relative mode, mouse capture,
 * and creation of custom cursors.
 *
 * Corresponds to the SDL3 mouse subsystem.
 */
@:access(String)
class SDLMouse {
	static inline function str(b:hl.Bytes):Null<String>
		return b == null ? null : String.fromUTF8(b);

	/**
	 * Checks whether at least one mouse is currently connected.
	 *
	 * @return `true` if any mouse is available.
	 */
	public static function hasMouse():Bool
		return SDLMouseNative.hasMouse();

	/**
	 * Returns the instance IDs of all currently connected mice.
	 *
	 * @return An array of mouse instance IDs.
	 */
	public static function getMice():Array<Int> {
		var a = SDLMouseNative.getMice();
		return a == null ? [] : [for (i in 0...a.length) a[i]];
	}

	/**
	 * Returns the human-readable name of a mouse.
	 *
	 * @param id The mouse instance ID.
	 * @return The name, or `null` if the ID is not valid.
	 */
	public static function getNameForId(id:Int):Null<String>
		return str(SDLMouseNative.nameForId(id));

	/**
	 * Returns the window that currently has mouse focus.
	 *
	 * @return The focused window, or `null` if no window has mouse focus.
	 */
	public static function getFocus():Null<SDLWindow> {
		var p = SDLMouseNative.getFocus();
		return p == null ? null : @:privateAccess new SDLWindow(p);
	}

	static function readState(a:hl.NativeArray<Float>, flags:Int):SDLMouseState
		return {x: a[0], y: a[1], buttons: flags};

	/**
	 * Returns the mouse position relative to the focused window.
	 *
	 * @return A `SDLMouseState` with window-relative coordinates.
	 */
	public static function getState():SDLMouseState {
		var o = new hl.NativeArray<Float>(2);
		var flags = SDLMouseNative.getState(o);
		return readState(o, flags);
	}

	/**
	 * Returns the mouse position in absolute desktop coordinates.
	 *
	 * The coordinates span all monitors and are unaffected by window
	 * positions.
	 *
	 * @return A `SDLMouseState` with desktop coordinates.
	 */
	public static function getGlobalState():SDLMouseState {
		var o = new hl.NativeArray<Float>(2);
		var flags = SDLMouseNative.getGlobalState(o);
		return readState(o, flags);
	}

	/**
	 * Returns the mouse movement accumulated since the last call.
	 *
	 * Useful in relative mode (see `setRelativeMouseMode`), where the `x`/`y`
	 * fields hold deltas rather than absolute positions.
	 *
	 * @return A `SDLMouseState` with relative deltas.
	 */
	public static function getRelativeState():SDLMouseState {
		var o = new hl.NativeArray<Float>(2);
		var flags = SDLMouseNative.getRelativeState(o);
		return readState(o, flags);
	}

	/**
	 * Moves the mouse cursor to `(x, y)` relative to `window`.
	 *
	 * Ignored if the platform does not support warping, or if the window is
	 * not focused.
	 *
	 * @param window The window to warp within.
	 * @param x      The new X coordinate, relative to the window.
	 * @param y      The new Y coordinate, relative to the window.
	 */
	public static function warpInWindow(window:SDLWindow, x:Float, y:Float):Void
		SDLMouseNative.warpInWindow(@:privateAccess window.ptr, x, y);

	/**
	 * Moves the mouse cursor to `(x, y)` in absolute desktop coordinates.
	 *
	 * @param x The new X coordinate, in desktop coordinates.
	 * @param y The new Y coordinate, in desktop coordinates.
	 * @return `true` on success, `false` if warping is not supported.
	 */
	public static function warpGlobal(x:Float, y:Float):Bool
		return SDLMouseNative.warpGlobal(x, y);

	/**
	 * Enables or disables relative mouse mode for a window.
	 *
	 * In relative mode the mouse cursor is hidden and confined to the window,
	 * and only movement deltas are reported (via `getRelativeState()` and the
	 * `xrel`/`yrel` fields of `MOUSE_MOTION` events). This is the standard
	 * setup for first-person camera controls.
	 *
	 * @param window  The window to configure.
	 * @param enabled `true` to enable relative mode.
	 * @return `true` on success, `false` on failure.
	 */
	public static function setRelativeMouseMode(window:SDLWindow, enabled:Bool):Bool
		return SDLMouseNative.setRelativeMouseMode(@:privateAccess window.ptr, enabled);

	/**
	 * Returns whether relative mouse mode is currently enabled for a window.
	 *
	 * @param window The window to query.
	 * @return `true` if relative mode is enabled.
	 */
	public static function getRelativeMouseMode(window:SDLWindow):Bool
		return SDLMouseNative.getRelativeMouseMode(@:privateAccess window.ptr);

	/**
	 * Enables or disables mouse capture.
	 *
	 * While captured, mouse events continue to be delivered even when the
	 * pointer leaves the window. This is useful for drag operations that
	 * should not be interrupted.
	 *
	 * @param enabled `true` to capture the mouse.
	 * @return `true` on success, `false` on failure.
	 */
	public static function captureMouse(enabled:Bool):Bool
		return SDLMouseNative.captureMouse(enabled);

	/**
	 * Creates a monochrome cursor from 1-bit-per-pixel bitmaps.
	 *
	 * `data` is the AND mask (pixels that survive), `mask` is the XOR mask
	 * (pixels that get inverted). Both must be `w * h / 8` bytes long.
	 *
	 * @param data The AND mask bitmap.
	 * @param mask The XOR mask bitmap.
	 * @param w    Width in pixels; must be a multiple of 8.
	 * @param h    Height in pixels.
	 * @param hotX X coordinate of the click point within the cursor.
	 * @param hotY Y coordinate of the click point within the cursor.
	 * @return A new cursor, or `null` on failure.
	 */
	public static function createCursor(data:haxe.io.Bytes, mask:haxe.io.Bytes, w:Int, h:Int, hotX:Int, hotY:Int):Null<SDLCursor> {
		var p = SDLMouseNative.createCursor(hl.Bytes.fromBytes(data), hl.Bytes.fromBytes(mask), w, h, hotX, hotY);
		return p == null ? null : new SDLCursor(p);
	}

	/**
	 * Creates a color cursor from a surface.
	 *
	 * @param surface The surface containing the cursor image.
	 * @param hotX    X coordinate of the click point within the cursor.
	 * @param hotY    Y coordinate of the click point within the cursor.
	 * @return A new cursor, or `null` on failure.
	 */
	public static function createColorCursor(surface:SDLSurface, hotX:Int, hotY:Int):Null<SDLCursor> {
		var p = SDLMouseNative.createColorCursor(@:privateAccess surface.ptr, hotX, hotY);
		return p == null ? null : new SDLCursor(p);
	}

	/**
	 * Creates a cursor using one of the OS's built-in shapes.
	 *
	 * @param id The system cursor shape to use.
	 * @return A new cursor, or `null` on failure.
	 */
	public static function createSystemCursor(id:SDLSystemCursor):Null<SDLCursor> {
		var p = SDLMouseNative.createSystemCursor(id);
		return p == null ? null : new SDLCursor(p);
	}

	/**
	 * Creates an animated cursor from a list of (surface, duration) frames.
	 *
	 * A `durationMs` of 0 on a frame stops the animation on that frame. If
	 * the platform does not support animated cursors, SDL falls back to a
	 * static color cursor built from the first frame.
	 *
	 * @param frames An array of `{surface, durationMs}` entries, in order.
	 * @param hotX   X coordinate of the click point within the cursor.
	 * @param hotY   Y coordinate of the click point within the cursor.
	 * @return A new cursor, or `null` on failure.
	 */
	public static function createAnimatedCursor(frames:Array<{surface:SDLSurface, durationMs:Int}>, hotX:Int, hotY:Int):Null<SDLCursor> {
		var b = SDLMouseNative.animBegin();
		for (f in frames)
			SDLMouseNative.animAddFrame(b, @:privateAccess f.surface.ptr, f.durationMs);
		var p = SDLMouseNative.animCreate(b, hotX, hotY);
		return p == null ? null : new SDLCursor(p);
	}

	/**
	 * Sets the active mouse cursor.
	 *
	 * Passing `null` restores the default system cursor.
	 *
	 * @param cursor The cursor to activate, or `null` for the default.
	 * @return `true` on success, `false` on failure.
	 */
	public static function setCursor(cursor:Null<SDLCursor>):Bool
		return SDLMouseNative.setCursor(cursor == null ? null : @:privateAccess cursor.ptr);

	/**
	 * Returns the currently active cursor.
	 *
	 * @return The active cursor, or `null` if none is set.
	 */
	public static function getCursor():Null<SDLCursor> {
		var p = SDLMouseNative.getCursor();
		return p == null ? null : new SDLCursor(p);
	}

	/**
	 * Returns the default system cursor.
	 *
	 * @return The default cursor, or `null` on failure.
	 */
	public static function getDefaultCursor():Null<SDLCursor> {
		var p = SDLMouseNative.getDefaultCursor();
		return p == null ? null : new SDLCursor(p);
	}

	/**
	 * Shows the mouse cursor.
	 *
	 * @return `true` on success, `false` on failure.
	 */
	public static function showCursor():Bool
		return SDLMouseNative.showCursor();

	/**
	 * Hides the mouse cursor.
	 *
	 * @return `true` on success, `false` on failure.
	 */
	public static function hideCursor():Bool
		return SDLMouseNative.hideCursor();

	/**
	 * Checks whether the mouse cursor is currently visible.
	 *
	 * @return `true` if the cursor is visible.
	 */
	public static function cursorVisible():Bool
		return SDLMouseNative.cursorVisible();
}

/**
 * A mouse cursor shape.
 *
 * Created with one of `SDLMouse.createCursor`, `createColorCursor`,
 * `createSystemCursor`, or `createAnimatedCursor`. Call `destroy()` when
 * done with it, or `use()` to make it the active cursor.
 *
 * Corresponds to `SDL_Cursor` in SDL3.
 */
class SDLCursor {
	var ptr:SDLCursorPtr;

	@:allow(hl.bindings.sdl3)
	function new(ptr:SDLCursorPtr)
		this.ptr = ptr;

	/**
	 * Makes this cursor the active mouse cursor.
	 *
	 * @return `true` on success, `false` on failure.
	 */
	public function use():Bool
		return SDLMouseNative.setCursor(ptr);

	/**
	 * Destroys the cursor and releases its resources.
	 *
	 * Safe to call multiple times; the instance becomes unusable afterwards.
	 * Do not destroy a cursor while it is the active cursor — set another
	 * cursor first (or call `SDLMouse.setCursor(null)`).
	 */
	public function destroy():Void {
		if (ptr != null)
			SDLMouseNative.destroyCursor(ptr);
		ptr = null;
	}
}
