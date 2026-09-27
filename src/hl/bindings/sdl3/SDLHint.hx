package hl.bindings.sdl3;

/**
 * The priority of a hint assignment.
 *
 * Higher-priority assignments override lower-priority ones. Resetting a hint
 * at a given priority restores whatever value was set at the next lower
 * priority, or the default if none.
 *
 * Corresponds to `SDL_HintPriority` in SDL3.
 */
enum abstract SDLHintPriority(Int) from Int to Int {
	/** Lowest priority: does not override any previously set value. */
	var DEFAULT = 0;

	/** Normal priority: overrides `DEFAULT` but not `OVERRIDE`. */
	var NORMAL = 1;

	/** Highest priority: overrides both `DEFAULT` and `NORMAL`. */
	var OVERRIDE = 2;
}

/**
 * Describes a change to the value of a hint.
 *
 * Delivered to callbacks registered with `SDLHint.watch()` and dispatched
 * by `SDLHint.poll()`.
 */
typedef SDLHintChangeEvent = {
	/** The name of the hint that changed (e.g. `"SDL_VIDEO_DRIVER"`). */
	name:String,

	/** The previous value, or `null` if the hint was unset. */
	oldValue:Null<String>,

	/** The new value, or `null` if the hint was reset. */
	newValue:Null<String>
}

typedef SDLHintChangePtr = hl.Abstract<"SDLHintChange">;

@:noCompletion
class SDLHintNative {
	@:hlNative("sdl3", "set_hint_with_priority") public static function setWithPriority(name:hl.Bytes, value:hl.Bytes, priority:Int):Bool
		return false;

	@:hlNative("sdl3", "set_hint") public static function set(name:hl.Bytes, value:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "reset_hint") public static function reset(name:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "reset_hints") public static function resetAll():Void {}

	@:hlNative("sdl3", "get_hint") public static function get(name:hl.Bytes):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_hint_boolean") public static function getBoolean(name:hl.Bytes, defaultValue:Bool):Bool
		return false;

	@:hlNative("sdl3", "add_hint_callback") public static function addCallback(name:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "remove_hint_callback") public static function removeCallback(name:hl.Bytes):Void {}

	@:hlNative("sdl3", "hint_callback_poll") public static function pollCallback():SDLHintChangePtr
		return null;

	@:hlNative("sdl3", "hint_change_name") public static function changeName(c:SDLHintChangePtr):hl.Bytes
		return null;

	@:hlNative("sdl3", "hint_change_old_value") public static function changeOldValue(c:SDLHintChangePtr):hl.Bytes
		return null;

	@:hlNative("sdl3", "hint_change_new_value") public static function changeNewValue(c:SDLHintChangePtr):hl.Bytes
		return null;

	@:hlNative("sdl3", "hint_change_free") public static function changeFree(c:SDLHintChangePtr):Void {}
}

/**
 * Canonical names of every SDL hint.
 *
 * Hints are string key/value pairs that let you influence SDL's behavior
 * before or during initialization. Each constant here corresponds to a
 * documented SDL hint (e.g. `SDL_HINT_VIDEO_DRIVER`). See the SDL3
 * documentation for the meaning and accepted values of each hint.
 *
 * Many hints must be set *before* the relevant subsystem is initialized
 * to take effect.
 */
class SDLHints {
	public static inline var ALLOW_ALT_TAB_WHILE_GRABBED = "SDL_ALLOW_ALT_TAB_WHILE_GRABBED";
	public static inline var ANDROID_ALLOW_RECREATE_ACTIVITY = "SDL_ANDROID_ALLOW_RECREATE_ACTIVITY";
	public static inline var ANDROID_BLOCK_ON_PAUSE = "SDL_ANDROID_BLOCK_ON_PAUSE";
	public static inline var ANDROID_LOW_LATENCY_AUDIO = "SDL_ANDROID_LOW_LATENCY_AUDIO";
	public static inline var ANDROID_AAUDIO_INPUT_PRESET = "SDL_ANDROID_AAUDIO_INPUT_PRESET";
	public static inline var ANDROID_TRAP_BACK_BUTTON = "SDL_ANDROID_TRAP_BACK_BUTTON";
	public static inline var APP_ID = "SDL_APP_ID";
	public static inline var APP_NAME = "SDL_APP_NAME";
	public static inline var APPLE_TV_CONTROLLER_UI_EVENTS = "SDL_APPLE_TV_CONTROLLER_UI_EVENTS";
	public static inline var APPLE_TV_REMOTE_ALLOW_ROTATION = "SDL_APPLE_TV_REMOTE_ALLOW_ROTATION";
	public static inline var AUDIO_ALSA_DEFAULT_DEVICE = "SDL_AUDIO_ALSA_DEFAULT_DEVICE";
	public static inline var AUDIO_ALSA_DEFAULT_PLAYBACK_DEVICE = "SDL_AUDIO_ALSA_DEFAULT_PLAYBACK_DEVICE";
	public static inline var AUDIO_ALSA_DEFAULT_RECORDING_DEVICE = "SDL_AUDIO_ALSA_DEFAULT_RECORDING_DEVICE";
	public static inline var AUDIO_CATEGORY = "SDL_AUDIO_CATEGORY";
	public static inline var AUDIO_CHANNELS = "SDL_AUDIO_CHANNELS";
	public static inline var AUDIO_DEVICE_APP_ICON_NAME = "SDL_AUDIO_DEVICE_APP_ICON_NAME";
	public static inline var AUDIO_DEVICE_SAMPLE_FRAMES = "SDL_AUDIO_DEVICE_SAMPLE_FRAMES";
	public static inline var AUDIO_DEVICE_STREAM_NAME = "SDL_AUDIO_DEVICE_STREAM_NAME";
	public static inline var AUDIO_DEVICE_STREAM_ROLE = "SDL_AUDIO_DEVICE_STREAM_ROLE";
	public static inline var AUDIO_DEVICE_RAW_STREAM = "SDL_AUDIO_DEVICE_RAW_STREAM";
	public static inline var AUDIO_DISK_INPUT_FILE = "SDL_AUDIO_DISK_INPUT_FILE";
	public static inline var AUDIO_DISK_OUTPUT_FILE = "SDL_AUDIO_DISK_OUTPUT_FILE";
	public static inline var AUDIO_DISK_TIMESCALE = "SDL_AUDIO_DISK_TIMESCALE";
	public static inline var AUDIO_DRIVER = "SDL_AUDIO_DRIVER";
	public static inline var AUDIO_DUMMY_TIMESCALE = "SDL_AUDIO_DUMMY_TIMESCALE";
	public static inline var AUDIO_FORMAT = "SDL_AUDIO_FORMAT";
	public static inline var AUDIO_FREQUENCY = "SDL_AUDIO_FREQUENCY";
	public static inline var AUDIO_INCLUDE_MONITORS = "SDL_AUDIO_INCLUDE_MONITORS";
	public static inline var AUTO_UPDATE_JOYSTICKS = "SDL_AUTO_UPDATE_JOYSTICKS";
	public static inline var AUTO_UPDATE_SENSORS = "SDL_AUTO_UPDATE_SENSORS";
	public static inline var BMP_SAVE_LEGACY_FORMAT = "SDL_BMP_SAVE_LEGACY_FORMAT";
	public static inline var CAMERA_DRIVER = "SDL_CAMERA_DRIVER";
	public static inline var CPU_FEATURE_MASK = "SDL_CPU_FEATURE_MASK";
	public static inline var JOYSTICK_DIRECTINPUT = "SDL_JOYSTICK_DIRECTINPUT";
	public static inline var FILE_DIALOG_DRIVER = "SDL_FILE_DIALOG_DRIVER";
	public static inline var DISPLAY_USABLE_BOUNDS = "SDL_DISPLAY_USABLE_BOUNDS";
	public static inline var INVALID_PARAM_CHECKS = "SDL_INVALID_PARAM_CHECKS";
	public static inline var EMSCRIPTEN_ASYNCIFY = "SDL_EMSCRIPTEN_ASYNCIFY";
	public static inline var EMSCRIPTEN_CANVAS_SELECTOR = "SDL_EMSCRIPTEN_CANVAS_SELECTOR";
	public static inline var EMSCRIPTEN_KEYBOARD_ELEMENT = "SDL_EMSCRIPTEN_KEYBOARD_ELEMENT";
	public static inline var ENABLE_SCREEN_KEYBOARD = "SDL_ENABLE_SCREEN_KEYBOARD";
	public static inline var ENABLE_STEAM_SCREEN_KEYBOARD = "SDL_ENABLE_STEAM_SCREEN_KEYBOARD";
	public static inline var EVDEV_DEVICES = "SDL_EVDEV_DEVICES";
	public static inline var EVENT_LOGGING = "SDL_EVENT_LOGGING";
	public static inline var FORCE_RAISEWINDOW = "SDL_FORCE_RAISEWINDOW";
	public static inline var FRAMEBUFFER_ACCELERATION = "SDL_FRAMEBUFFER_ACCELERATION";
	public static inline var GAMECONTROLLERCONFIG = "SDL_GAMECONTROLLERCONFIG";
	public static inline var GAMECONTROLLERCONFIG_FILE = "SDL_GAMECONTROLLERCONFIG_FILE";
	public static inline var GAMECONTROLLERTYPE = "SDL_GAMECONTROLLERTYPE";
	public static inline var GAMECONTROLLER_IGNORE_DEVICES = "SDL_GAMECONTROLLER_IGNORE_DEVICES";
	public static inline var GAMECONTROLLER_IGNORE_DEVICES_EXCEPT = "SDL_GAMECONTROLLER_IGNORE_DEVICES_EXCEPT";
	public static inline var GAMECONTROLLER_SENSOR_FUSION = "SDL_GAMECONTROLLER_SENSOR_FUSION";
	public static inline var GDK_TEXTINPUT_DEFAULT_TEXT = "SDL_GDK_TEXTINPUT_DEFAULT_TEXT";
	public static inline var GDK_TEXTINPUT_DESCRIPTION = "SDL_GDK_TEXTINPUT_DESCRIPTION";
	public static inline var GDK_TEXTINPUT_MAX_LENGTH = "SDL_GDK_TEXTINPUT_MAX_LENGTH";
	public static inline var GDK_TEXTINPUT_SCOPE = "SDL_GDK_TEXTINPUT_SCOPE";
	public static inline var GDK_TEXTINPUT_TITLE = "SDL_GDK_TEXTINPUT_TITLE";
	public static inline var HIDAPI_LIBUSB = "SDL_HIDAPI_LIBUSB";
	public static inline var HIDAPI_LIBUSB_GAMECUBE = "SDL_HIDAPI_LIBUSB_GAMECUBE";
	public static inline var HIDAPI_LIBUSB_WHITELIST = "SDL_HIDAPI_LIBUSB_WHITELIST";
	public static inline var HIDAPI_UDEV = "SDL_HIDAPI_UDEV";
	public static inline var GPU_DRIVER = "SDL_GPU_DRIVER";
	public static inline var HIDAPI_ENUMERATE_ONLY_CONTROLLERS = "SDL_HIDAPI_ENUMERATE_ONLY_CONTROLLERS";
	public static inline var HIDAPI_IGNORE_DEVICES = "SDL_HIDAPI_IGNORE_DEVICES";
	public static inline var IME_IMPLEMENTED_UI = "SDL_IME_IMPLEMENTED_UI";
	public static inline var IOS_HIDE_HOME_INDICATOR = "SDL_IOS_HIDE_HOME_INDICATOR";
	public static inline var JOYSTICK_ALLOW_BACKGROUND_EVENTS = "SDL_JOYSTICK_ALLOW_BACKGROUND_EVENTS";
	public static inline var JOYSTICK_ARCADESTICK_DEVICES = "SDL_JOYSTICK_ARCADESTICK_DEVICES";
	public static inline var JOYSTICK_ARCADESTICK_DEVICES_EXCLUDED = "SDL_JOYSTICK_ARCADESTICK_DEVICES_EXCLUDED";
	public static inline var JOYSTICK_BLACKLIST_DEVICES = "SDL_JOYSTICK_BLACKLIST_DEVICES";
	public static inline var JOYSTICK_BLACKLIST_DEVICES_EXCLUDED = "SDL_JOYSTICK_BLACKLIST_DEVICES_EXCLUDED";
	public static inline var JOYSTICK_DEVICE = "SDL_JOYSTICK_DEVICE";
	public static inline var JOYSTICK_ENHANCED_REPORTS = "SDL_JOYSTICK_ENHANCED_REPORTS";
	public static inline var JOYSTICK_FLIGHTSTICK_DEVICES = "SDL_JOYSTICK_FLIGHTSTICK_DEVICES";
	public static inline var JOYSTICK_FLIGHTSTICK_DEVICES_EXCLUDED = "SDL_JOYSTICK_FLIGHTSTICK_DEVICES_EXCLUDED";
	public static inline var JOYSTICK_GAMEINPUT = "SDL_JOYSTICK_GAMEINPUT";
	public static inline var JOYSTICK_GAMEINPUT_RAW = "SDL_JOYSTICK_GAMEINPUT_RAW";
	public static inline var JOYSTICK_GAMECUBE_DEVICES = "SDL_JOYSTICK_GAMECUBE_DEVICES";
	public static inline var JOYSTICK_GAMECUBE_DEVICES_EXCLUDED = "SDL_JOYSTICK_GAMECUBE_DEVICES_EXCLUDED";
	public static inline var JOYSTICK_HIDAPI = "SDL_JOYSTICK_HIDAPI";
	public static inline var JOYSTICK_HIDAPI_COMBINE_JOY_CONS = "SDL_JOYSTICK_HIDAPI_COMBINE_JOY_CONS";
	public static inline var JOYSTICK_HIDAPI_GAMECUBE = "SDL_JOYSTICK_HIDAPI_GAMECUBE";
	public static inline var JOYSTICK_HIDAPI_GAMECUBE_RUMBLE_BRAKE = "SDL_JOYSTICK_HIDAPI_GAMECUBE_RUMBLE_BRAKE";
	public static inline var JOYSTICK_HIDAPI_JOY_CONS = "SDL_JOYSTICK_HIDAPI_JOY_CONS";
	public static inline var JOYSTICK_HIDAPI_JOYCON_HOME_LED = "SDL_JOYSTICK_HIDAPI_JOYCON_HOME_LED";
	public static inline var JOYSTICK_HIDAPI_LUNA = "SDL_JOYSTICK_HIDAPI_LUNA";
	public static inline var JOYSTICK_HIDAPI_NINTENDO_CLASSIC = "SDL_JOYSTICK_HIDAPI_NINTENDO_CLASSIC";
	public static inline var JOYSTICK_HIDAPI_PS3 = "SDL_JOYSTICK_HIDAPI_PS3";
	public static inline var JOYSTICK_HIDAPI_PS3_SIXAXIS_DRIVER = "SDL_JOYSTICK_HIDAPI_PS3_SIXAXIS_DRIVER";
	public static inline var JOYSTICK_HIDAPI_PS4 = "SDL_JOYSTICK_HIDAPI_PS4";
	public static inline var JOYSTICK_HIDAPI_PS4_REPORT_INTERVAL = "SDL_JOYSTICK_HIDAPI_PS4_REPORT_INTERVAL";
	public static inline var JOYSTICK_HIDAPI_PS5 = "SDL_JOYSTICK_HIDAPI_PS5";
	public static inline var JOYSTICK_HIDAPI_PS5_PLAYER_LED = "SDL_JOYSTICK_HIDAPI_PS5_PLAYER_LED";
	public static inline var JOYSTICK_HIDAPI_SHIELD = "SDL_JOYSTICK_HIDAPI_SHIELD";
	public static inline var JOYSTICK_HIDAPI_STADIA = "SDL_JOYSTICK_HIDAPI_STADIA";
	public static inline var JOYSTICK_HIDAPI_STEAM = "SDL_JOYSTICK_HIDAPI_STEAM";
	public static inline var JOYSTICK_HIDAPI_STEAM_HOME_LED = "SDL_JOYSTICK_HIDAPI_STEAM_HOME_LED";
	public static inline var JOYSTICK_HIDAPI_STEAMDECK = "SDL_JOYSTICK_HIDAPI_STEAMDECK";
	public static inline var JOYSTICK_HIDAPI_STEAM_HORI = "SDL_JOYSTICK_HIDAPI_STEAM_HORI";
	public static inline var JOYSTICK_HIDAPI_LG4FF = "SDL_JOYSTICK_HIDAPI_LG4FF";
	public static inline var JOYSTICK_HIDAPI_8BITDO = "SDL_JOYSTICK_HIDAPI_8BITDO";
	public static inline var JOYSTICK_HIDAPI_SINPUT = "SDL_JOYSTICK_HIDAPI_SINPUT";
	public static inline var JOYSTICK_HIDAPI_ZUIKI = "SDL_JOYSTICK_HIDAPI_ZUIKI";
	public static inline var JOYSTICK_HIDAPI_FLYDIGI = "SDL_JOYSTICK_HIDAPI_FLYDIGI";
	public static inline var JOYSTICK_HIDAPI_SWITCH = "SDL_JOYSTICK_HIDAPI_SWITCH";
	public static inline var JOYSTICK_HIDAPI_SWITCH_HOME_LED = "SDL_JOYSTICK_HIDAPI_SWITCH_HOME_LED";
	public static inline var JOYSTICK_HIDAPI_SWITCH_PLAYER_LED = "SDL_JOYSTICK_HIDAPI_SWITCH_PLAYER_LED";
	public static inline var JOYSTICK_HIDAPI_SWITCH2 = "SDL_JOYSTICK_HIDAPI_SWITCH2";
	public static inline var JOYSTICK_HIDAPI_VERTICAL_JOY_CONS = "SDL_JOYSTICK_HIDAPI_VERTICAL_JOY_CONS";
	public static inline var JOYSTICK_HIDAPI_WII = "SDL_JOYSTICK_HIDAPI_WII";
	public static inline var JOYSTICK_HIDAPI_WII_PLAYER_LED = "SDL_JOYSTICK_HIDAPI_WII_PLAYER_LED";
	public static inline var JOYSTICK_HIDAPI_XBOX = "SDL_JOYSTICK_HIDAPI_XBOX";
	public static inline var JOYSTICK_HIDAPI_XBOX_360 = "SDL_JOYSTICK_HIDAPI_XBOX_360";
	public static inline var JOYSTICK_HIDAPI_XBOX_360_PLAYER_LED = "SDL_JOYSTICK_HIDAPI_XBOX_360_PLAYER_LED";
	public static inline var JOYSTICK_HIDAPI_XBOX_360_WIRELESS = "SDL_JOYSTICK_HIDAPI_XBOX_360_WIRELESS";
	public static inline var JOYSTICK_HIDAPI_XBOX_ONE = "SDL_JOYSTICK_HIDAPI_XBOX_ONE";
	public static inline var JOYSTICK_HIDAPI_XBOX_ONE_HOME_LED = "SDL_JOYSTICK_HIDAPI_XBOX_ONE_HOME_LED";
	public static inline var JOYSTICK_HIDAPI_GIP = "SDL_JOYSTICK_HIDAPI_GIP";
	public static inline var JOYSTICK_HIDAPI_GIP_RESET_FOR_METADATA = "SDL_JOYSTICK_HIDAPI_GIP_RESET_FOR_METADATA";
	public static inline var JOYSTICK_IOKIT = "SDL_JOYSTICK_IOKIT";
	public static inline var JOYSTICK_LINUX_CLASSIC = "SDL_JOYSTICK_LINUX_CLASSIC";
	public static inline var JOYSTICK_LINUX_DEADZONES = "SDL_JOYSTICK_LINUX_DEADZONES";
	public static inline var JOYSTICK_LINUX_DIGITAL_HATS = "SDL_JOYSTICK_LINUX_DIGITAL_HATS";
	public static inline var JOYSTICK_LINUX_HAT_DEADZONES = "SDL_JOYSTICK_LINUX_HAT_DEADZONES";
	public static inline var JOYSTICK_MFI = "SDL_JOYSTICK_MFI";
	public static inline var JOYSTICK_RAWINPUT = "SDL_JOYSTICK_RAWINPUT";
	public static inline var JOYSTICK_RAWINPUT_CORRELATE_XINPUT = "SDL_JOYSTICK_RAWINPUT_CORRELATE_XINPUT";
	public static inline var JOYSTICK_ROG_CHAKRAM = "SDL_JOYSTICK_ROG_CHAKRAM";
	public static inline var JOYSTICK_THREAD = "SDL_JOYSTICK_THREAD";
	public static inline var JOYSTICK_THROTTLE_DEVICES = "SDL_JOYSTICK_THROTTLE_DEVICES";
	public static inline var JOYSTICK_THROTTLE_DEVICES_EXCLUDED = "SDL_JOYSTICK_THROTTLE_DEVICES_EXCLUDED";
	public static inline var JOYSTICK_WGI = "SDL_JOYSTICK_WGI";
	public static inline var JOYSTICK_WHEEL_DEVICES = "SDL_JOYSTICK_WHEEL_DEVICES";
	public static inline var JOYSTICK_WHEEL_DEVICES_EXCLUDED = "SDL_JOYSTICK_WHEEL_DEVICES_EXCLUDED";
	public static inline var JOYSTICK_ZERO_CENTERED_DEVICES = "SDL_JOYSTICK_ZERO_CENTERED_DEVICES";
	public static inline var JOYSTICK_HAPTIC_AXES = "SDL_JOYSTICK_HAPTIC_AXES";
	public static inline var KEYCODE_OPTIONS = "SDL_KEYCODE_OPTIONS";
	public static inline var KMSDRM_DEVICE_INDEX = "SDL_KMSDRM_DEVICE_INDEX";
	public static inline var KMSDRM_REQUIRE_DRM_MASTER = "SDL_KMSDRM_REQUIRE_DRM_MASTER";
	public static inline var KMSDRM_ATOMIC = "SDL_KMSDRM_ATOMIC";
	public static inline var LOGGING = "SDL_LOGGING";
	public static inline var MAC_BACKGROUND_APP = "SDL_MAC_BACKGROUND_APP";
	public static inline var MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK = "SDL_MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK";
	public static inline var MAC_OPENGL_ASYNC_DISPATCH = "SDL_MAC_OPENGL_ASYNC_DISPATCH";
	public static inline var MAC_OPTION_AS_ALT = "SDL_MAC_OPTION_AS_ALT";
	public static inline var MAC_SCROLL_MOMENTUM = "SDL_MAC_SCROLL_MOMENTUM";
	public static inline var MAC_PRESS_AND_HOLD = "SDL_MAC_PRESS_AND_HOLD";
	public static inline var MAIN_CALLBACK_RATE = "SDL_MAIN_CALLBACK_RATE";
	public static inline var MOUSE_AUTO_CAPTURE = "SDL_MOUSE_AUTO_CAPTURE";
	public static inline var MOUSE_DOUBLE_CLICK_RADIUS = "SDL_MOUSE_DOUBLE_CLICK_RADIUS";
	public static inline var MOUSE_DOUBLE_CLICK_TIME = "SDL_MOUSE_DOUBLE_CLICK_TIME";
	public static inline var MOUSE_DEFAULT_SYSTEM_CURSOR = "SDL_MOUSE_DEFAULT_SYSTEM_CURSOR";
	public static inline var MOUSE_DPI_SCALE_CURSORS = "SDL_MOUSE_DPI_SCALE_CURSORS";
	public static inline var MOUSE_EMULATE_WARP_WITH_RELATIVE = "SDL_MOUSE_EMULATE_WARP_WITH_RELATIVE";
	public static inline var MOUSE_FOCUS_CLICKTHROUGH = "SDL_MOUSE_FOCUS_CLICKTHROUGH";
	public static inline var MOUSE_NORMAL_SPEED_SCALE = "SDL_MOUSE_NORMAL_SPEED_SCALE";
	public static inline var MOUSE_RELATIVE_MODE_CENTER = "SDL_MOUSE_RELATIVE_MODE_CENTER";
	public static inline var MOUSE_RELATIVE_SPEED_SCALE = "SDL_MOUSE_RELATIVE_SPEED_SCALE";
	public static inline var MOUSE_RELATIVE_SYSTEM_SCALE = "SDL_MOUSE_RELATIVE_SYSTEM_SCALE";
	public static inline var MOUSE_RELATIVE_WARP_MOTION = "SDL_MOUSE_RELATIVE_WARP_MOTION";
	public static inline var MOUSE_RELATIVE_CURSOR_VISIBLE = "SDL_MOUSE_RELATIVE_CURSOR_VISIBLE";
	public static inline var MOUSE_TOUCH_EVENTS = "SDL_MOUSE_TOUCH_EVENTS";
	public static inline var MUTE_CONSOLE_KEYBOARD = "SDL_MUTE_CONSOLE_KEYBOARD";
	public static inline var NO_SIGNAL_HANDLERS = "SDL_NO_SIGNAL_HANDLERS";
	public static inline var OPENGL_LIBRARY = "SDL_OPENGL_LIBRARY";
	public static inline var EGL_LIBRARY = "SDL_EGL_LIBRARY";
	public static inline var OPENGL_ES_DRIVER = "SDL_OPENGL_ES_DRIVER";
	public static inline var OPENGL_FORCE_SRGB_FRAMEBUFFER = "SDL_OPENGL_FORCE_SRGB_FRAMEBUFFER";
	public static inline var OPENVR_LIBRARY = "SDL_OPENVR_LIBRARY";
	public static inline var ORIENTATIONS = "SDL_ORIENTATIONS";
	public static inline var POLL_SENTINEL = "SDL_POLL_SENTINEL";
	public static inline var PREFERRED_LOCALES = "SDL_PREFERRED_LOCALES";
	public static inline var QUIT_ON_LAST_WINDOW_CLOSE = "SDL_QUIT_ON_LAST_WINDOW_CLOSE";
	public static inline var RENDER_DIRECT3D_THREADSAFE = "SDL_RENDER_DIRECT3D_THREADSAFE";
	public static inline var RENDER_DIRECT3D11_DEBUG = "SDL_RENDER_DIRECT3D11_DEBUG";
	public static inline var RENDER_DIRECT3D11_WARP = "SDL_RENDER_DIRECT3D11_WARP";
	public static inline var RENDER_VULKAN_DEBUG = "SDL_RENDER_VULKAN_DEBUG";
	public static inline var RENDER_GPU_DEBUG = "SDL_RENDER_GPU_DEBUG";
	public static inline var RENDER_GPU_LOW_POWER = "SDL_RENDER_GPU_LOW_POWER";
	public static inline var RENDER_DRIVER = "SDL_RENDER_DRIVER";
	public static inline var RENDER_LINE_METHOD = "SDL_RENDER_LINE_METHOD";
	public static inline var RENDER_METAL_PREFER_LOW_POWER_DEVICE = "SDL_RENDER_METAL_PREFER_LOW_POWER_DEVICE";
	public static inline var RENDER_VSYNC = "SDL_RENDER_VSYNC";
	public static inline var RETURN_KEY_HIDES_IME = "SDL_RETURN_KEY_HIDES_IME";
	public static inline var ROG_GAMEPAD_MICE = "SDL_ROG_GAMEPAD_MICE";
	public static inline var ROG_GAMEPAD_MICE_EXCLUDED = "SDL_ROG_GAMEPAD_MICE_EXCLUDED";
	public static inline var PS2_GS_WIDTH = "SDL_PS2_GS_WIDTH";
	public static inline var PS2_GS_HEIGHT = "SDL_PS2_GS_HEIGHT";
	public static inline var PS2_GS_PROGRESSIVE = "SDL_PS2_GS_PROGRESSIVE";
	public static inline var PS2_GS_MODE = "SDL_PS2_GS_MODE";
	public static inline var RPI_VIDEO_LAYER = "SDL_RPI_VIDEO_LAYER";
	public static inline var SCREENSAVER_INHIBIT_ACTIVITY_NAME = "SDL_SCREENSAVER_INHIBIT_ACTIVITY_NAME";
	public static inline var SHUTDOWN_DBUS_ON_QUIT = "SDL_SHUTDOWN_DBUS_ON_QUIT";
	public static inline var STORAGE_TITLE_DRIVER = "SDL_STORAGE_TITLE_DRIVER";
	public static inline var STORAGE_USER_DRIVER = "SDL_STORAGE_USER_DRIVER";
	public static inline var THREAD_FORCE_REALTIME_TIME_CRITICAL = "SDL_THREAD_FORCE_REALTIME_TIME_CRITICAL";
	public static inline var THREAD_PRIORITY_POLICY = "SDL_THREAD_PRIORITY_POLICY";
	public static inline var TIMER_RESOLUTION = "SDL_TIMER_RESOLUTION";
	public static inline var TOUCH_MOUSE_EVENTS = "SDL_TOUCH_MOUSE_EVENTS";
	public static inline var TRACKPAD_IS_TOUCH_ONLY = "SDL_TRACKPAD_IS_TOUCH_ONLY";
	public static inline var TV_REMOTE_AS_JOYSTICK = "SDL_TV_REMOTE_AS_JOYSTICK";
	public static inline var VIDEO_ALLOW_SCREENSAVER = "SDL_VIDEO_ALLOW_SCREENSAVER";
	public static inline var VIDEO_DISPLAY_PRIORITY = "SDL_VIDEO_DISPLAY_PRIORITY";
	public static inline var VIDEO_DOUBLE_BUFFER = "SDL_VIDEO_DOUBLE_BUFFER";
	public static inline var VIDEO_DRIVER = "SDL_VIDEO_DRIVER";
	public static inline var VIDEO_DUMMY_SAVE_FRAMES = "SDL_VIDEO_DUMMY_SAVE_FRAMES";
	public static inline var VIDEO_EGL_ALLOW_GETDISPLAY_FALLBACK = "SDL_VIDEO_EGL_ALLOW_GETDISPLAY_FALLBACK";
	public static inline var VIDEO_FORCE_EGL = "SDL_VIDEO_FORCE_EGL";
	public static inline var VIDEO_MAC_FULLSCREEN_SPACES = "SDL_VIDEO_MAC_FULLSCREEN_SPACES";
	public static inline var VIDEO_MAC_FULLSCREEN_MENU_VISIBILITY = "SDL_VIDEO_MAC_FULLSCREEN_MENU_VISIBILITY";
	public static inline var VIDEO_METAL_AUTO_RESIZE_DRAWABLE = "SDL_VIDEO_METAL_AUTO_RESIZE_DRAWABLE";
	public static inline var VIDEO_MATCH_EXCLUSIVE_MODE_ON_MOVE = "SDL_VIDEO_MATCH_EXCLUSIVE_MODE_ON_MOVE";
	public static inline var VIDEO_MINIMIZE_ON_FOCUS_LOSS = "SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS";
	public static inline var VIDEO_OFFSCREEN_SAVE_FRAMES = "SDL_VIDEO_OFFSCREEN_SAVE_FRAMES";
	public static inline var VIDEO_SYNC_WINDOW_OPERATIONS = "SDL_VIDEO_SYNC_WINDOW_OPERATIONS";
	public static inline var VIDEO_WAYLAND_ALLOW_LIBDECOR = "SDL_VIDEO_WAYLAND_ALLOW_LIBDECOR";
	public static inline var VIDEO_WAYLAND_MODE_EMULATION = "SDL_VIDEO_WAYLAND_MODE_EMULATION";
	public static inline var VIDEO_WAYLAND_MODE_SCALING = "SDL_VIDEO_WAYLAND_MODE_SCALING";
	public static inline var VIDEO_WAYLAND_PREFER_LIBDECOR = "SDL_VIDEO_WAYLAND_PREFER_LIBDECOR";
	public static inline var VIDEO_WAYLAND_SCALE_TO_DISPLAY = "SDL_VIDEO_WAYLAND_SCALE_TO_DISPLAY";
	public static inline var VIDEO_WIN_D3DCOMPILER = "SDL_VIDEO_WIN_D3DCOMPILER";
	public static inline var VIDEO_X11_ENABLE_XSYNC_EXT = "SDL_VIDEO_X11_ENABLE_XSYNC_EXT";
	public static inline var VIDEO_X11_EXTERNAL_WINDOW_INPUT = "SDL_VIDEO_X11_EXTERNAL_WINDOW_INPUT";
	public static inline var VIDEO_X11_NET_WM_BYPASS_COMPOSITOR = "SDL_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR";
	public static inline var VIDEO_X11_NET_WM_PING = "SDL_VIDEO_X11_NET_WM_PING";
	public static inline var VIDEO_X11_NODIRECTCOLOR = "SDL_VIDEO_X11_NODIRECTCOLOR";
	public static inline var VIDEO_X11_SCALING_FACTOR = "SDL_VIDEO_X11_SCALING_FACTOR";
	public static inline var VIDEO_X11_VISUALID = "SDL_VIDEO_X11_VISUALID";
	public static inline var VIDEO_X11_WINDOW_VISUALID = "SDL_VIDEO_X11_WINDOW_VISUALID";
	public static inline var VIDEO_X11_XRANDR = "SDL_VIDEO_X11_XRANDR";
	public static inline var VITA_ENABLE_BACK_TOUCH = "SDL_VITA_ENABLE_BACK_TOUCH";
	public static inline var VITA_ENABLE_FRONT_TOUCH = "SDL_VITA_ENABLE_FRONT_TOUCH";
	public static inline var VITA_MODULE_PATH = "SDL_VITA_MODULE_PATH";
	public static inline var VITA_PVR_INIT = "SDL_VITA_PVR_INIT";
	public static inline var VITA_RESOLUTION = "SDL_VITA_RESOLUTION";
	public static inline var VITA_PVR_OPENGL = "SDL_VITA_PVR_OPENGL";
	public static inline var VITA_TOUCH_MOUSE_DEVICE = "SDL_VITA_TOUCH_MOUSE_DEVICE";
	public static inline var VULKAN_DISPLAY = "SDL_VULKAN_DISPLAY";
	public static inline var VULKAN_LIBRARY = "SDL_VULKAN_LIBRARY";
	public static inline var WAVE_FACT_CHUNK = "SDL_WAVE_FACT_CHUNK";
	public static inline var WAVE_CHUNK_LIMIT = "SDL_WAVE_CHUNK_LIMIT";
	public static inline var WAVE_RIFF_CHUNK_SIZE = "SDL_WAVE_RIFF_CHUNK_SIZE";
	public static inline var WAVE_TRUNCATION = "SDL_WAVE_TRUNCATION";
	public static inline var WINDOW_ACTIVATE_WHEN_RAISED = "SDL_WINDOW_ACTIVATE_WHEN_RAISED";
	public static inline var WINDOW_ACTIVATE_WHEN_SHOWN = "SDL_WINDOW_ACTIVATE_WHEN_SHOWN";
	public static inline var WINDOW_ALLOW_TOPMOST = "SDL_WINDOW_ALLOW_TOPMOST";
	public static inline var WINDOW_FRAME_USABLE_WHILE_CURSOR_HIDDEN = "SDL_WINDOW_FRAME_USABLE_WHILE_CURSOR_HIDDEN";
	public static inline var WINDOWS_CLOSE_ON_ALT_F4 = "SDL_WINDOWS_CLOSE_ON_ALT_F4";
	public static inline var WINDOWS_ENABLE_MENU_MNEMONICS = "SDL_WINDOWS_ENABLE_MENU_MNEMONICS";
	public static inline var WINDOWS_ENABLE_MESSAGELOOP = "SDL_WINDOWS_ENABLE_MESSAGELOOP";
	public static inline var WINDOWS_GAMEINPUT = "SDL_WINDOWS_GAMEINPUT";
	public static inline var WINDOWS_RAW_KEYBOARD = "SDL_WINDOWS_RAW_KEYBOARD";
	public static inline var WINDOWS_RAW_KEYBOARD_EXCLUDE_HOTKEYS = "SDL_WINDOWS_RAW_KEYBOARD_EXCLUDE_HOTKEYS";
	public static inline var WINDOWS_RAW_KEYBOARD_INPUTSINK = "SDL_WINDOWS_RAW_KEYBOARD_INPUTSINK";
	public static inline var WINDOWS_FORCE_SEMAPHORE_KERNEL = "SDL_WINDOWS_FORCE_SEMAPHORE_KERNEL";
	public static inline var WINDOWS_INTRESOURCE_ICON = "SDL_WINDOWS_INTRESOURCE_ICON";
	public static inline var WINDOWS_INTRESOURCE_ICON_SMALL = "SDL_WINDOWS_INTRESOURCE_ICON_SMALL";
	public static inline var WINDOWS_USE_D3D9EX = "SDL_WINDOWS_USE_D3D9EX";
	public static inline var WINDOWS_ERASE_BACKGROUND_MODE = "SDL_WINDOWS_ERASE_BACKGROUND_MODE";
	public static inline var X11_FORCE_OVERRIDE_REDIRECT = "SDL_X11_FORCE_OVERRIDE_REDIRECT";
	public static inline var X11_WINDOW_TYPE = "SDL_X11_WINDOW_TYPE";
	public static inline var X11_XCB_LIBRARY = "SDL_X11_XCB_LIBRARY";
	public static inline var XINPUT_ENABLED = "SDL_XINPUT_ENABLED";
	public static inline var ASSERT = "SDL_ASSERT";
	public static inline var PEN_MOUSE_EVENTS = "SDL_PEN_MOUSE_EVENTS";
	public static inline var PEN_TOUCH_EVENTS = "SDL_PEN_TOUCH_EVENTS";
}

/**
 * Hints API.
 *
 * Hints are string key/value pairs that let you influence SDL's behavior
 * before or during initialization. Common uses include selecting a video or
 * audio driver, disabling specific input devices, or tweaking rendering
 * behavior.
 *
 * Hints can also be set via environment variables of the same name. Setting
 * a hint programmatically takes precedence over the environment variable.
 *
 * Corresponds to the SDL3 hint API (`SDL_SetHint`, `SDL_GetHint`,
 * `SDL_AddHintCallback`, and related functions).
 */
class SDLHint {
	static var watchers:Map<String, Array<SDLHintChangeEvent->Void>> = new Map();

	static inline function str(b:hl.Bytes):Null<String>
		@:privateAccess return b == null ? null : String.fromUTF8(b);

	/**
	 * Sets a hint to the given value with `NORMAL` priority.
	 *
	 * Equivalent to `setWithPriority(name, value, NORMAL)`.
	 *
	 * @param name  The hint name (use a constant from `SDLHints`).
	 * @param value The hint value.
	 * @return `true` if the hint was set successfully.
	 */
	public static function set(name:String, value:String):Bool
		@:privateAccess return SDLHintNative.set(name.toUtf8(), value.toUtf8());

	/**
	 * Sets a hint to the given value with an explicit priority.
	 *
	 * Higher priorities override lower ones; resetting a hint at a higher
	 * priority reveals the value previously set at a lower one.
	 *
	 * @param name     The hint name.
	 * @param value    The hint value.
	 * @param priority The priority to set the hint at.
	 * @return `true` if the hint was set successfully.
	 */
	public static function setWithPriority(name:String, value:String, priority:SDLHintPriority):Bool
		@:privateAccess return SDLHintNative.setWithPriority(name.toUtf8(), value.toUtf8(), priority);

	/**
	 * Resets a hint, clearing any value set at the highest active priority.
	 *
	 * @param name The hint name to reset.
	 * @return `true` if the hint was reset successfully.
	 */
	public static function reset(name:String):Bool
		@:privateAccess return SDLHintNative.reset(name.toUtf8());

	/** Resets every hint to its default state. */
	public static function resetAll():Void
		SDLHintNative.resetAll();

	/**
	 * Returns the current value of a hint.
	 *
	 * @param name The hint name.
	 * @return The hint value, or `null` if the hint is not set.
	 */
	public static function get(name:String):Null<String>
		@:privateAccess return str(SDLHintNative.get(name.toUtf8()));

	/**
	 * Returns the current value of a hint as a boolean.
	 *
	 * A hint is considered `true` when it is set to `"1"`, `"true"`, or
	 * `"yes"` (case-insensitive); `false` when set to `"0"`, `"false"`, or
	 * `"no"`; and `defaultValue` when unset or unrecognized.
	 *
	 * @param name         The hint name.
	 * @param defaultValue Value to return when the hint is unset.
	 * @return The parsed hint value.
	 */
	public static function getBoolean(name:String, defaultValue:Bool = false):Bool
		@:privateAccess return SDLHintNative.getBoolean(name.toUtf8(), defaultValue);

	/**
	 * Registers a callback that fires whenever a hint changes.
	 *
	 * Multiple callbacks may be registered for the same hint. Callbacks are
	 * dispatched from `poll()`; they are **not** invoked from SDL threads.
	 *
	 * @param name     The hint name to watch.
	 * @param callback Callback invoked with the change event.
	 * @return `true` if the watch was registered successfully.
	 */
	public static function watch(name:String, callback:SDLHintChangeEvent->Void):Bool {
		var list = watchers.get(name);
		if (list == null) {
			list = [];
			watchers.set(name, list);
			@:privateAccess
			if (!SDLHintNative.addCallback(name.toUtf8())) {
				watchers.remove(name);
				return false;
			}
		}
		list.push(callback);
		return true;
	}

	/**
	 * Removes a previously registered hint change callback.
	 *
	 * When the last callback for a given hint is removed, the underlying SDL
	 * watcher is also unregistered.
	 *
	 * @param name     The hint name the callback was registered for.
	 * @param callback The callback to remove.
	 */
	public static function unwatch(name:String, callback:SDLHintChangeEvent->Void):Void {
		var list = watchers.get(name);
		if (list == null)
			return;
		list.remove(callback);
		if (list.length == 0) {
			watchers.remove(name);
			@:privateAccess SDLHintNative.removeCallback(name.toUtf8());
		}
	}

	/**
	 * Processes pending hint change events and dispatches their callbacks.
	 *
	 * Call this regularly (e.g. once per frame) if you use `watch()`.
	 *
	 * @return The number of change events dispatched.
	 */
	public static function poll():Int {
		var n = 0;
		while (true) {
			var c = SDLHintNative.pollCallback();
			if (c == null)
				break;
			var name = str(SDLHintNative.changeName(c));
			var ev:SDLHintChangeEvent = {
				name: name,
				oldValue: str(SDLHintNative.changeOldValue(c)),
				newValue: str(SDLHintNative.changeNewValue(c))
			};
			SDLHintNative.changeFree(c);
			var list = watchers.get(name);
			if (list != null)
				for (cb in list)
					cb(ev);
			n++;
		}
		return n;
	}
}
