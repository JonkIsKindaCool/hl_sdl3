package hl.bindings.sdl3;

/**
 * Opaque handle to a dynamically loaded shared object (library).
 * Returned by `SDLSharedObject.load` and released by `SDLSharedObject.unload`.
 */
typedef SDLSharedObjectPtr = hl.Abstract<"SDL_SharedObject">;

/**
 * Opaque handle to a symbol resolved inside a loaded shared object.
 *
 * The value returned by `SDLSharedObject.getFunction` is not callable from
 * Haxe directly — it is an abstract handle whose true type depends on the
 * symbol. This binding does not expose a `callFunction`/`castToFunction`
 * helper, so in practice you would pass the raw pointer to native code that
 * knows the real signature.
 */
typedef SDLFunctionPointer = hl.Abstract<"SDL_FunctionPointer">;

@:noCompletion
class SDLLoadSoNative {
	@:hlNative("sdl3", "load_object") public static function loadObject(sofile:hl.Bytes):SDLSharedObjectPtr
		return null;

	@:hlNative("sdl3", "load_function") public static function loadFunction(handle:SDLSharedObjectPtr, name:hl.Bytes):SDLFunctionPointer
		return null;

	@:hlNative("sdl3", "unload_object") public static function unloadObject(handle:SDLSharedObjectPtr):Void {}
}

/**
 * Dynamic library loading.
 *
 * Loads native shared libraries (`.dll` on Windows, `.so` on Linux,
 * `.dylib` on macOS) at runtime and resolves symbols inside them. This is
 * how SDL itself exposes its optional subsystems (e.g. Vulkan, D3D) and
 * how plugin systems typically work.
 *
 * Typical lifecycle:
 * 1. `load()` the library.
 * 2. `getFunction()` each symbol you need.
 * 3. Use the symbols.
 * 4. `unload()` the library when done.
 *
 * On platforms where SDL is statically linked or where dynamic loading is
 * not supported, `load()` returns `null`.
 *
 * Corresponds to `SDL_LoadObject`, `SDL_LoadFunction`, and
 * `SDL_UnloadObject` in SDL3.
 */
class SDLSharedObject {
	var ptr:SDLSharedObjectPtr;

	function new(ptr:SDLSharedObjectPtr)
		this.ptr = ptr;

	/**
	 * Loads a shared library from disk.
	 *
	 * The path is platform-dependent: a plain filename searches the system
	 * library paths, whereas an absolute path loads that specific file.
	 *
	 * @param path Path to the shared library (e.g. `"libvulkan.so.1"`,
	 *             `"vulkan-1.dll"`, or an absolute filesystem path).
	 * @return A handle to the loaded library, or `null` on failure
	 *         (check `SDLError.get()` for details).
	 */
	public static function load(path:String):Null<SDLSharedObject> {
		@:privateAccess var p = SDLLoadSoNative.loadObject(path.toUtf8());
		return p == null ? null : new SDLSharedObject(p);
	}

	/**
	 * Resolves a symbol exported by the loaded library.
	 *
	 * The returned pointer is opaque: its actual type depends on the symbol's
	 * signature, which is not known to SDL. In this binding the pointer is
	 * not directly callable from Haxe — it must be passed to native code that
	 * knows the real prototype.
	 *
	 * @param name Name of the exported symbol (e.g. `"vkCreateInstance"`).
	 * @return A handle to the resolved symbol, or `null` if the symbol
	 *         could not be found.
	 */
	public function getFunction(name:String):Null<SDLFunctionPointer> {
		@:privateAccess var f = SDLLoadSoNative.loadFunction(ptr, name.toUtf8());
		return f == null ? null : f;
	}

	/**
	 * Unloads the shared library and releases its resources.
	 *
	 * Safe to call multiple times; the handle becomes unusable afterwards.
	 * All function pointers obtained from this library become invalid.
	 */
	public function unload():Void {
		if (ptr != null)
			SDLLoadSoNative.unloadObject(ptr);
		ptr = null;
	}
}
