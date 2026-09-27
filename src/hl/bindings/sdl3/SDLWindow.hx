package hl.bindings.sdl3;

import haxe.Int64;
import hl.bindings.sdl3.SDLVideo;

/**
 * Opaque handle to an SDL window instance.
 *
 * Corresponds to `SDL_Window*` in SDL3.
 */
typedef SDLWindowPtr = hl.Abstract<"SDL_Window">;

/**
 * Bitmask flags describing a window's state and creation options, returned by `SDLWindow.flags`.
 *
 * Corresponds to `SDL_WindowFlags` in SDL3.
 */
class SDLWindowFlags {
	/** Window is in fullscreen mode. */
	public static inline var FULLSCREEN:Int64 = 1;

	/** Window usable with an OpenGL context. */
	public static inline var OPENGL:Int64 = 2;

	/** Window is occluded (fully hidden behind other windows). */
	public static inline var OCCLUDED:Int64 = 4;

	/** Window is not visible. */
	public static inline var HIDDEN:Int64 = 8;

	/** Window has no border/decorations. */
	public static inline var BORDERLESS:Int64 = 16;

	/** Window can be resized by the user. */
	public static inline var RESIZABLE:Int64 = 32;

	/** Window is minimized. */
	public static inline var MINIMIZED:Int64 = 64;

	/** Window is maximized. */
	public static inline var MAXIMIZED:Int64 = 128;

	/** Window has grabbed mouse input. */
	public static inline var MOUSE_GRABBED:Int64 = 256;

	/** Window has keyboard input focus. */
	public static inline var INPUT_FOCUS:Int64 = 512;

	/** Window has mouse focus. */
	public static inline var MOUSE_FOCUS:Int64 = 1024;

	/** Window was created by another process and is being wrapped by SDL. */
	public static inline var EXTERNAL:Int64 = 2048;

	/** Window is modal relative to its parent. */
	public static inline var MODAL:Int64 = 4096;

	/** Window uses high pixel density back buffer if supported. */
	public static inline var HIGH_PIXEL_DENSITY:Int64 = 8192;

	/** Window has captured the mouse (can receive input outside its bounds). */
	public static inline var MOUSE_CAPTURE:Int64 = 16384;

	/** Window has relative mode enabled for the mouse. */
	public static inline var MOUSE_RELATIVE_MODE:Int64 = 32768;

	/** Window should always be above other windows. */
	public static inline var ALWAYS_ON_TOP:Int64 = 65536;

	/** Window should be treated as a utility window, not shown in the taskbar. */
	public static inline var UTILITY:Int64 = 131072;

	/** Window should be treated as a tooltip and must have a parent window. */
	public static inline var TOOLTIP:Int64 = 262144;

	/** Window should be treated as a popup menu and must have a parent window. */
	public static inline var POPUP_MENU:Int64 = 524288;

	/** Window has grabbed keyboard input. */
	public static inline var KEYBOARD_GRABBED:Int64 = 1048576;

	/** Window should fill its entire document/viewport area (web target). */
	public static inline var FILL_DOCUMENT:Int64 = 2097152;

	/** Window usable with a Vulkan surface. */
	public static inline var VULKAN:Int64 = 0x10000000;

	/** Window usable with a Metal view. */
	public static inline var METAL:Int64 = 0x20000000;

	/** Window has a transparent buffer. */
	public static inline var TRANSPARENT:Int64 = 0x40000000;

	/** Window should not be focusable. */
	public static inline var NOT_FOCUSABLE:Int64 = 0x80000000;
}

@:noCompletion
class SDLWindowNative {
	@:hlNative("sdl3", "create_window") public static function create(title:hl.Bytes, w:Int, h:Int, flags:Int64):SDLWindowPtr
		return null;

	@:hlNative("sdl3", "create_popup_window") public static function createPopup(parent:SDLWindowPtr, ox:Int, oy:Int, w:Int, h:Int, flags:Int64):SDLWindowPtr
		return null;

	@:hlNative("sdl3", "create_window_with_properties") public static function createWithProps(props:Int):SDLWindowPtr
		return null;

	@:hlNative("sdl3", "destroy_window") public static function destroyNative(w:SDLWindowPtr):Void {}

	@:hlNative("sdl3", "get_window_id") public static function id(w:SDLWindowPtr):Int
		return 0;

	@:hlNative("sdl3", "get_window_from_id") public static function fromId(id:Int):SDLWindowPtr
		return null;

	@:hlNative("sdl3", "get_window_parent") public static function parent(w:SDLWindowPtr):SDLWindowPtr
		return null;

	@:hlNative("sdl3", "get_window_properties") public static function properties(w:SDLWindowPtr):Int
		return 0;

	@:hlNative("sdl3", "get_window_flags") public static function flags(w:SDLWindowPtr):Int64
		return 0;

	@:hlNative("sdl3", "set_window_title") public static function setTitle(w:SDLWindowPtr, t:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "get_window_title") public static function getTitle(w:SDLWindowPtr):hl.Bytes
		return null;

	@:hlNative("sdl3", "set_window_icon") public static function setIcon(w:SDLWindowPtr, i:SDLSurfacePtr):Bool
		return false;

	@:hlNative("sdl3", "set_window_position") public static function setPosition(w:SDLWindowPtr, x:Int, y:Int):Bool
		return false;

	@:hlNative("sdl3", "get_window_position") public static function getPosition(w:SDLWindowPtr, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "set_window_size") public static function setSize(w:SDLWindowPtr, cw:Int, ch:Int):Bool
		return false;

	@:hlNative("sdl3", "get_window_size") public static function getSize(w:SDLWindowPtr, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "get_window_safe_area") public static function safeArea(w:SDLWindowPtr, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "set_window_aspect_ratio") public static function setAspect(w:SDLWindowPtr, mn:Float, mx:Float):Bool
		return false;

	@:hlNative("sdl3", "get_window_aspect_ratio") public static function getAspect(w:SDLWindowPtr, out:hl.NativeArray<Float>):Bool
		return false;

	@:hlNative("sdl3", "get_window_borders_size") public static function bordersSize(w:SDLWindowPtr, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "get_window_size_in_pixels") public static function sizeInPixels(w:SDLWindowPtr, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "set_window_minimum_size") public static function setMinSize(w:SDLWindowPtr, a:Int, b:Int):Bool
		return false;

	@:hlNative("sdl3", "get_window_minimum_size") public static function getMinSize(w:SDLWindowPtr, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "set_window_maximum_size") public static function setMaxSize(w:SDLWindowPtr, a:Int, b:Int):Bool
		return false;

	@:hlNative("sdl3", "get_window_maximum_size") public static function getMaxSize(w:SDLWindowPtr, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "get_window_pixel_density") public static function pixelDensity(w:SDLWindowPtr):Float
		return 0;

	@:hlNative("sdl3", "get_window_display_scale") public static function displayScale(w:SDLWindowPtr):Float
		return 0;

	@:hlNative("sdl3", "get_window_pixel_format") public static function pixelFormat(w:SDLWindowPtr):Int
		return 0;

	@:hlNative("sdl3", "get_window_icc_profile") public static function iccProfile(w:SDLWindowPtr, outSize:hl.NativeArray<Int>):hl.Bytes
		return null;

	@:hlNative("sdl3", "set_window_fullscreen_mode") public static function setFullscreenMode(w:SDLWindowPtr, m:SDLDisplayModePtr):Bool
		return false;

	@:hlNative("sdl3", "get_window_fullscreen_mode") public static function getFullscreenMode(w:SDLWindowPtr):SDLDisplayModePtr
		return null;

	@:hlNative("sdl3", "set_window_bordered") public static function setBordered(w:SDLWindowPtr, b:Bool):Bool
		return false;

	@:hlNative("sdl3", "set_window_resizable") public static function setResizable(w:SDLWindowPtr, r:Bool):Bool
		return false;

	@:hlNative("sdl3", "set_window_always_on_top") public static function setAlwaysOnTop(w:SDLWindowPtr, b:Bool):Bool
		return false;

	@:hlNative("sdl3", "set_window_fill_document") public static function setFillDocument(w:SDLWindowPtr, b:Bool):Bool
		return false;

	@:hlNative("sdl3", "show_window") public static function show(w:SDLWindowPtr):Bool
		return false;

	@:hlNative("sdl3", "hide_window") public static function hide(w:SDLWindowPtr):Bool
		return false;

	@:hlNative("sdl3", "raise_window") public static function raise(w:SDLWindowPtr):Bool
		return false;

	@:hlNative("sdl3", "maximize_window") public static function maximize(w:SDLWindowPtr):Bool
		return false;

	@:hlNative("sdl3", "minimize_window") public static function minimize(w:SDLWindowPtr):Bool
		return false;

	@:hlNative("sdl3", "restore_window") public static function restore(w:SDLWindowPtr):Bool
		return false;

	@:hlNative("sdl3", "set_window_fullscreen") public static function setFullscreen(w:SDLWindowPtr, b:Bool):Bool
		return false;

	@:hlNative("sdl3", "sync_window") public static function sync(w:SDLWindowPtr):Bool
		return false;

	@:hlNative("sdl3", "window_has_surface") public static function hasSurface(w:SDLWindowPtr):Bool
		return false;

	@:hlNative("sdl3", "get_window_surface") public static function getSurface(w:SDLWindowPtr):SDLSurfacePtr
		return null;

	@:hlNative("sdl3", "set_window_surface_vsync") public static function setSurfaceVSync(w:SDLWindowPtr, v:Int):Bool
		return false;

	@:hlNative("sdl3", "get_window_surface_vsync") public static function getSurfaceVSync(w:SDLWindowPtr, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "update_window_surface") public static function updateSurface(w:SDLWindowPtr):Bool
		return false;

	@:hlNative("sdl3", "update_window_surface_rects") public static function updateSurfaceRects(w:SDLWindowPtr, rectsXYWH:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "destroy_window_surface") public static function destroySurface(w:SDLWindowPtr):Bool
		return false;

	@:hlNative("sdl3", "set_window_keyboard_grab") public static function setKeyboardGrab(w:SDLWindowPtr, b:Bool):Bool
		return false;

	@:hlNative("sdl3", "set_window_mouse_grab") public static function setMouseGrab(w:SDLWindowPtr, b:Bool):Bool
		return false;

	@:hlNative("sdl3", "get_window_keyboard_grab") public static function getKeyboardGrab(w:SDLWindowPtr):Bool
		return false;

	@:hlNative("sdl3", "get_window_mouse_grab") public static function getMouseGrab(w:SDLWindowPtr):Bool
		return false;

	@:hlNative("sdl3", "get_grabbed_window") public static function grabbedWindow():SDLWindowPtr
		return null;

	@:hlNative("sdl3", "set_window_mouse_rect") public static function setMouseRect(w:SDLWindowPtr, x:Int, y:Int, rw:Int, rh:Int):Bool
		return false;

	@:hlNative("sdl3", "get_window_mouse_rect") public static function getMouseRect(w:SDLWindowPtr, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "set_window_opacity") public static function setOpacity(w:SDLWindowPtr, o:Float):Bool
		return false;

	@:hlNative("sdl3", "get_window_opacity") public static function getOpacity(w:SDLWindowPtr):Float
		return 0;

	@:hlNative("sdl3", "set_window_parent") public static function setParent(w:SDLWindowPtr, p:SDLWindowPtr):Bool
		return false;

	@:hlNative("sdl3", "set_window_modal") public static function setModal(w:SDLWindowPtr, m:Bool):Bool
		return false;

	@:hlNative("sdl3", "set_window_focusable") public static function setFocusable(w:SDLWindowPtr, f:Bool):Bool
		return false;

	@:hlNative("sdl3", "show_window_system_menu") public static function showSystemMenu(w:SDLWindowPtr, x:Int, y:Int):Bool
		return false;

	@:hlNative("sdl3", "set_window_shape") public static function setShape(w:SDLWindowPtr, s:SDLSurfacePtr):Bool
		return false;

	@:hlNative("sdl3", "flash_window") public static function flash(w:SDLWindowPtr, op:Int):Bool
		return false;

	@:hlNative("sdl3", "set_window_progress_state") public static function setProgressState(w:SDLWindowPtr, s:Int):Bool
		return false;

	@:hlNative("sdl3", "get_window_progress_state") public static function getProgressState(w:SDLWindowPtr):Int
		return 0;

	@:hlNative("sdl3", "set_window_progress_value") public static function setProgressValue(w:SDLWindowPtr, v:Float):Bool
		return false;

	@:hlNative("sdl3", "get_window_progress_value") public static function getProgressValue(w:SDLWindowPtr):Float
		return 0;

	@:hlNative("sdl3", "get_display_for_window") public static function getDisplay(w:SDLWindowPtr):Int
		return 0;
}

/**
 * An OS-level application window, created with `SDLWindow.create` (or one of its variants).
 *
 * Combine with `SDLRenderer` for hardware-accelerated drawing, or use `getSurface` for software rendering.
 * Call `destroy` when done with the window.
 *
 * Corresponds to `SDL_Window` in SDL3.
 */
@:access(String)
class SDLWindow {
	var ptr:SDLWindowPtr;

	@:allow(hl.bindings.sdl3)
	function new(ptr:SDLWindowPtr)
		this.ptr = ptr;

	/**
	 * Creates a new top-level window with the given title, size, and creation flags.
	 *
	 * Corresponds to `SDL_CreateWindow` in SDL3.
	 *
	 * @param title The title of the window, in UTF-8 encoding.
	 * @param w     The width of the window, in screen coordinates.
	 * @param h     The height of the window, in screen coordinates.
	 * @param flags 0, or one or more `SDLWindowFlags` OR'd together.
	 * @return A new window instance, or `null` on failure.
	 */
	public static function create(title:String, w:Int, h:Int, flags:Int64 = 0):Null<SDLWindow> {
		@:privateAccess
		var p = SDLWindowNative.create(title.toUtf8(), w, h, flags);
		return p == null ? null : new SDLWindow(p);
	}

	/**
	 * Creates a popup window (tooltip or menu) positioned relative to `parent`.
	 *
	 * Corresponds to `SDL_CreatePopupWindow` in SDL3.
	 *
	 * @param parent  The parent window.
	 * @param offsetX The horizontal offset relative to the parent window.
	 * @param offsetY The vertical offset relative to the parent window.
	 * @param w       The width of the window, in screen coordinates.
	 * @param h       The height of the window, in screen coordinates.
	 * @param flags   Creation flags; should include `POPUP_MENU` or `TOOLTIP`.
	 * @return A new popup window instance, or `null` on failure.
	 */
	public static function createPopup(parent:SDLWindow, offsetX:Int, offsetY:Int, w:Int, h:Int, flags:Int64):Null<SDLWindow> {
		var p = SDLWindowNative.createPopup(@:privateAccess parent.ptr, offsetX, offsetY, w, h, flags);
		return p == null ? null : new SDLWindow(p);
	}

	/**
	 * Creates a window using an `SDLProperties` object for fine-grained creation options.
	 *
	 * Corresponds to `SDL_CreateWindowWithProperties` in SDL3.
	 *
	 * @param props The properties container to use for window creation.
	 * @return A new window instance, or `null` on failure.
	 */
	public static function createWithProperties(props:SDLProperties):Null<SDLWindow> {
		var p = SDLWindowNative.createWithProps(props.rawId);
		return p == null ? null : new SDLWindow(p);
	}

	/**
	 * Looks up an existing window by its numeric ID.
	 *
	 * Corresponds to `SDL_GetWindowFromID` in SDL3.
	 *
	 * @param id The numeric ID of the window to find.
	 * @return The window associated with `id`, or `null` if no such window exists.
	 */
	public static function fromId(id:Int):Null<SDLWindow> {
		var p = SDLWindowNative.fromId(id);
		return p == null ? null : new SDLWindow(p);
	}

	/**
	 * Returns the window that currently has input grab (mouse or keyboard), if any.
	 *
	 * Corresponds to `SDL_GetGrabbedWindow` in SDL3.
	 *
	 * @return The window with input grab, or `null` if no window has grabbed input.
	 */
	public static function getGrabbed():Null<SDLWindow> {
		var p = SDLWindowNative.grabbedWindow();
		return p == null ? null : new SDLWindow(p);
	}

	static inline function str(b:hl.Bytes):Null<String>
		@:privateAccess return b == null ? null : String.fromUTF8(b);

	/**
	 * The numeric ID of this window, as used by window events.
	 *
	 * Corresponds to `SDL_GetWindowID` in SDL3.
	 */
	public var id(get, never):Int;

	/**
	 * The current `SDLWindowFlags` bitmask for this window.
	 *
	 * Corresponds to `SDL_GetWindowFlags` in SDL3.
	 */
	public var flags(get, never):Int64;

	/**
	 * The window's title bar text.
	 *
	 * Corresponds to `SDL_GetWindowTitle` and `SDL_SetWindowTitle` in SDL3.
	 */
	public var title(get, set):Null<String>;

	/**
	 * This window's parent window, or `null` if it has none.
	 *
	 * Corresponds to `SDL_GetWindowParent` in SDL3.
	 */
	public var parent(get, never):Null<SDLWindow>;

	inline function get_id()
		return SDLWindowNative.id(ptr);

	inline function get_flags()
		return SDLWindowNative.flags(ptr);

	inline function get_title()
		return str(SDLWindowNative.getTitle(ptr));

	inline function set_title(t:String):String {
		@:privateAccess SDLWindowNative.setTitle(ptr, t.toUtf8());
		return t;
	}

	inline function get_parent():Null<SDLWindow> {
		var p = SDLWindowNative.parent(ptr);
		return p == null ? null : new SDLWindow(p);
	}

	/**
	 * Returns the `SDLProperties` object associated with this window.
	 *
	 * Corresponds to `SDL_GetWindowProperties` in SDL3.
	 *
	 * @return The properties associated with this window.
	 */
	public function getProperties():SDLProperties
		return SDLProperties.fromId(SDLWindowNative.properties(ptr));

	/**
	 * Sets the window's icon from a surface.
	 *
	 * Corresponds to `SDL_SetWindowIcon` in SDL3.
	 *
	 * @param icon The surface containing the icon image.
	 * @return `true` on success, `false` on failure.
	 */
	public function setIcon(icon:SDLSurface):Bool
		return SDLWindowNative.setIcon(ptr, @:privateAccess icon.ptr);

	/**
	 * Returns the window's position on screen.
	 *
	 * Corresponds to `SDL_GetWindowPosition` in SDL3.
	 *
	 * @return An object containing `x` and `y` coordinates in screen coordinates.
	 */
	public function getPosition():{x:Int, y:Int} {
		var o = new hl.NativeArray<Int>(2);
		SDLWindowNative.getPosition(ptr, o);
		return {x: o[0], y: o[1]};
	}

	/**
	 * Moves the window to the given screen coordinates.
	 *
	 * Corresponds to `SDL_SetWindowPosition` in SDL3.
	 *
	 * @param x The X coordinate of the window position.
	 * @param y The Y coordinate of the window position.
	 * @return `true` on success, `false` on failure.
	 */
	public function setPosition(x:Int, y:Int):Bool
		return SDLWindowNative.setPosition(ptr, x, y);

	/**
	 * Returns the window's client area size in screen coordinates.
	 *
	 * Note: screen coordinates may differ from pixels on HiDPI displays.
	 * See `getSizeInPixels` for rendering resolution.
	 *
	 * Corresponds to `SDL_GetWindowSize` in SDL3.
	 *
	 * @return An object with `w` (width) and `h` (height) in screen coordinates.
	 */
	public function getSize():{w:Int, h:Int} {
		var o = new hl.NativeArray<Int>(2);
		SDLWindowNative.getSize(ptr, o);
		return {w: o[0], h: o[1]};
	}

	/**
	 * Resizes the window's client area in screen coordinates.
	 *
	 * Corresponds to `SDL_SetWindowSize` in SDL3.
	 *
	 * @param w The width in screen coordinates.
	 * @param h The height in screen coordinates.
	 * @return `true` on success, `false` on failure.
	 */
	public function setSize(w:Int, h:Int):Bool
		return SDLWindowNative.setSize(ptr, w, h);

	/**
	 * Returns the area of the window not obscured by notches, system bars, or rounded corners.
	 *
	 * Corresponds to `SDL_GetWindowSafeArea` in SDL3.
	 *
	 * @return An `SDLRect` representing the safe region, or `null` on failure.
	 */
	public function getSafeArea():Null<SDLRect> {
		var o = new hl.NativeArray<Int>(4);
		return SDLWindowNative.safeArea(ptr, o) ? {
			x: o[0],
			y: o[1],
			w: o[2],
			h: o[3]
		} : null;
	}

	/**
	 * Returns the window's minimum and maximum aspect ratio constraints.
	 *
	 * Corresponds to `SDL_GetWindowAspectRatio` in SDL3.
	 *
	 * @return An object with `min` and `max` aspect ratio factors.
	 */
	public function getAspectRatio():{min:Float, max:Float} {
		var o = new hl.NativeArray<Float>(2);
		SDLWindowNative.getAspect(ptr, o);
		return {min: o[0], max: o[1]};
	}

	/**
	 * Sets the minimum and maximum aspect ratio constraints for resizing this window.
	 *
	 * Corresponds to `SDL_SetWindowAspectRatio` in SDL3.
	 *
	 * @param min The minimum aspect ratio (0.0 for no limit).
	 * @param max The maximum aspect ratio (0.0 for no limit).
	 * @return `true` on success, `false` on failure.
	 */
	public function setAspectRatio(min:Float, max:Float):Bool
		return SDLWindowNative.setAspect(ptr, min, max);

	/**
	 * Returns the size in pixels of each window border decoration (top, left, bottom, right).
	 *
	 * Corresponds to `SDL_GetWindowBordersSize` in SDL3.
	 *
	 * @return An object containing border sizes for `top`, `left`, `bottom`, and `right`.
	 */
	public function getBordersSize():{
		top:Int,
		left:Int,
		bottom:Int,
		right:Int
	} {
		var o = new hl.NativeArray<Int>(4);
		SDLWindowNative.bordersSize(ptr, o);
		return {
			top: o[0],
			left: o[1],
			bottom: o[2],
			right: o[3]
		};
	}

	/**
	 * Returns the window's size in pixels.
	 *
	 * On HiDPI displays, this may differ from screen coordinates (`getSize()`).
	 *
	 * Corresponds to `SDL_GetWindowSizeInPixels` in SDL3.
	 *
	 * @return An object with `w` (width) and `h` (height) in pixels.
	 */
	public function getSizeInPixels():{w:Int, h:Int} {
		var o = new hl.NativeArray<Int>(2);
		SDLWindowNative.sizeInPixels(ptr, o);
		return {w: o[0], h: o[1]};
	}

	/**
	 * Returns the window's minimum allowed size.
	 *
	 * Corresponds to `SDL_GetWindowMinimumSize` in SDL3.
	 *
	 * @return An object with `w` and `h` minimum bounds.
	 */
	public function getMinimumSize():{w:Int, h:Int} {
		var o = new hl.NativeArray<Int>(2);
		SDLWindowNative.getMinSize(ptr, o);
		return {w: o[0], h: o[1]};
	}

	/**
	 * Sets the window's minimum allowed size.
	 *
	 * Corresponds to `SDL_SetWindowMinimumSize` in SDL3.
	 *
	 * @param w Minimum width in screen coordinates (0 for no limit).
	 * @param h Minimum height in screen coordinates (0 for no limit).
	 * @return `true` on success, `false` on failure.
	 */
	public function setMinimumSize(w:Int, h:Int):Bool
		return SDLWindowNative.setMinSize(ptr, w, h);

	/**
	 * Returns the window's maximum allowed size.
	 *
	 * Corresponds to `SDL_GetWindowMaximumSize` in SDL3.
	 *
	 * @return An object with `w` and `h` maximum bounds.
	 */
	public function getMaximumSize():{w:Int, h:Int} {
		var o = new hl.NativeArray<Int>(2);
		SDLWindowNative.getMaxSize(ptr, o);
		return {w: o[0], h: o[1]};
	}

	/**
	 * Sets the window's maximum allowed size.
	 *
	 * Corresponds to `SDL_SetWindowMaximumSize` in SDL3.
	 *
	 * @param w Maximum width in screen coordinates (0 for no limit).
	 * @param h Maximum height in screen coordinates (0 for no limit).
	 * @return `true` on success, `false` on failure.
	 */
	public function setMaximumSize(w:Int, h:Int):Bool
		return SDLWindowNative.setMaxSize(ptr, w, h);

	/**
	 * Ratio of pixel size to screen coordinate size (> 1 on HiDPI displays).
	 *
	 * Corresponds to `SDL_GetWindowPixelDensity` in SDL3.
	 */
	public var pixelDensity(get, never):Float;

	/**
	 * Content display scale factor for this window's display.
	 *
	 * Corresponds to `SDL_GetWindowDisplayScale` in SDL3.
	 */
	public var displayScale(get, never):Float;

	/**
	 * Pixel format of the window's associated surface or renderer context.
	 *
	 * Corresponds to `SDL_GetWindowPixelFormat` in SDL3.
	 */
	public var pixelFormat(get, never):Int;

	inline function get_pixelDensity()
		return SDLWindowNative.pixelDensity(ptr);

	inline function get_displayScale()
		return SDLWindowNative.displayScale(ptr);

	inline function get_pixelFormat()
		return SDLWindowNative.pixelFormat(ptr);

	/**
	 * Returns the raw ICC color profile data for the display this window is on.
	 *
	 * Corresponds to `SDL_GetWindowICCProfile` in SDL3.
	 *
	 * @return A `Bytes` object containing raw ICC profile data, or `null` if unavailable.
	 */
	public function getICCProfile():Null<haxe.io.Bytes> {
		var o = new hl.NativeArray<Int>(1);
		var raw = SDLWindowNative.iccProfile(ptr, o);
		if (raw == null)
			return null;
		var b = haxe.io.Bytes.alloc(o[0]);
		b.blit(0, raw.toBytes(o[0]), 0, o[0]);
		return b;
	}

	/**
	 * Sets the display mode to use when the window is in exclusive fullscreen mode.
	 *
	 * Corresponds to `SDL_SetWindowFullscreenMode` in SDL3.
	 *
	 * @param mode The display mode to use, or `null` for borderless desktop fullscreen.
	 * @return `true` on success, `false` on failure.
	 */
	public function setFullscreenMode(mode:Null<SDLDisplayMode>):Bool
		return SDLWindowNative.setFullscreenMode(ptr, mode == null ? null : @:privateAccess mode.ptr);

	/**
	 * Returns the exclusive fullscreen mode set for this window.
	 *
	 * Corresponds to `SDL_GetWindowFullscreenMode` in SDL3.
	 *
	 * @return The fullscreen display mode, or `null` if borderless desktop fullscreen is set.
	 */
	public function getFullscreenMode():Null<SDLDisplayMode> {
		var p = SDLWindowNative.getFullscreenMode(ptr);
		return p == null ? null : @:privateAccess new SDLDisplayMode(p);
	}

	/**
	 * Enables or disables the window's border and window manager decorations.
	 *
	 * Corresponds to `SDL_SetWindowBordered` in SDL3.
	 *
	 * @param b `true` to enable window borders, `false` to disable.
	 * @return `true` on success, `false` on failure.
	 */
	public function setBordered(b:Bool):Bool
		return SDLWindowNative.setBordered(ptr, b);

	/**
	 * Enables or disables user resizing of the window.
	 *
	 * Corresponds to `SDL_SetWindowResizable` in SDL3.
	 *
	 * @param r `true` to make resizable, `false` to disable resizing.
	 * @return `true` on success, `false` on failure.
	 */
	public function setResizable(r:Bool):Bool
		return SDLWindowNative.setResizable(ptr, r);

	/**
	 * Sets whether the window should always stay on top of other windows.
	 *
	 * Corresponds to `SDL_SetWindowAlwaysOnTop` in SDL3.
	 *
	 * @param b `true` to stay on top, `false` for standard z-ordering.
	 * @return `true` on success, `false` on failure.
	 */
	public function setAlwaysOnTop(b:Bool):Bool
		return SDLWindowNative.setAlwaysOnTop(ptr, b);

	/**
	 * Enables or disables filling the entire document/viewport area (web target).
	 *
	 * Corresponds to `SDL_SetWindowFillDocument` in SDL3.
	 *
	 * @param b `true` to fill document area, `false` otherwise.
	 * @return `true` on success, `false` on failure.
	 */
	public function setFillDocument(b:Bool):Bool
		return SDLWindowNative.setFillDocument(ptr, b);

	/**
	 * Shows the window if it was previously hidden.
	 *
	 * Corresponds to `SDL_ShowWindow` in SDL3.
	 *
	 * @return `true` on success, `false` on failure.
	 */
	public function show():Bool
		return SDLWindowNative.show(ptr);

	/**
	 * Hides the window.
	 *
	 * Corresponds to `SDL_HideWindow` in SDL3.
	 *
	 * @return `true` on success, `false` on failure.
	 */
	public function hide():Bool
		return SDLWindowNative.hide(ptr);

	/**
	 * Raises the window above other windows and requests input focus.
	 *
	 * Corresponds to `SDL_RaiseWindow` in SDL3.
	 *
	 * @return `true` on success, `false` on failure.
	 */
	public function raise():Bool
		return SDLWindowNative.raise(ptr);

	/**
	 * Maximizes the window to fill the screen space.
	 *
	 * Corresponds to `SDL_MaximizeWindow` in SDL3.
	 *
	 * @return `true` on success, `false` on failure.
	 */
	public function maximize():Bool
		return SDLWindowNative.maximize(ptr);

	/**
	 * Minimizes the window to the taskbar or dock.
	 *
	 * Corresponds to `SDL_MinimizeWindow` in SDL3.
	 *
	 * @return `true` on success, `false` on failure.
	 */
	public function minimize():Bool
		return SDLWindowNative.minimize(ptr);

	/**
	 * Restores a minimized or maximized window to its previous size and position.
	 *
	 * Corresponds to `SDL_RestoreWindow` in SDL3.
	 *
	 * @return `true` on success, `false` on failure.
	 */
	public function restore():Bool
		return SDLWindowNative.restore(ptr);

	/**
	 * Enables or disables fullscreen mode for this window.
	 *
	 * Corresponds to `SDL_SetWindowFullscreen` in SDL3.
	 *
	 * @param b `true` to switch to fullscreen, `false` for windowed mode.
	 * @return `true` on success, `false` on failure.
	 */
	public function setFullscreen(b:Bool):Bool
		return SDLWindowNative.setFullscreen(ptr, b);

	/**
	 * Blocks until any pending window state changes have been applied by the window manager.
	 *
	 * Corresponds to `SDL_SyncWindow` in SDL3.
	 *
	 * @return `true` on success, `false` on failure.
	 */
	public function sync():Bool
		return SDLWindowNative.sync(ptr);

	/**
	 * Checks whether this window currently has an associated software surface.
	 *
	 * Corresponds to `SDL_WindowHasSurface` in SDL3.
	 *
	 * @return `true` if a software surface exists, `false` otherwise.
	 */
	public function hasSurface():Bool
		return SDLWindowNative.hasSurface(ptr);

	/**
	 * Returns the window's software rendering surface, creating it if necessary.
	 *
	 * Do not combine software surface rendering with `SDLRenderer`.
	 *
	 * Corresponds to `SDL_GetWindowSurface` in SDL3.
	 *
	 * @return The window's software surface, or `null` on failure.
	 */
	public function getSurface():Null<SDLSurface> {
		var p = SDLWindowNative.getSurface(ptr);
		return p == null ? null : @:privateAccess new SDLSurface(p);
	}

	/**
	 * Sets vertical synchronization (vsync) behavior for `updateSurface`.
	 *
	 * Corresponds to `SDL_SetWindowSurfaceVSync` in SDL3.
	 *
	 * @param v Vsync mode: 0 = disabled, 1 = enabled, negative = adaptive.
	 * @return `true` on success, `false` on failure.
	 */
	public function setSurfaceVSync(v:Int):Bool
		return SDLWindowNative.setSurfaceVSync(ptr, v);

	/**
	 * Returns the current vsync setting for the window surface.
	 *
	 * Corresponds to `SDL_GetWindowSurfaceVSync` in SDL3.
	 *
	 * @return The current vsync value, or `null` if unavailable.
	 */
	public function getSurfaceVSync():Null<Int> {
		var o = new hl.NativeArray<Int>(1);
		return SDLWindowNative.getSurfaceVSync(ptr, o) ? o[0] : null;
	}

	/**
	 * Copies the entire window software surface to the screen.
	 *
	 * Corresponds to `SDL_UpdateWindowSurface` in SDL3.
	 *
	 * @return `true` on success, `false` on failure.
	 */
	public function updateSurface():Bool
		return SDLWindowNative.updateSurface(ptr);

	/**
	 * Copies only the specified regions of the window surface to the screen.
	 *
	 * Corresponds to `SDL_UpdateWindowSurfaceRects` in SDL3.
	 *
	 * @param rects An array of rectangles to update.
	 * @return `true` on success, `false` on failure.
	 */
	public function updateSurfaceRects(rects:Array<SDLRect>):Bool {
		var a = new hl.NativeArray<Int>(rects.length * 4);
		for (i in 0...rects.length) {
			a[i * 4] = rects[i].x;
			a[i * 4 + 1] = rects[i].y;
			a[i * 4 + 2] = rects[i].w;
			a[i * 4 + 3] = rects[i].h;
		}
		return SDLWindowNative.updateSurfaceRects(ptr, a);
	}

	/**
	 * Destroys the window's software surface (created by `getSurface`).
	 *
	 * Corresponds to `SDL_DestroyWindowSurface` in SDL3.
	 *
	 * @return `true` on success, `false` on failure.
	 */
	public function destroySurface():Bool
		return SDLWindowNative.destroySurface(ptr);

	/**
	 * Enables or disables keyboard grab, forcing keyboard focus to this window.
	 *
	 * Corresponds to `SDL_SetWindowKeyboardGrab` in SDL3.
	 *
	 * @param b `true` to grab keyboard input, `false` to release.
	 * @return `true` on success, `false` on failure.
	 */
	public function setKeyboardGrab(b:Bool):Bool
		return SDLWindowNative.setKeyboardGrab(ptr, b);

	/**
	 * Enables or disables mouse grab, confining the mouse cursor to this window.
	 *
	 * Corresponds to `SDL_SetWindowMouseGrab` in SDL3.
	 *
	 * @param b `true` to grab mouse input, `false` to release.
	 * @return `true` on success, `false` on failure.
	 */
	public function setMouseGrab(b:Bool):Bool
		return SDLWindowNative.setMouseGrab(ptr, b);

	/**
	 * Checks whether this window currently has keyboard grab enabled.
	 *
	 * Corresponds to `SDL_GetWindowKeyboardGrab` in SDL3.
	 *
	 * @return `true` if keyboard grab is active, `false` otherwise.
	 */
	public function isKeyboardGrabbed():Bool
		return SDLWindowNative.getKeyboardGrab(ptr);

	/**
	 * Checks whether this window currently has mouse grab enabled.
	 *
	 * Corresponds to `SDL_GetWindowMouseGrab` in SDL3.
	 *
	 * @return `true` if mouse grab is active, `false` otherwise.
	 */
	public function isMouseGrabbed():Bool
		return SDLWindowNative.getMouseGrab(ptr);

	/**
	 * Confines the mouse cursor to a specific rectangle within the window.
	 *
	 * Corresponds to `SDL_SetWindowMouseRect` in SDL3.
	 *
	 * @param rect Confinement region, or `null` to clear mouse confinement.
	 * @return `true` on success, `false` on failure.
	 */
	public function setMouseRect(?rect:SDLRect):Bool
		return rect == null ? SDLWindowNative.setMouseRect(ptr, 0, 0, 0, 0) : SDLWindowNative.setMouseRect(ptr, rect.x, rect.y, rect.w, rect.h);

	/**
	 * Returns the rectangle the mouse cursor is confined to within this window.
	 *
	 * Corresponds to `SDL_GetWindowMouseRect` in SDL3.
	 *
	 * @return The confinement `SDLRect`, or `null` if unconfined.
	 */
	public function getMouseRect():Null<SDLRect> {
		var o = new hl.NativeArray<Int>(4);
		return SDLWindowNative.getMouseRect(ptr, o) ? {
			x: o[0],
			y: o[1],
			w: o[2],
			h: o[3]
		} : null;
	}

	/**
	 * Sets the window's opacity.
	 *
	 * Corresponds to `SDL_SetWindowOpacity` in SDL3.
	 *
	 * @param o Opacity value from `0.0` (transparent) to `1.0` (opaque).
	 * @return `true` on success, `false` on failure.
	 */
	public function setOpacity(o:Float):Bool
		return SDLWindowNative.setOpacity(ptr, o);

	/**
	 * Returns the window's opacity.
	 *
	 * Corresponds to `SDL_GetWindowOpacity` in SDL3.
	 *
	 * @return Opacity value from `0.0` (transparent) to `1.0` (opaque).
	 */
	public function getOpacity():Float
		return SDLWindowNative.getOpacity(ptr);

	/**
	 * Reparents this window under `p`, or clears its parent if `null`.
	 *
	 * Corresponds to `SDL_SetWindowParent` in SDL3.
	 *
	 * @param p The new parent window, or `null` to clear parent.
	 * @return `true` on success, `false` on failure.
	 */
	public function setParent(?p:SDLWindow):Bool
		return SDLWindowNative.setParent(ptr, p == null ? null : @:privateAccess p.ptr);

	/**
	 * Sets whether this window is modal relative to its parent.
	 *
	 * Corresponds to `SDL_SetWindowModal` in SDL3.
	 *
	 * @param m `true` to make modal, `false` otherwise.
	 * @return `true` on success, `false` on failure.
	 */
	public function setModal(m:Bool):Bool
		return SDLWindowNative.setModal(ptr, m);

	/**
	 * Sets whether this window can receive keyboard focus.
	 *
	 * Corresponds to `SDL_SetWindowFocusable` in SDL3.
	 *
	 * @param f `true` to enable focus, `false` to disable focusability.
	 * @return `true` on success, `false` on failure.
	 */
	public function setFocusable(f:Bool):Bool
		return SDLWindowNative.setFocusable(ptr, f);

	/**
	 * Shows the window's system (title bar) menu at the given position.
	 *
	 * Corresponds to `SDL_ShowWindowSystemMenu` in SDL3.
	 *
	 * @param x X coordinate for system menu display.
	 * @param y Y coordinate for system menu display.
	 * @return `true` on success, `false` on failure.
	 */
	public function showSystemMenu(x:Int, y:Int):Bool
		return SDLWindowNative.showSystemMenu(ptr, x, y);

	/**
	 * Sets a shape mask surface for a borderless, non-rectangular window.
	 *
	 * Corresponds to `SDL_SetWindowShape` in SDL3.
	 *
	 * @param shape Surface containing shape mask, or `null` to clear.
	 * @return `true` on success, `false` on failure.
	 */
	public function setShape(shape:Null<SDLSurface>):Bool
		return SDLWindowNative.setShape(ptr, shape == null ? null : @:privateAccess shape.ptr);

	/**
	 * Requests user attention by flashing the window (e.g. taskbar/dock icon).
	 *
	 * Corresponds to `SDL_FlashWindow` in SDL3.
	 *
	 * @param op The flash operation mode (defaults to `BRIEFLY`).
	 * @return `true` on success, `false` on failure.
	 */
	public function flash(op:SDLFlashOperation = BRIEFLY):Bool
		return SDLWindowNative.flash(ptr, op);

	/**
	 * Sets the taskbar/dock progress indicator state for this window.
	 *
	 * Corresponds to `SDL_SetWindowProgressState` in SDL3.
	 *
	 * @param s Progress indicator state.
	 * @return `true` on success, `false` on failure.
	 */
	public function setProgressState(s:SDLProgressState):Bool
		return SDLWindowNative.setProgressState(ptr, s);

	/**
	 * Returns the taskbar/dock progress indicator state currently set for this window.
	 *
	 * Corresponds to `SDL_GetWindowProgressState` in SDL3.
	 *
	 * @return The active progress indicator state.
	 */
	public function getProgressState():SDLProgressState
		return SDLWindowNative.getProgressState(ptr);

	/**
	 * Sets the taskbar/dock progress indicator value, from 0 to 1.
	 *
	 * Corresponds to `SDL_SetWindowProgressValue` in SDL3.
	 *
	 * @param v Completion fraction from `0.0` to `1.0`.
	 * @return `true` on success, `false` on failure.
	 */
	public function setProgressValue(v:Float):Bool
		return SDLWindowNative.setProgressValue(ptr, v);

	/**
	 * Returns the taskbar/dock progress indicator value, from 0 to 1.
	 *
	 * Corresponds to `SDL_GetWindowProgressValue` in SDL3.
	 *
	 * @return Completion fraction from `0.0` to `1.0`.
	 */
	public function getProgressValue():Float
		return SDLWindowNative.getProgressValue(ptr);

	/**
	 * Returns the index of the display this window is currently on.
	 *
	 * Corresponds to `SDL_GetDisplayForWindow` in SDL3.
	 *
	 * @return The associated display ID.
	 */
	public function getDisplay():Int
		return SDLWindowNative.getDisplay(ptr);

	/**
	 * Destroys the window and releases its native resources.
	 *
	 * Safe to call multiple times; the instance becomes unusable afterwards.
	 *
	 * Corresponds to `SDL_DestroyWindow` in SDL3.
	 */
	public function destroy():Void {
		if (ptr != null)
			SDLWindowNative.destroyNative(ptr);
		ptr = null;
	}
}
