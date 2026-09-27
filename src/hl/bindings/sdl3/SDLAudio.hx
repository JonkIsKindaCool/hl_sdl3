package hl.bindings.sdl3;

import haxe.io.Bytes;

typedef SDLAudioStreamPtr = hl.Abstract<"SDL_AudioStream">;
typedef SDLAudioSpecPtr = hl.Abstract<"SDL_AudioSpec">;
typedef SDLWavPtr = hl.Abstract<"SDL_WavData">;

/**
 * Audio sample format.
 * Corresponds to `SDL_AudioFormat` in SDL3.
 */
enum abstract SDLAudioFormat(Int) from Int to Int {
	/** Unknown or invalid format. */
	var UNKNOWN = 0x0000;

	/** Unsigned 8-bit samples. */
	var U8 = 0x0008;

	/** Signed 8-bit samples. */
	var S8 = 0x8008;

	/** Signed 16-bit samples, little-endian. */
	var S16LE = 0x8010;

	/** Signed 16-bit samples, big-endian. */
	var S16BE = 0x9010;

	/** Signed 32-bit samples, little-endian. */
	var S32LE = 0x8020;

	/** Signed 32-bit samples, big-endian. */
	var S32BE = 0x9020;

	/** 32-bit floating point samples, little-endian. */
	var F32LE = 0x8120;

	/** 32-bit floating point samples, big-endian. */
	var F32BE = 0x9120;

	/** Alias for S16LE (native endianness on most platforms). */
	var S16 = 0x8010;

	/** Alias for S32LE (native endianness on most platforms). */
	var S32 = 0x8020;

	/** Alias for F32LE (native endianness on most platforms). */
	var F32 = 0x8120;

	/** Number of bits per sample. */
	public var bitSize(get, never):Int;

	/** Number of bytes per sample. */
	public var byteSize(get, never):Int;

	/** Whether the format is floating-point. */
	public var isFloat(get, never):Bool;

	/** Whether the format is signed. */
	public var isSigned(get, never):Bool;

	/** Whether the format is big-endian. */
	public var isBigEndian(get, never):Bool;

	inline function get_bitSize()
		return this & 0xFF;

	inline function get_byteSize()
		return (this & 0xFF) >> 3;

	inline function get_isFloat()
		return (this & 0x100) != 0;

	inline function get_isSigned()
		return (this & 0x8000) != 0;

	inline function get_isBigEndian()
		return (this & 0x1000) != 0;
}

/**
 * Audio specification: format, channels, and sample rate.
 * Corresponds to `SDL_AudioSpec` in SDL3.
 */
class SDLAudioSpec {
	/** Sample format. */
	public var format:SDLAudioFormat;

	/** Number of channels. */
	public var channels:Int;

	/** Sample rate in Hz. */
	public var freq:Int;

	/**
	 * Creates a new audio specification.
	 * @param format Sample format.
	 * @param channels Number of channels.
	 * @param freq Sample rate in Hz.
	 */
	public function new(format:SDLAudioFormat, channels:Int, freq:Int) {
		this.format = format;
		this.channels = channels;
		this.freq = freq;
	}

	/** Returns the size of one audio frame in bytes (format.byteSize * channels). */
	public inline function frameSize():Int
		return format.byteSize * channels;

	public function toString():String
		return 'AudioSpec($format, ${channels}ch, ${freq}Hz)';

	@:allow(hl.bindings.sdl3)
	function toNative():SDLAudioSpecPtr
		return SDLAudioNative.specAlloc(format, channels, freq);

	@:allow(hl.bindings.sdl3)
	static function fromNative(p:SDLAudioSpecPtr):SDLAudioSpec
		return new SDLAudioSpec(SDLAudioNative.specFormat(p), SDLAudioNative.specChannels(p), SDLAudioNative.specFreq(p));

	@:allow(hl.bindings.sdl3)
	static inline function nativeOrNull(s:Null<SDLAudioSpec>):SDLAudioSpecPtr
		return s == null ? null : s.toNative();
}

@:noCompletion
class SDLAudioNative {
	@:hlNative("sdl3", "get_error") public static function getError():hl.Bytes
		return null;

	@:hlNative("sdl3", "audio_spec_alloc") public static function specAlloc(format:Int, channels:Int, freq:Int):SDLAudioSpecPtr
		return null;

	@:hlNative("sdl3", "audio_spec_format") public static function specFormat(s:SDLAudioSpecPtr):Int
		return 0;

	@:hlNative("sdl3", "audio_spec_channels") public static function specChannels(s:SDLAudioSpecPtr):Int
		return 0;

	@:hlNative("sdl3", "audio_spec_freq") public static function specFreq(s:SDLAudioSpecPtr):Int
		return 0;

	@:hlNative("sdl3", "get_num_audio_drivers") public static function getNumDrivers():Int
		return 0;

	@:hlNative("sdl3", "get_audio_driver") public static function getDriver(i:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_current_audio_driver") public static function getCurrentDriver():hl.Bytes
		return null;

	@:hlNative("sdl3", "get_audio_playback_devices") public static function getPlaybackDevices():hl.NativeArray<Int>
		return null;

	@:hlNative("sdl3", "get_audio_recording_devices") public static function getRecordingDevices():hl.NativeArray<Int>
		return null;

	@:hlNative("sdl3", "get_audio_device_name") public static function getDeviceName(id:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_audio_device_format") public static function getDeviceFormat(id:Int, spec:SDLAudioSpecPtr):Int
		return 0;

	@:hlNative("sdl3", "get_audio_device_channel_map") public static function getDeviceChannelMap(id:Int):hl.NativeArray<Int>
		return null;

	@:hlNative("sdl3", "open_audio_device") public static function openDevice(id:Int, spec:SDLAudioSpecPtr):Int
		return 0;

	@:hlNative("sdl3", "is_audio_device_physical") public static function isPhysical(id:Int):Bool
		return false;

	@:hlNative("sdl3", "is_audio_device_playback") public static function isPlayback(id:Int):Bool
		return false;

	@:hlNative("sdl3", "pause_audio_device") public static function pauseDevice(id:Int):Bool
		return false;

	@:hlNative("sdl3", "resume_audio_device") public static function resumeDevice(id:Int):Bool
		return false;

	@:hlNative("sdl3", "audio_device_paused") public static function devicePaused(id:Int):Bool
		return false;

	@:hlNative("sdl3", "get_audio_device_gain") public static function getDeviceGain(id:Int):Float
		return 0;

	@:hlNative("sdl3", "set_audio_device_gain") public static function setDeviceGain(id:Int, g:Float):Bool
		return false;

	@:hlNative("sdl3", "close_audio_device") public static function closeDevice(id:Int):Void {}

	@:hlNative("sdl3", "bind_audio_stream") public static function bindStream(id:Int, s:SDLAudioStreamPtr):Bool
		return false;

	@:hlNative("sdl3", "unbind_audio_stream") public static function unbindStream(s:SDLAudioStreamPtr):Void {}

	@:hlNative("sdl3", "get_audio_stream_device") public static function streamDevice(s:SDLAudioStreamPtr):Int
		return 0;

	@:hlNative("sdl3", "create_audio_stream") public static function createStream(src:SDLAudioSpecPtr, dst:SDLAudioSpecPtr):SDLAudioStreamPtr
		return null;

	@:hlNative("sdl3", "open_audio_device_stream") public static function openDeviceStream(id:Int, spec:SDLAudioSpecPtr):SDLAudioStreamPtr
		return null;

	@:hlNative("sdl3", "destroy_audio_stream") public static function destroyStream(s:SDLAudioStreamPtr):Void {}

	@:hlNative("sdl3", "get_audio_stream_format") public static function getStreamFormat(s:SDLAudioStreamPtr, src:SDLAudioSpecPtr, dst:SDLAudioSpecPtr):Bool
		return false;

	@:hlNative("sdl3", "set_audio_stream_format") public static function setStreamFormat(s:SDLAudioStreamPtr, src:SDLAudioSpecPtr, dst:SDLAudioSpecPtr):Bool
		return false;

	@:hlNative("sdl3", "get_audio_stream_frequency_ratio") public static function getFreqRatio(s:SDLAudioStreamPtr):Float
		return 0;

	@:hlNative("sdl3", "set_audio_stream_frequency_ratio") public static function setFreqRatio(s:SDLAudioStreamPtr, r:Float):Bool
		return false;

	@:hlNative("sdl3", "get_audio_stream_gain") public static function getStreamGain(s:SDLAudioStreamPtr):Float
		return 0;

	@:hlNative("sdl3", "set_audio_stream_gain") public static function setStreamGain(s:SDLAudioStreamPtr, g:Float):Bool
		return false;

	@:hlNative("sdl3", "get_audio_stream_input_channel_map") public static function getInMap(s:SDLAudioStreamPtr):hl.NativeArray<Int>
		return null;

	@:hlNative("sdl3", "get_audio_stream_output_channel_map") public static function getOutMap(s:SDLAudioStreamPtr):hl.NativeArray<Int>
		return null;

	@:hlNative("sdl3", "set_audio_stream_input_channel_map") public static function setInMap(s:SDLAudioStreamPtr, m:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "set_audio_stream_output_channel_map") public static function setOutMap(s:SDLAudioStreamPtr, m:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "put_audio_stream_data") public static function put(s:SDLAudioStreamPtr, buf:hl.Bytes, len:Int):Bool
		return false;

	@:hlNative("sdl3", "get_audio_stream_data") public static function get(s:SDLAudioStreamPtr, buf:hl.Bytes, len:Int):Int
		return 0;

	@:hlNative("sdl3", "get_audio_stream_available") public static function available(s:SDLAudioStreamPtr):Int
		return 0;

	@:hlNative("sdl3", "get_audio_stream_queued") public static function queued(s:SDLAudioStreamPtr):Int
		return 0;

	@:hlNative("sdl3", "flush_audio_stream") public static function flush(s:SDLAudioStreamPtr):Bool
		return false;

	@:hlNative("sdl3", "clear_audio_stream") public static function clear(s:SDLAudioStreamPtr):Bool
		return false;

	@:hlNative("sdl3", "pause_audio_stream_device") public static function pauseStreamDevice(s:SDLAudioStreamPtr):Bool
		return false;

	@:hlNative("sdl3", "resume_audio_stream_device") public static function resumeStreamDevice(s:SDLAudioStreamPtr):Bool
		return false;

	@:hlNative("sdl3", "audio_stream_device_paused") public static function streamDevicePaused(s:SDLAudioStreamPtr):Bool
		return false;

	@:hlNative("sdl3", "lock_audio_stream") public static function lockStream(s:SDLAudioStreamPtr):Bool
		return false;

	@:hlNative("sdl3", "unlock_audio_stream") public static function unlockStream(s:SDLAudioStreamPtr):Bool
		return false;

	@:hlNative("sdl3", "wav_load") public static function wavLoad(path:hl.Bytes):SDLWavPtr
		return null;

	@:hlNative("sdl3", "wav_format") public static function wavFormat(w:SDLWavPtr):Int
		return 0;

	@:hlNative("sdl3", "wav_channels") public static function wavChannels(w:SDLWavPtr):Int
		return 0;

	@:hlNative("sdl3", "wav_freq") public static function wavFreq(w:SDLWavPtr):Int
		return 0;

	@:hlNative("sdl3", "wav_length") public static function wavLength(w:SDLWavPtr):Int
		return 0;

	@:hlNative("sdl3", "wav_copy") public static function wavCopy(w:SDLWavPtr, dst:hl.Bytes):Void {}

	@:hlNative("sdl3", "wav_free") public static function wavFree(w:SDLWavPtr):Void {}

	@:hlNative("sdl3", "mix_audio") public static function mix(dst:hl.Bytes, src:hl.Bytes, format:Int, len:Int, volume:Float):Bool
		return false;

	@:hlNative("sdl3", "get_audio_format_name") public static function formatName(format:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_silence_value_for_format") public static function silenceValue(format:Int):Int
		return 0;
}

/**
 * WAV file data: audio specification and raw sample data.
 */
typedef SDLWavData = {
	var spec:SDLAudioSpec;
	var data:Bytes;
}

/**
 * Main audio subsystem interface.
 * Provides device enumeration, WAV loading, mixing, and format utilities.
 * Corresponds to the SDL3 audio API.
 */
class SDLAudio {
	/** Use this device ID to open the default playback device. */
	public static inline var DEFAULT_PLAYBACK:Int = -1;

	/** Use this device ID to open the default recording device. */
	public static inline var DEFAULT_RECORDING:Int = -2;

	static inline function str(b:hl.Bytes):Null<String>
		@:privateAccess return b == null ? null : String.fromUTF8(b);

	static function toArray(a:hl.NativeArray<Int>):Array<Int> {
		var r = [];
		if (a != null)
			for (i in 0...a.length)
				r.push(a[i]);
		return r;
	}

	/** Returns the last SDL error message. */
	public static function getError():String
		return str(SDLAudioNative.getError());

	/** Returns a list of available audio drivers. */
	public static function getDrivers():Array<String> {
		var r = [];
		for (i in 0...SDLAudioNative.getNumDrivers())
			r.push(str(SDLAudioNative.getDriver(i)));
		return r;
	}

	/** Returns the name of the currently initialized audio driver, or `null`. */
	public static function getCurrentDriver():Null<String>
		return str(SDLAudioNative.getCurrentDriver());

	/** Returns a list of playback device IDs. */
	public static function getPlaybackDevices():Array<Int>
		return toArray(SDLAudioNative.getPlaybackDevices());

	/** Returns a list of recording device IDs. */
	public static function getRecordingDevices():Array<Int>
		return toArray(SDLAudioNative.getRecordingDevices());

	/** Returns the human-readable name of an audio device, or `null`. */
	public static function getDeviceName(devid:Int):Null<String>
		return str(SDLAudioNative.getDeviceName(devid));

	/**
	 * Returns the native format of an audio device.
	 * @return An object with `spec` and `sampleFrames`, or `null` on error.
	 */
	public static function getDeviceFormat(devid:Int):Null<{spec:SDLAudioSpec, sampleFrames:Int}> {
		var p = SDLAudioNative.specAlloc(0, 0, 0);
		var frames = SDLAudioNative.getDeviceFormat(devid, p);
		if (frames < 0)
			return null;
		return {spec: SDLAudioSpec.fromNative(p), sampleFrames: frames};
	}

	/** Returns `true` if the device is a physical audio device. */
	public static function isDevicePhysical(devid:Int):Bool
		return SDLAudioNative.isPhysical(devid);

	/** Returns `true` if the device is a playback device. */
	public static function isDevicePlayback(devid:Int):Bool
		return SDLAudioNative.isPlayback(devid);

	/**
	 * Loads a WAV file from disk.
	 * @return A `SDLWavData` structure, or `null` on failure.
	 */
	public static function loadWav(path:String):Null<SDLWavData> {
		@:privateAccess
		var w = SDLAudioNative.wavLoad(path.toUtf8());
		if (w == null)
			return null;
		var len = SDLAudioNative.wavLength(w);
		var data = Bytes.alloc(len);
		SDLAudioNative.wavCopy(w, hl.Bytes.fromBytes(data));
		var spec = new SDLAudioSpec(SDLAudioNative.wavFormat(w), SDLAudioNative.wavChannels(w), SDLAudioNative.wavFreq(w));
		SDLAudioNative.wavFree(w);
		return {spec: spec, data: data};
	}

	/**
	 * Mixes audio from `src` into `dst` with a given volume.
	 * Both buffers must be in the specified format.
	 * @param dst Destination buffer.
	 * @param src Source buffer.
	 * @param format Sample format.
	 * @param len Number of bytes to mix.
	 * @param volume Volume multiplier (1.0 = normal).
	 * @return `true` on success.
	 */
	public static function mix(dst:Bytes, src:Bytes, format:SDLAudioFormat, len:Int, volume:Float = 1.0):Bool
		return SDLAudioNative.mix(hl.Bytes.fromBytes(dst), hl.Bytes.fromBytes(src), format, len, volume);

	/** Returns a human-readable name for an audio format. */
	public static function getFormatName(format:SDLAudioFormat):String
		return str(SDLAudioNative.formatName(format));

	/** Returns the silence value for an audio format. */
	public static function getSilenceValue(format:SDLAudioFormat):Int
		return SDLAudioNative.silenceValue(format);
}

/**
 * A logical audio device opened with `SDL_OpenAudioDevice`.
 */
class SDLAudioDevice {
	/** The underlying SDL device ID. */
	public var id(default, null):Int;

	function new(id:Int)
		this.id = id;

	/**
	 * Opens an audio device.
	 * @param devid `DEFAULT_PLAYBACK`, `DEFAULT_RECORDING`, or a specific device ID.
	 * @param spec Optional desired audio specification. May be `null`.
	 * @return A new device, or `null` on failure.
	 */
	public static function open(devid:Int, ?spec:SDLAudioSpec):Null<SDLAudioDevice> {
		var id = SDLAudioNative.openDevice(devid, SDLAudioSpec.nativeOrNull(spec));
		return id == 0 ? null : new SDLAudioDevice(id);
	}

	/** Gets or sets the device gain (volume). */
	public var gain(get, set):Float;

	function get_gain()
		return SDLAudioNative.getDeviceGain(id);

	function set_gain(v:Float) {
		SDLAudioNative.setDeviceGain(id, v);
		return v;
	}

	/** Pauses the device. */
	public function pause():Bool
		return SDLAudioNative.pauseDevice(id);

	/** Resumes the device. */
	public function resume():Bool
		return SDLAudioNative.resumeDevice(id);

	/** Returns `true` if the device is paused. */
	public function isPaused():Bool
		return SDLAudioNative.devicePaused(id);

	/** Returns the device's channel map, or `null` if unavailable. */
	public function getChannelMap():Null<Array<Int>> {
		var m = SDLAudioNative.getDeviceChannelMap(id);
		return m == null ? null : [for (i in 0...m.length) m[i]];
	}

	/** Binds a stream to this device. */
	public function bind(stream:SDLAudioStream):Bool
		return stream.bindTo(this);

	/**
	 * Closes the device.
	 * May block briefly to finish playing the last buffer.
	 */
	public function close():Void {
		if (id != 0)
			SDLAudioNative.closeDevice(id);
		id = 0;
	}
}

/**
 * `SDL_AudioStream`: converts, remaps, and buffers PCM audio.
 */
class SDLAudioStream {
	var ptr:SDLAudioStreamPtr;

	function new(ptr:SDLAudioStreamPtr)
		this.ptr = ptr;

	/**
	 * Creates a standalone stream (not bound to a device).
	 * The `src` and `dst` specs may be `null` and set later with `setFormat`/`bind`.
	 * @return A new stream, or `null` on failure.
	 */
	public static function create(?src:SDLAudioSpec, ?dst:SDLAudioSpec):Null<SDLAudioStream> {
		var p = SDLAudioNative.createStream(SDLAudioSpec.nativeOrNull(src), SDLAudioSpec.nativeOrNull(dst));
		return p == null ? null : new SDLAudioStream(p);
	}

	/**
	 * Opens a device, creates a stream, and binds them in one call.
	 * The device starts PAUSED: call `resumeDevice()` to start playback.
	 * Destroying the stream will also close the device.
	 * @param devid Device ID, defaults to `DEFAULT_PLAYBACK`.
	 * @param spec Optional audio specification.
	 * @return A new stream, or `null` on failure.
	 */
	public static function openDeviceStream(devid:Int = SDLAudio.DEFAULT_PLAYBACK, ?spec:SDLAudioSpec):Null<SDLAudioStream> {
		var p = SDLAudioNative.openDeviceStream(devid, SDLAudioSpec.nativeOrNull(spec));
		return p == null ? null : new SDLAudioStream(p);
	}

	@:allow(hl.bindings.sdl3)
	function bindTo(dev:SDLAudioDevice):Bool
		return SDLAudioNative.bindStream(dev.id, ptr);

	/** Unbinds the stream from its device. */
	public function unbind():Void
		SDLAudioNative.unbindStream(ptr);

	/** Returns the device ID this stream is bound to, or 0 if none. */
	public function getDeviceId():Int
		return SDLAudioNative.streamDevice(ptr);

	/**
	 * Sets the input and/or output audio format.
	 * @param src Source format (may be `null` to leave unchanged).
	 * @param dst Destination format (may be `null` to leave unchanged).
	 * @return `true` on success.
	 */
	public function setFormat(?src:SDLAudioSpec, ?dst:SDLAudioSpec):Bool
		return SDLAudioNative.setStreamFormat(ptr, SDLAudioSpec.nativeOrNull(src), SDLAudioSpec.nativeOrNull(dst));

	/** Returns the current input and output formats, or `null` on error. */
	public function getFormat():Null<{src:SDLAudioSpec, dst:SDLAudioSpec}> {
		var s = SDLAudioNative.specAlloc(0, 0, 0);
		var d = SDLAudioNative.specAlloc(0, 0, 0);
		if (!SDLAudioNative.getStreamFormat(ptr, s, d))
			return null;
		return {src: SDLAudioSpec.fromNative(s), dst: SDLAudioSpec.fromNative(d)};
	}

	/** Gets or sets the stream gain (volume). */
	public var gain(get, set):Float;

	function get_gain()
		return SDLAudioNative.getStreamGain(ptr);

	function set_gain(v:Float) {
		SDLAudioNative.setStreamGain(ptr, v);
		return v;
	}

	/**
	 * Gets or sets the frequency ratio.
	 * 1.0 = normal; >1 faster and higher pitch; range 0.01 to 100.
	 */
	public var frequencyRatio(get, set):Float;

	function get_frequencyRatio()
		return SDLAudioNative.getFreqRatio(ptr);

	function set_frequencyRatio(v:Float) {
		SDLAudioNative.setFreqRatio(ptr, v);
		return v;
	}

	/**
	 * Enqueues `len` bytes (default: all) from `data` starting at `pos`.
	 * SDL copies the data, so the buffer can be reused immediately.
	 * @return `true` on success.
	 */
	public function put(data:Bytes, pos:Int = 0, len:Int = -1):Bool {
		if (len < 0)
			len = data.length - pos;
		return SDLAudioNative.put(ptr, hl.Bytes.fromBytes(data).offset(pos), len);
	}

	/**
	 * Reads converted audio into `out`.
	 * @return Number of bytes read, or -1 on error.
	 */
	public function get(out:Bytes, pos:Int = 0, len:Int = -1):Int {
		if (len < 0)
			len = out.length - pos;
		return SDLAudioNative.get(ptr, hl.Bytes.fromBytes(out).offset(pos), len);
	}

	/** Returns the number of converted bytes available to read. */
	public function available():Int
		return SDLAudioNative.available(ptr);

	/** Returns the number of bytes queued in the stream (input format). */
	public function queued():Int
		return SDLAudioNative.queued(ptr);

	/** Flushes the stream, discarding any pending audio. */
	public function flush():Bool
		return SDLAudioNative.flush(ptr);

	/** Clears the stream, removing all queued audio. */
	public function clear():Bool
		return SDLAudioNative.clear(ptr);

	/** Pauses the bound device. */
	public function pauseDevice():Bool
		return SDLAudioNative.pauseStreamDevice(ptr);

	/** Resumes the bound device. */
	public function resumeDevice():Bool
		return SDLAudioNative.resumeStreamDevice(ptr);

	/** Returns `true` if the bound device is paused. */
	public function isDevicePaused():Bool
		return SDLAudioNative.streamDevicePaused(ptr);

	/** Locks the stream for direct access. */
	public function lock():Bool
		return SDLAudioNative.lockStream(ptr);

	/** Unlocks the stream. */
	public function unlock():Bool
		return SDLAudioNative.unlockStream(ptr);

	/**
	 * Sets the input channel map.
	 * `null` resets the map. Each element is a destination channel; -1 silences it.
	 */
	public function setInputChannelMap(?map:Array<Int>):Bool
		return SDLAudioNative.setInMap(ptr, toNative(map));

	/**
	 * Sets the output channel map.
	 * `null` resets the map. Each element is a destination channel; -1 silences it.
	 */
	public function setOutputChannelMap(?map:Array<Int>):Bool
		return SDLAudioNative.setOutMap(ptr, toNative(map));

	static function toNative(map:Null<Array<Int>>):hl.NativeArray<Int> {
		if (map == null)
			return null;
		var a = new hl.NativeArray<Int>(map.length);
		for (i in 0...map.length)
			a[i] = map[i];
		return a;
	}

	/**
	 * Destroys the stream.
	 * If created with `openDeviceStream`, the device is also closed.
	 */
	public function destroy():Void {
		if (ptr != null)
			SDLAudioNative.destroyStream(ptr);
		ptr = null;
	}
}
