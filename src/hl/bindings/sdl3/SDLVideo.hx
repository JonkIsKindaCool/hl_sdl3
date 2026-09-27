package hl.bindings.sdl3;

import haxe.Int64;

typedef SDLDisplayModePtr = hl.Abstract<"SDL_DisplayMode">;
typedef SDLGLContextPtr = hl.Abstract<"SDL_GLContext">;
typedef SDLEGLDisplayPtr = hl.Abstract<"SDL_EGLDisplay">;
typedef SDLEGLConfigPtr = hl.Abstract<"SDL_EGLConfig">;
typedef SDLEGLSurfacePtr = hl.Abstract<"SDL_EGLSurface">;
typedef SDLFunctionPointerPtr = hl.Abstract<"SDL_FunctionPointer">;

/**
 * The OS-wide light/dark theme preference.
 *
 * Corresponds to `SDL_SystemTheme` in SDL3.
 */
enum abstract SDLSystemTheme(Int) from Int to Int {
	/** System theme preference is unknown. Corresponds to `SDL_SYSTEM_THEME_UNKNOWN`. */
	var UNKNOWN = 0;

	/** System is using a light theme. Corresponds to `SDL_SYSTEM_THEME_LIGHT`. */
	var LIGHT = 1;

	/** System is using a dark theme. Corresponds to `SDL_SYSTEM_THEME_DARK`. */
	var DARK = 2;
}

/**
 * The orientation of a display.
 *
 * Corresponds to `SDL_DisplayOrientation` in SDL3.
 */
enum abstract SDLDisplayOrientation(Int) from Int to Int {
	/** Display orientation is unknown. Corresponds to `SDL_ORIENTATION_UNKNOWN`. */
	var UNKNOWN = 0;

	/** Display is in landscape orientation. Corresponds to `SDL_ORIENTATION_LANDSCAPE`. */
	var LANDSCAPE = 1;

	/** Display is in inverted landscape orientation. Corresponds to `SDL_ORIENTATION_LANDSCAPE_FLIPPED`. */
	var LANDSCAPE_FLIPPED = 2;

	/** Display is in portrait orientation. Corresponds to `SDL_ORIENTATION_PORTRAIT`. */
	var PORTRAIT = 3;

	/** Display is in inverted portrait orientation. Corresponds to `SDL_ORIENTATION_PORTRAIT_FLIPPED`. */
	var PORTRAIT_FLIPPED = 4;
}

/**
 * How `SDLWindow.flash` should get the user's attention.
 *
 * Corresponds to `SDL_FlashOperation` in SDL3.
 */
enum abstract SDLFlashOperation(Int) from Int to Int {
	/** Cancel any ongoing window flashing. Corresponds to `SDL_FLASH_CANCEL`. */
	var CANCEL = 0;

	/** Flash briefly to highlight the window. Corresponds to `SDL_FLASH_BRIEFLY`. */
	var BRIEFLY = 1;

	/** Flash continuously until the window receives input focus. Corresponds to `SDL_FLASH_UNTIL_FOCUSED`. */
	var UNTIL_FOCUSED = 2;
}

/**
 * Taskbar/dock progress indicator state, used with `SDLWindow.setProgressState`.
 *
 * Corresponds to `SDL_ProgressState` in SDL3.
 */
enum abstract SDLProgressState(Int) from Int to Int {
	/** Invalid or unsupported progress state. Corresponds to `SDL_PROGRESS_STATE_INVALID`. */
	var INVALID = -1;

	/** No progress indicator shown. Corresponds to `SDL_PROGRESS_STATE_NONE`. */
	var NONE = 0;

	/** Indeterminate ("busy") progress indicator animation. Corresponds to `SDL_PROGRESS_STATE_INDETERMINATE`. */
	var INDETERMINATE = 1;

	/** Normal progress indicator, filled according to value. Corresponds to `SDL_PROGRESS_STATE_NORMAL`. */
	var NORMAL = 2;

	/** Paused progress indicator. Corresponds to `SDL_PROGRESS_STATE_PAUSED`. */
	var PAUSED = 3;

	/** Error-colored progress indicator. Corresponds to `SDL_PROGRESS_STATE_ERROR`. */
	var ERROR = 4;
}

/**
 * OpenGL context attributes settable with `SDLVideo.glSetAttribute` before creating a GL context.
 *
 * Corresponds to `SDL_GLAttr` in SDL3.
 */
enum abstract SDLGLAttr(Int) from Int to Int {
	/** Size of the framebuffer red color component, in bits. Corresponds to `SDL_GL_RED_SIZE`. */
	var RED_SIZE = 0;

	/** Size of the framebuffer green color component, in bits. Corresponds to `SDL_GL_GREEN_SIZE`. */
	var GREEN_SIZE = 1;

	/** Size of the framebuffer blue color component, in bits. Corresponds to `SDL_GL_BLUE_SIZE`. */
	var BLUE_SIZE = 2;

	/** Size of the framebuffer alpha component, in bits. Corresponds to `SDL_GL_ALPHA_SIZE`. */
	var ALPHA_SIZE = 3;

	/** Size of the framebuffer frame buffer depth, in bits. Corresponds to `SDL_GL_BUFFER_SIZE`. */
	var BUFFER_SIZE = 4;

	/** Double buffering support (0 or 1). Corresponds to `SDL_GL_DOUBLEBUFFER`. */
	var DOUBLEBUFFER = 5;

	/** Size of the depth buffer, in bits. Corresponds to `SDL_GL_DEPTH_SIZE`. */
	var DEPTH_SIZE = 6;

	/** Size of the stencil buffer, in bits. Corresponds to `SDL_GL_STENCIL_SIZE`. */
	var STENCIL_SIZE = 7;

	/** Size of the accumulation buffer red component, in bits. Corresponds to `SDL_GL_ACCUM_RED_SIZE`. */
	var ACCUM_RED_SIZE = 8;

	/** Size of the accumulation buffer green component, in bits. Corresponds to `SDL_GL_ACCUM_GREEN_SIZE`. */
	var ACCUM_GREEN_SIZE = 9;

	/** Size of the accumulation buffer blue component, in bits. Corresponds to `SDL_GL_ACCUM_BLUE_SIZE`. */
	var ACCUM_BLUE_SIZE = 10;

	/** Size of the accumulation buffer alpha component, in bits. Corresponds to `SDL_GL_ACCUM_ALPHA_SIZE`. */
	var ACCUM_ALPHA_SIZE = 11;

	/** Stereo 3D rendering support (0 or 1). Corresponds to `SDL_GL_STEREO`. */
	var STEREO = 12;

	/** Number of multisample buffers. Corresponds to `SDL_GL_MULTISAMPLEBUFFERS`. */
	var MULTISAMPLEBUFFERS = 13;

	/** Number of samples per pixel for multisampling. Corresponds to `SDL_GL_MULTISAMPLESAMPLES`. */
	var MULTISAMPLESAMPLES = 14;

	/** Hardware acceleration preference. Corresponds to `SDL_GL_ACCELERATED_VISUAL`. */
	var ACCELERATED_VISUAL = 15;

	/** Retained backing buffer support. Corresponds to `SDL_GL_RETAINED_BACKING`. */
	var RETAINED_BACKING = 16;

	/** OpenGL context major version number. Corresponds to `SDL_GL_CONTEXT_MAJOR_VERSION`. */
	var CONTEXT_MAJOR_VERSION = 17;

	/** OpenGL context minor version number. Corresponds to `SDL_GL_CONTEXT_MINOR_VERSION`. */
	var CONTEXT_MINOR_VERSION = 18;

	/** OpenGL context flags (`SDL_GLContextFlag`). Corresponds to `SDL_GL_CONTEXT_FLAGS`. */
	var CONTEXT_FLAGS = 19;

	/** OpenGL context profile mask (`SDL_GLProfile`). Corresponds to `SDL_GL_CONTEXT_PROFILE_MASK`. */
	var CONTEXT_PROFILE_MASK = 20;

	/** Share context resources with current context. Corresponds to `SDL_GL_SHARE_WITH_CURRENT_CONTEXT`. */
	var SHARE_WITH_CURRENT_CONTEXT = 21;

	/** Framebuffer sRGB capability support. Corresponds to `SDL_GL_FRAMEBUFFER_SRGB_CAPABLE`. */
	var FRAMEBUFFER_SRGB_CAPABLE = 22;

	/** OpenGL context release behavior. Corresponds to `SDL_GL_CONTEXT_RELEASE_BEHAVIOR`. */
	var CONTEXT_RELEASE_BEHAVIOR = 23;

	/** OpenGL context reset notification strategy. Corresponds to `SDL_GL_CONTEXT_RESET_NOTIFICATION`. */
	var CONTEXT_RESET_NOTIFICATION = 24;

	/** OpenGL context no-error flag. Corresponds to `SDL_GL_CONTEXT_NO_ERROR`. */
	var CONTEXT_NO_ERROR = 25;

	/** Floating-point color buffer support. Corresponds to `SDL_GL_FLOATBUFFERS`. */
	var FLOATBUFFERS = 26;

	/** EGL platform selection indicator. Corresponds to `SDL_GL_EGL_PLATFORM`. */
	var EGL_PLATFORM = 27;
}

@:noCompletion
class SDLVideoNative {
	@:hlNative("sdl3", "get_num_video_drivers") public static function numDrivers():Int
		return 0;

	@:hlNative("sdl3", "get_video_driver") public static function driver(i:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_current_video_driver") public static function currentDriver():hl.Bytes
		return null;

	@:hlNative("sdl3", "get_system_theme") public static function systemTheme():Int
		return 0;

	@:hlNative("sdl3", "get_displays") public static function displays():hl.NativeArray<Int>
		return null;

	@:hlNative("sdl3", "get_primary_display") public static function primaryDisplay():Int
		return 0;

	@:hlNative("sdl3", "get_display_properties") public static function displayProps(id:Int):Int
		return 0;

	@:hlNative("sdl3", "get_display_name") public static function displayName(id:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_display_bounds") public static function displayBounds(id:Int, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "get_display_usable_bounds") public static function displayUsableBounds(id:Int, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "get_natural_display_orientation") public static function naturalOrientation(id:Int):Int
		return 0;

	@:hlNative("sdl3", "get_current_display_orientation") public static function currentOrientation(id:Int):Int
		return 0;

	@:hlNative("sdl3", "get_display_content_scale") public static function displayScale(id:Int):Float
		return 0;

	@:hlNative("sdl3", "get_fullscreen_display_modes_count") public static function fsModesCount(id:Int):Int
		return 0;

	@:hlNative("sdl3", "get_fullscreen_display_mode_at") public static function fsModeAt(id:Int, i:Int):SDLDisplayModePtr
		return null;

	@:hlNative("sdl3", "get_closest_fullscreen_display_mode") public static function closestMode(id:Int, w:Int, h:Int, rate:Float, hi:Bool,
			out:SDLDisplayModePtr):Bool
		return false;

	@:hlNative("sdl3", "get_desktop_display_mode") public static function desktopMode(id:Int):SDLDisplayModePtr
		return null;

	@:hlNative("sdl3", "get_current_display_mode") public static function currentMode(id:Int):SDLDisplayModePtr
		return null;

	@:hlNative("sdl3", "get_display_for_point") public static function displayForPoint(x:Int, y:Int):Int
		return 0;

	@:hlNative("sdl3", "get_display_for_rect") public static function displayForRect(x:Int, y:Int, w:Int, h:Int):Int
		return 0;

	@:hlNative("sdl3", "display_mode_alloc") public static function modeAlloc():SDLDisplayModePtr
		return null;

	@:hlNative("sdl3", "display_mode_display_id") public static function modeId(m:SDLDisplayModePtr):Int
		return 0;

	@:hlNative("sdl3", "display_mode_format") public static function modeFormat(m:SDLDisplayModePtr):Int
		return 0;

	@:hlNative("sdl3", "display_mode_w") public static function modeW(m:SDLDisplayModePtr):Int
		return 0;

	@:hlNative("sdl3", "display_mode_h") public static function modeH(m:SDLDisplayModePtr):Int
		return 0;

	@:hlNative("sdl3", "display_mode_pixel_density") public static function modePixelDensity(m:SDLDisplayModePtr):Float
		return 0;

	@:hlNative("sdl3", "display_mode_refresh_rate") public static function modeRefreshRate(m:SDLDisplayModePtr):Float
		return 0;

	@:hlNative("sdl3", "display_mode_refresh_rate_numerator") public static function modeRefreshNum(m:SDLDisplayModePtr):Int
		return 0;

	@:hlNative("sdl3", "display_mode_refresh_rate_denominator") public static function modeRefreshDen(m:SDLDisplayModePtr):Int
		return 0;

	@:hlNative("sdl3", "get_windows_count") public static function windowsCount():Int
		return 0;

	@:hlNative("sdl3", "get_window_at") public static function windowAt(i:Int):SDLWindowPtr
		return null;

	@:hlNative("sdl3", "screen_saver_enabled") public static function saverEnabled():Bool
		return false;

	@:hlNative("sdl3", "enable_screen_saver") public static function enableSaver():Bool
		return false;

	@:hlNative("sdl3", "disable_screen_saver") public static function disableSaver():Bool
		return false;

	@:hlNative("sdl3", "gl_load_library") public static function glLoad(p:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "gl_get_proc_address") public static function glProc(p:hl.Bytes):SDLFunctionPointerPtr
		return null;

	@:hlNative("sdl3", "egl_get_proc_address") public static function eglProc(p:hl.Bytes):SDLFunctionPointerPtr
		return null;

	@:hlNative("sdl3", "gl_unload_library") public static function glUnload():Void {}

	@:hlNative("sdl3", "gl_extension_supported") public static function glExt(e:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "gl_reset_attributes") public static function glReset():Void {}

	@:hlNative("sdl3", "gl_set_attribute") public static function glSet(a:Int, v:Int):Bool
		return false;

	@:hlNative("sdl3", "gl_get_attribute") public static function glGet(a:Int, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "gl_create_context") public static function glCreate(w:SDLWindowPtr):SDLGLContextPtr
		return null;

	@:hlNative("sdl3", "gl_make_current") public static function glMakeCurrent(w:SDLWindowPtr, c:SDLGLContextPtr):Bool
		return false;

	@:hlNative("sdl3", "gl_get_current_window") public static function glCurrentWindow():SDLWindowPtr
		return null;

	@:hlNative("sdl3", "gl_get_current_context") public static function glCurrentContext():SDLGLContextPtr
		return null;

	@:hlNative("sdl3", "egl_get_current_display") public static function eglCurrentDisplay():SDLEGLDisplayPtr
		return null;

	@:hlNative("sdl3", "egl_get_current_config") public static function eglCurrentConfig():SDLEGLConfigPtr
		return null;

	@:hlNative("sdl3", "egl_get_window_surface") public static function eglWindowSurface(w:SDLWindowPtr):SDLEGLSurfacePtr
		return null;

	@:hlNative("sdl3", "gl_set_swap_interval") public static function glSetSwap(i:Int):Bool
		return false;

	@:hlNative("sdl3", "gl_get_swap_interval") public static function glGetSwap(out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "gl_swap_window") public static function glSwap(w:SDLWindowPtr):Bool
		return false;

	@:hlNative("sdl3", "gl_destroy_context") public static function glDestroy(c:SDLGLContextPtr):Bool
		return false;
}

/**
 * Static video subsystem API: drivers, displays and display modes, the window list,
 * screensaver control, and OpenGL/EGL context management.
 *
 * Provides Haxe bindings for video functions in SDL3.
 */
@:access(String)
class SDLVideo {
	static inline function str(b:hl.Bytes):Null<String>
		return b == null ? null : String.fromUTF8(b);

	/* ---- Drivers / theme ---- */
	/**
	 * Returns the number of built-in video drivers available.
	 *
	 * Corresponds to `SDL_GetNumVideoDrivers` in SDL3.
	 *
	 * @return Number of video drivers.
	 */
	public static function getNumVideoDrivers():Int
		return SDLVideoNative.numDrivers();

	/**
	 * Returns the name of the video driver at `index`, or `null` if out of range.
	 *
	 * Corresponds to `SDL_GetVideoDriver` in SDL3.
	 *
	 * @param index The zero-based driver index.
	 * @return Driver name string, or `null` if invalid.
	 */
	public static function getVideoDriver(index:Int):Null<String>
		return str(SDLVideoNative.driver(index));

	/**
	 * Returns the name of the video driver currently in use.
	 *
	 * Corresponds to `SDL_GetCurrentVideoDriver` in SDL3.
	 *
	 * @return Current driver name string, or `null` if initialized without video.
	 */
	public static function getCurrentVideoDriver():Null<String>
		return str(SDLVideoNative.currentDriver());

	/**
	 * Returns the OS-wide light/dark theme preference.
	 *
	 * Corresponds to `SDL_GetSystemTheme` in SDL3.
	 *
	 * @return The active `SDLSystemTheme`.
	 */
	public static function getSystemTheme():SDLSystemTheme
		return SDLVideoNative.systemTheme();

	/* ---- Displays ---- */
	/**
	 * Returns an array of active display IDs.
	 *
	 * Corresponds to `SDL_GetDisplays` in SDL3.
	 *
	 * @return Array of display IDs.
	 */
	public static function getDisplays():Array<Int> {
		var a = SDLVideoNative.displays();
		return a == null ? [] : [for (i in 0...a.length) a[i]];
	}

	/**
	 * Returns the ID of the primary display.
	 *
	 * Corresponds to `SDL_GetPrimaryDisplay` in SDL3.
	 *
	 * @return Primary display ID.
	 */
	public static function getPrimaryDisplay():Int
		return SDLVideoNative.primaryDisplay();

	/**
	 * Returns the `SDLProperties` object associated with a display.
	 *
	 * Corresponds to `SDL_GetDisplayProperties` in SDL3.
	 *
	 * @param displayID The display identifier.
	 * @return Associated `SDLProperties` handle.
	 */
	public static function getDisplayProperties(displayID:Int):SDLProperties
		return SDLProperties.fromId(SDLVideoNative.displayProps(displayID));

	/**
	 * Returns the human-readable name of a display.
	 *
	 * Corresponds to `SDL_GetDisplayName` in SDL3.
	 *
	 * @param displayID The display identifier.
	 * @return Display name, or `null` on failure.
	 */
	public static function getDisplayName(displayID:Int):Null<String>
		return str(SDLVideoNative.displayName(displayID));

	/**
	 * Returns the bounds (position and size) of a display in desktop coordinates.
	 *
	 * Corresponds to `SDL_GetDisplayBounds` in SDL3.
	 *
	 * @param displayID The display identifier.
	 * @return An `SDLRect` containing bounds, or `null` on failure.
	 */
	public static function getDisplayBounds(displayID:Int):Null<SDLRect> {
		var o = new hl.NativeArray<Int>(4);
		if (!SDLVideoNative.displayBounds(displayID, o))
			return null;
		return {
			x: o[0],
			y: o[1],
			w: o[2],
			h: o[3]
		};
	}

	/**
	 * Returns the usable bounds of a display, excluding OS reserved areas (taskbars, menu bars, notches).
	 *
	 * Corresponds to `SDL_GetDisplayUsableBounds` in SDL3.
	 *
	 * @param displayID The display identifier.
	 * @return An `SDLRect` with usable dimensions, or `null` on failure.
	 */
	public static function getDisplayUsableBounds(displayID:Int):Null<SDLRect> {
		var o = new hl.NativeArray<Int>(4);
		if (!SDLVideoNative.displayUsableBounds(displayID, o))
			return null;
		return {
			x: o[0],
			y: o[1],
			w: o[2],
			h: o[3]
		};
	}

	/**
	 * Returns the display's natural (default) orientation.
	 *
	 * Corresponds to `SDL_GetNaturalDisplayOrientation` in SDL3.
	 *
	 * @param displayID The display identifier.
	 * @return Natural `SDLDisplayOrientation`.
	 */
	public static function getNaturalDisplayOrientation(displayID:Int):SDLDisplayOrientation
		return SDLVideoNative.naturalOrientation(displayID);

	/**
	 * Returns the display's current orientation.
	 *
	 * Corresponds to `SDL_GetCurrentDisplayOrientation` in SDL3.
	 *
	 * @param displayID The display identifier.
	 * @return Current `SDLDisplayOrientation`.
	 */
	public static function getCurrentDisplayOrientation(displayID:Int):SDLDisplayOrientation
		return SDLVideoNative.currentOrientation(displayID);

	/**
	 * Returns the content scale factor for a display (for HiDPI scaling of UI content).
	 *
	 * Corresponds to `SDL_GetDisplayContentScale` in SDL3.
	 *
	 * @param displayID The display identifier.
	 * @return Scale factor float.
	 */
	public static function getDisplayContentScale(displayID:Int):Float
		return SDLVideoNative.displayScale(displayID);

	/**
	 * Returns all fullscreen display modes supported by a display.
	 *
	 * Corresponds to `SDL_GetFullscreenDisplayModes` in SDL3.
	 *
	 * @param displayID The display identifier.
	 * @return Array of `SDLDisplayMode` objects.
	 */
	public static function getFullscreenDisplayModes(displayID:Int):Array<SDLDisplayMode> {
		var n = SDLVideoNative.fsModesCount(displayID);
		var r = [];
		for (i in 0...n) {
			var p = SDLVideoNative.fsModeAt(displayID, i);
			if (p != null)
				r.push(new SDLDisplayMode(p));
		}
		return r;
	}

	/**
	 * Returns the fullscreen display mode on `displayID` closest to the requested size/refresh rate.
	 *
	 * Corresponds to `SDL_GetClosestFullscreenDisplayMode` in SDL3.
	 *
	 * @param displayID          The display identifier.
	 * @param w                  Target width.
	 * @param h                  Target height.
	 * @param refreshRate        Target refresh rate in Hz (default `0`).
	 * @param includeHighDensity Whether to include High DPI display modes (default `false`).
	 * @return Nearest `SDLDisplayMode`, or `null` if none matches.
	 */
	public static function getClosestFullscreenDisplayMode(displayID:Int, w:Int, h:Int, refreshRate:Float = 0,
			includeHighDensity:Bool = false):Null<SDLDisplayMode> {
		var p = SDLVideoNative.modeAlloc();
		return SDLVideoNative.closestMode(displayID, w, h, refreshRate, includeHighDensity, p) ? new SDLDisplayMode(p) : null;
	}

	/**
	 * Returns the display's default desktop (windowed) mode.
	 *
	 * Corresponds to `SDL_GetDesktopDisplayMode` in SDL3.
	 *
	 * @param displayID The display identifier.
	 * @return Desktop `SDLDisplayMode`, or `null` on failure.
	 */
	public static function getDesktopDisplayMode(displayID:Int):Null<SDLDisplayMode> {
		var p = SDLVideoNative.desktopMode(displayID);
		return p == null ? null : new SDLDisplayMode(p);
	}

	/**
	 * Returns the display's current mode.
	 *
	 * Corresponds to `SDL_GetCurrentDisplayMode` in SDL3.
	 *
	 * @param displayID The display identifier.
	 * @return Active `SDLDisplayMode`, or `null` on failure.
	 */
	public static function getCurrentDisplayMode(displayID:Int):Null<SDLDisplayMode> {
		var p = SDLVideoNative.currentMode(displayID);
		return p == null ? null : new SDLDisplayMode(p);
	}

	/**
	 * Returns the ID of the display containing the point `(x, y)` in desktop coordinates.
	 *
	 * Corresponds to `SDL_GetDisplayForPoint` in SDL3.
	 *
	 * @param x Horizontal pixel position.
	 * @param y Vertical pixel position.
	 * @return Display ID containing point.
	 */
	public static function getDisplayForPoint(x:Int, y:Int):Int
		return SDLVideoNative.displayForPoint(x, y);

	/**
	 * Returns the ID of the display that contains the largest portion of the given rectangle.
	 *
	 * Corresponds to `SDL_GetDisplayForRect` in SDL3.
	 *
	 * @param x Horizontal position.
	 * @param y Vertical position.
	 * @param w Rectangle width.
	 * @param h Rectangle height.
	 * @return Display ID intersecting most of the rectangle.
	 */
	public static function getDisplayForRect(x:Int, y:Int, w:Int, h:Int):Int
		return SDLVideoNative.displayForRect(x, y, w, h);

	/* ---- Window list ---- */
	/**
	 * Returns an array of all currently active windows.
	 *
	 * Corresponds to `SDL_GetWindows` in SDL3.
	 *
	 * @return Array of `SDLWindow` instances.
	 */
	public static function getWindows():Array<SDLWindow> {
		var n = SDLVideoNative.windowsCount();
		var r = [];
		for (i in 0...n) {
			var p = SDLVideoNative.windowAt(i);
			if (p != null)
				r.push(@:privateAccess new SDLWindow(p));
		}
		return r;
	}

	/* ---- Screensaver ---- */
	/**
	 * Checks whether the screensaver is currently allowed to run.
	 *
	 * Corresponds to `SDL_ScreenSaverEnabled` in SDL3.
	 *
	 * @return `true` if enabled, `false` otherwise.
	 */
	public static function screensaverEnabled():Bool
		return SDLVideoNative.saverEnabled();

	/**
	 * Allows the screensaver to run again after `disableScreensaver`.
	 *
	 * Corresponds to `SDL_EnableScreenSaver` in SDL3.
	 *
	 * @return `true` on success, `false` on failure.
	 */
	public static function enableScreensaver():Bool
		return SDLVideoNative.enableSaver();

	/**
	 * Prevents the screensaver from running (e.g. during video playback or gameplay).
	 *
	 * Corresponds to `SDL_DisableScreenSaver` in SDL3.
	 *
	 * @return `true` on success, `false` on failure.
	 */
	public static function disableScreensaver():Bool
		return SDLVideoNative.disableSaver();

	/* ---- OpenGL / EGL ---- */
	/**
	 * Dynamically loads an OpenGL library from a given path or system default.
	 *
	 * Corresponds to `SDL_GL_LoadLibrary` in SDL3.
	 *
	 * @param path Optional library path, or `null` for system default.
	 * @return `true` on success, `false` on failure.
	 */
	public static function glLoadLibrary(?path:String):Bool
		@:privateAccess return SDLVideoNative.glLoad(path == null ? null : path.toUtf8());

	/**
	 * Returns the procedure address of an OpenGL function by name for dynamic binding.
	 *
	 * Corresponds to `SDL_GL_GetProcAddress` in SDL3.
	 *
	 * @param name OpenGL function name.
	 * @return Abstract function pointer, or `null` if unavailable.
	 */
	public static function glGetProcAddress(name:String):Null<SDLFunctionPointerPtr>
		@:privateAccess return SDLVideoNative.glProc(name.toUtf8());

	/**
	 * Returns the procedure address of an EGL function by name for dynamic binding.
	 *
	 * Corresponds to `SDL_EGL_GetProcAddress` in SDL3.
	 *
	 * @param name EGL function name.
	 * @return Abstract function pointer, or `null` if unavailable.
	 */
	public static function eglGetProcAddress(name:String):Null<SDLFunctionPointerPtr>
		@:privateAccess return SDLVideoNative.eglProc(name.toUtf8());

	/**
	 * Unloads the OpenGL library previously loaded with `glLoadLibrary`.
	 *
	 * Corresponds to `SDL_GL_UnloadLibrary` in SDL3.
	 */
	public static function glUnloadLibrary():Void
		SDLVideoNative.glUnload();

	/**
	 * Checks if the named OpenGL extension is supported by the current context.
	 *
	 * Corresponds to `SDL_GL_ExtensionSupported` in SDL3.
	 *
	 * @param ext Extension name string.
	 * @return `true` if supported, `false` otherwise.
	 */
	public static function glExtensionSupported(ext:String):Bool
		@:privateAccess return SDLVideoNative.glExt(ext.toUtf8());

	/**
	 * Resets all OpenGL context attributes to their default values.
	 *
	 * Corresponds to `SDL_GL_ResetAttributes` in SDL3.
	 */
	public static function glResetAttributes():Void
		SDLVideoNative.glReset();

	/**
	 * Sets an OpenGL context attribute to be used upon subsequent context creation.
	 *
	 * Corresponds to `SDL_GL_SetAttribute` in SDL3.
	 *
	 * @param attr  The attribute enum value to set.
	 * @param value Desired integer value.
	 * @return `true` on success, `false` on failure.
	 */
	public static function glSetAttribute(attr:SDLGLAttr, value:Int):Bool
		return SDLVideoNative.glSet(attr, value);

	/**
	 * Returns the value of an OpenGL context attribute for the active context.
	 *
	 * Corresponds to `SDL_GL_GetAttribute` in SDL3.
	 *
	 * @param attr The attribute enum value to query.
	 * @return Attribute value, or `null` on failure.
	 */
	public static function glGetAttribute(attr:SDLGLAttr):Null<Int> {
		var o = new hl.NativeArray<Int>(1);
		return SDLVideoNative.glGet(attr, o) ? o[0] : null;
	}

	/**
	 * Creates an OpenGL context for the specified window.
	 *
	 * Corresponds to `SDL_GL_CreateContext` in SDL3.
	 *
	 * @param window Target `SDLWindow`.
	 * @return New `SDLGLContext` instance, or `null` on failure.
	 */
	public static function glCreateContext(window:SDLWindow):Null<SDLGLContext> {
		var p = SDLVideoNative.glCreate(@:privateAccess window.ptr);
		return p == null ? null : new SDLGLContext(p);
	}

	/**
	 * Makes a specific OpenGL context current for a window.
	 *
	 * Corresponds to `SDL_GL_MakeCurrent` in SDL3.
	 *
	 * @param window Associated `SDLWindow`.
	 * @param ctx    The `SDLGLContext` to set current.
	 * @return `true` on success, `false` on failure.
	 */
	public static function glMakeCurrent(window:SDLWindow, ctx:SDLGLContext):Bool
		return SDLVideoNative.glMakeCurrent(@:privateAccess window.ptr, @:privateAccess ctx.ptr);

	/**
	 * Returns the window associated with the current OpenGL context.
	 *
	 * Corresponds to `SDL_GL_GetCurrentWindow` in SDL3.
	 *
	 * @return Active `SDLWindow`, or `null` if none.
	 */
	public static function glGetCurrentWindow():Null<SDLWindow> {
		var p = SDLVideoNative.glCurrentWindow();
		return p == null ? null : @:privateAccess new SDLWindow(p);
	}

	/**
	 * Returns the currently active OpenGL rendering context.
	 *
	 * Corresponds to `SDL_GL_GetCurrentContext` in SDL3.
	 *
	 * @return Active `SDLGLContext`, or `null` if none.
	 */
	public static function glGetCurrentContext():Null<SDLGLContext> {
		var p = SDLVideoNative.glCurrentContext();
		return p == null ? null : new SDLGLContext(p);
	}

	/**
	 * Returns the raw EGL display handle for the current context.
	 *
	 * Corresponds to `SDL_EGL_GetCurrentDisplay` in SDL3.
	 *
	 * @return `SDLEGLDisplayPtr` handle, or `null` if unavailable.
	 */
	public static function eglGetCurrentDisplay():Null<SDLEGLDisplayPtr>
		return SDLVideoNative.eglCurrentDisplay();

	/**
	 * Returns the raw EGL configuration handle for the current context.
	 *
	 * Corresponds to `SDL_EGL_GetCurrentConfig` in SDL3.
	 *
	 * @return `SDLEGLConfigPtr` handle, or `null` if unavailable.
	 */
	public static function eglGetCurrentConfig():Null<SDLEGLConfigPtr>
		return SDLVideoNative.eglCurrentConfig();

	/**
	 * Returns the raw EGL surface handle associated with `window`.
	 *
	 * Corresponds to `SDL_EGL_GetWindowSurface` in SDL3.
	 *
	 * @param window Associated `SDLWindow`.
	 * @return `SDLEGLSurfacePtr` handle, or `null` if unavailable.
	 */
	public static function eglGetWindowSurface(window:SDLWindow):Null<SDLEGLSurfacePtr>
		return SDLVideoNative.eglWindowSurface(@:privateAccess window.ptr);

	/**
	 * Sets the swap interval (vsync) for the current OpenGL context.
	 *
	 * Corresponds to `SDL_GL_SetSwapInterval` in SDL3.
	 *
	 * @param interval Swap interval (`0` for immediate, `1` for vsync, `-1` for adaptive vsync).
	 * @return `true` on success, `false` on failure.
	 */
	public static function glSetSwapInterval(interval:Int):Bool
		return SDLVideoNative.glSetSwap(interval);

	/**
	 * Returns the current OpenGL swap interval setting.
	 *
	 * Corresponds to `SDL_GL_GetSwapInterval` in SDL3.
	 *
	 * @return Integer swap interval value, or `null` on failure.
	 */
	public static function glGetSwapInterval():Null<Int> {
		var o = new hl.NativeArray<Int>(1);
		return SDLVideoNative.glGetSwap(o) ? o[0] : null;
	}

	/**
	 * Swaps the OpenGL back buffer for `window`, presenting rendered content.
	 *
	 * Corresponds to `SDL_GL_SwapWindow` in SDL3.
	 *
	 * @param window The target `SDLWindow`.
	 * @return `true` on success, `false` on failure.
	 */
	public static function glSwapWindow(window:SDLWindow):Bool
		return SDLVideoNative.glSwap(@:privateAccess window.ptr);
}

/**
 * Information on a display's resolution, pixel format, pixel density, and refresh rate.
 *
 * Encapsulates data from `SDL_DisplayMode` in SDL3.
 */
class SDLDisplayMode {
	var ptr:SDLDisplayModePtr;

	@:allow(hl.bindings.sdl3)
	function new(ptr:SDLDisplayModePtr)
		this.ptr = ptr;

	/** ID of the display associated with this mode. Corresponds to `displayID` in `SDL_DisplayMode`. */
	public var displayID(get, never):Int;

	/** Pixel format integer identifier. Corresponds to `format` in `SDL_DisplayMode`. */
	public var format(get, never):Int;

	/** Screen width in pixels. Corresponds to `w` in `SDL_DisplayMode`. */
	public var width(get, never):Int;

	/** Screen height in pixels. Corresponds to `h` in `SDL_DisplayMode`. */
	public var height(get, never):Int;

	/** Pixel density scale factor. Corresponds to `pixel_density` in `SDL_DisplayMode`. */
	public var pixelDensity(get, never):Float;

	/** Approximate refresh rate in Hz. Corresponds to `refresh_rate` in `SDL_DisplayMode`. */
	public var refreshRate(get, never):Float;

	/** Precise refresh rate numerator. Corresponds to `refresh_rate_numerator` in `SDL_DisplayMode`. */
	public var refreshRateNumerator(get, never):Int;

	/** Precise refresh rate denominator. Corresponds to `refresh_rate_denominator` in `SDL_DisplayMode`. */
	public var refreshRateDenominator(get, never):Int;

	inline function get_displayID()
		return SDLVideoNative.modeId(ptr);

	inline function get_format()
		return SDLVideoNative.modeFormat(ptr);

	inline function get_width()
		return SDLVideoNative.modeW(ptr);

	inline function get_height()
		return SDLVideoNative.modeH(ptr);

	inline function get_pixelDensity()
		return SDLVideoNative.modePixelDensity(ptr);

	inline function get_refreshRate()
		return SDLVideoNative.modeRefreshRate(ptr);

	inline function get_refreshRateNumerator()
		return SDLVideoNative.modeRefreshNum(ptr);

	inline function get_refreshRateDenominator()
		return SDLVideoNative.modeRefreshDen(ptr);

	/**
	 * Returns a human-readable description of this display mode.
	 *
	 * @return Formatted string representation.
	 */
	public function toString():String
		return 'SDLDisplayMode(${width}x${height}@${refreshRate}Hz, display=$displayID)';

	@:allow(hl.bindings.sdl3)
	static function alloc():SDLDisplayMode
		return new SDLDisplayMode(SDLVideoNative.modeAlloc());
}

/**
 * An OpenGL rendering context created with `SDLVideo.glCreateContext`.
 *
 * Corresponds to `SDL_GLContext` in SDL3.
 */
class SDLGLContext {
	var ptr:SDLGLContextPtr;

	@:allow(hl.bindings.sdl3)
	function new(ptr:SDLGLContextPtr)
		this.ptr = ptr;

	/**
	 * Destroys the OpenGL context and releases allocated native resources.
	 *
	 * Corresponds to `SDL_GL_DestroyContext` in SDL3.
	 *
	 * @return `true` on success, `false` on failure.
	 */
	public function destroy():Bool {
		if (ptr == null)
			return true;
		var r = SDLVideoNative.glDestroy(ptr);
		ptr = null;
		return r;
	}
}
