package hl.bindings.sdl3;

typedef SDLHapticPtr = hl.Abstract<"SDL_Haptic">;

/**
 * The type of a haptic effect.
 * These values are bitmask-compatible with `SDL_HapticFeatures` (the same bits
 * are used both to describe an effect's type and to test support).
 * Corresponds to `SDL_HapticEffectType` in SDL3.
 */
enum abstract SDLHapticEffectType(Int) from Int to Int {
	/** Constant force applied along an axis. */
	var CONSTANT = 1;

	/** Sinusoidal periodic wave. */
	var SINE = 2;

	/** Square periodic wave. */
	var SQUARE = 4;

	/** Triangular periodic wave. */
	var TRIANGLE = 8;

	/** Sawtooth-up periodic wave. */
	var SAWTOOTHUP = 16;

	/** Sawtooth-down periodic wave. */
	var SAWTOOTHDOWN = 32;

	/** Ramp starting at `start` level and ending at `end` level. */
	var RAMP = 64;

	/** Spring condition. */
	var SPRING = 128;

	/** Damper (resistance) condition. */
	var DAMPER = 256;

	/** Inertia condition. */
	var INERTIA = 512;

	/** Friction condition. */
	var FRICTION = 1024;

	/** Left/right effect (e.g. rumble). */
	var LEFTRIGHT = 2048;

	/** Custom effect defined by the application. */
	var CUSTOM = 32768;
}

/**
 * Optional features supported by a haptic device.
 * Corresponds to `SDL_HapticFeatures` in SDL3.
 */
enum abstract SDLHapticFeature(Int) from Int to Int {
	/** Device supports a global gain. */
	var GAIN = 65536;

	/** Device supports autocenter. */
	var AUTOCENTER = 131072;

	/** Device supports status queries. */
	var STATUS = 262144;

	/** Device supports pausing/resuming playback. */
	var PAUSE = 524288;
}

/**
 * The coordinate system used by an effect's direction.
 * Corresponds to `SDL_HapticDirection`'s `type` field in SDL3.
 */
enum abstract SDLHapticDirectionType(Int) from Int to Int {
	/** Polar coordinates: `dir[0]` = angle. */
	var POLAR = 0;

	/** Cartesian coordinates: `dir[0]`, `dir[1]` = (x, y). */
	var CARTESIAN = 1;

	/** Spherical coordinates: `dir[0]`, `dir[1]`, `dir[2]` = (yaw, pitch, roll). */
	var SPHERICAL = 2;

	/** Steering axis: `dir[0]` = axis index. */
	var STEERING_AXIS = 3;
}

/**
 * The direction of a haptic effect.
 * The interpretation of `dir` depends on `type`.
 */
typedef SDLHapticDirection = {
	/** Coordinate system used by `dir`. */
	type:SDLHapticDirectionType,

	/** Direction components; length depends on `type`. */
	dir:Array<Int>
}

/**
 * A haptic effect description.
 *
 * Only the fields relevant to the chosen `type` need to be set; all others
 * are optional and default to 0 (or empty).
 */
typedef SDLHapticEffect = {
	/** The type of the effect. */
	type:SDLHapticEffectType,

	/** Direction of the effect. */
	?direction:SDLHapticDirection,

	/** Duration of the effect in milliseconds. */
	?length:Int,

	/** Delay before the effect starts, in milliseconds. */
	?delay:Int,

	/** Button that triggers the effect. */
	?button:Int,

	/** Interval between triggers, in milliseconds. */
	?interval:Int,

	/** Duration of the attack (fade-in) phase, in milliseconds. */
	?attackLength:Int,

	/** Intensity level at the start of the attack phase. */
	?attackLevel:Int,

	/** Duration of the fade-out phase, in milliseconds. */
	?fadeLength:Int,

	/** Intensity level at the end of the fade-out phase. */
	?fadeLevel:Int,

	/** Strength of a constant effect. */
	?level:Int,

	/** Starting value for a ramp effect. */
	?start:Int,

	/** Ending value for a ramp effect. */
	?end:Int,

	/** Magnitude of the large (low-frequency) motor. */
	?largeMagnitude:Int,

	/** Magnitude of the small (high-frequency) motor. */
	?smallMagnitude:Int,

	/** Period of a periodic effect, in milliseconds. */
	?period:Int,

	/** Magnitude of a periodic effect. */
	?magnitude:Int,

	/** Offset into the period at which the effect starts. */
	?offset:Int,

	/** Phase of the effect, in hundredths of a degree. */
	?phase:Int,

	/** Number of channels for the custom effect. */
	?channels:Int,

	/** Sample data for a custom effect. */
	?samples:Array<Int>,

	/** Right saturation values for a condition effect. */
	?rightSat:Array<Int>,

	/** Left saturation values for a condition effect. */
	?leftSat:Array<Int>,

	/** Right coefficient values for a condition effect. */
	?rightCoeff:Array<Int>,

	/** Left coefficient values for a condition effect. */
	?leftCoeff:Array<Int>,

	/** Deadband values for a condition effect. */
	?deadband:Array<Int>,

	/** Center values for a condition effect. */
	?center:Array<Int>
}

@:noCompletion
class SDLHapticNative {
	@:hlNative("sdl3", "get_haptics") public static function getHaptics():hl.NativeArray<Int>
		return null;

	@:hlNative("sdl3", "get_haptic_name_for_id") public static function nameForId(id:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "open_haptic") public static function open(id:Int):SDLHapticPtr
		return null;

	@:hlNative("sdl3", "get_haptic_from_id") public static function fromId(id:Int):SDLHapticPtr
		return null;

	@:hlNative("sdl3", "get_haptic_id") public static function getId(h:SDLHapticPtr):Int
		return 0;

	@:hlNative("sdl3", "get_haptic_name") public static function getName(h:SDLHapticPtr):hl.Bytes
		return null;

	@:hlNative("sdl3", "is_mouse_haptic") public static function isMouseHaptic():Bool
		return false;

	@:hlNative("sdl3", "open_haptic_from_mouse") public static function openFromMouse():SDLHapticPtr
		return null;

	@:hlNative("sdl3", "is_joystick_haptic") public static function isJoystickHaptic(j:SDLJoystickPtr):Bool
		return false;

	@:hlNative("sdl3", "open_haptic_from_joystick") public static function openFromJoystick(j:SDLJoystickPtr):SDLHapticPtr
		return null;

	@:hlNative("sdl3", "close_haptic") public static function close(h:SDLHapticPtr):Void {}

	@:hlNative("sdl3", "get_max_haptic_effects") public static function maxEffects(h:SDLHapticPtr):Int
		return 0;

	@:hlNative("sdl3", "get_max_haptic_effects_playing") public static function maxEffectsPlaying(h:SDLHapticPtr):Int
		return 0;

	@:hlNative("sdl3", "get_haptic_features") public static function features(h:SDLHapticPtr):Int
		return 0;

	@:hlNative("sdl3", "get_num_haptic_axes") public static function numAxes(h:SDLHapticPtr):Int
		return 0;

	@:hlNative("sdl3", "haptic_effect_supported") public static function effectSupported(h:SDLHapticPtr, ints:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "create_haptic_effect") public static function createEffect(h:SDLHapticPtr, ints:hl.NativeArray<Int>, data:hl.NativeArray<Int>):Int
		return -1;

	@:hlNative("sdl3", "update_haptic_effect") public static function updateEffect(h:SDLHapticPtr, effect:Int, ints:hl.NativeArray<Int>,
			data:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "run_haptic_effect") public static function runEffect(h:SDLHapticPtr, effect:Int, iterations:Int):Bool
		return false;

	@:hlNative("sdl3", "stop_haptic_effect") public static function stopEffect(h:SDLHapticPtr, effect:Int):Bool
		return false;

	@:hlNative("sdl3", "destroy_haptic_effect") public static function destroyEffect(h:SDLHapticPtr, effect:Int):Void {}

	@:hlNative("sdl3", "get_haptic_effect_status") public static function effectStatus(h:SDLHapticPtr, effect:Int):Bool
		return false;

	@:hlNative("sdl3", "set_haptic_gain") public static function setGain(h:SDLHapticPtr, gain:Int):Bool
		return false;

	@:hlNative("sdl3", "set_haptic_autocenter") public static function setAutocenter(h:SDLHapticPtr, v:Int):Bool
		return false;

	@:hlNative("sdl3", "pause_haptic") public static function pause(h:SDLHapticPtr):Bool
		return false;

	@:hlNative("sdl3", "resume_haptic") public static function resume(h:SDLHapticPtr):Bool
		return false;

	@:hlNative("sdl3", "stop_haptic_effects") public static function stopAll(h:SDLHapticPtr):Bool
		return false;

	@:hlNative("sdl3", "haptic_rumble_supported") public static function rumbleSupported(h:SDLHapticPtr):Bool
		return false;

	@:hlNative("sdl3", "init_haptic_rumble") public static function initRumble(h:SDLHapticPtr):Bool
		return false;

	@:hlNative("sdl3", "play_haptic_rumble") public static function playRumble(h:SDLHapticPtr, strength:Float, lengthMs:Int):Bool
		return false;

	@:hlNative("sdl3", "stop_haptic_rumble") public static function stopRumble(h:SDLHapticPtr):Bool
		return false;
}

/**
 * Static haptic API: device enumeration and hotplug queries.
 *
 * Corresponds to the SDL3 haptic subsystem.
 */
@:access(String)
class SDLHaptics {
	static inline function str(b:hl.Bytes):Null<String>
		return b == null ? null : String.fromUTF8(b);

	/**
	 * Returns the device IDs of all currently connected haptic devices.
	 *
	 * @return An array of haptic device IDs.
	 */
	public static function getHaptics():Array<Int> {
		var a = SDLHapticNative.getHaptics();
		return a == null ? [] : [for (i in 0...a.length) a[i]];
	}

	/**
	 * Returns the human-readable name of a haptic device.
	 *
	 * @param id The haptic device ID.
	 * @return The name, or `null` on failure.
	 */
	public static function getNameForId(id:Int):Null<String>
		return str(SDLHapticNative.nameForId(id));

	/**
	 * Checks whether the system mouse supports haptic feedback.
	 *
	 * @return `true` if the mouse is haptic-capable.
	 */
	public static function isMouseHaptic():Bool
		return SDLHapticNative.isMouseHaptic();

	/**
	 * Checks whether a given joystick supports haptic feedback.
	 *
	 * @param joystick The joystick to query.
	 * @return `true` if the joystick is haptic-capable.
	 */
	public static function isJoystickHaptic(joystick:SDLJoystick):Bool
		return SDLHapticNative.isJoystickHaptic(@:privateAccess joystick.ptr);
}

/**
 * A handle to an opened haptic device.
 *
 * Provides access to effects, rumble, gain, and autocenter controls.
 * Remember to `close()` it when done.
 */
@:access(String)
class SDLHaptic {
	var ptr:SDLHapticPtr;

	function new(ptr:SDLHapticPtr)
		this.ptr = ptr;

	/**
	 * Opens a haptic device by ID.
	 *
	 * @param id The haptic device ID.
	 * @return A new haptic handle, or `null` on failure.
	 */
	public static function open(id:Int):Null<SDLHaptic> {
		var p = SDLHapticNative.open(id);
		return p == null ? null : new SDLHaptic(p);
	}

	/**
	 * Returns the already-opened haptic handle for a device ID, if any.
	 *
	 * @param id The haptic device ID.
	 * @return The haptic handle, or `null` if not open.
	 */
	public static function fromId(id:Int):Null<SDLHaptic> {
		var p = SDLHapticNative.fromId(id);
		return p == null ? null : new SDLHaptic(p);
	}

	/**
	 * Opens the haptic device associated with the system mouse.
	 *
	 * @return A new haptic handle, or `null` on failure.
	 */
	public static function openFromMouse():Null<SDLHaptic> {
		var p = SDLHapticNative.openFromMouse();
		return p == null ? null : new SDLHaptic(p);
	}

	/**
	 * Opens the haptic device associated with a joystick.
	 *
	 * @param joystick The joystick to open haptics for.
	 * @return A new haptic handle, or `null` on failure.
	 */
	public static function openFromJoystick(joystick:SDLJoystick):Null<SDLHaptic> {
		var p = SDLHapticNative.openFromJoystick(@:privateAccess joystick.ptr);
		return p == null ? null : new SDLHaptic(p);
	}

	/**
	 * Closes the haptic device and releases its resources.
	 *
	 * Safe to call multiple times; the handle becomes unusable afterwards.
	 */
	public function close():Void {
		if (ptr != null)
			SDLHapticNative.close(ptr);
		ptr = null;
	}

	/** Haptic device ID. */
	public var id(get, never):Int;

	/** Human-readable name of the device. */
	public var name(get, never):Null<String>;

	/** Maximum number of effects the device can store simultaneously. */
	public var maxEffects(get, never):Int;

	/** Maximum number of effects that can play simultaneously. */
	public var maxEffectsPlaying(get, never):Int;

	/** Number of axes supported by the device. */
	public var numAxes(get, never):Int;

	inline function get_id()
		return SDLHapticNative.getId(ptr);

	inline function get_name()
		return String.fromUTF8(SDLHapticNative.getName(ptr));

	inline function get_maxEffects()
		return SDLHapticNative.maxEffects(ptr);

	inline function get_maxEffectsPlaying()
		return SDLHapticNative.maxEffectsPlaying(ptr);

	inline function get_numAxes()
		return SDLHapticNative.numAxes(ptr);

	/**
	 * Returns the raw feature bitmask for the device.
	 *
	 * @return A bitmask combining `SDLHapticFeature` and `SDLHapticEffectType` bits.
	 */
	public function getFeatures():Int
		return SDLHapticNative.features(ptr);

	/**
	 * Checks whether the device supports a given feature.
	 *
	 * @param feature The feature to query (gain, autocenter, etc.).
	 * @return `true` if the feature is supported.
	 */
	public function hasFeature(feature:SDLHapticFeature):Bool
		return (getFeatures() & feature) != 0;

	/**
	 * Checks whether the device supports a given effect type.
	 *
	 * @param type The effect type to query.
	 * @return `true` if the effect type is supported.
	 */
	public function supportsEffectType(type:SDLHapticEffectType):Bool
		return (getFeatures() & type) != 0;

	static function encode(e:SDLHapticEffect):hl.NativeArray<Int> {
		var i = new hl.NativeArray<Int>(40);
		for (k in 0...40)
			i[k] = 0;
		i[0] = e.type;
		if (e.direction != null) {
			i[1] = e.direction.type;
			if (e.direction.dir != null)
				for (k in 0...e.direction.dir.length)
					i[2 + k] = e.direction.dir[k];
		}
		if (e.length != null)
			i[5] = e.length;
		if (e.delay != null)
			i[6] = e.delay;
		if (e.button != null)
			i[7] = e.button;
		if (e.interval != null)
			i[8] = e.interval;
		if (e.attackLength != null)
			i[9] = e.attackLength;
		if (e.attackLevel != null)
			i[10] = e.attackLevel;
		if (e.fadeLength != null)
			i[11] = e.fadeLength;
		if (e.fadeLevel != null)
			i[12] = e.fadeLevel;
		if (e.level != null)
			i[13] = e.level;
		if (e.start != null)
			i[13] = e.start;
		if (e.end != null)
			i[14] = e.end;
		if (e.largeMagnitude != null)
			i[13] = e.largeMagnitude;
		if (e.smallMagnitude != null)
			i[14] = e.smallMagnitude;
		if (e.period != null)
			i[15] = e.period;
		if (e.magnitude != null)
			i[16] = e.magnitude;
		if (e.offset != null)
			i[17] = e.offset;
		if (e.phase != null)
			i[18] = e.phase;
		if (e.channels != null)
			i[19] = e.channels;
		if (e.samples != null)
			i[20] = e.samples.length;
		if (e.rightSat != null)
			for (k in 0...e.rightSat.length)
				i[21 + k] = e.rightSat[k];
		if (e.leftSat != null)
			for (k in 0...e.leftSat.length)
				i[24 + k] = e.leftSat[k];
		if (e.rightCoeff != null)
			for (k in 0...e.rightCoeff.length)
				i[27 + k] = e.rightCoeff[k];
		if (e.leftCoeff != null)
			for (k in 0...e.leftCoeff.length)
				i[30 + k] = e.leftCoeff[k];
		if (e.deadband != null)
			for (k in 0...e.deadband.length)
				i[33 + k] = e.deadband[k];
		if (e.center != null)
			for (k in 0...e.center.length)
				i[36 + k] = e.center[k];
		return i;
	}

	static function encodeSamples(e:SDLHapticEffect):hl.NativeArray<Int> {
		if (e.samples == null)
			return new hl.NativeArray<Int>(0);
		var a = new hl.NativeArray<Int>(e.samples.length);
		for (k in 0...e.samples.length)
			a[k] = e.samples[k];
		return a;
	}

	/**
	 * Checks whether a given effect is supported by the device.
	 *
	 * @param effect The effect to test.
	 * @return `true` if the effect can be created on this device.
	 */
	public function effectSupported(effect:SDLHapticEffect):Bool
		return SDLHapticNative.effectSupported(ptr, encode(effect));

	/**
	 * Creates an effect on the device.
	 *
	 * @param effect The effect description.
	 * @return The effect ID (non-negative), or -1 on failure.
	 */
	public function createEffect(effect:SDLHapticEffect):Int
		return SDLHapticNative.createEffect(ptr, encode(effect), encodeSamples(effect));

	/**
	 * Updates an existing effect.
	 *
	 * @param id The effect ID returned by `createEffect`.
	 * @param effect The new effect description.
	 * @return `true` on success.
	 */
	public function updateEffect(id:Int, effect:SDLHapticEffect):Bool
		return SDLHapticNative.updateEffect(ptr, id, encode(effect), encodeSamples(effect));

	/**
	 * Plays a previously created effect.
	 *
	 * @param id The effect ID.
	 * @param iterations Number of times to repeat (default 1).
	 * @return `true` on success.
	 */
	public function runEffect(id:Int, iterations:Int = 1):Bool
		return SDLHapticNative.runEffect(ptr, id, iterations);

	/**
	 * Stops a currently playing effect.
	 *
	 * @param id The effect ID.
	 * @return `true` on success.
	 */
	public function stopEffect(id:Int):Bool
		return SDLHapticNative.stopEffect(ptr, id);

	/**
	 * Destroys a previously created effect.
	 *
	 * @param id The effect ID.
	 */
	public function destroyEffect(id:Int):Void
		SDLHapticNative.destroyEffect(ptr, id);

	/**
	 * Checks whether an effect is currently playing.
	 *
	 * @param id The effect ID.
	 * @return `true` if the effect is playing.
	 */
	public function isEffectPlaying(id:Int):Bool
		return SDLHapticNative.effectStatus(ptr, id);

	/**
	 * Sets the global gain for the device.
	 *
	 * @param gain Gain in `[0, 100]`.
	 * @return `true` on success.
	 */
	public function setGain(gain:Int):Bool
		return SDLHapticNative.setGain(ptr, gain);

	/**
	 * Sets the autocenter strength for the device.
	 *
	 * @param autocenter Autocenter strength in `[0, 100]`.
	 * @return `true` on success.
	 */
	public function setAutocenter(autocenter:Int):Bool
		return SDLHapticNative.setAutocenter(ptr, autocenter);

	/**
	 * Pauses all currently playing effects.
	 *
	 * @return `true` on success.
	 */
	public function pause():Bool
		return SDLHapticNative.pause(ptr);

	/**
	 * Resumes all paused effects.
	 *
	 * @return `true` on success.
	 */
	public function resume():Bool
		return SDLHapticNative.resume(ptr);

	/**
	 * Stops all currently playing effects.
	 *
	 * @return `true` on success.
	 */
	public function stopAllEffects():Bool
		return SDLHapticNative.stopAll(ptr);

	/**
	 * Checks whether the device supports simple rumble playback.
	 *
	 * @return `true` if rumble is supported.
	 */
	public function rumbleSupported():Bool
		return SDLHapticNative.rumbleSupported(ptr);

	/**
	 * Initializes simple rumble playback on the device.
	 *
	 * @return `true` on success.
	 */
	public function initRumble():Bool
		return SDLHapticNative.initRumble(ptr);

	/**
	 * Plays a rumble effect.
	 *
	 * @param strength Rumble strength in `[0, 1]`.
	 * @param lengthMs Duration in milliseconds.
	 * @return `true` on success.
	 */
	public function playRumble(strength:Float, lengthMs:Int):Bool
		return SDLHapticNative.playRumble(ptr, strength, lengthMs);

	/**
	 * Stops any rumble currently playing.
	 *
	 * @return `true` on success.
	 */
	public function stopRumble():Bool
		return SDLHapticNative.stopRumble(ptr);
}
