package hl.bindings.sdl3;

typedef SDLSensorPtr = hl.Abstract<"SDL_Sensor">;

/**
 * The type of a sensor.
 *
 * Sensors are classified by what they measure. Some devices (e.g. Nintendo
 * Joy-Cons) expose pairs of the same type, one on the left half and one on
 * the right half of the controller; those are represented by the `_L` and
 * `_R` variants.
 *
 * Corresponds to `SDL_SensorType` in SDL3.
 */
enum abstract SDLSensorType(Int) from Int to Int {
	/** Invalid or unset sensor type. */
	var INVALID = -1;

	/** Unknown or unrecognized sensor type. */
	var UNKNOWN = 0;

	/** Accelerometer (measures linear acceleration). */
	var ACCEL = 1;

	/** Gyroscope (measures angular velocity). */
	var GYRO = 2;

	/** Left accelerometer on a split controller. */
	var ACCEL_L = 3;

	/** Left gyroscope on a split controller. */
	var GYRO_L = 4;

	/** Right accelerometer on a split controller. */
	var ACCEL_R = 5;

	/** Right gyroscope on a split controller. */
	var GYRO_R = 6;

	/** Total number of defined sensor types (not a valid sensor type). */
	var COUNT = 7;
}

/**
 * Constants used together with the sensor API.
 */
class SDLSensorConstants {
	/**
	 * Standard gravity in m/s², useful for converting accelerometer
	 * readings (usually expressed in `g`) to SI units.
	 */
	public static inline var STANDARD_GRAVITY = 9.80665;
}

@:noCompletion
class SDLSensorNative {
	@:hlNative("sdl3", "get_sensors") public static function getSensors():hl.NativeArray<Int>
		return null;

	@:hlNative("sdl3", "get_sensor_name_for_id") public static function nameForId(id:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_sensor_type_for_id") public static function typeForId(id:Int):Int
		return 0;

	@:hlNative("sdl3", "get_sensor_non_portable_type_for_id") public static function nonPortableTypeForId(id:Int):Int
		return 0;

	@:hlNative("sdl3", "open_sensor") public static function open(id:Int):SDLSensorPtr
		return null;

	@:hlNative("sdl3", "get_sensor_from_id") public static function fromId(id:Int):SDLSensorPtr
		return null;

	@:hlNative("sdl3", "get_sensor_name") public static function getName(s:SDLSensorPtr):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_sensor_type") public static function getType(s:SDLSensorPtr):Int
		return 0;

	@:hlNative("sdl3", "get_sensor_non_portable_type") public static function getNonPortableType(s:SDLSensorPtr):Int
		return 0;

	@:hlNative("sdl3", "get_sensor_id") public static function getId(s:SDLSensorPtr):Int
		return 0;

	@:hlNative("sdl3", "get_sensor_data") public static function getData(s:SDLSensorPtr, out:hl.NativeArray<Float>):Bool
		return false;

	@:hlNative("sdl3", "close_sensor") public static function close(s:SDLSensorPtr):Void {}

	@:hlNative("sdl3", "update_sensors") public static function update():Void {}
}

/**
 * Static sensor API.
 *
 * Provides enumeration of sensors and device metadata queries that do not
 * require opening the sensor. Use `SDLSensor.open` to obtain an instance
 * for reading values.
 *
 * Corresponds to the SDL3 sensor subsystem functions that operate on device
 * instance IDs rather than open handles.
 */
@:access(String)
class SDLSensors {
	static inline function str(b:hl.Bytes):Null<String>
		return b == null ? null : String.fromUTF8(b);

	/**
	 * Returns the instance IDs of all currently connected sensors.
	 *
	 * @return An array of sensor instance IDs.
	 */
	public static function getSensors():Array<Int> {
		var a = SDLSensorNative.getSensors();
		return a == null ? [] : [for (i in 0...a.length) a[i]];
	}

	/**
	 * Returns the human-readable name of a sensor without opening it.
	 *
	 * @param id The sensor instance ID.
	 * @return The sensor name, or `null` if the ID is not valid.
	 */
	public static function getNameForId(id:Int):Null<String>
		return str(SDLSensorNative.nameForId(id));

	/**
	 * Returns the type of a sensor without opening it.
	 *
	 * @param id The sensor instance ID.
	 * @return The sensor type.
	 */
	public static function getTypeForId(id:Int):SDLSensorType
		return SDLSensorNative.typeForId(id);

	/**
	 * Returns the platform-specific sensor type, which can give more detail
	 * than `getTypeForId` for unusual sensors.
	 *
	 * @param id The sensor instance ID.
	 * @return A platform-specific type identifier, or -1 if unavailable.
	 */
	public static function getNonPortableTypeForId(id:Int):Int
		return SDLSensorNative.nonPortableTypeForId(id);

	/**
	 * Manually updates the state of all open sensors.
	 *
	 * Not needed if you are processing the SDL event queue; SDL updates
	 * sensor state automatically in that case.
	 */
	public static function update():Void
		SDLSensorNative.update();
}

/**
 * An open sensor device.
 *
 * Open with `SDLSensor.open()` or `SDLSensor.fromId()`, read values with
 * `getData()`, and remember to `close()` when done.
 *
 * Corresponds to `SDL_Sensor` in SDL3.
 */
@:access(String)
class SDLSensor {
	var ptr:SDLSensorPtr;

	function new(ptr:SDLSensorPtr)
		this.ptr = ptr;

	/**
	 * Opens a sensor by its instance ID.
	 *
	 * @param id The sensor instance ID (see `SDLSensors.getSensors()`).
	 * @return A new sensor handle, or `null` on failure.
	 */
	public static function open(id:Int):Null<SDLSensor> {
		var p = SDLSensorNative.open(id);
		return p == null ? null : new SDLSensor(p);
	}

	/**
	 * Returns the already-open sensor handle for a device ID, if any.
	 *
	 * @param id The sensor instance ID.
	 * @return The sensor handle, or `null` if not open.
	 */
	public static function fromId(id:Int):Null<SDLSensor> {
		var p = SDLSensorNative.fromId(id);
		return p == null ? null : new SDLSensor(p);
	}

	/** The instance ID of this sensor. */
	public var id(get, never):Int;

	inline function get_id()
		return SDLSensorNative.getId(ptr);

	/** The human-readable name of this sensor. */
	public var name(get, never):Null<String>;

	inline function get_name()
		return String.fromUTF8(SDLSensorNative.getName(ptr));

	/** The type of this sensor. */
	public var type(get, never):SDLSensorType;

	inline function get_type():SDLSensorType
		return SDLSensorNative.getType(ptr);

	/** The platform-specific type of this sensor, if available; otherwise -1. */
	public var nonPortableType(get, never):Int;

	inline function get_nonPortableType()
		return SDLSensorNative.getNonPortableType(ptr);

	/**
	 * Returns the latest reading from this sensor.
	 *
	 * For accelerometers and gyroscopes the returned array holds
	 * `[x, y, z]` values (accelerations are in m/s², angular velocities in
	 * rad/s). Call this after `SDLSensors.update()` or after processing
	 * the event queue to get fresh values.
	 *
	 * @param numValues The number of values to read (default 3).
	 * @return The sensor values, or `null` on failure.
	 */
	public function getData(numValues:Int = 3):Null<Array<Float>> {
		var o = new hl.NativeArray<Float>(numValues);
		if (!SDLSensorNative.getData(ptr, o))
			return null;
		return [for (i in 0...numValues) o[i]];
	}

	/**
	 * Closes the sensor and releases its resources.
	 *
	 * Safe to call multiple times; the instance becomes unusable afterwards.
	 */
	public function close():Void {
		if (ptr != null)
			SDLSensorNative.close(ptr);
		ptr = null;
	}
}
