package hl.bindings.sdl3;

import haxe.io.Bytes;

typedef SDLJoystickPtr = hl.Abstract<"SDL_Joystick">;

/**
 * The general category of a joystick device.
 * Corresponds to `SDL_JoystickType` in SDL3.
 */
enum abstract SDLJoystickType(Int) from Int to Int {
	/** Unknown or unrecognized joystick. */
	var UNKNOWN = 0;

	/** A gamepad-style controller. */
	var GAMEPAD = 1;

	/** A steering wheel. */
	var WHEEL = 2;

	/** An arcade stick. */
	var ARCADE_STICK = 3;

	/** A flight stick. */
	var FLIGHT_STICK = 4;

	/** A dance pad. */
	var DANCE_PAD = 5;

	/** A guitar controller. */
	var GUITAR = 6;

	/** A drum kit. */
	var DRUM_KIT = 7;

	/** An arcade pad (button-only controller). */
	var ARCADE_PAD = 8;

	/** A throttle lever. */
	var THROTTLE = 9;
}

/**
 * Whether a joystick is connected by wire or wirelessly.
 * Corresponds to `SDL_JoystickConnectionState` in SDL3.
 */
enum abstract SDLJoystickConnectionState(Int) from Int to Int {
	/** The connection state could not be determined. */
	var INVALID = -1;

	/** The connection state is unknown. */
	var UNKNOWN = 0;

	/** The joystick is connected via a cable. */
	var WIRED = 1;

	/** The joystick is connected wirelessly. */
	var WIRELESS = 2;
}

/**
 * Bitmask of hardware features a joystick supports (LEDs, rumble).
 * Test individual bits with `SDLJoystick.hasCapability`.
 *
 * Corresponds to `SDL_JoystickCapability` in SDL3.
 */
enum abstract SDLJoystickCapability(Int) from Int to Int {
	/** The joystick has a single-colour LED. */
	var MONO_LED = 1;

	/** The joystick has an RGB LED. */
	var RGB_LED = 2;

	/** The joystick has a player indicator LED. */
	var PLAYER_LED = 4;

	/** The joystick supports rumble. */
	var RUMBLE = 8;

	/** The joystick supports trigger rumble. */
	var TRIGGER_RUMBLE = 16;
}

/**
 * Vendor, product, version, and CRC-16 information decoded from a joystick GUID.
 */
typedef SDLJoystickGuidInfo = {
	/** USB vendor ID. */
	vendor:Int,

	/** USB product ID. */
	product:Int,

	/** Product version. */
	version:Int,

	/** CRC-16 checksum of the GUID. */
	crc16:Int
}

/**
 * A joystick's current power state and, if known, battery percentage.
 */
typedef SDLJoystickPower = {
	/** The current power/battery state. */
	state:SDLPowerState,

	/** Estimated battery percentage in `[0, 100]`, or -1 if unknown. */
	percent:Int
}

@:noCompletion
class SDLJoystickNative {
	@:hlNative("sdl3", "lock_joysticks") public static function lock():Void {}

	@:hlNative("sdl3", "unlock_joysticks") public static function unlock():Void {}

	@:hlNative("sdl3", "has_joystick") public static function hasJoystick():Bool
		return false;

	@:hlNative("sdl3", "get_joysticks") public static function getJoysticks():hl.NativeArray<Int>
		return null;

	@:hlNative("sdl3", "get_joystick_name_for_id") public static function nameForId(id:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_joystick_path_for_id") public static function pathForId(id:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_joystick_player_index_for_id") public static function playerIndexForId(id:Int):Int
		return 0;

	@:hlNative("sdl3", "get_joystick_guid_for_id") public static function guidForId(id:Int, out16:hl.Bytes):Void {}

	@:hlNative("sdl3", "get_joystick_vendor_for_id") public static function vendorForId(id:Int):Int
		return 0;

	@:hlNative("sdl3", "get_joystick_product_for_id") public static function productForId(id:Int):Int
		return 0;

	@:hlNative("sdl3", "get_joystick_product_version_for_id") public static function versionForId(id:Int):Int
		return 0;

	@:hlNative("sdl3", "get_joystick_type_for_id") public static function typeForId(id:Int):Int
		return 0;

	@:hlNative("sdl3", "open_joystick") public static function open(id:Int):SDLJoystickPtr
		return null;

	@:hlNative("sdl3", "get_joystick_from_id") public static function fromId(id:Int):SDLJoystickPtr
		return null;

	@:hlNative("sdl3", "get_joystick_from_player_index") public static function fromPlayerIndex(idx:Int):SDLJoystickPtr
		return null;

	@:hlNative("sdl3", "attach_virtual_joystick") public static function attachVirtual(type:Int, vendorId:Int, productId:Int, naxes:Int, nbuttons:Int,
			nballs:Int, nhats:Int, buttonMask:Int, axisMask:Int, name:hl.Bytes):Int
		return 0;

	@:hlNative("sdl3", "detach_virtual_joystick") public static function detachVirtual(id:Int):Bool
		return false;

	@:hlNative("sdl3", "is_joystick_virtual") public static function isVirtual(id:Int):Bool
		return false;

	@:hlNative("sdl3", "set_joystick_virtual_axis") public static function setVirtualAxis(j:SDLJoystickPtr, axis:Int, value:Int):Bool
		return false;

	@:hlNative("sdl3", "set_joystick_virtual_ball") public static function setVirtualBall(j:SDLJoystickPtr, ball:Int, xrel:Int, yrel:Int):Bool
		return false;

	@:hlNative("sdl3", "set_joystick_virtual_button") public static function setVirtualButton(j:SDLJoystickPtr, button:Int, down:Bool):Bool
		return false;

	@:hlNative("sdl3", "set_joystick_virtual_hat") public static function setVirtualHat(j:SDLJoystickPtr, hat:Int, value:Int):Bool
		return false;

	@:hlNative("sdl3", "set_joystick_virtual_touchpad") public static function setVirtualTouchpad(j:SDLJoystickPtr, touchpad:Int, finger:Int, down:Bool,
			x:Float, y:Float, pressure:Float):Bool
		return false;

	@:hlNative("sdl3", "send_joystick_virtual_sensor_data") public static function sendVirtualSensorData(j:SDLJoystickPtr, sensorType:Int, tsHi:Int, tsLo:Int,
			data:hl.NativeArray<Float>):Bool
		return false;

	@:hlNative("sdl3", "joystick_capabilities") public static function capabilities(j:SDLJoystickPtr):Int
		return 0;

	@:hlNative("sdl3", "get_joystick_name") public static function getName(j:SDLJoystickPtr):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_joystick_path") public static function getPath(j:SDLJoystickPtr):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_joystick_player_index") public static function getPlayerIndex(j:SDLJoystickPtr):Int
		return 0;

	@:hlNative("sdl3", "set_joystick_player_index") public static function setPlayerIndex(j:SDLJoystickPtr, idx:Int):Bool
		return false;

	@:hlNative("sdl3", "get_joystick_guid") public static function getGuid(j:SDLJoystickPtr, out16:hl.Bytes):Void {}

	@:hlNative("sdl3", "get_joystick_vendor") public static function getVendor(j:SDLJoystickPtr):Int
		return 0;

	@:hlNative("sdl3", "get_joystick_product") public static function getProduct(j:SDLJoystickPtr):Int
		return 0;

	@:hlNative("sdl3", "get_joystick_product_version") public static function getProductVersion(j:SDLJoystickPtr):Int
		return 0;

	@:hlNative("sdl3", "get_joystick_firmware_version") public static function getFirmwareVersion(j:SDLJoystickPtr):Int
		return 0;

	@:hlNative("sdl3", "get_joystick_serial") public static function getSerial(j:SDLJoystickPtr):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_joystick_type") public static function getType(j:SDLJoystickPtr):Int
		return 0;

	@:hlNative("sdl3", "get_joystick_guid_info") public static function getGuidInfo(guid16:hl.Bytes, out:hl.NativeArray<Int>):Void {}

	@:hlNative("sdl3", "joystick_connected") public static function connected(j:SDLJoystickPtr):Bool
		return false;

	@:hlNative("sdl3", "get_joystick_id") public static function getId(j:SDLJoystickPtr):Int
		return 0;

	@:hlNative("sdl3", "get_num_joystick_axes") public static function numAxes(j:SDLJoystickPtr):Int
		return 0;

	@:hlNative("sdl3", "get_num_joystick_balls") public static function numBalls(j:SDLJoystickPtr):Int
		return 0;

	@:hlNative("sdl3", "get_num_joystick_hats") public static function numHats(j:SDLJoystickPtr):Int
		return 0;

	@:hlNative("sdl3", "get_num_joystick_buttons") public static function numButtons(j:SDLJoystickPtr):Int
		return 0;

	@:hlNative("sdl3", "set_joystick_events_enabled") public static function setEventsEnabled(b:Bool):Void {}

	@:hlNative("sdl3", "joystick_events_enabled") public static function eventsEnabled():Bool
		return false;

	@:hlNative("sdl3", "update_joysticks") public static function update():Void {}

	@:hlNative("sdl3", "get_joystick_axis") public static function getAxis(j:SDLJoystickPtr, axis:Int):Int
		return 0;

	@:hlNative("sdl3", "get_joystick_axis_initial_state") public static function getAxisInitialState(j:SDLJoystickPtr, axis:Int, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "get_joystick_ball") public static function getBall(j:SDLJoystickPtr, ball:Int, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "get_joystick_hat") public static function getHat(j:SDLJoystickPtr, hat:Int):Int
		return 0;

	@:hlNative("sdl3", "get_joystick_button") public static function getButton(j:SDLJoystickPtr, button:Int):Bool
		return false;

	@:hlNative("sdl3", "rumble_joystick") public static function rumble(j:SDLJoystickPtr, low:Int, high:Int, ms:Int):Bool
		return false;

	@:hlNative("sdl3", "rumble_joystick_triggers") public static function rumbleTriggers(j:SDLJoystickPtr, left:Int, right:Int, ms:Int):Bool
		return false;

	@:hlNative("sdl3", "set_joystick_led") public static function setLed(j:SDLJoystickPtr, r:Int, g:Int, b:Int):Bool
		return false;

	@:hlNative("sdl3", "send_joystick_effect") public static function sendEffect(j:SDLJoystickPtr, data:hl.Bytes, size:Int):Bool
		return false;

	@:hlNative("sdl3", "close_joystick") public static function close(j:SDLJoystickPtr):Void {}

	@:hlNative("sdl3", "get_joystick_connection_state") public static function getConnectionState(j:SDLJoystickPtr):Int
		return 0;

	@:hlNative("sdl3", "get_joystick_power_info") public static function getPowerInfo(j:SDLJoystickPtr, out:hl.NativeArray<Int>):Void {}
}

/**
 * The position of a joystick hat (D-pad) switch.
 *
 * The values are a bitmask: `UP`/`DOWN` and `LEFT`/`RIGHT` can be combined,
 * producing the diagonal positions (e.g. `RIGHTUP`).
 *
 * Corresponds to `SDL_HatPosition` in SDL3.
 */
enum abstract SDLHatPosition(Int) from Int to Int {
	/** Hat is centered. */
	var CENTERED = 0;

	/** Hat is pushed up. */
	var UP = 1;

	/** Hat is pushed right. */
	var RIGHT = 2;

	/** Hat is pushed up-right. */
	var RIGHTUP = 3;

	/** Hat is pushed down. */
	var DOWN = 4;

	/** Hat is pushed down-right. */
	var RIGHTDOWN = 6;

	/** Hat is pushed left. */
	var LEFT = 8;

	/** Hat is pushed up-left. */
	var LEFTUP = 9;

	/** Hat is pushed down-left. */
	var LEFTDOWN = 12;
}

/**
 * Static joystick subsystem API.
 *
 * Provides device enumeration, metadata queries (that do not require opening
 * the joystick), virtual joystick creation, and global subsystem settings.
 *
 * Corresponds to the SDL3 joystick subsystem functions that operate on
 * device instance IDs rather than open handles.
 */
class SDLJoysticks {
	static inline function str(b:hl.Bytes):Null<String>
		@:privateAccess return b == null ? null : String.fromUTF8(b);

	/**
	 * Locks the joystick subsystem for thread-safe access.
	 *
	 * Use this when multiple threads need to query joystick state. Must be
	 * paired with a matching call to `unlock()`.
	 */
	public static function lock():Void
		SDLJoystickNative.lock();

	/**
	 * Unlocks the joystick subsystem previously locked with `lock()`.
	 */
	public static function unlock():Void
		SDLJoystickNative.unlock();

	/**
	 * Checks whether at least one joystick is currently connected.
	 *
	 * @return `true` if any joystick is available.
	 */
	public static function hasJoystick():Bool
		return SDLJoystickNative.hasJoystick();

	/**
	 * Returns the instance IDs of all currently connected joysticks.
	 *
	 * @return An array of joystick instance IDs.
	 */
	public static function getJoysticks():Array<Int> {
		var a = SDLJoystickNative.getJoysticks();
		return a == null ? [] : [for (i in 0...a.length) a[i]];
	}

	/**
	 * Returns the name of a joystick without opening it.
	 *
	 * @param id The joystick instance ID.
	 * @return The joystick name, or `null` if not found.
	 */
	public static function getNameForId(id:Int):Null<String>
		return str(SDLJoystickNative.nameForId(id));

	/**
	 * Returns the implementation-dependent device path of a joystick
	 * without opening it.
	 *
	 * @param id The joystick instance ID.
	 * @return The device path, or `null` if not found.
	 */
	public static function getPathForId(id:Int):Null<String>
		return str(SDLJoystickNative.pathForId(id));

	/**
	 * Returns the player index assigned to a joystick, without opening it.
	 *
	 * @param id The joystick instance ID.
	 * @return The player index, or -1 if not assigned.
	 */
	public static function getPlayerIndexForId(id:Int):Int
		return SDLJoystickNative.playerIndexForId(id);

	/**
	 * Returns the 16-byte GUID of a joystick, without opening it.
	 *
	 * @param id The joystick instance ID.
	 * @return A 16-byte GUID as a `Bytes` object.
	 */
	public static function getGuidForId(id:Int):Bytes {
		var b = Bytes.alloc(16);
		SDLJoystickNative.guidForId(id, hl.Bytes.fromBytes(b));
		return b;
	}

	/**
	 * Returns the USB vendor ID of a joystick, without opening it.
	 *
	 * @param id The joystick instance ID.
	 * @return The vendor ID, or 0 if unknown.
	 */
	public static function getVendorForId(id:Int):Int
		return SDLJoystickNative.vendorForId(id);

	/**
	 * Returns the USB product ID of a joystick, without opening it.
	 *
	 * @param id The joystick instance ID.
	 * @return The product ID, or 0 if unknown.
	 */
	public static function getProductForId(id:Int):Int
		return SDLJoystickNative.productForId(id);

	/**
	 * Returns the product version of a joystick, without opening it.
	 *
	 * @param id The joystick instance ID.
	 * @return The product version, or 0 if unknown.
	 */
	public static function getProductVersionForId(id:Int):Int
		return SDLJoystickNative.versionForId(id);

	/**
	 * Returns the type/category of a joystick, without opening it.
	 *
	 * @param id The joystick instance ID.
	 * @return The joystick type.
	 */
	public static function getTypeForId(id:Int):SDLJoystickType
		return SDLJoystickNative.typeForId(id);

	/**
	 * Decodes vendor, product, version, and CRC information from a GUID.
	 *
	 * @param guid A 16-byte GUID (as returned by `getGuidForId`).
	 * @return The decoded GUID information.
	 * @throws String if `guid` is not 16 bytes long.
	 */
	public static function getGuidInfo(guid:Bytes):SDLJoystickGuidInfo {
		if (guid.length != 16)
			throw "GUID must be 16 bytes";
		var o = new hl.NativeArray<Int>(4);
		SDLJoystickNative.getGuidInfo(hl.Bytes.fromBytes(guid), o);
		return {
			vendor: o[0],
			product: o[1],
			version: o[2],
			crc16: o[3]
		};
	}

	/**
	 * Creates a virtual (software-simulated) joystick.
	 *
	 * Useful for testing or for feeding input from a custom source through
	 * SDL's joystick API. Detach it with `detachVirtual()` when done.
	 *
	 * @param type       The type/category of the virtual joystick.
	 * @param vendorId   The USB vendor ID to report.
	 * @param productId  The USB product ID to report.
	 * @param naxes      Number of axes the virtual joystick supports.
	 * @param nbuttons   Number of buttons the virtual joystick supports.
	 * @param nballs     Number of trackballs the virtual joystick supports.
	 * @param nhats      Number of hats the virtual joystick supports.
	 * @param buttonMask A bitmask of SDL gamepad button bindings.
	 * @param axisMask   A bitmask of SDL gamepad axis bindings.
	 * @param name       Optional joystick name.
	 * @return The new joystick instance ID, or -1 on failure.
	 */
	public static function attachVirtual(type:SDLJoystickType, vendorId:Int = 0, productId:Int = 0, naxes:Int = 0, nbuttons:Int = 0, nballs:Int = 0,
			nhats:Int = 0, buttonMask:Int = 0, axisMask:Int = 0, ?name:String):Int
		@:privateAccess return SDLJoystickNative.attachVirtual(type, vendorId, productId, naxes, nbuttons, nballs, nhats, buttonMask, axisMask,
			name == null ? null : name.toUtf8());

	/**
	 * Removes a previously attached virtual joystick.
	 *
	 * @param id The virtual joystick's instance ID.
	 * @return `true` on success, `false` on failure.
	 */
	public static function detachVirtual(id:Int):Bool
		return SDLJoystickNative.detachVirtual(id);

	/**
	 * Checks whether a joystick is virtual (software-simulated).
	 *
	 * @param id The joystick instance ID.
	 * @return `true` if the joystick is virtual.
	 */
	public static function isVirtual(id:Int):Bool
		return SDLJoystickNative.isVirtual(id);

	/**
	 * Enables or disables generating events when joystick state changes.
	 *
	 * @param enabled `true` to receive joystick events, `false` to suppress them.
	 */
	public static function setEventsEnabled(enabled:Bool):Void
		SDLJoystickNative.setEventsEnabled(enabled);

	/**
	 * Returns whether joystick event generation is currently enabled.
	 *
	 * @return `true` if joystick events are enabled.
	 */
	public static function eventsEnabled():Bool
		return SDLJoystickNative.eventsEnabled();

	/**
	 * Manually updates the state of all open joysticks.
	 *
	 * Not needed if you are processing the SDL event queue; SDL updates
	 * joystick state automatically in that case.
	 */
	public static function update():Void
		SDLJoystickNative.update();
}

/**
 * An open joystick device.
 *
 * Open with `SDLJoystick.open()`, `fromId()`, or `fromPlayerIndex()`, and
 * remember to `close()` when done. All accessors on this class operate on
 * the open handle.
 *
 * Corresponds to `SDL_Joystick` in SDL3.
 */
class SDLJoystick {
	var ptr:SDLJoystickPtr;

	function new(ptr:SDLJoystickPtr)
		this.ptr = ptr;

	/**
	 * Opens a joystick by its instance ID.
	 *
	 * @param id The joystick instance ID (see `SDLJoysticks.getJoysticks()`).
	 * @return A new joystick handle, or `null` on failure.
	 */
	public static function open(id:Int):Null<SDLJoystick> {
		var p = SDLJoystickNative.open(id);
		return p == null ? null : new SDLJoystick(p);
	}

	/**
	 * Returns the already-open joystick handle for a device ID, if any.
	 *
	 * @param id The joystick instance ID.
	 * @return The joystick handle, or `null` if not open.
	 */
	public static function fromId(id:Int):Null<SDLJoystick> {
		var p = SDLJoystickNative.fromId(id);
		return p == null ? null : new SDLJoystick(p);
	}

	/**
	 * Returns the already-open joystick handle for a player index, if any.
	 *
	 * @param index The player index.
	 * @return The joystick handle, or `null` if none.
	 */
	public static function fromPlayerIndex(index:Int):Null<SDLJoystick> {
		var p = SDLJoystickNative.fromPlayerIndex(index);
		return p == null ? null : new SDLJoystick(p);
	}

	/**
	 * Closes the joystick and releases its resources.
	 *
	 * Safe to call multiple times; the handle becomes unusable afterwards.
	 */
	public function close():Void {
		if (ptr != null)
			SDLJoystickNative.close(ptr);
		ptr = null;
	}

	static inline function str(b:hl.Bytes):Null<String>
		@:privateAccess return b == null ? null : String.fromUTF8(b);

	/** The instance ID of this joystick. */
	public var id(get, never):Int;

	/** The name of this joystick. */
	public var name(get, never):Null<String>;

	/** The filesystem path of this joystick, if known. */
	public var path(get, never):Null<String>;

	/** The type/category of this joystick. */
	public var type(get, never):SDLJoystickType;

	/** The USB vendor ID of this joystick. */
	public var vendor(get, never):Int;

	/** The USB product ID of this joystick. */
	public var product(get, never):Int;

	/** The product version of this joystick. */
	public var productVersion(get, never):Int;

	/** The firmware version of this joystick, if known. */
	public var firmwareVersion(get, never):Int;

	/** The serial number of this joystick, if known. */
	public var serial(get, never):Null<String>;

	/** Whether this joystick is still connected. */
	public var connected(get, never):Bool;

	/** Whether this joystick is connected by wire or wirelessly. */
	public var connectionState(get, never):SDLJoystickConnectionState;

	/** The player index assigned to this joystick; assignable via `set`. */
	public var playerIndex(get, set):Int;

	/** The number of axes on this joystick. */
	public var numAxes(get, never):Int;

	/** The number of trackballs on this joystick. */
	public var numBalls(get, never):Int;

	/** The number of hats (D-pads) on this joystick. */
	public var numHats(get, never):Int;

	/** The number of buttons on this joystick. */
	public var numButtons(get, never):Int;

	inline function get_id()
		return SDLJoystickNative.getId(ptr);

	inline function get_name()
		return str(SDLJoystickNative.getName(ptr));

	inline function get_path()
		return str(SDLJoystickNative.getPath(ptr));

	inline function get_type():SDLJoystickType
		return SDLJoystickNative.getType(ptr);

	inline function get_vendor()
		return SDLJoystickNative.getVendor(ptr);

	inline function get_product()
		return SDLJoystickNative.getProduct(ptr);

	inline function get_productVersion()
		return SDLJoystickNative.getProductVersion(ptr);

	inline function get_firmwareVersion()
		return SDLJoystickNative.getFirmwareVersion(ptr);

	inline function get_serial()
		return str(SDLJoystickNative.getSerial(ptr));

	inline function get_connected()
		return SDLJoystickNative.connected(ptr);

	inline function get_connectionState():SDLJoystickConnectionState
		return SDLJoystickNative.getConnectionState(ptr);

	inline function get_playerIndex()
		return SDLJoystickNative.getPlayerIndex(ptr);

	inline function get_numAxes()
		return SDLJoystickNative.numAxes(ptr);

	inline function get_numBalls()
		return SDLJoystickNative.numBalls(ptr);

	inline function get_numHats()
		return SDLJoystickNative.numHats(ptr);

	inline function get_numButtons()
		return SDLJoystickNative.numButtons(ptr);

	function set_playerIndex(v:Int):Int {
		SDLJoystickNative.setPlayerIndex(ptr, v);
		return v;
	}

	/**
	 * Returns this joystick's 16-byte GUID.
	 *
	 * @return A 16-byte GUID as a `Bytes` object.
	 */
	public function getGuid():Bytes {
		var b = Bytes.alloc(16);
		SDLJoystickNative.getGuid(ptr, hl.Bytes.fromBytes(b));
		return b;
	}

	/**
	 * Returns this joystick's current power/battery state.
	 *
	 * @return A `SDLJoystickPower` structure.
	 */
	public function getPower():SDLJoystickPower {
		var o = new hl.NativeArray<Int>(2);
		SDLJoystickNative.getPowerInfo(ptr, o);
		return {state: o[0], percent: o[1]};
	}

	/**
	 * Returns the raw bitmask of hardware features this joystick supports.
	 *
	 * @return A bitmask combining `SDLJoystickCapability` bits.
	 */
	public function getCapabilities():Int
		return SDLJoystickNative.capabilities(ptr);

	/**
	 * Checks whether this joystick supports a given capability.
	 *
	 * @param cap The capability to query.
	 * @return `true` if the capability is supported.
	 */
	public function hasCapability(cap:SDLJoystickCapability):Bool
		return (getCapabilities() & cap) != 0;

	/**
	 * Checks whether this joystick is virtual (software-simulated).
	 *
	 * @return `true` if the joystick is virtual.
	 */
	public function isVirtual():Bool
		return SDLJoystickNative.isVirtual(id);

	/**
	 * Returns the current value of an axis.
	 *
	 * @param axis The axis index (in `[0, numAxes)`).
	 * @return The axis value in `[-32768, 32767]`, or 0 on failure.
	 */
	public function getAxis(axis:Int):Int
		return SDLJoystickNative.getAxis(ptr, axis);

	/**
	 * Returns the initial (rest) value of an axis, if the device reports one.
	 *
	 * @param axis The axis index.
	 * @return The initial value, or `null` if the device does not report one.
	 */
	public function getAxisInitialState(axis:Int):Null<Int> {
		var o = new hl.NativeArray<Int>(1);
		return SDLJoystickNative.getAxisInitialState(ptr, axis, o) ? o[0] : null;
	}

	/**
	 * Returns and resets the accumulated relative motion of a trackball.
	 *
	 * Each call returns the movement since the previous call and resets the
	 * internal accumulator.
	 *
	 * @param ball The trackball index.
	 * @return An object with `dx`/`dy` deltas, or `null` on failure.
	 */
	public function getBall(ball:Int):Null<{dx:Int, dy:Int}> {
		var o = new hl.NativeArray<Int>(2);
		return SDLJoystickNative.getBall(ptr, ball, o) ? {dx: o[0], dy: o[1]} : null;
	}

	/**
	 * Returns the current position of a hat (D-pad) switch.
	 *
	 * @param hat The hat index.
	 * @return One of the `SDLHatPosition` values.
	 */
	public function getHat(hat:Int):SDLHatPosition
		return SDLJoystickNative.getHat(ptr, hat);

	/**
	 * Checks whether a button is currently pressed.
	 *
	 * @param button The button index (in `[0, numButtons)`).
	 * @return `true` if the button is down.
	 */
	public function isDown(button:Int):Bool
		return SDLJoystickNative.getButton(ptr, button);

	/**
	 * Starts a rumble effect with independent low- and high-frequency motors.
	 *
	 * @param low        Low-frequency motor intensity in `[0, 65535]`.
	 * @param high       High-frequency motor intensity in `[0, 65535]`.
	 * @param durationMs Duration in milliseconds.
	 * @return `true` on success, `false` if the joystick cannot rumble.
	 */
	public function rumble(low:Int, high:Int, durationMs:Int):Bool
		return SDLJoystickNative.rumble(ptr, low, high, durationMs);

	/**
	 * Starts a rumble effect on the left/right trigger motors.
	 *
	 * @param left       Left trigger intensity in `[0, 65535]`.
	 * @param right      Right trigger intensity in `[0, 65535]`.
	 * @param durationMs Duration in milliseconds.
	 * @return `true` on success, `false` if trigger rumble is not supported.
	 */
	public function rumbleTriggers(left:Int, right:Int, durationMs:Int):Bool
		return SDLJoystickNative.rumbleTriggers(ptr, left, right, durationMs);

	/**
	 * Sets the color of this joystick's LED, if it has one.
	 *
	 * @param r Red component in `[0, 255]`.
	 * @param g Green component in `[0, 255]`.
	 * @param b Blue component in `[0, 255]`.
	 * @return `true` on success, `false` if the joystick has no LED.
	 */
	public function setLED(r:Int, g:Int, b:Int):Bool
		return SDLJoystickNative.setLed(ptr, r, g, b);

	/**
	 * Sends a raw, device-specific effect payload to the joystick.
	 *
	 * The meaning of the payload depends on the underlying driver; most
	 * applications will not need this.
	 *
	 * @param data The raw effect data.
	 * @return `true` on success, `false` on failure.
	 */
	public function sendEffect(data:Bytes):Bool
		return SDLJoystickNative.sendEffect(ptr, hl.Bytes.fromBytes(data), data.length);

	/**
	 * Sets the value of an axis on a virtual joystick.
	 *
	 * Only valid if this joystick was created with `SDLJoysticks.attachVirtual()`.
	 *
	 * @param axis  The axis index.
	 * @param value The axis value in `[-32768, 32767]`.
	 * @return `true` on success, `false` on failure.
	 */
	public function setVirtualAxis(axis:Int, value:Int):Bool
		return SDLJoystickNative.setVirtualAxis(ptr, axis, value);

	/**
	 * Reports relative trackball motion on a virtual joystick.
	 *
	 * @param ball The trackball index.
	 * @param xrel Horizontal delta since the last report.
	 * @param yrel Vertical delta since the last report.
	 * @return `true` on success, `false` on failure.
	 */
	public function setVirtualBall(ball:Int, xrel:Int, yrel:Int):Bool
		return SDLJoystickNative.setVirtualBall(ptr, ball, xrel, yrel);

	/**
	 * Sets the state of a button on a virtual joystick.
	 *
	 * @param button The button index.
	 * @param down   `true` to press, `false` to release.
	 * @return `true` on success, `false` on failure.
	 */
	public function setVirtualButton(button:Int, down:Bool):Bool
		return SDLJoystickNative.setVirtualButton(ptr, button, down);

	/**
	 * Sets the position of a hat (D-pad) switch on a virtual joystick.
	 *
	 * @param hat   The hat index.
	 * @param value The new hat position (see `SDLHatPosition`).
	 * @return `true` on success, `false` on failure.
	 */
	public function setVirtualHat(hat:Int, value:SDLHatPosition):Bool
		return SDLJoystickNative.setVirtualHat(ptr, hat, value);

	/**
	 * Reports touchpad finger state on a virtual joystick.
	 *
	 * @param touchpad The touchpad index.
	 * @param finger   The finger index.
	 * @param down     `true` if the finger is touching the pad.
	 * @param x        Normalized X position in `[0, 1]`.
	 * @param y        Normalized Y position in `[0, 1]`.
	 * @param pressure Normalized pressure in `[0, 1]`.
	 * @return `true` on success, `false` on failure.
	 */
	public function setVirtualTouchpad(touchpad:Int, finger:Int, down:Bool, x:Float, y:Float, pressure:Float):Bool
		return SDLJoystickNative.setVirtualTouchpad(ptr, touchpad, finger, down, x, y, pressure);

	/**
	 * Reports sensor data on a virtual joystick.
	 *
	 * @param sensorType        The sensor type index.
	 * @param sensorTimestampNS The timestamp of the reading in nanoseconds.
	 * @param data              The sensor values (`[x, y, z]` for accelerometer/gyro).
	 * @return `true` on success, `false` on failure.
	 */
	public function sendVirtualSensorData(sensorType:Int, sensorTimestampNS:haxe.Int64, data:Array<Float>):Bool {
		var a = new hl.NativeArray<Float>(data.length);
		for (i in 0...data.length)
			a[i] = data[i];
		return SDLJoystickNative.sendVirtualSensorData(ptr, sensorType, haxe.Int64.getHigh(sensorTimestampNS), haxe.Int64.getLow(sensorTimestampNS), a);
	}
}
