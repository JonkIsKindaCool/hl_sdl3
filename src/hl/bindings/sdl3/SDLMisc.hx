package hl.bindings.sdl3;

@:noCompletion
class SDLMiscNative {
	@:hlNative("sdl3", "open_url") public static function openUrl(url:hl.Bytes):Bool
		return false;
}

/**
 * Miscellaneous platform utilities that don't fit into a specific subsystem.
 *
 * Corresponds to the SDL3 miscellaneous API.
 */
class SDLMisc {
	/**
	 * Opens the given URL using the system's default handler.
	 *
	 * The URL is passed to the OS, which decides which application to launch
	 * (a web browser for `https://`, a mail client for `mailto:`, a media
	 * player for `file://`, etc.). The call returns immediately; the target
	 * application opens asynchronously.
	 *
	 * @param url The URL to open (e.g. `"https://example.com"`).
	 * @return `true` if the URL was successfully handed off to the OS,
	 *         `false` on failure (check `SDLError.get()` for details).
	 */
	public static function openURL(url:String):Bool
		@:privateAccess return SDLMiscNative.openUrl(url.toUtf8());
}
