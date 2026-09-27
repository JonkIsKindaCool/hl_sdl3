package hl.bindings.sdl3;

import haxe.io.Bytes;

typedef SDLClipboardBlobPtr = hl.Abstract<"SDL_ClipboardBlob">;

@:noCompletion
class SDLClipboardNative {
	@:hlNative("sdl3", "set_clipboard_text") public static function setText(t:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "get_clipboard_text") public static function getText():hl.Bytes
		return null;

	@:hlNative("sdl3", "has_clipboard_text") public static function hasText():Bool
		return false;

	@:hlNative("sdl3", "set_primary_selection_text") public static function setPrimary(t:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "get_primary_selection_text") public static function getPrimary():hl.Bytes
		return null;

	@:hlNative("sdl3", "has_primary_selection_text") public static function hasPrimary():Bool
		return false;

	@:hlNative("sdl3", "clipboard_data_begin") public static function dataBegin():Void {}

	@:hlNative("sdl3", "clipboard_data_add") public static function dataAdd(mime:hl.Bytes, data:hl.Bytes, size:Int):Bool
		return false;

	@:hlNative("sdl3", "clipboard_data_commit") public static function dataCommit():Bool
		return false;

	@:hlNative("sdl3", "clear_clipboard_data") public static function clear():Bool
		return false;

	@:hlNative("sdl3", "has_clipboard_data") public static function hasData(mime:hl.Bytes):Bool
		return false;

	@:hlNative("sdl3", "clipboard_fetch") public static function fetch(mime:hl.Bytes):SDLClipboardBlobPtr
		return null;

	@:hlNative("sdl3", "clipboard_blob_size") public static function blobSize(b:SDLClipboardBlobPtr):Int
		return 0;

	@:hlNative("sdl3", "clipboard_blob_copy") public static function blobCopy(b:SDLClipboardBlobPtr, dst:hl.Bytes):Void {}

	@:hlNative("sdl3", "clipboard_blob_free") public static function blobFree(b:SDLClipboardBlobPtr):Void {}

	@:hlNative("sdl3", "get_clipboard_mime_types") public static function mimeTypes():hl.NativeArray<hl.Bytes>
		return null;
}

/**
 * Provides access to the system clipboard, including simple text and
 * advanced multi‑MIME‑type data.
 * Corresponds to the SDL3 clipboard API.
 */
class SDLClipboard {
	/**
	 * Sets the clipboard text.
	 * @param text The text to place on the clipboard.
	 * @return `true` on success, `false` on failure.
	 */
	public static function setText(text:String):Bool
		@:privateAccess return SDLClipboardNative.setText(text.toUtf8());

	/**
	 * Returns the current clipboard text.
	 * @return The clipboard text, or an empty string if none.
	 */
	public static function getText():String
		@:privateAccess return String.fromUTF8(SDLClipboardNative.getText());

	/**
	 * Checks whether the clipboard contains text.
	 * @return `true` if text is available.
	 */
	public static function hasText():Bool
		return SDLClipboardNative.hasText();

	/**
	 * Sets the primary selection text (X11 only).
	 * @param text The text to place on the primary selection.
	 * @return `true` on success, `false` on failure.
	 */
	public static function setPrimarySelectionText(text:String):Bool
		@:privateAccess return SDLClipboardNative.setPrimary(text.toUtf8());

	/**
	 * Returns the current primary selection text (X11 only).
	 * @return The primary selection text, or an empty string if none.
	 */
	public static function getPrimarySelectionText():String
		@:privateAccess return String.fromUTF8(SDLClipboardNative.getPrimary());

	/**
	 * Checks whether the primary selection contains text (X11 only).
	 * @return `true` if text is available.
	 */
	public static function hasPrimarySelectionText():Bool
		return SDLClipboardNative.hasPrimary();

	/**
	 * Sets the clipboard data for multiple MIME types.
	 * This is the advanced clipboard API. Use `setText` for simple text.
	 * @param items A map from MIME type (e.g. `"text/plain"`) to raw data.
	 * @return `true` on success, `false` on failure.
	 */
	public static function setData(items:Map<String, Bytes>):Bool {
		SDLClipboardNative.dataBegin();
		for (mime => data in items)
			@:privateAccess
			if (!SDLClipboardNative.dataAdd(mime.toUtf8(), hl.Bytes.fromBytes(data), data.length))
				return false;
		return SDLClipboardNative.dataCommit();
	}

	/**
	 * Convenience method to set a single MIME type with a string value.
	 * @param mime The MIME type (e.g. `"text/plain"`).
	 * @param value The string value.
	 * @return `true` on success, `false` on failure.
	 */
	public static function setString(mime:String, value:String):Bool {
		var m = new Map<String, Bytes>();
		m.set(mime, Bytes.ofString(value));
		return setData(m);
	}

	/**
	 * Checks whether the clipboard contains data for a given MIME type.
	 * @param mime The MIME type to check.
	 * @return `true` if data is available.
	 */
	public static function hasData(mime:String):Bool
		@:privateAccess return SDLClipboardNative.hasData(mime.toUtf8());

	/**
	 * Retrieves clipboard data for a given MIME type.
	 * @param mime The MIME type to fetch.
	 * @return The raw data, or `null` if not available.
	 */
	public static function getData(mime:String):Null<Bytes> {
		@:privateAccess var blob = SDLClipboardNative.fetch(mime.toUtf8());
		if (blob == null)
			return null;
		var b = Bytes.alloc(SDLClipboardNative.blobSize(blob));
		SDLClipboardNative.blobCopy(blob, hl.Bytes.fromBytes(b));
		SDLClipboardNative.blobFree(blob);
		return b;
	}

	/**
	 * Retrieves clipboard data for a given MIME type as a string.
	 * @param mime The MIME type to fetch.
	 * @return The string value, or `null` if not available.
	 */
	public static function getString(mime:String):Null<String> {
		var b = getData(mime);
		return b == null ? null : b.toString();
	}

	/**
	 * Returns a list of MIME types currently available on the clipboard.
	 * @return An array of MIME type strings.
	 */
	public static function getMimeTypes():Array<String> {
		var a = SDLClipboardNative.mimeTypes();
		@:privateAccess return a == null ? [] : [for (i in 0...a.length) String.fromUTF8(a[i])];
	}

	/**
	 * Clears all data from the clipboard.
	 * @return `true` on success, `false` on failure.
	 */
	public static function clearData():Bool
		return SDLClipboardNative.clear();
}
