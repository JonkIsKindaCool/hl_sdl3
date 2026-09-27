package hl.bindings.sdl3;

import haxe.Int64;
import haxe.io.Bytes;

typedef SDLGamepadPtr = hl.Abstract<"SDL_Gamepad">;

/**
 * The type or family of a gamepad.
 * Corresponds to `SDL_GamepadType` in SDL3.
 */
enum abstract SDLGamepadType(Int) from Int to Int {
	/** Unknown or unrecognized gamepad type. */
	var UNKNOWN = 0;

	/** A standard, well-known gamepad layout. */
	var STANDARD = 1;

	/** An Xbox 360 controller. */
	var XBOX360 = 2;

	/** An Xbox One controller. */
	var XBOXONE = 3;

	/** A PlayStation 3 controller. */
	var PS3 = 4;

	/** A PlayStation 4 controller. */
	var PS4 = 5;

	/** A PlayStation 5 controller. */
	var PS5 = 6;

	/** A Nintendo Switch Pro controller. */
	var NINTENDO_SWITCH_PRO = 7;

	/** Left Nintendo Switch Joy-Con. */
	var NINTENDO_SWITCH_JOYCON_LEFT = 8;

	/** Right Nintendo Switch Joy-Con. */
	var NINTENDO_SWITCH_JOYCON_RIGHT = 9;

	/** A pair of Nintendo Switch Joy-Cons. */
	var NINTENDO_SWITCH_JOYCON_PAIR = 10;

	/** A Nintendo GameCube controller. */
	var GAMECUBE = 11;
}

/**
 * Gamepad buttons using the SDL positional layout.
 * Corresponds to `SDL_GamepadButton` in SDL3.
 */
enum abstract SDLGamepadButton(Int) from Int to Int {
	/** Invalid or unknown button. */
	var INVALID = -1;

	/** Bottom face button (A / Cross). */
	var SOUTH = 0;

	/** Right face button (B / Circle). */
	var EAST = 1;

	/** Left face button (X / Square). */
	var WEST = 2;

	/** Top face button (Y / Triangle). */
	var NORTH = 3;

	/** Back / Select / Share button. */
	var BACK = 4;

	/** Guide / Home / PS button. */
	var GUIDE = 5;

	/** Start / Options button. */
	var START = 6;

	/** Left stick press (L3). */
	var LEFT_STICK = 7;

	/** Right stick press (R3). */
	var RIGHT_STICK = 8;

	/** Left shoulder bumper (L1 / LB). */
	var LEFT_SHOULDER = 9;

	/** Right shoulder bumper (R1 / RB). */
	var RIGHT_SHOULDER = 10;

	/** D-pad up. */
	var DPAD_UP = 11;

	/** D-pad down. */
	var DPAD_DOWN = 12;

	/** D-pad left. */
	var DPAD_LEFT = 13;

	/** D-pad right. */
	var DPAD_RIGHT = 14;

	/** Misc button 1 (platform-specific). */
	var MISC1 = 15;

	/** Right paddle 1 (e.g. Xbox Elite). */
	var RIGHT_PADDLE1 = 16;

	/** Left paddle 1 (e.g. Xbox Elite). */
	var LEFT_PADDLE1 = 17;

	/** Right paddle 2 (e.g. Xbox Elite). */
	var RIGHT_PADDLE2 = 18;

	/** Left paddle 2 (e.g. Xbox Elite). */
	var LEFT_PADDLE2 = 19;

	/** Touchpad click (PS4/PS5). */
	var TOUCHPAD = 20;

	/** Misc button 2. */
	var MISC2 = 21;

	/** Misc button 3. */
	var MISC3 = 22;

	/** Misc button 4. */
	var MISC4 = 23;

	/** Misc button 5. */
	var MISC5 = 24;

	/** Misc button 6. */
	var MISC6 = 25;

	/** Total number of gamepad buttons. */
	var COUNT = 26;
}

/**
 * The label printed on a given gamepad button for a specific controller type.
 * Corresponds to `SDL_GamepadButtonLabel` in SDL3.
 */
enum abstract SDLGamepadButtonLabel(Int) from Int to Int {
	/** Unknown label. */
	var UNKNOWN = 0;

	/** "A" (Xbox-style). */
	var A = 1;

	/** "B" (Xbox-style). */
	var B = 2;

	/** "X" (Xbox-style). */
	var X = 3;

	/** "Y" (Xbox-style). */
	var Y = 4;

	/** "Cross" (PlayStation-style). */
	var CROSS = 5;

	/** "Circle" (PlayStation-style). */
	var CIRCLE = 6;

	/** "Square" (PlayStation-style). */
	var SQUARE = 7;

	/** "Triangle" (PlayStation-style). */
	var TRIANGLE = 8;
}

/**
 * Gamepad axes using the SDL positional layout.
 * Corresponds to `SDL_GamepadAxis` in SDL3.
 */
enum abstract SDLGamepadAxis(Int) from Int to Int {
	/** Invalid or unknown axis. */
	var INVALID = -1;

	/** Left stick, horizontal. */
	var LEFTX = 0;

	/** Left stick, vertical. */
	var LEFTY = 1;

	/** Right stick, horizontal. */
	var RIGHTX = 2;

	/** Right stick, vertical. */
	var RIGHTY = 3;

	/** Left trigger (L2 / LT). */
	var LEFT_TRIGGER = 4;

	/** Right trigger (R2 / RT). */
	var RIGHT_TRIGGER = 5;

	/** Total number of gamepad axes. */
	var COUNT = 6;
}

/**
 * The type of an input or output in a gamepad mapping binding.
 * Corresponds to `SDL_GamepadBindingType` in SDL3.
 */
enum abstract SDLGamepadBindingType(Int) from Int to Int {
	/** No binding. */
	var NONE = 0;

	/** A digital button binding. */
	var BUTTON = 1;

	/** An analog axis binding. */
	var AXIS = 2;

	/** A hat (D-pad) binding. */
	var HAT = 3;
}

/**
 * The kind of sensor present in a gamepad.
 * Corresponds to `SDL_SensorType` gamepad values in SDL3.
 */
enum abstract SDLGamepadSensor(Int) from Int to Int {
	/** Accelerometer. */
	var ACCEL = 1;

	/** Gyroscope. */
	var GYRO = 2;

	/** Left accelerometer (on Joy-Cons). */
	var ACCEL_L = 3;

	/** Left gyroscope. */
	var GYRO_L = 4;

	/** Right accelerometer. */
	var ACCEL_R = 5;

	/** Right gyroscope. */
	var GYRO_R = 6;
}

/**
 * A single binding rule from a gamepad mapping string.
 * Maps a raw joystick input to a gamepad input/output.
 */
typedef SDLGamepadBinding = {
	/** Type of the raw input (button, axis, or hat). */
	inputType:SDLGamepadBindingType,

	/** Input parameters; meaning depends on `inputType`. */
	input:Array<Int>,

	/** Type of the gamepad output. */
	outputType:SDLGamepadBindingType,

	/** Output parameters; meaning depends on `outputType`. */
	output:Array<Int>
}

/**
 * Optional features supported by a gamepad.
 */
typedef SDLGamepadCapabilities = {
	/** Whether a single-color LED is available. */
	monoLED:Bool,

	/** Whether a full RGB LED is available. */
	rgbLED:Bool,

	/** Whether a player-indicator LED is available. */
	playerLED:Bool,

	/** Whether rumble (low/high frequency motors) is available. */
	rumble:Bool,

	/** Whether trigger rumble motors are available. */
	triggerRumble:Bool
}

/**
 * The state of a single finger on a gamepad touchpad.
 */
typedef SDLTouchpadFinger = {
	/** Whether the finger is currently touching the pad. */
	down:Bool,

	/** Normalized X position in `[0, 1]`. */
	x:Float,

	/** Normalized Y position in `[0, 1]`. */
	y:Float,

	/** Pressure in `[0, 1]`. */
	pressure:Float
}

/**
 * Power state of a gamepad, as returned by `SDLGamepad.getPower()`.
 */
typedef SDLGamepadPower = {
	/** The current power state. */
	state:SDLPowerState,

	/** Estimated battery percentage in `[0, 100]`, or -1 if unknown. */
	percent:Int
}

@:noCompletion
class SDLGamepadNative {
	@:hlNative("sdl3", "add_gamepad_mapping") public static function addMapping(m:hl.Bytes):Int
		return 0;

	@:hlNative("sdl3", "add_gamepad_mappings_from_file") public static function addMappingsFromFile(f:hl.Bytes):Int
		return 0;

	@:hlNative("sdl3", "reload_gamepad_mappings") public static function reloadMappings():Bool
		return false;

	@:hlNative("sdl3", "get_gamepad_mappings") public static function getMappings():hl.NativeArray<hl.Bytes>
		return null;

	@:hlNative("sdl3", "get_gamepad_mapping_for_guid") public static function mappingForGuid(guid16:hl.Bytes):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_gamepad_mapping") public static function getMapping(g:SDLGamepadPtr):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_gamepad_mapping_for_id") public static function mappingForId(id:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "set_gamepad_mapping") public static function setMapping(id:Int, m:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "has_gamepad") public static function hasGamepad():Bool
		return false;

	@:hlNative("sdl3", "get_gamepads") public static function getGamepads():hl.NativeArray<Int>
		return null;

	@:hlNative("sdl3", "is_gamepad") public static function isGamepad(id:Int):Bool
		return false;

	@:hlNative("sdl3", "get_gamepad_name_for_id") public static function nameForId(id:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_gamepad_path_for_id") public static function pathForId(id:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_gamepad_player_index_for_id") public static function playerIndexForId(id:Int):Int
		return 0;

	@:hlNative("sdl3", "get_gamepad_guid_for_id") public static function guidForId(id:Int, out16:hl.Bytes):Void {}

	@:hlNative("sdl3", "get_gamepad_vendor_for_id") public static function vendorForId(id:Int):Int
		return 0;

	@:hlNative("sdl3", "get_gamepad_product_for_id") public static function productForId(id:Int):Int
		return 0;

	@:hlNative("sdl3", "get_gamepad_product_version_for_id") public static function versionForId(id:Int):Int
		return 0;

	@:hlNative("sdl3", "get_gamepad_type_for_id") public static function typeForId(id:Int):Int
		return 0;

	@:hlNative("sdl3", "get_real_gamepad_type_for_id") public static function realTypeForId(id:Int):Int
		return 0;

	@:hlNative("sdl3", "open_gamepad") public static function open(id:Int):SDLGamepadPtr
		return null;

	@:hlNative("sdl3", "get_gamepad_from_id") public static function fromId(id:Int):SDLGamepadPtr
		return null;

	@:hlNative("sdl3", "get_gamepad_from_player_index") public static function fromPlayerIndex(i:Int):SDLGamepadPtr
		return null;

	@:hlNative("sdl3", "close_gamepad") public static function close(g:SDLGamepadPtr):Void {}

	@:hlNative("sdl3", "gamepad_capabilities") public static function capabilities(g:SDLGamepadPtr):Int
		return 0;

	@:hlNative("sdl3", "get_gamepad_id") public static function getId(g:SDLGamepadPtr):Int
		return 0;

	@:hlNative("sdl3", "get_gamepad_name") public static function getName(g:SDLGamepadPtr):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_gamepad_path") public static function getPath(g:SDLGamepadPtr):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_gamepad_type") public static function getType(g:SDLGamepadPtr):Int
		return 0;

	@:hlNative("sdl3", "get_real_gamepad_type") public static function getRealType(g:SDLGamepadPtr):Int
		return 0;

	@:hlNative("sdl3", "get_gamepad_player_index") public static function getPlayerIndex(g:SDLGamepadPtr):Int
		return 0;

	@:hlNative("sdl3", "set_gamepad_player_index") public static function setPlayerIndex(g:SDLGamepadPtr, i:Int):Bool
		return false;

	@:hlNative("sdl3", "get_gamepad_vendor") public static function getVendor(g:SDLGamepadPtr):Int
		return 0;

	@:hlNative("sdl3", "get_gamepad_product") public static function getProduct(g:SDLGamepadPtr):Int
		return 0;

	@:hlNative("sdl3", "get_gamepad_product_version") public static function getProductVersion(g:SDLGamepadPtr):Int
		return 0;

	@:hlNative("sdl3", "get_gamepad_firmware_version") public static function getFirmwareVersion(g:SDLGamepadPtr):Int
		return 0;

	@:hlNative("sdl3", "get_gamepad_serial") public static function getSerial(g:SDLGamepadPtr):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_gamepad_steam_handle") public static function getSteamHandle(g:SDLGamepadPtr, out:hl.NativeArray<Int>):Void {}

	@:hlNative("sdl3", "get_gamepad_connection_state") public static function getConnectionState(g:SDLGamepadPtr):Int
		return 0;

	@:hlNative("sdl3", "get_gamepad_power_info") public static function getPowerInfo(g:SDLGamepadPtr, out:hl.NativeArray<Int>):Void {}

	@:hlNative("sdl3", "gamepad_connected") public static function connected(g:SDLGamepadPtr):Bool
		return false;

	@:hlNative("sdl3", "get_gamepad_joystick") public static function getJoystick(g:SDLGamepadPtr):SDLJoystickPtr
		return null;

	@:hlNative("sdl3", "set_gamepad_events_enabled") public static function setEventsEnabled(b:Bool):Void {}

	@:hlNative("sdl3", "gamepad_events_enabled") public static function eventsEnabled():Bool
		return false;

	@:hlNative("sdl3", "update_gamepads") public static function update():Void {}

	@:hlNative("sdl3", "get_gamepad_bindings") public static function getBindings(g:SDLGamepadPtr):hl.NativeArray<Int>
		return null;

	@:hlNative("sdl3", "get_gamepad_type_from_string") public static function typeFromString(s:hl.Bytes):Int
		return 0;

	@:hlNative("sdl3", "get_gamepad_string_for_type") public static function stringForType(t:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_gamepad_axis_from_string") public static function axisFromString(s:hl.Bytes):Int
		return 0;

	@:hlNative("sdl3", "get_gamepad_string_for_axis") public static function stringForAxis(a:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_gamepad_button_from_string") public static function buttonFromString(s:hl.Bytes):Int
		return 0;

	@:hlNative("sdl3", "get_gamepad_string_for_button") public static function stringForButton(b:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_gamepad_button_label_for_type") public static function labelForType(t:Int, b:Int):Int
		return 0;

	@:hlNative("sdl3", "get_gamepad_button_label") public static function buttonLabel(g:SDLGamepadPtr, b:Int):Int
		return 0;

	@:hlNative("sdl3", "gamepad_has_axis") public static function hasAxis(g:SDLGamepadPtr, a:Int):Bool
		return false;

	@:hlNative("sdl3", "get_gamepad_axis") public static function getAxis(g:SDLGamepadPtr, a:Int):Int
		return 0;

	@:hlNative("sdl3", "gamepad_has_button") public static function hasButton(g:SDLGamepadPtr, b:Int):Bool
		return false;

	@:hlNative("sdl3", "get_gamepad_button") public static function getButton(g:SDLGamepadPtr, b:Int):Bool
		return false;

	@:hlNative("sdl3", "get_num_gamepad_touchpads") public static function numTouchpads(g:SDLGamepadPtr):Int
		return 0;

	@:hlNative("sdl3", "get_num_gamepad_touchpad_fingers") public static function numFingers(g:SDLGamepadPtr, t:Int):Int
		return 0;

	@:hlNative("sdl3", "get_gamepad_touchpad_finger") public static function getFinger(g:SDLGamepadPtr, t:Int, f:Int, out:hl.NativeArray<Float>):Bool
		return false;

	@:hlNative("sdl3", "gamepad_has_sensor") public static function hasSensor(g:SDLGamepadPtr, t:Int):Bool
		return false;

	@:hlNative("sdl3", "set_gamepad_sensor_enabled") public static function setSensorEnabled(g:SDLGamepadPtr, t:Int, on:Bool):Bool
		return false;

	@:hlNative("sdl3", "gamepad_sensor_enabled") public static function sensorEnabled(g:SDLGamepadPtr, t:Int):Bool
		return false;

	@:hlNative("sdl3", "get_gamepad_sensor_data_rate") public static function sensorRate(g:SDLGamepadPtr, t:Int):Float
		return 0;

	@:hlNative("sdl3", "get_gamepad_sensor_data") public static function sensorData(g:SDLGamepadPtr, t:Int, out:hl.NativeArray<Float>):Bool
		return false;

	@:hlNative("sdl3", "rumble_gamepad") public static function rumble(g:SDLGamepadPtr, low:Int, high:Int, ms:Int):Bool
		return false;

	@:hlNative("sdl3", "rumble_gamepad_triggers") public static function rumbleTriggers(g:SDLGamepadPtr, l:Int, r:Int, ms:Int):Bool
		return false;

	@:hlNative("sdl3", "set_gamepad_led") public static function setLed(g:SDLGamepadPtr, r:Int, gr:Int, b:Int):Bool
		return false;

	@:hlNative("sdl3", "send_gamepad_effect") public static function sendEffect(g:SDLGamepadPtr, data:hl.Bytes, size:Int):Bool
		return false;

	@:hlNative("sdl3", "get_gamepad_apple_sf_symbols_name_for_button") public static function sfButton(g:SDLGamepadPtr, b:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_gamepad_apple_sf_symbols_name_for_axis") public static function sfAxis(g:SDLGamepadPtr, a:Int):hl.Bytes
		return null;
}

/**
 * Static gamepad API: hotplug detection, mapping management, and
 * type/string conversions.
 *
 * The functions here operate on gamepad IDs (not handles) and are useful for
 * querying device metadata without opening the gamepad. Use `SDLGamepad.open()`
 * to obtain an instance for actual input polling.
 *
 * Corresponds to the SDL3 gamepad subsystem.
 */
class SDLGamepads {
	static inline function str(b:hl.Bytes):Null<String>
		@:privateAccess return b == null ? null : String.fromUTF8(b);

	static function ids(a:hl.NativeArray<Int>):Array<Int>
		return a == null ? [] : [for (i in 0...a.length) a[i]];

	/**
	 * Checks whether any gamepads are currently connected.
	 *
	 * @return `true` if at least one gamepad is available.
	 */
	public static function hasGamepad():Bool
		return SDLGamepadNative.hasGamepad();

	/**
	 * Returns the IDs of all currently connected gamepads.
	 *
	 * @return An array of gamepad device IDs.
	 */
	public static function getGamepads():Array<Int>
		return ids(SDLGamepadNative.getGamepads());

	/**
	 * Checks whether the given device ID refers to a gamepad.
	 *
	 * @param id The device ID to check.
	 * @return `true` if the device is a gamepad.
	 */
	public static function isGamepad(id:Int):Bool
		return SDLGamepadNative.isGamepad(id);

	/**
	 * Returns the human-readable name of a gamepad.
	 *
	 * @param id The gamepad device ID.
	 * @return The name, or `null` on failure.
	 */
	public static function getNameForId(id:Int):Null<String>
		return str(SDLGamepadNative.nameForId(id));

	/**
	 * Returns the implementation-dependent device path for a gamepad.
	 *
	 * @param id The gamepad device ID.
	 * @return The device path, or `null` on failure.
	 */
	public static function getPathForId(id:Int):Null<String>
		return str(SDLGamepadNative.pathForId(id));

	/**
	 * Returns the player index assigned to a gamepad.
	 *
	 * @param id The gamepad device ID.
	 * @return The player index, or -1 if not assigned.
	 */
	public static function getPlayerIndexForId(id:Int):Int
		return SDLGamepadNative.playerIndexForId(id);

	/**
	 * Returns the 16-byte GUID identifying a gamepad's model.
	 *
	 * @param id The gamepad device ID.
	 * @return A 16-byte `Bytes` object containing the GUID.
	 */
	public static function getGuidForId(id:Int):Bytes {
		var b = Bytes.alloc(16);
		SDLGamepadNative.guidForId(id, hl.Bytes.fromBytes(b));
		return b;
	}

	/**
	 * Returns the USB vendor ID of a gamepad.
	 *
	 * @param id The gamepad device ID.
	 * @return The vendor ID, or 0 if unknown.
	 */
	public static function getVendorForId(id:Int):Int
		return SDLGamepadNative.vendorForId(id);

	/**
	 * Returns the USB product ID of a gamepad.
	 *
	 * @param id The gamepad device ID.
	 * @return The product ID, or 0 if unknown.
	 */
	public static function getProductForId(id:Int):Int
		return SDLGamepadNative.productForId(id);

	/**
	 * Returns the product version of a gamepad.
	 *
	 * @param id The gamepad device ID.
	 * @return The product version, or 0 if unknown.
	 */
	public static function getProductVersionForId(id:Int):Int
		return SDLGamepadNative.versionForId(id);

	/**
	 * Returns the SDL gamepad type for a device ID.
	 *
	 * @param id The gamepad device ID.
	 * @return The gamepad type.
	 */
	public static function getTypeForId(id:Int):SDLGamepadType
		return SDLGamepadNative.typeForId(id);

	/**
	 * Returns the "real" gamepad type, ignoring any user remapping.
	 *
	 * @param id The gamepad device ID.
	 * @return The underlying gamepad type.
	 */
	public static function getRealTypeForId(id:Int):SDLGamepadType
		return SDLGamepadNative.realTypeForId(id);

	/**
	 * Updates the internal state of all open gamepads.
	 *
	 * Call this once per frame before polling input, if you are not using
	 * the SDL event loop to update gamepads automatically.
	 */
	public static function update():Void
		SDLGamepadNative.update();

	/**
	 * Enables or disables gamepad event generation.
	 *
	 * @param enabled `true` to receive gamepad events, `false` to suppress them.
	 */
	public static function setEventsEnabled(enabled:Bool):Void
		SDLGamepadNative.setEventsEnabled(enabled);

	/**
	 * Returns whether gamepad event generation is currently enabled.
	 *
	 * @return `true` if gamepad events are enabled.
	 */
	public static function eventsEnabled():Bool
		return SDLGamepadNative.eventsEnabled();

	/**
	 * Adds a single gamepad mapping string to the mapping database.
	 *
	 * @param mapping The mapping string to add.
	 * @return 1 if the mapping was added, 0 if it was updated, -1 on error.
	 */
	public static function addMapping(mapping:String):Int
		@:privateAccess return SDLGamepadNative.addMapping(mapping.toUtf8());

	/**
	 * Loads a set of gamepad mappings from a file.
	 *
	 * @param path Path to the file containing mapping strings.
	 * @return The number of mappings added, or -1 on error.
	 */
	public static function addMappingsFromFile(path:String):Int
		@:privateAccess return SDLGamepadNative.addMappingsFromFile(path.toUtf8());

	/**
	 * Reloads gamepad mappings from the standard SDL mapping database.
	 *
	 * @return `true` on success.
	 */
	public static function reloadMappings():Bool
		return SDLGamepadNative.reloadMappings();

	/**
	 * Returns every mapping string currently in the database.
	 *
	 * @return An array of mapping strings.
	 */
	public static function getMappings():Array<String> {
		var a = SDLGamepadNative.getMappings();
		@:privateAccess return a == null ? [] : [for (i in 0...a.length) String.fromUTF8(a[i])];
	}

	/**
	 * Looks up the mapping string for a gamepad GUID.
	 *
	 * @param guid A 16-byte GUID as returned by `getGuidForId`.
	 * @return The matching mapping string, or `null` if none.
	 * @throws String if `guid` is not 16 bytes long.
	 */
	public static function getMappingForGuid(guid:Bytes):Null<String> {
		if (guid.length != 16)
			throw "GUID debe tener 16 bytes";
		return str(SDLGamepadNative.mappingForGuid(hl.Bytes.fromBytes(guid)));
	}

	/**
	 * Looks up the mapping string for a gamepad device ID.
	 *
	 * @param id The gamepad device ID.
	 * @return The matching mapping string, or `null` if none.
	 */
	public static function getMappingForId(id:Int):Null<String>
		return str(SDLGamepadNative.mappingForId(id));

	/**
	 * Assigns a mapping string to a specific device ID (or removes it).
	 *
	 * @param id The gamepad device ID.
	 * @param mapping The mapping string, or `null` to remove the mapping.
	 * @return `true` on success.
	 */
	public static function setMapping(id:Int, mapping:Null<String>):Bool
		@:privateAccess return SDLGamepadNative.setMapping(id, mapping == null ? null : mapping.toUtf8());

	/**
	 * Converts a gamepad type name to its enum value.
	 *
	 * @param s The type name (e.g. `"xbox360"`).
	 * @return The corresponding gamepad type, or `UNKNOWN` if not recognized.
	 */
	public static function typeFromString(s:String):SDLGamepadType
		@:privateAccess return SDLGamepadNative.typeFromString(s.toUtf8());

	/**
	 * Converts a gamepad type enum to its canonical string name.
	 *
	 * @param t The gamepad type.
	 * @return The type name, or `null` if unknown.
	 */
	public static function stringForType(t:SDLGamepadType):Null<String>
		return str(SDLGamepadNative.stringForType(t));

	/**
	 * Converts an axis name to its enum value.
	 *
	 * @param s The axis name (e.g. `"leftx"`).
	 * @return The corresponding axis, or `INVALID` if not recognized.
	 */
	public static function axisFromString(s:String):SDLGamepadAxis
		@:privateAccess return SDLGamepadNative.axisFromString(s.toUtf8());

	/**
	 * Converts an axis enum to its canonical string name.
	 *
	 * @param a The axis.
	 * @return The axis name, or `null` if unknown.
	 */
	public static function stringForAxis(a:SDLGamepadAxis):Null<String>
		return str(SDLGamepadNative.stringForAxis(a));

	/**
	 * Converts a button name to its enum value.
	 *
	 * @param s The button name (e.g. `"a"`, `"dpad_up"`).
	 * @return The corresponding button, or `INVALID` if not recognized.
	 */
	public static function buttonFromString(s:String):SDLGamepadButton
		@:privateAccess return SDLGamepadNative.buttonFromString(s.toUtf8());

	/**
	 * Converts a button enum to its canonical string name.
	 *
	 * @param b The button.
	 * @return The button name, or `null` if unknown.
	 */
	public static function stringForButton(b:SDLGamepadButton):Null<String>
		return str(SDLGamepadNative.stringForButton(b));

	/**
	 * Returns the physical button label for a given type without opening a gamepad.
	 *
	 * @param type The gamepad type.
	 * @param button The button to query.
	 * @return The label printed on that button for this gamepad type.
	 */
	public static function buttonLabelForType(type:SDLGamepadType, button:SDLGamepadButton):SDLGamepadButtonLabel
		return SDLGamepadNative.labelForType(type, button);
}

/**
 * A handle to an opened gamepad.
 *
 * Wraps `SDL_Gamepad` and provides convenient access to buttons, axes,
 * touchpads, sensors, rumble, and LEDs. Remember to `close()` it when done.
 */
class SDLGamepad {
	var ptr:SDLGamepadPtr;

	function new(ptr:SDLGamepadPtr)
		this.ptr = ptr;

	/**
	 * Opens a gamepad by device ID.
	 *
	 * @param id The gamepad device ID.
	 * @return A new gamepad handle, or `null` on failure.
	 */
	public static function open(id:Int):Null<SDLGamepad> {
		var p = SDLGamepadNative.open(id);
		return p == null ? null : new SDLGamepad(p);
	}

	/**
	 * Returns the already-opened gamepad handle for a device ID, if any.
	 *
	 * @param id The gamepad device ID.
	 * @return The gamepad handle, or `null` if not open.
	 */
	public static function fromId(id:Int):Null<SDLGamepad> {
		var p = SDLGamepadNative.fromId(id);
		return p == null ? null : new SDLGamepad(p);
	}

	/**
	 * Returns the gamepad handle assigned to a player index, if any.
	 *
	 * @param index The player index.
	 * @return The gamepad handle, or `null` if none.
	 */
	public static function fromPlayerIndex(index:Int):Null<SDLGamepad> {
		var p = SDLGamepadNative.fromPlayerIndex(index);
		return p == null ? null : new SDLGamepad(p);
	}

	/**
	 * Closes the gamepad and releases its resources.
	 *
	 * Safe to call multiple times; the handle becomes unusable afterwards.
	 */
	public function close():Void {
		if (ptr != null)
			SDLGamepadNative.close(ptr);
		ptr = null;
	}

	static inline function str(b:hl.Bytes):Null<String>
		@:privateAccess return b == null ? null : String.fromUTF8(b);

	/** Device ID of this gamepad. */
	public var id(get, never):Int;

	/** Human-readable name of this gamepad. */
	public var name(get, never):Null<String>;

	/** Implementation-dependent device path. */
	public var path(get, never):Null<String>;

	/** SDL gamepad type. */
	public var type(get, never):SDLGamepadType;

	/** Underlying gamepad type ignoring remappings. */
	public var realType(get, never):SDLGamepadType;

	/** USB vendor ID. */
	public var vendor(get, never):Int;

	/** USB product ID. */
	public var product(get, never):Int;

	/** Product version. */
	public var productVersion(get, never):Int;

	/** Firmware version. */
	public var firmwareVersion(get, never):Int;

	/** Serial number, if available. */
	public var serial(get, never):Null<String>;

	/** Whether the gamepad is currently connected. */
	public var connected(get, never):Bool;

	/** Connection state (wired/wireless/etc.). */
	public var connectionState(get, never):SDLJoystickConnectionState;

	/** Player index assigned to this gamepad; assignable via `set`. */
	public var playerIndex(get, set):Int;

	inline function get_id()
		return SDLGamepadNative.getId(ptr);

	inline function get_name()
		return str(SDLGamepadNative.getName(ptr));

	inline function get_path()
		return str(SDLGamepadNative.getPath(ptr));

	inline function get_type():SDLGamepadType
		return SDLGamepadNative.getType(ptr);

	inline function get_realType():SDLGamepadType
		return SDLGamepadNative.getRealType(ptr);

	inline function get_vendor()
		return SDLGamepadNative.getVendor(ptr);

	inline function get_product()
		return SDLGamepadNative.getProduct(ptr);

	inline function get_productVersion()
		return SDLGamepadNative.getProductVersion(ptr);

	inline function get_firmwareVersion()
		return SDLGamepadNative.getFirmwareVersion(ptr);

	inline function get_serial()
		return str(SDLGamepadNative.getSerial(ptr));

	inline function get_connected()
		return SDLGamepadNative.connected(ptr);

	inline function get_connectionState():SDLJoystickConnectionState
		return SDLGamepadNative.getConnectionState(ptr);

	inline function get_playerIndex()
		return SDLGamepadNative.getPlayerIndex(ptr);

	function set_playerIndex(v:Int):Int {
		SDLGamepadNative.setPlayerIndex(ptr, v);
		return v;
	}

	/**
	 * Returns the Steam handle for this gamepad, if it is a Steam Input device.
	 *
	 * @return A 64-bit handle, or 0 if not applicable.
	 */
	public function getSteamHandle():Int64 {
		var o = new hl.NativeArray<Int>(2);
		SDLGamepadNative.getSteamHandle(ptr, o);
		return Int64.make(o[0], o[1]);
	}

	/**
	 * Returns the current power state of the gamepad.
	 *
	 * @return A `SDLGamepadPower` with the state and battery percentage.
	 */
	public function getPower():SDLGamepadPower {
		var o = new hl.NativeArray<Int>(2);
		SDLGamepadNative.getPowerInfo(ptr, o);
		return {state: o[0], percent: o[1]};
	}

	/**
	 * Returns the optional features supported by this gamepad.
	 *
	 * @return A `SDLGamepadCapabilities` structure.
	 */
	public function getCapabilities():SDLGamepadCapabilities {
		var c = SDLGamepadNative.capabilities(ptr);
		return {
			monoLED: (c & 1) != 0,
			rgbLED: (c & 2) != 0,
			playerLED: (c & 4) != 0,
			rumble: (c & 8) != 0,
			triggerRumble: (c & 16) != 0
		};
	}

	/**
	 * Returns the active mapping string for this gamepad.
	 *
	 * @return The mapping string, or `null` if none.
	 */
	public function getMapping():Null<String>
		return str(SDLGamepadNative.getMapping(ptr));

	/**
	 * Returns the underlying joystick handle for this gamepad.
	 *
	 * @return A `SDLJoystick`, or `null` on failure.
	 */
	public function getJoystick():Null<SDLJoystick> {
		var p = SDLGamepadNative.getJoystick(ptr);
		return p == null ? null : @:privateAccess new SDLJoystick(p);
	}

	/**
	 * Returns the parsed list of bindings in this gamepad's mapping.
	 *
	 * @return An array of `SDLGamepadBinding` entries.
	 */
	public function getBindings():Array<SDLGamepadBinding> {
		var a = SDLGamepadNative.getBindings(ptr);
		var r = [];
		if (a == null)
			return r;
		var n = Std.int(a.length / 8);
		for (k in 0...n) {
			var o = k * 8;
			var it:SDLGamepadBindingType = a[o];
			var ot:SDLGamepadBindingType = a[o + 4];
			r.push({
				inputType: it,
				input: it == BUTTON ? [a[o + 1]] : it == AXIS ? [a[o + 1], a[o + 2], a[o + 3]] : it == HAT ? [a[o + 1], a[o + 2]] : [],
				outputType: ot,
				output: ot == BUTTON ? [a[o + 5]] : ot == AXIS ? [a[o + 5], a[o + 6], a[o + 7]] : []
			});
		}
		return r;
	}

	/**
	 * Checks whether this gamepad has a given axis.
	 *
	 * @param axis The axis to check.
	 * @return `true` if the axis is present.
	 */
	public function hasAxis(axis:SDLGamepadAxis):Bool
		return SDLGamepadNative.hasAxis(ptr, axis);

	/**
	 * Returns the raw value of a gamepad axis.
	 *
	 * @param axis The axis to read.
	 * @return The axis value in `[-32768, 32767]`.
	 */
	public function getAxis(axis:SDLGamepadAxis):Int
		return SDLGamepadNative.getAxis(ptr, axis);

	/**
	 * Returns the value of a gamepad axis normalized to `[-1, 1]`.
	 *
	 * @param axis The axis to read.
	 * @return The normalized axis value.
	 */
	public function getAxisNormalized(axis:SDLGamepadAxis):Float {
		var v = SDLGamepadNative.getAxis(ptr, axis);
		var f = v / 32767.0;
		return f < -1 ? -1 : f;
	}

	/**
	 * Checks whether this gamepad has a given button.
	 *
	 * @param button The button to check.
	 * @return `true` if the button is present.
	 */
	public function hasButton(button:SDLGamepadButton):Bool
		return SDLGamepadNative.hasButton(ptr, button);

	/**
	 * Checks whether a button is currently pressed.
	 *
	 * @param button The button to query.
	 * @return `true` if the button is down.
	 */
	public function isDown(button:SDLGamepadButton):Bool
		return SDLGamepadNative.getButton(ptr, button);

	/**
	 * Returns the label printed on a given button for this gamepad's type.
	 *
	 * @param button The button to query.
	 * @return The button label.
	 */
	public function getButtonLabel(button:SDLGamepadButton):SDLGamepadButtonLabel
		return SDLGamepadNative.buttonLabel(ptr, button);

	/**
	 * Returns the Apple SF Symbols name for a button (macOS/iOS only).
	 *
	 * @param button The button to query.
	 * @return The SF Symbols name, or `null` if unavailable.
	 */
	public function getAppleSFSymbolsNameForButton(button:SDLGamepadButton):Null<String>
		return str(SDLGamepadNative.sfButton(ptr, button));

	/**
	 * Returns the Apple SF Symbols name for an axis (macOS/iOS only).
	 *
	 * @param axis The axis to query.
	 * @return The SF Symbols name, or `null` if unavailable.
	 */
	public function getAppleSFSymbolsNameForAxis(axis:SDLGamepadAxis):Null<String>
		return str(SDLGamepadNative.sfAxis(ptr, axis));

	/**
	 * Returns the number of touchpads available on this gamepad.
	 *
	 * @return The touchpad count.
	 */
	public function getNumTouchpads():Int
		return SDLGamepadNative.numTouchpads(ptr);

	/**
	 * Returns the number of fingers currently tracked on a touchpad.
	 *
	 * @param touchpad The touchpad index.
	 * @return The number of active fingers.
	 */
	public function getNumTouchpadFingers(touchpad:Int):Int
		return SDLGamepadNative.numFingers(ptr, touchpad);

	/**
	 * Returns the state of a finger on a touchpad.
	 *
	 * @param touchpad The touchpad index.
	 * @param finger The finger index.
	 * @return A `SDLTouchpadFinger`, or `null` if the finger is not valid.
	 */
	public function getTouchpadFinger(touchpad:Int, finger:Int):Null<SDLTouchpadFinger> {
		var o = new hl.NativeArray<Float>(4);
		if (!SDLGamepadNative.getFinger(ptr, touchpad, finger, o))
			return null;
		return {
			down: o[0] != 0,
			x: o[1],
			y: o[2],
			pressure: o[3]
		};
	}

	/**
	 * Checks whether this gamepad exposes a given sensor.
	 *
	 * @param sensor The sensor to check.
	 * @return `true` if the sensor is present.
	 */
	public function hasSensor(sensor:SDLGamepadSensor):Bool
		return SDLGamepadNative.hasSensor(ptr, sensor);

	/**
	 * Enables or disables a gamepad sensor.
	 *
	 * @param sensor The sensor to toggle.
	 * @param enabled `true` to enable, `false` to disable.
	 * @return `true` on success.
	 */
	public function setSensorEnabled(sensor:SDLGamepadSensor, enabled:Bool):Bool
		return SDLGamepadNative.setSensorEnabled(ptr, sensor, enabled);

	/**
	 * Returns whether a given sensor is currently enabled.
	 *
	 * @param sensor The sensor to query.
	 * @return `true` if the sensor is enabled.
	 */
	public function isSensorEnabled(sensor:SDLGamepadSensor):Bool
		return SDLGamepadNative.sensorEnabled(ptr, sensor);

	/**
	 * Returns the effective data rate of a sensor, in Hz.
	 *
	 * @param sensor The sensor to query.
	 * @return The sensor data rate in Hz.
	 */
	public function getSensorDataRate(sensor:SDLGamepadSensor):Float
		return SDLGamepadNative.sensorRate(ptr, sensor);

	/**
	 * Returns the latest reading from a gamepad sensor.
	 *
	 * @param sensor The sensor to read.
	 * @return An array of `[x, y, z]` values, or `null` on failure.
	 */
	public function getSensorData(sensor:SDLGamepadSensor):Null<Array<Float>> {
		var o = new hl.NativeArray<Float>(3);
		if (!SDLGamepadNative.sensorData(ptr, sensor, o))
			return null;
		return [o[0], o[1], o[2]];
	}

	/**
	 * Starts a rumble effect on the gamepad.
	 *
	 * @param low Low-frequency motor intensity in `[0, 65535]`.
	 * @param high High-frequency motor intensity in `[0, 65535]`.
	 * @param durationMs Duration in milliseconds.
	 * @return `true` on success.
	 */
	public function rumble(low:Int, high:Int, durationMs:Int):Bool
		return SDLGamepadNative.rumble(ptr, low, high, durationMs);

	/**
	 * Starts a rumble effect on the trigger motors.
	 *
	 * @param left Left trigger intensity in `[0, 65535]`.
	 * @param right Right trigger intensity in `[0, 65535]`.
	 * @param durationMs Duration in milliseconds.
	 * @return `true` on success.
	 */
	public function rumbleTriggers(left:Int, right:Int, durationMs:Int):Bool
		return SDLGamepadNative.rumbleTriggers(ptr, left, right, durationMs);

	/**
	 * Sets the color of the gamepad's RGB LED.
	 *
	 * @param r Red component in `[0, 255]`.
	 * @param g Green component in `[0, 255]`.
	 * @param b Blue component in `[0, 255]`.
	 * @return `true` on success.
	 */
	public function setLED(r:Int, g:Int, b:Int):Bool
		return SDLGamepadNative.setLed(ptr, r, g, b);

	/**
	 * Sends a raw platform-specific effect packet to the gamepad.
	 *
	 * @param data The effect data.
	 * @return `true` on success.
	 */
	public function sendEffect(data:Bytes):Bool
		return SDLGamepadNative.sendEffect(ptr, hl.Bytes.fromBytes(data), data.length);
}
