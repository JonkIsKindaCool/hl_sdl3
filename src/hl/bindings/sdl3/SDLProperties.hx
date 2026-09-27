package hl.bindings.sdl3;

import haxe.Int64;

/**
 * The type of a property stored in an `SDLProperties` set.
 *
 * Corresponds to `SDL_PropertyType` in SDL3.
 */
enum abstract SDLPropertyType(Int) from Int to Int {
	/** The property does not exist or has an unrecognized type. */
	var INVALID = 0;

	/** The property holds an opaque pointer. */
	var POINTER = 1;

	/** The property holds a UTF-8 string. */
	var STRING = 2;

	/** The property holds a signed 64-bit integer. */
	var NUMBER = 3;

	/** The property holds a 32-bit floating-point value. */
	var FLOAT = 4;

	/** The property holds a boolean. */
	var BOOLEAN = 5;
}

@:noCompletion
class SDLPropertiesNative {
	@:hlNative("sdl3", "get_global_properties") public static function getGlobal():Int
		return 0;

	@:hlNative("sdl3", "create_properties") public static function create():Int
		return 0;

	@:hlNative("sdl3", "copy_properties") public static function copy(src:Int, dst:Int):Bool
		return false;

	@:hlNative("sdl3", "lock_properties") public static function lock(props:Int):Bool
		return false;

	@:hlNative("sdl3", "unlock_properties") public static function unlock(props:Int):Void {}

	@:hlNative("sdl3", "set_pointer_property") public static function setPointer(props:Int, name:hl.Bytes, value:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "set_string_property") public static function setString(props:Int, name:hl.Bytes, value:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "set_number_property") public static function setNumber(props:Int, name:hl.Bytes, hi:Int, lo:Int):Bool
		return false;

	@:hlNative("sdl3", "set_float_property") public static function setFloat(props:Int, name:hl.Bytes, value:Float):Bool
		return false;

	@:hlNative("sdl3", "set_boolean_property") public static function setBoolean(props:Int, name:hl.Bytes, value:Bool):Bool
		return false;

	@:hlNative("sdl3", "has_property") public static function has(props:Int, name:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "get_property_type") public static function getType(props:Int, name:hl.Bytes):Int
		return 0;

	@:hlNative("sdl3", "get_pointer_property") public static function getPointer(props:Int, name:hl.Bytes, defaultValue:hl.Bytes):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_string_property") public static function getString(props:Int, name:hl.Bytes, defaultValue:hl.Bytes):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_number_property") public static function getNumber(props:Int, name:hl.Bytes, defaultHi:Int, defaultLo:Int,
		out:hl.NativeArray<Int>):Void {}

	@:hlNative("sdl3", "get_float_property") public static function getFloat(props:Int, name:hl.Bytes, defaultValue:Float):Float
		return 0;

	@:hlNative("sdl3", "get_boolean_property") public static function getBoolean(props:Int, name:hl.Bytes, defaultValue:Bool):Bool
		return false;

	@:hlNative("sdl3", "clear_property") public static function clear(props:Int, name:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "enumerate_properties") public static function enumerate(props:Int):hl.NativeArray<hl.Bytes>
		return null;

	@:hlNative("sdl3", "destroy_properties") public static function destroyNative(props:Int):Void {}
}

/**
 * A thread-safe set of typed name/value properties.
 *
 * Property sets are the SDL 3 replacement for the older "hint" mechanism in
 * contexts where more structure (typed values, reference counting, thread
 * safety) is needed: texture descriptions, window creation, audio device
 * configuration, and so on.
 *
 * Each property has a name and a value of one of the types in
 * `SDLPropertyType`. Values can be pointers, strings, integers, floats, or
 * booleans. Iterating the set, copying it, and reading/writing individual
 * properties are all supported.
 *
 * There is a single process-wide property set accessible through
 * `getGlobal()` — useful for application-wide configuration. Additional
 * sets can be created with `create()` and destroyed with `destroy()`.
 *
 * Most SDL subsystems accept an integer property-set ID rather than the
 * wrapper object; use `rawId` to retrieve it.
 *
 * Corresponds to the SDL3 properties API (`SDL_PropertiesID`,
 * `SDL_SetStringProperty`, `SDL_GetNumberProperty`, etc.).
 */
@:access(String)
class SDLProperties {
	var id:Int;

	function new(id:Int)
		this.id = id;

	/**
	 * Returns the process-wide global property set.
	 *
	 * It is always available and never needs to be destroyed.
	 *
	 * @return A wrapper around the global property set.
	 */
	public static function getGlobal():SDLProperties
		return new SDLProperties(SDLPropertiesNative.getGlobal());

	/**
	 * Creates a new, empty property set.
	 *
	 * The returned set should be released with `destroy()` when no longer
	 * needed.
	 *
	 * @return A wrapper around the newly created property set.
	 */
	public static function create():SDLProperties
		return new SDLProperties(SDLPropertiesNative.create());

	/**
	 * Wraps an existing property-set ID returned by another SDL subsystem.
	 *
	 * Use this when SDL hands you a raw property-set ID (for example from a
	 * texture or window description) so you can read or write properties on
	 * it.
	 *
	 * @param id The raw property-set ID.
	 * @return A wrapper around the given ID.
	 */
	public static function fromId(id:Int):SDLProperties
		return new SDLProperties(id);

	/** The underlying property-set ID used by SDL's native API. */
	public var rawId(get, never):Int;

	inline function get_rawId()
		return id;

	/**
	 * Copies every property from this set into `dst`.
	 *
	 * Existing entries in `dst` with matching names are overwritten.
	 *
	 * @param dst The destination property set.
	 * @return `true` on success, `false` on failure.
	 */
	public function copyTo(dst:SDLProperties):Bool
		return SDLPropertiesNative.copy(id, dst.id);

	/**
	 * Locks the property set for exclusive access.
	 *
	 * Use this when multiple threads need to read or write the same set and
	 * you want to perform several operations atomically. Must be paired with
	 * a matching call to `unlock()`.
	 *
	 * @return `true` on success, `false` on failure.
	 */
	public function lock():Bool
		return SDLPropertiesNative.lock(id);

	/**
	 * Releases a lock acquired with `lock()`.
	 */
	public function unlock():Void
		SDLPropertiesNative.unlock(id);

	/**
	 * Stores an opaque pointer value under the given name.
	 *
	 * @param name  The property name.
	 * @param value The pointer to store, as a `hl.Bytes`.
	 * @return `true` on success, `false` on failure.
	 */
	public function setPointer(name:String, value:hl.Bytes):Bool
		return SDLPropertiesNative.setPointer(id, name.toUtf8(), value);

	/**
	 * Stores a string value under the given name.
	 *
	 * The string is copied internally; the caller retains ownership of the
	 * original.
	 *
	 * @param name  The property name.
	 * @param value The string value.
	 * @return `true` on success, `false` on failure.
	 */
	public function setString(name:String, value:String):Bool
		return SDLPropertiesNative.setString(id, name.toUtf8(), value.toUtf8());

	/**
	 * Stores a signed 64-bit integer under the given name.
	 *
	 * @param name  The property name.
	 * @param value The integer value.
	 * @return `true` on success, `false` on failure.
	 */
	public function setNumber(name:String, value:Int64):Bool
		return SDLPropertiesNative.setNumber(id, name.toUtf8(), Int64.getHigh(value), Int64.getLow(value));

	/**
	 * Convenience overload of `setNumber` accepting a native `Int`.
	 *
	 * @param name  The property name.
	 * @param value The integer value.
	 * @return `true` on success, `false` on failure.
	 */
	public function setInt(name:String, value:Int):Bool
		return setNumber(name, Int64.ofInt(value));

	/**
	 * Stores a 32-bit floating-point value under the given name.
	 *
	 * @param name  The property name.
	 * @param value The float value.
	 * @return `true` on success, `false` on failure.
	 */
	public function setFloat(name:String, value:Float):Bool
		return SDLPropertiesNative.setFloat(id, name.toUtf8(), value);

	/**
	 * Stores a boolean value under the given name.
	 *
	 * @param name  The property name.
	 * @param value The boolean value.
	 * @return `true` on success, `false` on failure.
	 */
	public function setBool(name:String, value:Bool):Bool
		return SDLPropertiesNative.setBoolean(id, name.toUtf8(), value);

	/**
	 * Checks whether a property with the given name exists.
	 *
	 * @param name The property name.
	 * @return `true` if the property is set.
	 */
	public function has(name:String):Bool
		return SDLPropertiesNative.has(id, name.toUtf8());

	/**
	 * Returns the type of the property with the given name.
	 *
	 * @param name The property name.
	 * @return The property type, or `INVALID` if the property does not exist.
	 */
	public function getType(name:String):SDLPropertyType
		return SDLPropertiesNative.getType(id, name.toUtf8());

	/**
	 * Returns the pointer stored under the given name.
	 *
	 * @param name         The property name.
	 * @param defaultValue Value returned when the property is unset.
	 * @return The stored pointer, or `defaultValue` if the property is unset
	 *         or is not a pointer.
	 */
	public function getPointer(name:String, ?defaultValue:hl.Bytes):hl.Bytes
		return SDLPropertiesNative.getPointer(id, name.toUtf8(), defaultValue);

	/**
	 * Returns the string stored under the given name.
	 *
	 * @param name         The property name.
	 * @param defaultValue Value returned when the property is unset.
	 * @return The stored string, or `defaultValue` if the property is unset
	 *         or is not a string.
	 */
	public function getString(name:String, defaultValue:String = ""):String
		return String.fromUTF8(SDLPropertiesNative.getString(id, name.toUtf8(), defaultValue.toUtf8()));

	/**
	 * Returns the 64-bit integer stored under the given name.
	 *
	 * @param name         The property name.
	 * @param defaultValue Value returned when the property is unset.
	 * @return The stored integer, or `defaultValue` if the property is unset
	 *         or is not a number.
	 */
	public function getNumber(name:String, ?defaultValue:Int64):Int64 {
		var def = defaultValue == null ? Int64.ofInt(0) : defaultValue;
		var o = new hl.NativeArray<Int>(2);
		SDLPropertiesNative.getNumber(id, name.toUtf8(), Int64.getHigh(def), Int64.getLow(def), o);
		return Int64.make(o[0], o[1]);
	}

	/**
	 * Convenience overload of `getNumber` returning a native `Int`.
	 *
	 * @param name         The property name.
	 * @param defaultValue Value returned when the property is unset.
	 * @return The stored integer, or `defaultValue` if the property is unset
	 *         or is not a number.
	 */
	public function getInt(name:String, defaultValue:Int = 0):Int
		return Int64.toInt(getNumber(name, Int64.ofInt(defaultValue)));

	/**
	 * Returns the float stored under the given name.
	 *
	 * @param name         The property name.
	 * @param defaultValue Value returned when the property is unset.
	 * @return The stored float, or `defaultValue` if the property is unset
	 *         or is not a float.
	 */
	public function getFloat(name:String, defaultValue:Float = 0):Float
		return SDLPropertiesNative.getFloat(id, name.toUtf8(), defaultValue);

	/**
	 * Returns the boolean stored under the given name.
	 *
	 * @param name         The property name.
	 * @param defaultValue Value returned when the property is unset.
	 * @return The stored boolean, or `defaultValue` if the property is unset
	 *         or is not a boolean.
	 */
	public function getBool(name:String, defaultValue:Bool = false):Bool
		return SDLPropertiesNative.getBoolean(id, name.toUtf8(), defaultValue);

	/**
	 * Removes a property from the set.
	 *
	 * @param name The property name to remove.
	 * @return `true` if the property existed and was removed, `false` otherwise.
	 */
	public function clear(name:String):Bool
		return SDLPropertiesNative.clear(id, name.toUtf8());

	/**
	 * Returns the names of every property in the set.
	 *
	 * @return An array of property names. Empty if the set has no properties.
	 */
	public function getNames():Array<String> {
		var a = SDLPropertiesNative.enumerate(id);
		return a == null ? [] : [for (i in 0...a.length) String.fromUTF8(a[i])];
	}

	/**
	 * Destroys the property set and releases its resources.
	 *
	 * Do **not** call this on the global property set returned by
	 * `getGlobal()`. After this call the instance must not be used again.
	 */
	public function destroy():Void
		SDLPropertiesNative.destroyNative(id);
}
