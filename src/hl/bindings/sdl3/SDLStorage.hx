package hl.bindings.sdl3;

import hl.bindings.sdl3.SDLFilesystem.SDLPathType;
import haxe.Int64;
import haxe.io.Bytes;

typedef SDLStoragePtr = hl.Abstract<"SDL_Storage">;

/**
 * Information about a path within an `SDLStorage` container.
 *
 * Mirrors the fields of `SDL_PathInfo`, restricted to what storage
 * containers expose (no nanosecond timestamp).
 */
typedef SDLStoragePathInfo = {
	/** The type of the path (file, directory, other, or none). */
	type:SDLPathType,

	/** The size of the file in bytes, or 0 for directories. */
	size:Int64,

	/** Creation time. */
	createTime:Date,

	/** Last modification time. */
	modifyTime:Date,

	/** Last access time. */
	accessTime:Date
}

@:noCompletion
class SDLStorageNative {
	@:hlNative("sdl3", "open_title_storage") public static function openTitle(overridePath:hl.Bytes, props:Int):SDLStoragePtr
		return null;

	@:hlNative("sdl3", "open_user_storage") public static function openUser(org:hl.Bytes, app:hl.Bytes, props:Int):SDLStoragePtr
		return null;

	@:hlNative("sdl3", "open_file_storage") public static function openFile(path:hl.Bytes):SDLStoragePtr
		return null;

	@:hlNative("sdl3", "close_storage") public static function close(s:SDLStoragePtr):Bool
		return false;

	@:hlNative("sdl3", "storage_ready") public static function ready(s:SDLStoragePtr):Bool
		return false;

	@:hlNative("sdl3", "get_storage_file_size") public static function getFileSize(s:SDLStoragePtr, path:hl.Bytes, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "read_storage_file") public static function readFile(s:SDLStoragePtr, path:hl.Bytes, destination:hl.Bytes, lengthHi:Int,
			lengthLo:Int):Bool
		return false;

	@:hlNative("sdl3", "write_storage_file") public static function writeFile(s:SDLStoragePtr, path:hl.Bytes, source:hl.Bytes, lengthHi:Int, lengthLo:Int):Bool
		return false;

	@:hlNative("sdl3", "create_storage_directory") public static function createDirectory(s:SDLStoragePtr, path:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "enumerate_storage_directory") public static function enumerate(s:SDLStoragePtr, path:hl.Bytes):hl.NativeArray<hl.Bytes>
		return null;

	@:hlNative("sdl3", "remove_storage_path") public static function remove(s:SDLStoragePtr, path:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "rename_storage_path") public static function rename(s:SDLStoragePtr, oldPath:hl.Bytes, newPath:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "copy_storage_file") public static function copy(s:SDLStoragePtr, oldPath:hl.Bytes, newPath:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "get_storage_path_info") public static function getPathInfo(s:SDLStoragePtr, path:hl.Bytes, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "get_storage_space_remaining") public static function getSpaceRemaining(s:SDLStoragePtr, out:hl.NativeArray<Int>):Void {}

	@:hlNative("sdl3", "glob_storage_directory") public static function glob(s:SDLStoragePtr, path:hl.Bytes, pattern:hl.Bytes,
			flags:Int):hl.NativeArray<hl.Bytes>
		return null;
}

/**
 * Abstract storage containers.
 *
 * `SDLStorage` provides a uniform filesystem-like API for reading and
 * writing files inside a "storage container" — a directory that SDL
 * manages for you (user preferences, title data, or an explicit path).
 *
 * Compared to `SDLFilesystem`, storage containers:
 * - Sandbox paths to a specific root, so relative paths cannot escape it.
 * - Work correctly on platforms (consoles, some mobile) where direct
 *   filesystem access is limited or unavailable.
 * - May be asynchronously initialized; check `isReady()` before use.
 *
 * Three containers can be opened:
 * - `openTitle()`: read-only data shipped alongside the application
 *   (assets, game data). The optional `overridePath` substitutes a
 *   user-supplied directory (useful for mod support).
 * - `openUser()`: read/write storage for user-specific data such as
 *   saves and configuration, keyed by organization and application name.
 * - `openFile()`: a container rooted at an explicit filesystem path.
 *
 * Corresponds to the SDL3 storage API (`SDL_OpenTitleStorage`,
 * `SDL_OpenUserStorage`, `SDL_OpenFileStorage`, `SDL_StorageReady`,
 * `SDL_ReadStorageFile`, `SDL_WriteStorageFile`, and related functions).
 */
@:access(String)
class SDLStorage {
	var ptr:SDLStoragePtr;

	function new(ptr:SDLStoragePtr)
		this.ptr = ptr;

	/**
	 * Opens a title storage container.
	 *
	 * Title storage is typically read-only and holds assets shipped with
	 * the application. On most platforms it resolves to a directory next
	 * to the executable.
	 *
	 * @param overridePath Optional filesystem path to use instead of the
	 *                     default title storage location. May be `null`.
	 * @return A new storage handle, or `null` on failure.
	 */
	public static function openTitle(?overridePath:String):Null<SDLStorage> {
		var p = SDLStorageNative.openTitle(overridePath == null ? null : overridePath.toUtf8(), 0);
		return p == null ? null : new SDLStorage(p);
	}

	/**
	 * Opens a user storage container.
	 *
	 * User storage is read/write and is the correct place to store saves,
	 * settings, and other per-user data. The location is derived from
	 * `org` and `app` and follows the platform's conventions
	 * (`%APPDATA%`, `~/Library/Application Support`, XDG dirs, etc.).
	 *
	 * @param org The name of your organization (e.g. `"MyCompany"`).
	 * @param app The name of your application (e.g. `"MyGame"`).
	 * @return A new storage handle, or `null` on failure.
	 */
	public static function openUser(org:String, app:String):Null<SDLStorage> {
		var p = SDLStorageNative.openUser(org.toUtf8(), app.toUtf8(), 0);
		return p == null ? null : new SDLStorage(p);
	}

	/**
	 * Opens a storage container rooted at an explicit filesystem path.
	 *
	 * @param path The filesystem directory that becomes the container root.
	 * @return A new storage handle, or `null` on failure.
	 */
	public static function openFile(path:String):Null<SDLStorage> {
		var p = SDLStorageNative.openFile(path.toUtf8());
		return p == null ? null : new SDLStorage(p);
	}

	/**
	 * Checks whether the storage container has finished initializing.
	 *
	 * Some platforms initialize storage asynchronously; call this before
	 * attempting any file operations.
	 *
	 * @return `true` if the container is ready for use.
	 */
	public function isReady():Bool
		return SDLStorageNative.ready(ptr);

	/**
	 * Closes the storage container and releases its resources.
	 *
	 * Safe to call multiple times; the instance becomes unusable afterwards.
	 *
	 * @return `true` on success, `false` on failure.
	 */
	public function close():Bool {
		var r = ptr == null ? true : SDLStorageNative.close(ptr);
		ptr = null;
		return r;
	}

	/**
	 * Returns the size of a file inside the container.
	 *
	 * @param path The path relative to the container root.
	 * @return The file size in bytes, or `null` on failure.
	 */
	public function getFileSize(path:String):Null<Int64> {
		var o = new hl.NativeArray<Int>(2);
		if (!SDLStorageNative.getFileSize(ptr, path.toUtf8(), o))
			return null;
		return Int64.make(o[0], o[1]);
	}

	/**
	 * Reads the entire contents of a file into memory.
	 *
	 * @param path The path relative to the container root.
	 * @return The file contents, or `null` on failure.
	 */
	public function readFile(path:String):Null<Bytes> {
		var size = getFileSize(path);
		if (size == null)
			return null;
		var len = Int64.toInt(size);
		var data = Bytes.alloc(len);
		if (!SDLStorageNative.readFile(ptr, path.toUtf8(), hl.Bytes.fromBytes(data), Int64.getHigh(size), Int64.getLow(size)))
			return null;
		return data;
	}

	/**
	 * Writes the given bytes to a file, replacing any existing content.
	 *
	 * @param path The path relative to the container root.
	 * @param data The bytes to write.
	 * @return `true` on success, `false` on failure.
	 */
	public function writeFile(path:String, data:Bytes):Bool {
		var len = Int64.ofInt(data.length);
		return SDLStorageNative.writeFile(ptr, path.toUtf8(), hl.Bytes.fromBytes(data), Int64.getHigh(len), Int64.getLow(len));
	}

	/**
	 * Creates a directory inside the container. The parent directory must
	 * already exist.
	 *
	 * @param path The path to create, relative to the container root.
	 * @return `true` on success, `false` on failure.
	 */
	public function createDirectory(path:String):Bool
		return SDLStorageNative.createDirectory(ptr, path.toUtf8());

	/**
	 * Lists the entries in a directory inside the container.
	 *
	 * @param path The path to enumerate, relative to the container root.
	 * @return An array of entry names (not full paths), or `null` on failure.
	 */
	public function enumerate(path:String):Null<Array<String>> {
		var a = SDLStorageNative.enumerate(ptr, path.toUtf8());
		return a == null ? null : [for (i in 0...a.length) String.fromUTF8(a[i])];
	}

	/**
	 * Removes a file or an empty directory inside the container.
	 *
	 * @param path The path to remove, relative to the container root.
	 * @return `true` on success, `false` on failure.
	 */
	public function remove(path:String):Bool
		return SDLStorageNative.remove(ptr, path.toUtf8());

	/**
	 * Renames or moves a file or directory inside the container.
	 *
	 * @param oldPath The existing path.
	 * @param newPath The new path.
	 * @return `true` on success, `false` on failure.
	 */
	public function rename(oldPath:String, newPath:String):Bool
		return SDLStorageNative.rename(ptr, oldPath.toUtf8(), newPath.toUtf8());

	/**
	 * Copies a file from `oldPath` to `newPath` inside the container.
	 *
	 * @param oldPath The source path.
	 * @param newPath The destination path.
	 * @return `true` on success, `false` on failure.
	 */
	public function copy(oldPath:String, newPath:String):Bool
		return SDLStorageNative.copy(ptr, oldPath.toUtf8(), newPath.toUtf8());

	/**
	 * Returns detailed information about a path inside the container.
	 *
	 * @param path The path to query, relative to the container root.
	 * @return A `SDLStoragePathInfo` structure, or `null` if the path does
	 *         not exist or an error occurred.
	 */
	public function getPathInfo(path:String):Null<SDLStoragePathInfo> {
		var o = new hl.NativeArray<Int>(9);
		if (!SDLStorageNative.getPathInfo(ptr, path.toUtf8(), o))
			return null;
		return {
			type: o[0],
			size: Int64.make(o[1], o[2]),
			createTime: toDate(o[3], o[4]),
			modifyTime: toDate(o[5], o[6]),
			accessTime: toDate(o[7], o[8])
		};
	}

	/**
	 * Checks whether a path exists inside the container.
	 *
	 * @param path The path to check, relative to the container root.
	 * @return `true` if the path exists.
	 */
	public function exists(path:String):Bool
		return getPathInfo(path) != null;

	/**
	 * Returns the amount of free space (in bytes) available to the container.
	 *
	 * @return The remaining space in bytes.
	 */
	public function getSpaceRemaining():Int64 {
		var o = new hl.NativeArray<Int>(2);
		SDLStorageNative.getSpaceRemaining(ptr, o);
		return Int64.make(o[0], o[1]);
	}

	/**
	 * Lists files in a directory inside the container matching a glob pattern.
	 *
	 * @param path            The directory to search.
	 * @param pattern         Optional glob pattern (e.g. `"*.sav"`). If
	 *                        omitted, all files are returned.
	 * @param caseInsensitive If `true`, matching is case-insensitive.
	 * @return An array of matching file names (not full paths), or `null`
	 *         on failure.
	 */
	public function glob(path:String, ?pattern:String, caseInsensitive:Bool = false):Null<Array<String>> {
		var a = SDLStorageNative.glob(ptr, path.toUtf8(), pattern == null ? null : pattern.toUtf8(), caseInsensitive ? 1 : 0);
		return a == null ? null : [for (i in 0...a.length) String.fromUTF8(a[i])];
	}

	static function toDate(hi:Int, lo:Int):Date {
		var low:Float = lo < 0 ? lo + 4294967296.0 : lo;
		var ns:Float = hi * 4294967296.0 + low;
		return Date.fromTime(ns / 1000000.0);
	}
}
