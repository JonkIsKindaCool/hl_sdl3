package hl.bindings.sdl3;

import haxe.Int64;
import haxe.io.Bytes;

typedef SDLIOStreamPtr = hl.Abstract<"SDL_IOStream">;

/**
 * The current status of an `SDLIOStream`.
 * Corresponds to `SDL_IOStatus` in SDL3.
 */
enum abstract SDLIOStatus(Int) from Int to Int {
	/** The stream is ready for reading or writing. */
	var READY = 0;

	/** An error occurred on the stream. */
	var ERROR = 1;

	/** The end of the stream has been reached. */
	var EOF = 2;

	/** The stream is not ready (e.g. non-blocking operation would block). */
	var NOT_READY = 3;

	/** The stream does not allow writing. */
	var READONLY = 4;

	/** The stream does not allow reading. */
	var WRITEONLY = 5;
}

/**
 * The reference point used by `SDLIOStream.seek`.
 * Corresponds to `SDL_IOWhence` in SDL3.
 */
enum abstract SDLIOWhence(Int) from Int to Int {
	/** Seek relative to the start of the stream. */
	var SET = 0;

	/** Seek relative to the current position. */
	var CUR = 1;

	/** Seek relative to the end of the stream. */
	var END = 2;
}

@:noCompletion
class SDLIOStreamNative {
	@:hlNative("sdl3", "io_from_file") public static function fromFile(path:hl.Bytes, mode:hl.Bytes):SDLIOStreamPtr
		return null;

	@:hlNative("sdl3", "io_from_mem") public static function fromMem(mem:hl.Bytes, size:Int):SDLIOStreamPtr
		return null;

	@:hlNative("sdl3", "io_from_const_mem") public static function fromConstMem(mem:hl.Bytes, size:Int):SDLIOStreamPtr
		return null;

	@:hlNative("sdl3", "io_from_dynamic_mem") public static function fromDynamicMem():SDLIOStreamPtr
		return null;

	@:hlNative("sdl3", "close_io") public static function close(ctx:SDLIOStreamPtr):Bool
		return false;

	@:hlNative("sdl3", "get_io_status") public static function getStatus(ctx:SDLIOStreamPtr):Int
		return 0;

	@:hlNative("sdl3", "get_io_size") public static function getSize(ctx:SDLIOStreamPtr, out:hl.NativeArray<Int>):Void {}

	@:hlNative("sdl3", "seek_io") public static function seek(ctx:SDLIOStreamPtr, offHi:Int, offLo:Int, whence:Int, out:hl.NativeArray<Int>):Void {}

	@:hlNative("sdl3", "tell_io") public static function tell(ctx:SDLIOStreamPtr, out:hl.NativeArray<Int>):Void {}

	@:hlNative("sdl3", "read_io") public static function read(ctx:SDLIOStreamPtr, ptr:hl.Bytes, size:Int):Int
		return 0;

	@:hlNative("sdl3", "write_io") public static function write(ctx:SDLIOStreamPtr, ptr:hl.Bytes, size:Int):Int
		return 0;

	@:hlNative("sdl3", "io_puts") public static function puts(ctx:SDLIOStreamPtr, s:hl.Bytes):Int
		return 0;

	@:hlNative("sdl3", "flush_io") public static function flush(ctx:SDLIOStreamPtr):Bool
		return false;

	@:hlNative("sdl3", "load_file_io") public static function loadFileIO(src:SDLIOStreamPtr, closeio:Bool, outSize:hl.NativeArray<Int>):hl.Bytes
		return null;

	@:hlNative("sdl3", "load_file") public static function loadFile(path:hl.Bytes, outSize:hl.NativeArray<Int>):hl.Bytes
		return null;

	@:hlNative("sdl3", "save_file_io") public static function saveFileIO(src:SDLIOStreamPtr, data:hl.Bytes, size:Int, closeio:Bool):Bool
		return false;

	@:hlNative("sdl3", "save_file") public static function saveFile(path:hl.Bytes, data:hl.Bytes, size:Int):Bool
		return false;

	@:hlNative("sdl3", "read_u8") public static function readU8(src:SDLIOStreamPtr, out:hl.NativeArray<Int>):Int
		return 0;

	@:hlNative("sdl3", "read_s8") public static function readS8(src:SDLIOStreamPtr, out:hl.NativeArray<Int>):Int
		return 0;

	@:hlNative("sdl3", "read_u16_le") public static function readU16LE(src:SDLIOStreamPtr, out:hl.NativeArray<Int>):Int
		return 0;

	@:hlNative("sdl3", "read_s16_le") public static function readS16LE(src:SDLIOStreamPtr, out:hl.NativeArray<Int>):Int
		return 0;

	@:hlNative("sdl3", "read_u16_be") public static function readU16BE(src:SDLIOStreamPtr, out:hl.NativeArray<Int>):Int
		return 0;

	@:hlNative("sdl3", "read_s16_be") public static function readS16BE(src:SDLIOStreamPtr, out:hl.NativeArray<Int>):Int
		return 0;

	@:hlNative("sdl3", "read_u32_le") public static function readU32LE(src:SDLIOStreamPtr, out:hl.NativeArray<Int>):Int
		return 0;

	@:hlNative("sdl3", "read_s32_le") public static function readS32LE(src:SDLIOStreamPtr, out:hl.NativeArray<Int>):Int
		return 0;

	@:hlNative("sdl3", "read_u32_be") public static function readU32BE(src:SDLIOStreamPtr, out:hl.NativeArray<Int>):Int
		return 0;

	@:hlNative("sdl3", "read_s32_be") public static function readS32BE(src:SDLIOStreamPtr, out:hl.NativeArray<Int>):Int
		return 0;

	@:hlNative("sdl3", "read_u64_le") public static function readU64LE(src:SDLIOStreamPtr, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "read_s64_le") public static function readS64LE(src:SDLIOStreamPtr, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "read_u64_be") public static function readU64BE(src:SDLIOStreamPtr, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "read_s64_be") public static function readS64BE(src:SDLIOStreamPtr, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "write_u8") public static function writeU8(dst:SDLIOStreamPtr, v:Int):Bool
		return false;

	@:hlNative("sdl3", "write_s8") public static function writeS8(dst:SDLIOStreamPtr, v:Int):Bool
		return false;

	@:hlNative("sdl3", "write_u16_le") public static function writeU16LE(dst:SDLIOStreamPtr, v:Int):Bool
		return false;

	@:hlNative("sdl3", "write_s16_le") public static function writeS16LE(dst:SDLIOStreamPtr, v:Int):Bool
		return false;

	@:hlNative("sdl3", "write_u16_be") public static function writeU16BE(dst:SDLIOStreamPtr, v:Int):Bool
		return false;

	@:hlNative("sdl3", "write_s16_be") public static function writeS16BE(dst:SDLIOStreamPtr, v:Int):Bool
		return false;

	@:hlNative("sdl3", "write_u32_le") public static function writeU32LE(dst:SDLIOStreamPtr, v:Int):Bool
		return false;

	@:hlNative("sdl3", "write_s32_le") public static function writeS32LE(dst:SDLIOStreamPtr, v:Int):Bool
		return false;

	@:hlNative("sdl3", "write_u32_be") public static function writeU32BE(dst:SDLIOStreamPtr, v:Int):Bool
		return false;

	@:hlNative("sdl3", "write_s32_be") public static function writeS32BE(dst:SDLIOStreamPtr, v:Int):Bool
		return false;

	@:hlNative("sdl3", "write_u64_le") public static function writeU64LE(dst:SDLIOStreamPtr, hi:Int, lo:Int):Bool
		return false;

	@:hlNative("sdl3", "write_s64_le") public static function writeS64LE(dst:SDLIOStreamPtr, hi:Int, lo:Int):Bool
		return false;

	@:hlNative("sdl3", "write_u64_be") public static function writeU64BE(dst:SDLIOStreamPtr, hi:Int, lo:Int):Bool
		return false;

	@:hlNative("sdl3", "write_s64_be") public static function writeS64BE(dst:SDLIOStreamPtr, hi:Int, lo:Int):Bool
		return false;
}

/**
 * A generic I/O stream abstraction for reading and writing bytes.
 *
 * Streams can be backed by files, in-memory buffers, or custom sources.
 * They support sequential and random access, and typed big-endian /
 * little-endian read/write helpers.
 *
 * Corresponds to `SDL_IOStream` in SDL3.
 */
class SDLIOStream {
	var ptr:SDLIOStreamPtr;
	var keep:Null<Bytes>;

	function new(ptr:SDLIOStreamPtr, ?keep:Bytes) {
		this.ptr = ptr;
		this.keep = keep;
	}

	/**
	 * Opens a file as an I/O stream.
	 *
	 * @param path The file path.
	 * @param mode The open mode; same syntax as C `fopen` (e.g. `"rb"`, `"wb"`, `"r+b"`).
	 * @return A new stream, or `null` on failure.
	 */
	public static function fromFile(path:String, mode:String):Null<SDLIOStream> {
		@:privateAccess var p = SDLIOStreamNative.fromFile(path.toUtf8(), mode.toUtf8());
		return p == null ? null : new SDLIOStream(p);
	}

	/**
	 * Creates a read/write stream backed by the given in-memory buffer.
	 *
	 * The buffer is retained for the lifetime of the stream; writes may
	 * modify it in place.
	 *
	 * @param mem The backing memory.
	 * @return A new stream, or `null` on failure.
	 */
	public static function fromMem(mem:Bytes):Null<SDLIOStream> {
		var p = SDLIOStreamNative.fromMem(hl.Bytes.fromBytes(mem), mem.length);
		return p == null ? null : new SDLIOStream(p, mem);
	}

	/**
	 * Creates a read-only stream backed by the given in-memory buffer.
	 *
	 * @param mem The backing memory; must not be modified while the stream is open.
	 * @return A new stream, or `null` on failure.
	 */
	public static function fromConstMem(mem:Bytes):Null<SDLIOStream> {
		var p = SDLIOStreamNative.fromConstMem(hl.Bytes.fromBytes(mem), mem.length);
		return p == null ? null : new SDLIOStream(p, mem);
	}

	/**
	 * Creates a stream that grows dynamically in memory as data is written.
	 *
	 * @return A new stream, or `null` on failure.
	 */
	public static function fromDynamicMem():Null<SDLIOStream> {
		var p = SDLIOStreamNative.fromDynamicMem();
		return p == null ? null : new SDLIOStream(p);
	}

	/**
	 * Closes the stream and releases its resources.
	 *
	 * Safe to call multiple times; after this call, the stream is unusable.
	 *
	 * @return `true` on success, `false` on failure.
	 */
	public function close():Bool {
		var r = ptr == null ? true : SDLIOStreamNative.close(ptr);
		ptr = null;
		keep = null;
		return r;
	}

	/**
	 * Returns the current status of the stream.
	 *
	 * @return One of the `SDLIOStatus` values.
	 */
	public function getStatus():SDLIOStatus
		return SDLIOStreamNative.getStatus(ptr);

	/**
	 * Returns the total size of the stream in bytes, if known.
	 *
	 * @return The size, or -1 if the stream size is unknown.
	 */
	public function getSize():Int64 {
		var o = new hl.NativeArray<Int>(2);
		SDLIOStreamNative.getSize(ptr, o);
		return Int64.make(o[0], o[1]);
	}

	/**
	 * Seeks to a new position in the stream.
	 *
	 * @param offset The offset to seek to, interpreted relative to `whence`.
	 * @param whence The reference point (`SET`, `CUR`, or `END`).
	 * @return The new absolute position, or -1 on failure.
	 */
	public function seek(offset:Int64, whence:SDLIOWhence):Int64 {
		var o = new hl.NativeArray<Int>(2);
		SDLIOStreamNative.seek(ptr, Int64.getHigh(offset), Int64.getLow(offset), whence, o);
		return Int64.make(o[0], o[1]);
	}

	/**
	 * Returns the current position in the stream.
	 *
	 * @return The current absolute position, or -1 on failure.
	 */
	public function tell():Int64 {
		var o = new hl.NativeArray<Int>(2);
		SDLIOStreamNative.tell(ptr, o);
		return Int64.make(o[0], o[1]);
	}

	/**
	 * Reads up to `maxLength` bytes from the stream.
	 *
	 * @param maxLength Maximum number of bytes to read.
	 * @return The bytes actually read; may be shorter than `maxLength`.
	 */
	public function read(maxLength:Int):Bytes {
		var buf = Bytes.alloc(maxLength);
		var n = SDLIOStreamNative.read(ptr, hl.Bytes.fromBytes(buf), maxLength);
		if (n < 0)
			n = 0;
		return buf.sub(0, n);
	}

	/**
	 * Writes data to the stream.
	 *
	 * @param data The bytes to write.
	 * @return The number of bytes actually written, or -1 on failure.
	 */
	public function write(data:Bytes):Int
		return SDLIOStreamNative.write(ptr, hl.Bytes.fromBytes(data), data.length);

	/**
	 * Writes a UTF-8 string to the stream, followed by a NUL terminator.
	 *
	 * @param s The string to write.
	 * @return The number of bytes written, or -1 on failure.
	 */
	public function puts(s:String):Int
		@:privateAccess return SDLIOStreamNative.puts(ptr, s.toUtf8());

	/**
	 * Flushes any buffered output to the underlying medium.
	 *
	 * @return `true` on success, `false` on failure.
	 */
	public function flush():Bool
		return SDLIOStreamNative.flush(ptr);

	/**
	 * Reads the entire stream into memory.
	 *
	 * @param closeAfter If `true`, the stream is closed after reading and this object becomes unusable.
	 * @return The full contents, or `null` on failure.
	 */
	public function loadAll(closeAfter:Bool = false):Null<Bytes> {
		var o = new hl.NativeArray<Int>(1);
		var raw = SDLIOStreamNative.loadFileIO(ptr, closeAfter, o);
		if (closeAfter)
			ptr = null;
		if (raw == null)
			return null;
		var len = o[0];
		var out = Bytes.alloc(len);
		out.blit(0, raw.toBytes(len), 0, len);
		return out;
	}

	/**
	 * Writes the given bytes to the stream.
	 *
	 * @param data The bytes to write.
	 * @param closeAfter If `true`, the stream is closed after writing and this object becomes unusable.
	 * @return `true` on success, `false` on failure.
	 */
	public function saveAll(data:Bytes, closeAfter:Bool = false):Bool {
		var r = SDLIOStreamNative.saveFileIO(ptr, hl.Bytes.fromBytes(data), data.length, closeAfter);
		if (closeAfter)
			ptr = null;
		return r;
	}

	static inline function ok(v:Int):Bool
		return v == 1;

	/**
	 * Reads an unsigned 8-bit integer.
	 *
	 * @return The value, or `null` if the read failed.
	 */
	public function readU8():Null<Int> {
		var o = new hl.NativeArray<Int>(1);
		return ok(SDLIOStreamNative.readU8(ptr, o)) ? o[0] & 0xFF : null;
	}

	/**
	 * Reads a signed 8-bit integer.
	 *
	 * @return The value, or `null` if the read failed.
	 */
	public function readS8():Null<Int> {
		var o = new hl.NativeArray<Int>(1);
		return ok(SDLIOStreamNative.readS8(ptr, o)) ? o[0] : null;
	}

	/**
	 * Reads an unsigned 16-bit little-endian integer.
	 *
	 * @return The value, or `null` if the read failed.
	 */
	public function readU16LE():Null<Int> {
		var o = new hl.NativeArray<Int>(1);
		return ok(SDLIOStreamNative.readU16LE(ptr, o)) ? o[0] & 0xFFFF : null;
	}

	/**
	 * Reads a signed 16-bit little-endian integer.
	 *
	 * @return The value, or `null` if the read failed.
	 */
	public function readS16LE():Null<Int> {
		var o = new hl.NativeArray<Int>(1);
		return ok(SDLIOStreamNative.readS16LE(ptr, o)) ? o[0] : null;
	}

	/**
	 * Reads an unsigned 16-bit big-endian integer.
	 *
	 * @return The value, or `null` if the read failed.
	 */
	public function readU16BE():Null<Int> {
		var o = new hl.NativeArray<Int>(1);
		return ok(SDLIOStreamNative.readU16BE(ptr, o)) ? o[0] & 0xFFFF : null;
	}

	/**
	 * Reads a signed 16-bit big-endian integer.
	 *
	 * @return The value, or `null` if the read failed.
	 */
	public function readS16BE():Null<Int> {
		var o = new hl.NativeArray<Int>(1);
		return ok(SDLIOStreamNative.readS16BE(ptr, o)) ? o[0] : null;
	}

	/**
	 * Reads an unsigned 32-bit little-endian integer.
	 *
	 * @return The value, or `null` if the read failed.
	 */
	public function readU32LE():Null<Int> {
		var o = new hl.NativeArray<Int>(1);
		return ok(SDLIOStreamNative.readU32LE(ptr, o)) ? o[0] : null;
	}

	/**
	 * Reads a signed 32-bit little-endian integer.
	 *
	 * @return The value, or `null` if the read failed.
	 */
	public function readS32LE():Null<Int> {
		var o = new hl.NativeArray<Int>(1);
		return ok(SDLIOStreamNative.readS32LE(ptr, o)) ? o[0] : null;
	}

	/**
	 * Reads an unsigned 32-bit big-endian integer.
	 *
	 * @return The value, or `null` if the read failed.
	 */
	public function readU32BE():Null<Int> {
		var o = new hl.NativeArray<Int>(1);
		return ok(SDLIOStreamNative.readU32BE(ptr, o)) ? o[0] : null;
	}

	/**
	 * Reads a signed 32-bit big-endian integer.
	 *
	 * @return The value, or `null` if the read failed.
	 */
	public function readS32BE():Null<Int> {
		var o = new hl.NativeArray<Int>(1);
		return ok(SDLIOStreamNative.readS32BE(ptr, o)) ? o[0] : null;
	}

	/**
	 * Reads an unsigned 64-bit little-endian integer.
	 *
	 * @return The value, or `null` if the read failed.
	 */
	public function readU64LE():Null<Int64> {
		var o = new hl.NativeArray<Int>(2);
		return SDLIOStreamNative.readU64LE(ptr, o) ? Int64.make(o[0], o[1]) : null;
	}

	/**
	 * Reads a signed 64-bit little-endian integer.
	 *
	 * @return The value, or `null` if the read failed.
	 */
	public function readS64LE():Null<Int64> {
		var o = new hl.NativeArray<Int>(2);
		return SDLIOStreamNative.readS64LE(ptr, o) ? Int64.make(o[0], o[1]) : null;
	}

	/**
	 * Reads an unsigned 64-bit big-endian integer.
	 *
	 * @return The value, or `null` if the read failed.
	 */
	public function readU64BE():Null<Int64> {
		var o = new hl.NativeArray<Int>(2);
		return SDLIOStreamNative.readU64BE(ptr, o) ? Int64.make(o[0], o[1]) : null;
	}

	/**
	 * Reads a signed 64-bit big-endian integer.
	 *
	 * @return The value, or `null` if the read failed.
	 */
	public function readS64BE():Null<Int64> {
		var o = new hl.NativeArray<Int>(2);
		return SDLIOStreamNative.readS64BE(ptr, o) ? Int64.make(o[0], o[1]) : null;
	}

	/**
	 * Writes an unsigned 8-bit integer.
	 *
	 * @param v The value to write.
	 * @return `true` on success, `false` on failure.
	 */
	public function writeU8(v:Int):Bool
		return SDLIOStreamNative.writeU8(ptr, v);

	/**
	 * Writes a signed 8-bit integer.
	 *
	 * @param v The value to write.
	 * @return `true` on success, `false` on failure.
	 */
	public function writeS8(v:Int):Bool
		return SDLIOStreamNative.writeS8(ptr, v);

	/**
	 * Writes an unsigned 16-bit little-endian integer.
	 *
	 * @param v The value to write.
	 * @return `true` on success, `false` on failure.
	 */
	public function writeU16LE(v:Int):Bool
		return SDLIOStreamNative.writeU16LE(ptr, v);

	/**
	 * Writes a signed 16-bit little-endian integer.
	 *
	 * @param v The value to write.
	 * @return `true` on success, `false` on failure.
	 */
	public function writeS16LE(v:Int):Bool
		return SDLIOStreamNative.writeS16LE(ptr, v);

	/**
	 * Writes an unsigned 16-bit big-endian integer.
	 *
	 * @param v The value to write.
	 * @return `true` on success, `false` on failure.
	 */
	public function writeU16BE(v:Int):Bool
		return SDLIOStreamNative.writeU16BE(ptr, v);

	/**
	 * Writes a signed 16-bit big-endian integer.
	 *
	 * @param v The value to write.
	 * @return `true` on success, `false` on failure.
	 */
	public function writeS16BE(v:Int):Bool
		return SDLIOStreamNative.writeS16BE(ptr, v);

	/**
	 * Writes an unsigned 32-bit little-endian integer.
	 *
	 * @param v The value to write.
	 * @return `true` on success, `false` on failure.
	 */
	public function writeU32LE(v:Int):Bool
		return SDLIOStreamNative.writeU32LE(ptr, v);

	/**
	 * Writes a signed 32-bit little-endian integer.
	 *
	 * @param v The value to write.
	 * @return `true` on success, `false` on failure.
	 */
	public function writeS32LE(v:Int):Bool
		return SDLIOStreamNative.writeS32LE(ptr, v);

	/**
	 * Writes an unsigned 32-bit big-endian integer.
	 *
	 * @param v The value to write.
	 * @return `true` on success, `false` on failure.
	 */
	public function writeU32BE(v:Int):Bool
		return SDLIOStreamNative.writeU32BE(ptr, v);

	/**
	 * Writes a signed 32-bit big-endian integer.
	 *
	 * @param v The value to write.
	 * @return `true` on success, `false` on failure.
	 */
	public function writeS32BE(v:Int):Bool
		return SDLIOStreamNative.writeS32BE(ptr, v);

	/**
	 * Writes an unsigned 64-bit little-endian integer.
	 *
	 * @param v The value to write.
	 * @return `true` on success, `false` on failure.
	 */
	public function writeU64LE(v:Int64):Bool
		return SDLIOStreamNative.writeU64LE(ptr, Int64.getHigh(v), Int64.getLow(v));

	/**
	 * Writes a signed 64-bit little-endian integer.
	 *
	 * @param v The value to write.
	 * @return `true` on success, `false` on failure.
	 */
	public function writeS64LE(v:Int64):Bool
		return SDLIOStreamNative.writeS64LE(ptr, Int64.getHigh(v), Int64.getLow(v));

	/**
	 * Writes an unsigned 64-bit big-endian integer.
	 *
	 * @param v The value to write.
	 * @return `true` on success, `false` on failure.
	 */
	public function writeU64BE(v:Int64):Bool
		return SDLIOStreamNative.writeU64BE(ptr, Int64.getHigh(v), Int64.getLow(v));

	/**
	 * Writes a signed 64-bit big-endian integer.
	 *
	 * @param v The value to write.
	 * @return `true` on success, `false` on failure.
	 */
	public function writeS64BE(v:Int64):Bool
		return SDLIOStreamNative.writeS64BE(ptr, Int64.getHigh(v), Int64.getLow(v));
}

/**
 * Convenience helpers for loading and saving whole files.
 *
 * These wrap the SDL3 `SDL_LoadFile` / `SDL_SaveFile` functions and are
 * typically the simplest way to read or write a file when you don't need
 * streaming or random access.
 */
class SDLFile {
	/**
	 * Loads the entire contents of a file into memory.
	 *
	 * @param path The file path.
	 * @return The file contents, or `null` on failure.
	 */
	public static function loadFile(path:String):Null<Bytes> {
		var o = new hl.NativeArray<Int>(1);
		@:privateAccess var raw = SDLIOStreamNative.loadFile(path.toUtf8(), o);
		if (raw == null)
			return null;
		var len = o[0];
		var out = Bytes.alloc(len);
		out.blit(0, raw.toBytes(len), 0, len);
		return out;
	}

	/**
	 * Writes the given bytes to a file, replacing any existing content.
	 *
	 * @param path The destination file path.
	 * @param data The bytes to write.
	 * @return `true` on success, `false` on failure.
	 */
	public static function saveFile(path:String, data:Bytes):Bool
		@:privateAccess return SDLIOStreamNative.saveFile(path.toUtf8(), hl.Bytes.fromBytes(data), data.length);
}
