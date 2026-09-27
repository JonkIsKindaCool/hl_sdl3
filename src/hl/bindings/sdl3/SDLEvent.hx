package hl.bindings.sdl3;

import haxe.Int64;

/**
 * The types of events that can be delivered.
 *
 * Corresponds to `SDL_EventType` in SDL3.
 */
enum abstract SDLEventType(Int) from Int to Int {
	/** Unused; do not remove. First event type in the range of valid IDs. */
	var FIRST = 0;

	/* Application events */
	/** User-requested quit (e.g. closing the last window or pressing Ctrl-C). */
	var QUIT = 0x100;

	/**
	 * The application is being terminated by the OS.
	 */
	var TERMINATING = 0x101;

	/**
	 * The application is low on memory; free memory if possible.
	 */
	var LOW_MEMORY = 0x102;

	/**
	 * The application is about to enter the background.
	 */
	var WILL_ENTER_BACKGROUND = 0x103;

	/**
	 * The application did enter the background and may not get CPU for some time.
	 */
	var DID_ENTER_BACKGROUND = 0x104;

	/**
	 * The application is about to enter the foreground.
	 */
	var WILL_ENTER_FOREGROUND = 0x105;

	/**
	 * The application is now interactive.
	 */
	var DID_ENTER_FOREGROUND = 0x106;

	/** The user's locale preferences have changed. */
	var LOCALE_CHANGED = 0x107;

	/** The system theme (light/dark) has changed. */
	var SYSTEM_THEME_CHANGED = 0x108;

	/* Display events */
	/** Display orientation has changed to `data1`. */
	var DISPLAY_ORIENTATION = 0x151;

	/** A display has been added to the system. */
	var DISPLAY_ADDED = 0x152;

	/** A display has been removed from the system. */
	var DISPLAY_REMOVED = 0x153;

	/** A display has changed position. */
	var DISPLAY_MOVED = 0x154;

	/** A display has changed desktop mode. */
	var DISPLAY_DESKTOP_MODE_CHANGED = 0x155;

	/** A display has changed current mode. */
	var DISPLAY_CURRENT_MODE_CHANGED = 0x156;

	/** A display has changed content scale. */
	var DISPLAY_CONTENT_SCALE_CHANGED = 0x157;

	/** The usable bounds of a display have changed. */
	var DISPLAY_USABLE_BOUNDS_CHANGED = 0x158;

	/** First display-related event type. */
	var DISPLAY_FIRST = 0x151;

	/** Last display-related event type. */
	var DISPLAY_LAST = 0x158;

	/* Window events */
	/** A window has been shown. */
	var WINDOW_SHOWN = 0x202;

	/** A window has been hidden. */
	var WINDOW_HIDDEN = 0x203;

	/**
	 * A window has been exposed and should be redrawn.
	 * The window can be redrawn directly from event watchers for this event.
	 */
	var WINDOW_EXPOSED = 0x204;

	/** A window has been moved to `data1, data2`. */
	var WINDOW_MOVED = 0x205;

	/** A window has been resized to `data1 x data2`. */
	var WINDOW_RESIZED = 0x206;

	/** The pixel size of the window has changed to `data1 x data2`. */
	var WINDOW_PIXEL_SIZE_CHANGED = 0x207;

	/** The pixel size of a Metal view associated with the window has changed. */
	var WINDOW_METAL_VIEW_RESIZED = 0x208;

	/** A window has been minimized. */
	var WINDOW_MINIMIZED = 0x209;

	/** A window has been maximized. */
	var WINDOW_MAXIMIZED = 0x20A;

	/** A window has been restored to normal size and position. */
	var WINDOW_RESTORED = 0x20B;

	/** The window has gained mouse focus. */
	var WINDOW_MOUSE_ENTER = 0x20C;

	/** The window has lost mouse focus. */
	var WINDOW_MOUSE_LEAVE = 0x20D;

	/** The window has gained keyboard focus. */
	var WINDOW_FOCUS_GAINED = 0x20E;

	/** The window has lost keyboard focus. */
	var WINDOW_FOCUS_LOST = 0x20F;

	/** The window manager requests that the window be closed. */
	var WINDOW_CLOSE_REQUESTED = 0x210;

	/** The window had a hit test that wasn't `SDL_HITTEST_NORMAL`. */
	var WINDOW_HIT_TEST = 0x211;

	/** The ICC profile of the window's display has changed. */
	var WINDOW_ICCPROF_CHANGED = 0x212;

	/** The window has been moved to display `data1`. */
	var WINDOW_DISPLAY_CHANGED = 0x213;

	/** The window display scale has been changed. */
	var WINDOW_DISPLAY_SCALE_CHANGED = 0x214;

	/** The window safe area has been changed. */
	var WINDOW_SAFE_AREA_CHANGED = 0x215;

	/** The window has been occluded. */
	var WINDOW_OCCLUDED = 0x216;

	/** The window has entered fullscreen mode. */
	var WINDOW_ENTER_FULLSCREEN = 0x217;

	/** The window has left fullscreen mode. */
	var WINDOW_LEAVE_FULLSCREEN = 0x218;

	/**
	 * The window with the associated ID is being or has been destroyed.
	 * If handled in an event watcher, the window handle is still valid and can
	 * still be used to retrieve any properties associated with the window.
	 * Otherwise, the handle has already been destroyed and all resources
	 * associated with it are invalid.
	 */
	var WINDOW_DESTROYED = 0x219;

	/** The window HDR properties have changed. */
	var WINDOW_HDR_STATE_CHANGED = 0x21A;

	/** First window-related event type. */
	var WINDOW_FIRST = 0x202;

	/** Last window-related event type. */
	var WINDOW_LAST = 0x21A;

	/* Keyboard events */
	/** A key has been pressed. */
	var KEY_DOWN = 0x300;

	/** A key has been released. */
	var KEY_UP = 0x301;

	/** Keyboard text editing (composition). */
	var TEXT_EDITING = 0x302;

	/** Keyboard text input. */
	var TEXT_INPUT = 0x303;

	/**
	 * The keymap has changed due to a system event such as an input language
	 * or keyboard layout change.
	 */
	var KEYMAP_CHANGED = 0x304;

	/** A new keyboard has been inserted into the system. */
	var KEYBOARD_ADDED = 0x305;

	/** A keyboard has been removed. */
	var KEYBOARD_REMOVED = 0x306;

	/** Keyboard text editing candidates. */
	var TEXT_EDITING_CANDIDATES = 0x307;

	/** The on-screen keyboard has been shown. */
	var SCREEN_KEYBOARD_SHOWN = 0x308;

	/** The on-screen keyboard has been hidden. */
	var SCREEN_KEYBOARD_HIDDEN = 0x309;

	/* Mouse events */
	/** The mouse has moved. */
	var MOUSE_MOTION = 0x400;

	/** A mouse button has been pressed. */
	var MOUSE_BUTTON_DOWN = 0x401;

	/** A mouse button has been released. */
	var MOUSE_BUTTON_UP = 0x402;

	/** The mouse wheel has moved. */
	var MOUSE_WHEEL = 0x403;

	/** A new mouse has been inserted into the system. */
	var MOUSE_ADDED = 0x404;

	/** A mouse has been removed. */
	var MOUSE_REMOVED = 0x405;

	/* Joystick events */
	/** A joystick axis has moved. */
	var JOYSTICK_AXIS_MOTION = 0x600;

	/** A joystick trackball has moved. */
	var JOYSTICK_BALL_MOTION = 0x601;

	/** A joystick hat position has changed. */
	var JOYSTICK_HAT_MOTION = 0x602;

	/** A joystick button has been pressed. */
	var JOYSTICK_BUTTON_DOWN = 0x603;

	/** A joystick button has been released. */
	var JOYSTICK_BUTTON_UP = 0x604;

	/** A new joystick has been inserted into the system. */
	var JOYSTICK_ADDED = 0x605;

	/** An opened joystick has been removed. */
	var JOYSTICK_REMOVED = 0x606;

	/** A joystick battery level has changed. */
	var JOYSTICK_BATTERY_UPDATED = 0x607;

	/** A joystick update is complete. */
	var JOYSTICK_UPDATE_COMPLETE = 0x608;

	/* Gamepad events */
	/** A gamepad axis has moved. */
	var GAMEPAD_AXIS_MOTION = 0x650;

	/** A gamepad button has been pressed. */
	var GAMEPAD_BUTTON_DOWN = 0x651;

	/** A gamepad button has been released. */
	var GAMEPAD_BUTTON_UP = 0x652;

	/** A new gamepad has been inserted into the system. */
	var GAMEPAD_ADDED = 0x653;

	/** A gamepad has been removed. */
	var GAMEPAD_REMOVED = 0x654;

	/** The gamepad mapping was updated. */
	var GAMEPAD_REMAPPED = 0x655;

	/** A gamepad touchpad was touched. */
	var GAMEPAD_TOUCHPAD_DOWN = 0x656;

	/** A gamepad touchpad finger was moved. */
	var GAMEPAD_TOUCHPAD_MOTION = 0x657;

	/** A gamepad touchpad finger was lifted. */
	var GAMEPAD_TOUCHPAD_UP = 0x658;

	/** A gamepad sensor was updated. */
	var GAMEPAD_SENSOR_UPDATE = 0x659;

	/** A gamepad update is complete. */
	var GAMEPAD_UPDATE_COMPLETE = 0x65A;

	/** A gamepad Steam handle has changed. */
	var GAMEPAD_STEAM_HANDLE_UPDATED = 0x65B;

	/* Touch events */
	/** A finger has touched a touch device. */
	var FINGER_DOWN = 0x700;

	/** A finger has left a touch device. */
	var FINGER_UP = 0x701;

	/** A finger has moved on a touch device. */
	var FINGER_MOTION = 0x702;

	/** A touch event has been canceled. */
	var FINGER_CANCELED = 0x703;

	/** A pinch gesture has begun. */
	var PINCH_BEGIN = 0x710;

	/** A pinch gesture has been updated. */
	var PINCH_UPDATE = 0x711;

	/** A pinch gesture has ended. */
	var PINCH_END = 0x712;

	/* Clipboard events */
	/** The system clipboard contents have changed. */
	var CLIPBOARD_UPDATE = 0x900;

	/* Drag-and-drop events */
	/** A file has been dropped onto a window. */
	var DROP_FILE = 0x1000;

	/** A `text/plain` drag-and-drop event. */
	var DROP_TEXT = 0x1001;

	/** A new set of drops is beginning (`NULL` filename). */
	var DROP_BEGIN = 0x1002;

	/** The current set of drops is now complete (`NULL` filename). */
	var DROP_COMPLETE = 0x1003;

	/** Position while moving over the window. */
	var DROP_POSITION = 0x1004;

	/* Audio hotplug events */
	/** A new audio device is available. */
	var AUDIO_DEVICE_ADDED = 0x1100;

	/** An audio device has been removed. */
	var AUDIO_DEVICE_REMOVED = 0x1101;

	/** An audio device's format has been changed by the system. */
	var AUDIO_DEVICE_FORMAT_CHANGED = 0x1102;

	/* Sensor events */
	/** A sensor was updated. */
	var SENSOR_UPDATE = 0x1200;

	/* Pressure-sensitive pen events */
	/** A pressure-sensitive pen has become available. */
	var PEN_PROXIMITY_IN = 0x1300;

	/** A pressure-sensitive pen has become unavailable. */
	var PEN_PROXIMITY_OUT = 0x1301;

	/** A pressure-sensitive pen touched the drawing surface. */
	var PEN_DOWN = 0x1302;

	/** A pressure-sensitive pen stopped touching the drawing surface. */
	var PEN_UP = 0x1303;

	/** A pressure-sensitive pen button was pressed. */
	var PEN_BUTTON_DOWN = 0x1304;

	/** A pressure-sensitive pen button was released. */
	var PEN_BUTTON_UP = 0x1305;

	/** A pressure-sensitive pen is moving on the tablet. */
	var PEN_MOTION = 0x1306;

	/** A pressure-sensitive pen's angle/pressure/etc. changed. */
	var PEN_AXIS = 0x1307;

	/* Camera hotplug events */
	/** A new camera device is available. */
	var CAMERA_DEVICE_ADDED = 0x1400;

	/** A camera device has been removed. */
	var CAMERA_DEVICE_REMOVED = 0x1401;

	/** A camera device has been approved for use by the user. */
	var CAMERA_DEVICE_APPROVED = 0x1402;

	/** A camera device has been denied for use by the user. */
	var CAMERA_DEVICE_DENIED = 0x1403;

	/* Render events */
	/** The render targets have been reset and their contents need to be updated. */
	var RENDER_TARGETS_RESET = 0x2000;

	/** The device has been reset and all textures need to be recreated. */
	var RENDER_DEVICE_RESET = 0x2001;

	/** The device has been lost and can't be recovered. */
	var RENDER_DEVICE_LOST = 0x2002;

	/**
	 * Events `USER` through `LAST` are for your use, and should be allocated
	 * with `SDLEventQueue.registerEvents()`.
	 */
	var USER = 0x8000;

	/** Last event type in the range of valid IDs. */
	var LAST = 0xFFFF;
}

/**
 * A decoded SDL event, as returned by `SDLEventQueue.poll()` or `SDLEventQueue.wait()`.
 *
 * Each constructor corresponds to one or more raw `SDLEventType` values, with
 * fields already unpacked into their natural Haxe types (compare with the C
 * `SDL_Event` union, which stores all event types in a single memory block).
 *
 * The `type` field is preserved where it helps distinguish which specific event
 * occurred within a group (e.g. `WINDOW_SHOWN` vs `WINDOW_RESIZED`).
 */
enum SDLEvent {
	/** The user or OS requested the application quit. */
	Quit;

	/**
	 * A generic app-lifecycle event.
	 * Covers `TERMINATING`, `LOW_MEMORY`, background/foreground transitions,
	 * locale changes, theme changes, and on-screen keyboard visibility.
	 */
	App(type:SDLEventType);

	/**
	 * A display event.
	 * `displayID` identifies which display changed; `data1`/`data2` carry
	 * event-specific values (orientation, position, mode, scale, etc.).
	 */
	Display(type:SDLEventType, displayID:Int, data1:Int, data2:Int);

	/**
	 * A window event.
	 * `windowID` identifies which window changed; `data1`/`data2` carry
	 * event-specific values (new size, position, etc.).
	 */
	Window(type:SDLEventType, windowID:Int, data1:Int, data2:Int);

	/* Keyboard */
	/** A keyboard device was connected (`added = true`) or disconnected. */
	KeyboardDevice(added:Bool, which:Int);

	/**
	 * A key was pressed or released.
	 * `scancode` is the physical key location; `key` is the interpreted key
	 * based on the current keyboard layout; `mod` holds active modifiers;
	 * `raw` is the raw platform-dependent keycode; `repeat` is `true` if this
	 * is a key-repeat event.
	 */
	Key(down:Bool, windowID:Int, which:Int, scancode:Int, key:Int, mod:Int, raw:Int, repeat:Bool);

	/**
	 * IME composition text changed (not yet committed).
	 * `start` and `length` indicate the region of `text` being edited.
	 */
	TextEditing(windowID:Int, text:String, start:Int, length:Int);

	/** Committed text input, ready to be appended to a text field. */
	TextInput(windowID:Int, text:String);

	/* Mouse */
	/** A mouse device was connected (`added = true`) or disconnected. */
	MouseDevice(added:Bool, which:Int);

	/**
	 * The mouse moved.
	 * `x`/`y` are window-relative position; `xrel`/`yrel` are the delta since
	 * the last event; `state` is a bitmask of pressed buttons.
	 */
	MouseMotion(windowID:Int, which:Int, state:Int, x:Float, y:Float, xrel:Float, yrel:Float);

	/**
	 * A mouse button was pressed or released.
	 * `clicks` is 1 for a single click, 2 for a double-click, etc.
	 */
	MouseButton(down:Bool, windowID:Int, which:Int, button:Int, clicks:Int, x:Float, y:Float);

	/**
	 * The mouse wheel was scrolled.
	 * `x`/`y` are the scroll amount (positive = right/down);
	 * `direction` indicates the scrolling direction;
	 * `integerX`/`integerY` are the scroll amount rounded to integers.
	 */
	MouseWheel(windowID:Int, which:Int, x:Float, y:Float, direction:Int, mouseX:Float, mouseY:Float, integerX:Int, integerY:Int);

	/* Joystick */
	/** A joystick axis moved. */
	JoyAxis(which:Int, axis:Int, value:Int);

	/** A joystick trackball moved. */
	JoyBall(which:Int, ball:Int, xrel:Int, yrel:Int);

	/** A joystick hat (D-pad) switch changed position. */
	JoyHat(which:Int, hat:Int, value:Int);

	/** A joystick button was pressed or released. */
	JoyButton(down:Bool, which:Int, button:Int);

	/** A joystick was connected, disconnected, or finished updating. */
	JoyDevice(type:SDLEventType, which:Int);

	/** A joystick's battery level changed. */
	JoyBattery(which:Int, state:Int, percent:Int);

	/* Gamepad */
	/** A gamepad axis (stick/trigger) moved. */
	GamepadAxis(which:Int, axis:Int, value:Int);

	/** A gamepad button was pressed or released. */
	GamepadButton(down:Bool, which:Int, button:Int);

	/** A gamepad was connected, disconnected, remapped, or otherwise changed. */
	GamepadDevice(type:SDLEventType, which:Int);

	/** A finger touched, moved on, or left a gamepad's touchpad. */
	GamepadTouchpad(type:SDLEventType, which:Int, touchpad:Int, finger:Int, x:Float, y:Float, pressure:Float);

	/** A gamepad's built-in sensor (e.g. accelerometer/gyro) reported new data. */
	GamepadSensor(which:Int, sensor:Int, x:Float, y:Float, z:Float, sensorTimestampNS:Int64);

	/* Touch */
	/**
	 * A finger touched, moved on, or left a touch device.
	 * `touchID` identifies the touch device; `fingerID` identifies the finger.
	 */
	Finger(type:SDLEventType, windowID:Int, touchID:Int64, fingerID:Int64, x:Float, y:Float, dx:Float, dy:Float, pressure:Float);

	/** A multi-touch pinch gesture began, updated, or ended. */
	Pinch(type:SDLEventType, windowID:Int, scale:Float);

	/* Pen */
	/** A pen entered or left proximity of the tablet. */
	PenProximity(inProximity:Bool, windowID:Int, which:Int, penState:Int);

	/** A pen moved. */
	PenMotion(windowID:Int, which:Int, penState:Int, x:Float, y:Float);

	/**
	 * A pen touched down or lifted off the surface.
	 * `eraser` is `true` if the eraser end of the pen is in use.
	 */
	PenTouch(down:Bool, eraser:Bool, windowID:Int, which:Int, penState:Int, x:Float, y:Float);

	/** A pen's side button was pressed or released. */
	PenButton(down:Bool, button:Int, windowID:Int, which:Int, penState:Int, x:Float, y:Float);

	/** A pen axis (e.g. pressure or tilt) changed. */
	PenAxis(axis:Int, value:Float, windowID:Int, which:Int, penState:Int, x:Float, y:Float);

	/* Clipboard and drag-and-drop */
	/** The system clipboard contents changed. `owner` is `true` if this app owns the clipboard. */
	ClipboardUpdate(owner:Bool);

	/**
	 * A drag-and-drop file, text, or position event.
	 * `source` is the source of the drag operation (may be `null`).
	 * `data` is the dropped file path or text (may be `null`).
	 * Both strings are temporary memory owned by SDL and must not be held
	 * beyond the scope of handling this event.
	 */
	Drop(type:SDLEventType, windowID:Int, x:Float, y:Float, source:Null<String>, data:Null<String>);

	/* Device hotplug */
	/**
	 * An audio playback or recording device was added, removed, or changed format.
	 * `recording` is `true` if this is a recording device.
	 */
	AudioDevice(type:SDLEventType, which:Int, recording:Bool);

	/** A camera device was added, removed, approved, or denied. */
	CameraDevice(type:SDLEventType, which:Int);

	/** A standalone sensor reported new data. */
	Sensor(which:Int, data:Array<Float>, sensorTimestampNS:Int64);

	/** A renderer's targets were reset, or its device was reset/lost. */
	Render(type:SDLEventType, windowID:Int);

	/**
	 * A custom event registered with `SDLEventQueue.registerEvents()` and
	 * pushed with `SDLEventQueue.pushUser()`.
	 */
	User(type:Int, windowID:Int, code:Int);

	/** Any event type not otherwise decoded above. */
	Other(type:Int);
}

@:noCompletion
class SDLEventNative {
	@:hlNative("sdl3", "event_alloc") public static function alloc():hl.Bytes
		return null;

	@:hlNative("sdl3", "event_type") public static function type(e:hl.Bytes):Int
		return 0;

	@:hlNative("sdl3", "event_decode") public static function decode(e:hl.Bytes, ints:hl.NativeArray<Int>, floats:hl.NativeArray<Float>):Void {}

	@:hlNative("sdl3", "event_text") public static function text(e:hl.Bytes, idx:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "pump_events") public static function pump():Void {}

	@:hlNative("sdl3", "poll_event") public static function poll(e:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "wait_event") public static function wait(e:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "wait_event_timeout") public static function waitTimeout(e:hl.Bytes, ms:Int):Bool
		return false;

	@:hlNative("sdl3", "count_events") public static function count(min:Int, max:Int):Int
		return 0;

	@:hlNative("sdl3", "has_event") public static function has(t:Int):Bool
		return false;

	@:hlNative("sdl3", "has_events") public static function hasRange(min:Int, max:Int):Bool
		return false;

	@:hlNative("sdl3", "flush_event") public static function flush(t:Int):Void {}

	@:hlNative("sdl3", "flush_events") public static function flushRange(min:Int, max:Int):Void {}

	@:hlNative("sdl3", "set_event_enabled") public static function setEnabled(t:Int, on:Bool):Void {}

	@:hlNative("sdl3", "event_enabled") public static function enabled(t:Int):Bool
		return false;

	@:hlNative("sdl3", "register_events") public static function register(n:Int):Int
		return 0;

	@:hlNative("sdl3", "push_user_event") public static function pushUser(t:Int, windowID:Int, code:Int):Bool
		return false;

	@:hlNative("sdl3", "push_quit_event") public static function pushQuit():Bool
		return false;

	@:hlNative("sdl3", "event_description") public static function description(e:hl.Bytes):hl.Bytes
		return null;

	@:hlNative("sdl3", "lifecycle_watch_install") public static function lcInstall():Bool
		return false;

	@:hlNative("sdl3", "lifecycle_watch_remove") public static function lcRemove():Void {}

	@:hlNative("sdl3", "lifecycle_poll") public static function lcPoll():Int
		return 0;
}

/**
 * Static access to SDL's event queue.
 *
 * The event queue is how SDL delivers input and system notifications to your
 * application. Typical usage is to call `poll()` in a loop each frame until it
 * returns `null`, processing every event that has arrived since the last frame.
 * For low-power applications, `wait()` or `waitTimeout()` can block the process
 * until something interesting happens instead of busy-polling.
 *
 * `pump()` is called implicitly by `poll()`, `wait()`, and `waitTimeout()`, but
 * you may also call it directly to update the queue without removing events.
 *
 * Custom events can be generated with `registerEvents()` and `pushUser()`, and
 * queried/filtered with the various `has`, `count`, and `flush` helpers.
 *
 * Corresponds to the SDL3 event queue API.
 */
class SDLEventQueue {
	static var ev:hl.Bytes = SDLEventNative.alloc();
	static var ints = new hl.NativeArray<Int>(18);
	static var floats = new hl.NativeArray<Float>(6);

	/**
	 * The timestamp (in nanoseconds) of the most recently decoded event.
	 * Populated by `decode()` and therefore valid after `poll()`, `wait()`, or
	 * `waitTimeout()` returns a non-`null` event.
	 */
	public static var timestampNS(default, null):Int64 = Int64.ofInt(0);

	/**
	 * Pumps the event loop, gathering events from the input devices.
	 *
	 * This updates the event queue and internal input device state without
	 * removing any events from the queue. You generally don't need to call this
	 * directly, as `poll()`, `wait()`, and `waitTimeout()` call it implicitly.
	 */
	public static function pump():Void
		SDLEventNative.pump();

	/**
	 * Pumps events and removes/returns the next event from the queue.
	 *
	 * @return The next event, or `null` if there are no events waiting.
	 *         Call this in a loop until it returns `null` to drain the queue.
	 */
	public static function poll():Null<SDLEvent>
		return SDLEventNative.poll(ev) ? decode() : null;

	/**
	 * Blocks indefinitely until an event is available, then returns it.
	 *
	 * This can be beneficial for low-power applications that don't need to run
	 * at a constant frame rate. To avoid blocking forever, consider using
	 * `waitTimeout()` instead.
	 *
	 * @return The next event (never `null` under normal operation).
	 */
	public static function wait():Null<SDLEvent>
		return SDLEventNative.wait(ev) ? decode() : null;

	/**
	 * Blocks until an event is available or `ms` milliseconds have passed.
	 *
	 * @param ms Maximum time to wait, in milliseconds.
	 * @return The next event, or `null` if the timeout expired without an event.
	 */
	public static function waitTimeout(ms:Int):Null<SDLEvent>
		return SDLEventNative.waitTimeout(ev, ms) ? decode() : null;

	/**
	 * Checks whether an event of the given `type` is currently in the queue.
	 *
	 * @param type The event type to check for.
	 * @return `true` if at least one matching event is queued.
	 */
	public static function has(type:SDLEventType):Bool
		return SDLEventNative.has(type);

	/**
	 * Checks whether any event with a type in `[min, max]` is in the queue.
	 *
	 * This is useful for checking a whole event category at once, e.g. all
	 * keyboard events via `hasRange(KEY_DOWN, TEXT_EDITING_CANDIDATES)`.
	 *
	 * @param min Inclusive lower bound of event types to check.
	 * @param max Inclusive upper bound of event types to check.
	 * @return `true` if at least one matching event is queued.
	 */
	public static function hasRange(min:SDLEventType, max:SDLEventType):Bool
		return SDLEventNative.hasRange(min, max);

	/**
	 * Returns the number of queued events with a type in `[min, max]`.
	 *
	 * By default this counts every event in the queue. Narrow the range to
	 * count specific categories.
	 *
	 * @param min Inclusive lower bound (default: `FIRST`).
	 * @param max Inclusive upper bound (default: `LAST`).
	 * @return The number of matching events in the queue.
	 */
	public static function count(min:SDLEventType = FIRST, max:SDLEventType = LAST):Int
		return SDLEventNative.count(min, max);

	/**
	 * Removes all events of the given `type` from the queue without processing them.
	 *
	 * This is often used to clear out events you don't care about instead of
	 * ignoring them in the event loop.
	 *
	 * @param type The event type to remove.
	 */
	public static function flush(type:SDLEventType):Void
		SDLEventNative.flush(type);

	/**
	 * Removes all events with a type in `[min, max]` from the queue.
	 *
	 * @param min Inclusive lower bound of event types to remove.
	 * @param max Inclusive upper bound of event types to remove.
	 */
	public static function flushRange(min:SDLEventType, max:SDLEventType):Void
		SDLEventNative.flushRange(min, max);

	/**
	 * Enables or disables processing of events of the given `type`.
	 *
	 * Disabled events are dropped before ever reaching the queue, which is more
	 * efficient than filtering them out in the event loop.
	 *
	 * @param type The event type to toggle.
	 * @param enabled Whether to process events of this type.
	 */
	public static function setEnabled(type:SDLEventType, enabled:Bool):Void
		SDLEventNative.setEnabled(type, enabled);

	/**
	 * Returns whether events of the given `type` are currently enabled.
	 *
	 * @param type The event type to query.
	 * @return `true` if events of this type are being processed.
	 */
	public static function isEnabled(type:SDLEventType):Bool
		return SDLEventNative.enabled(type);

	/**
	 * Reserves `n` custom event type IDs for use with `pushUser()`.
	 *
	 * Use this to safely generate custom events without conflicting with SDL's
	 * own event types or other libraries.
	 *
	 * @param n How many custom event type IDs to reserve.
	 * @return The first reserved type ID, or -1 on failure.
	 */
	public static function registerEvents(n:Int):Int
		return SDLEventNative.register(n);

	/**
	 * Pushes a custom user event onto the queue.
	 *
	 * `type` must be a value obtained from `registerEvents()`. The optional
	 * `code` and `windowID` fields are application-defined.
	 *
	 * @param type A custom event type from `registerEvents()`.
	 * @param code Application-defined event code (default 0).
	 * @param windowID Associated window, if any (default 0).
	 * @return `true` on success, `false` on failure.
	 */
	public static function pushUser(type:Int, code:Int = 0, windowID:Int = 0):Bool
		return SDLEventNative.pushUser(type, windowID, code);

	/**
	 * Pushes a quit event onto the queue.
	 *
	 * This is equivalent to the user closing the last window or pressing Ctrl-C.
	 *
	 * @return `true` on success, `false` on failure.
	 */
	public static function pushQuit():Bool
		return SDLEventNative.pushQuit();

	/**
	 * Returns a human-readable description of the most recently decoded event.
	 *
	 * This is useful for debugging and logging. The description follows the
	 * format used by SDL's own event logging.
	 *
	 * @return An English description of the last decoded event.
	 */
	public static function describeLast():String
		@:privateAccess return String.fromUTF8(SDLEventNative.description(ev));

	/**
	 * Installs a watcher that captures app-lifecycle events for `pollLifecycle()`.
	 *
	 * Lifecycle events (background/foreground transitions, termination, low
	 * memory) must be handled in an event watcher rather than the normal event
	 * queue on mobile platforms. Call this once at startup, then poll with
	 * `pollLifecycle()`.
	 *
	 * @return `true` on success, `false` on failure.
	 */
	public static function installLifecycleWatch():Bool
		return SDLEventNative.lcInstall();

	/** Removes the lifecycle watcher installed by `installLifecycleWatch()`. */
	public static function removeLifecycleWatch():Void
		SDLEventNative.lcRemove();

	/**
	 * Returns the next pending lifecycle event captured by `installLifecycleWatch()`.
	 *
	 * @return The next lifecycle event type, or `null` if none are pending.
	 */
	public static function pollLifecycle():Null<SDLEventType> {
		var t = SDLEventNative.lcPoll();
		return t == 0 ? null : (t : SDLEventType);
	}

	static inline function str(b:hl.Bytes):Null<String>
		@:privateAccess return b == null ? null : String.fromUTF8(b);

	static inline function b(v:Int):Bool
		return v != 0;

	static function decode():SDLEvent {
		SDLEventNative.decode(ev, ints, floats);
		var i = ints;
		var f = floats;
		timestampNS = Int64.make(i[16], i[17]);

		var type = SDLEventNative.type(ev);
		var t:SDLEventType = type;

		if (type >= (SDLEventType.DISPLAY_FIRST : Int) && type <= (SDLEventType.DISPLAY_LAST : Int))
			return Display(t, i[0], i[1], i[2]);
		if (type >= (SDLEventType.WINDOW_FIRST : Int) && type <= (SDLEventType.WINDOW_LAST : Int))
			return Window(t, i[0], i[1], i[2]);
		if (type >= (SDLEventType.USER : Int))
			return User(type, i[0], i[1]);

		return switch (t) {
			case QUIT: Quit;
			case TERMINATING | LOW_MEMORY | WILL_ENTER_BACKGROUND | DID_ENTER_BACKGROUND | WILL_ENTER_FOREGROUND | DID_ENTER_FOREGROUND | LOCALE_CHANGED |
				SYSTEM_THEME_CHANGED | KEYMAP_CHANGED | SCREEN_KEYBOARD_SHOWN | SCREEN_KEYBOARD_HIDDEN:
				App(t);

			case KEYBOARD_ADDED: KeyboardDevice(true, i[0]);
			case KEYBOARD_REMOVED: KeyboardDevice(false, i[0]);
			case KEY_DOWN | KEY_UP: Key(b(i[6]), i[0], i[1], i[2], i[3], i[4], i[5], b(i[7]));
			case TEXT_EDITING: TextEditing(i[0], str(SDLEventNative.text(ev, 0)), i[1], i[2]);
			case TEXT_INPUT: TextInput(i[0], str(SDLEventNative.text(ev, 0)));

			case MOUSE_ADDED: MouseDevice(true, i[0]);
			case MOUSE_REMOVED: MouseDevice(false, i[0]);
			case MOUSE_MOTION: MouseMotion(i[0], i[1], i[2], f[0], f[1], f[2], f[3]);
			case MOUSE_BUTTON_DOWN | MOUSE_BUTTON_UP: MouseButton(b(i[3]), i[0], i[1], i[2], i[4], f[0], f[1]);
			case MOUSE_WHEEL: MouseWheel(i[0], i[1], f[0], f[1], i[2], f[2], f[3], i[3], i[4]);

			case JOYSTICK_AXIS_MOTION: JoyAxis(i[0], i[1], i[2]);
			case JOYSTICK_BALL_MOTION: JoyBall(i[0], i[1], i[2], i[3]);
			case JOYSTICK_HAT_MOTION: JoyHat(i[0], i[1], i[2]);
			case JOYSTICK_BUTTON_DOWN | JOYSTICK_BUTTON_UP: JoyButton(b(i[2]), i[0], i[1]);
			case JOYSTICK_ADDED | JOYSTICK_REMOVED | JOYSTICK_UPDATE_COMPLETE: JoyDevice(t, i[0]);
			case JOYSTICK_BATTERY_UPDATED: JoyBattery(i[0], i[1], i[2]);

			case GAMEPAD_AXIS_MOTION: GamepadAxis(i[0], i[1], i[2]);
			case GAMEPAD_BUTTON_DOWN | GAMEPAD_BUTTON_UP: GamepadButton(b(i[2]), i[0], i[1]);
			case GAMEPAD_ADDED | GAMEPAD_REMOVED | GAMEPAD_REMAPPED | GAMEPAD_UPDATE_COMPLETE | GAMEPAD_STEAM_HANDLE_UPDATED: GamepadDevice(t, i[0]);
			case GAMEPAD_TOUCHPAD_DOWN | GAMEPAD_TOUCHPAD_MOTION | GAMEPAD_TOUCHPAD_UP: GamepadTouchpad(t, i[0], i[1], i[2], f[0], f[1], f[2]);
			case GAMEPAD_SENSOR_UPDATE: GamepadSensor(i[0], i[1], f[0], f[1], f[2], Int64.make(i[12], i[13]));

			case FINGER_DOWN | FINGER_UP | FINGER_MOTION | FINGER_CANCELED:
				Finger(t, i[0], Int64.make(i[12], i[13]), Int64.make(i[14], i[15]), f[0], f[1], f[2], f[3], f[4]);
			case PINCH_BEGIN | PINCH_UPDATE | PINCH_END: Pinch(t, i[0], f[0]);

			case PEN_PROXIMITY_IN: PenProximity(true, i[0], i[1], i[2]);
			case PEN_PROXIMITY_OUT: PenProximity(false, i[0], i[1], i[2]);
			case PEN_MOTION: PenMotion(i[0], i[1], i[2], f[0], f[1]);
			case PEN_DOWN | PEN_UP: PenTouch(b(i[4]), b(i[3]), i[0], i[1], i[2], f[0], f[1]);
			case PEN_BUTTON_DOWN | PEN_BUTTON_UP: PenButton(b(i[4]), i[3], i[0], i[1], i[2], f[0], f[1]);
			case PEN_AXIS: PenAxis(i[3], f[2], i[0], i[1], i[2], f[0], f[1]);

			case CLIPBOARD_UPDATE: ClipboardUpdate(b(i[0]));
			case DROP_FILE | DROP_TEXT | DROP_BEGIN | DROP_COMPLETE | DROP_POSITION:
				Drop(t, i[0], f[0], f[1], str(SDLEventNative.text(ev, 0)), str(SDLEventNative.text(ev, 1)));

			case AUDIO_DEVICE_ADDED | AUDIO_DEVICE_REMOVED | AUDIO_DEVICE_FORMAT_CHANGED: AudioDevice(t, i[0], b(i[1]));
			case CAMERA_DEVICE_ADDED | CAMERA_DEVICE_REMOVED | CAMERA_DEVICE_APPROVED | CAMERA_DEVICE_DENIED: CameraDevice(t, i[0]);
			case SENSOR_UPDATE: Sensor(i[0], [for (k in 0...6) f[k]], Int64.make(i[12], i[13]));
			case RENDER_TARGETS_RESET | RENDER_DEVICE_RESET | RENDER_DEVICE_LOST: Render(t, i[0]);

			default: Other(type);
		}
	}
}
