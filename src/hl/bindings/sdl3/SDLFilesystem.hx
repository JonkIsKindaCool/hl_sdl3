package hl.bindings.sdl3;

import haxe.Int64;

/**
 * Standard user-specific folders that can be queried with
 * `SDLFilesystem.getUserFolder()`.
 *
 * Corresponds to `SDL_Folder` in SDL3.
 */
enum abstract SDLFolder(Int) from Int to Int {
	/** The user's home directory. */
	var HOME = 0;

	/** The user's desktop directory. */
	var DESKTOP = 1;

	/** The user's documents directory. */
	var DOCUMENTS = 2;

	/** The user's downloads directory. */
	var DOWNLOADS = 3;

	/** The user's music directory. */
	var MUSIC = 4;

	/** The user's pictures directory. */
	var PICTURES = 5;

	/** The user's public share directory. */
	var PUBLICSHARE = 6;

	/** The directory where saved games should be stored. */
	var SAVEDGAMES = 7;

	/** The directory where screenshots should be stored. */
	var SCREENSHOTS = 8;

	/** The user's templates directory. */
	var TEMPLATES = 9;

	/** The user's videos directory. */
	var VIDEOS = 10;
}

/**
 * The type of a filesystem path as returned by `SDLFilesystem.getPathInfo()`.
 *
 * Corresponds to `SDL_PathType` in SDL3.
 */
enum abstract SDLPathType(Int) from Int to Int {
	/** The path does not exist. */
	var NONE = 0;

	/** The path refers to a regular file. */
	var FILE = 1;

	/** The path refers to a directory. */
	var DIRECTORY = 2;

	/** The path refers to something else (e.g. a device, socket, etc.). */
	var OTHER = 3;
}

/**
 * Information about a filesystem path, returned by `SDLFilesystem.getPathInfo()`.
 */
typedef SDLPathInfo = {
	/** The type of the path (file, directory, etc.). */
	type:SDLPathType,

	/** The size of the file in bytes, or 0 for directories. */
	size:Int64,

	/** Creation time as a `Date`. */
	createTime:Date,

	/** Last modification time as a `Date`. */
	modifyTime:Date,

	/** Last access time as a `Date`. */
	accessTime:Date,

	/** Last modification time in nanoseconds since the epoch, for higher precision. */
	modifyTimeNS:Int64
}

@:noCompletion
class SDLFilesystemNative {
	@:hlNative("sdl3", "get_base_path") public static function getBasePath():hl.Bytes
		return null;

	@:hlNative("sdl3", "get_pref_path") public static function getPrefPath(org:hl.Bytes, app:hl.Bytes):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_user_folder") public static function getUserFolder(f:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_current_directory") public static function getCurrentDirectory():hl.Bytes
		return null;

	@:hlNative("sdl3", "create_directory") public static function createDirectory(p:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "remove_path") public static function removePath(p:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "rename_path") public static function renamePath(a:hl.Bytes, b:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "copy_file") public static function copyFile(a:hl.Bytes, b:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "path_exists") public static function pathExists(p:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "get_path_info") public static function getPathInfo(p:hl.Bytes, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "enumerate_directory") public static function enumerate(p:hl.Bytes):hl.NativeArray<hl.Bytes>
		return null;

	@:hlNative("sdl3", "glob_directory") public static function glob(p:hl.Bytes, pattern:hl.Bytes, flags:Int):hl.NativeArray<hl.Bytes>
		return null;
}

/**
 * Filesystem utilities for SDL3.
 *
 * Provides cross-platform helpers for querying standard directories,
 * manipulating paths, and enumerating directory contents.
 */
class SDLFilesystem {
	static inline function utf8(s:Null<String>):hl.Bytes
		@:privateAccess return s == null ? null : s.toUtf8();

	static inline function str(b:hl.Bytes):Null<String>
		@:privateAccess return b == null ? null : String.fromUTF8(b);

	static function list(a:hl.NativeArray<hl.Bytes>):Null<Array<String>>
		@:privateAccess return a == null ? null : [for (i in 0...a.length) String.fromUTF8(a[i])];

	/**
	 * Returns the base path of the application, i.e. the directory from which
	 * the executable was launched, or the bundle directory on macOS.
	 *
	 * @return The base path, or `null` on failure.
	 */
	public static function getBasePath():Null<String>
		return str(SDLFilesystemNative.getBasePath());

	/**
	 * Returns the preferred path for storing user-specific application data.
	 *
	 * This is typically a per-user, per-application directory that is safe
	 * to write to. The directory is created if it does not exist.
	 *
	 * @param org The name of your organization.
	 * @param app The name of your application.
	 * @return The preference path, or `null` on failure.
	 */
	public static function getPrefPath(org:String, app:String):Null<String>
		@:privateAccess return str(SDLFilesystemNative.getPrefPath(org.toUtf8(), app.toUtf8()));

	/**
	 * Returns the path to a standard user folder.
	 *
	 * @param folder The folder to query (e.g. `SAVEDGAMES`, `DOCUMENTS`).
	 * @return The folder path, or `null` if it could not be determined.
	 */
	public static function getUserFolder(folder:SDLFolder):Null<String>
		return str(SDLFilesystemNative.getUserFolder(folder));

	/**
	 * Returns the current working directory of the process.
	 *
	 * @return The current directory, or `null` on failure.
	 */
	public static function getCurrentDirectory():Null<String>
		return str(SDLFilesystemNative.getCurrentDirectory());

	/**
	 * Creates a single directory. The parent directory must already exist.
	 *
	 * @param path The directory path to create.
	 * @return `true` on success, `false` on failure.
	 */
	public static function createDirectory(path:String):Bool
		@:privateAccess return SDLFilesystemNative.createDirectory(path.toUtf8());

	/**
	 * Removes a file or an empty directory.
	 *
	 * @param path The path to remove.
	 * @return `true` on success, `false` on failure.
	 */
	public static function remove(path:String):Bool
		@:privateAccess return SDLFilesystemNative.removePath(path.toUtf8());

	/**
	 * Renames or moves a file or directory.
	 *
	 * @param oldPath The existing path.
	 * @param newPath The new path.
	 * @return `true` on success, `false` on failure.
	 */
	public static function rename(oldPath:String, newPath:String):Bool
		@:privateAccess return SDLFilesystemNative.renamePath(oldPath.toUtf8(), newPath.toUtf8());

	/**
	 * Copies a file from `oldPath` to `newPath`.
	 *
	 * @param oldPath The source file path.
	 * @param newPath The destination file path.
	 * @return `true` on success, `false` on failure.
	 */
	public static function copy(oldPath:String, newPath:String):Bool
		@:privateAccess return SDLFilesystemNative.copyFile(oldPath.toUtf8(), newPath.toUtf8());

	/**
	 * Checks whether a path exists.
	 *
	 * @param path The path to check.
	 * @return `true` if the path exists, `false` otherwise.
	 */
	public static function exists(path:String):Bool
		@:privateAccess return SDLFilesystemNative.pathExists(path.toUtf8());

	/**
	 * Returns detailed information about a filesystem path.
	 *
	 * @param path The path to query.
	 * @return A `SDLPathInfo` structure, or `null` if the path does not exist
	 *         or an error occurred.
	 */
	public static function getPathInfo(path:String):Null<SDLPathInfo> {
		var o = new hl.NativeArray<Int>(9);
		@:privateAccess
		if (!SDLFilesystemNative.getPathInfo(path.toUtf8(), o))
			return null;
		return {
			type: o[0],
			size: Int64.make(o[1], o[2]),
			createTime: toDate(o[3], o[4]),
			modifyTime: toDate(o[5], o[6]),
			accessTime: toDate(o[7], o[8]),
			modifyTimeNS: Int64.make(o[5], o[6])
		};
	}

	/**
	 * Checks whether a path refers to a regular file.
	 *
	 * @param path The path to check.
	 * @return `true` if the path exists and is a file, `false` otherwise.
	 */
	public static function isFile(path:String):Bool {
		var i = getPathInfo(path);
		return i != null && i.type == FILE;
	}

	/**
	 * Checks whether a path refers to a directory.
	 *
	 * @param path The path to check.
	 * @return `true` if the path exists and is a directory, `false` otherwise.
	 */
	public static function isDirectory(path:String):Bool {
		var i = getPathInfo(path);
		return i != null && i.type == DIRECTORY;
	}

	/**
	 * Enumerates the contents of a directory.
	 *
	 * @param path The directory to enumerate.
	 * @return An array of entry names (not full paths), or `null` on failure.
	 */
	public static function enumerate(path:String):Null<Array<String>>
		@:privateAccess return list(SDLFilesystemNative.enumerate(path.toUtf8()));

	/**
	 * Enumerates files in a directory matching a glob pattern.
	 *
	 * @param path The directory to search.
	 * @param pattern Optional glob pattern (e.g. `"*.png"`). If omitted, all files are returned.
	 * @param caseInsensitive If `true`, matching is case-insensitive.
	 * @return An array of matching file names (not full paths), or `null` on failure.
	 */
	public static function glob(path:String, ?pattern:String, caseInsensitive:Bool = false):Null<Array<String>>
		@:privateAccess return list(SDLFilesystemNative.glob(path.toUtf8(), utf8(pattern), caseInsensitive ? 1 : 0));

	/**
	 * Joins two path components with the platform-appropriate separator.
	 *
	 * @param base The base path.
	 * @param name The path component to append.
	 * @return The combined path.
	 */
	public static function join(base:String, name:String):String {
		var last = base.charAt(base.length - 1);
		return (last == "/" || last == "\\") ? base + name : base + "/" + name;
	}

	static function toDate(hi:Int, lo:Int):Date {
		var low:Float = lo < 0 ? lo + 4294967296.0 : lo;
		var ns:Float = hi * 4294967296.0 + low;
		return Date.fromTime(ns / 1000000.0);
	}
}
