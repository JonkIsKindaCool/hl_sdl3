package hl.bindings.sdl3;

import hl.bindings.sdl3.SDLIOStream.SDLIOStreamPtr;

typedef SDLProcessPtr = hl.Abstract<"SDL_Process">;

/**
 * Describes how a child process's standard I/O stream should be set up.
 *
 * Corresponds to `SDL_ProcessIO` in SDL3.
 */
enum abstract SDLProcessIO(Int) from Int to Int {
	/** The stream is inherited from the parent process. */
	var INHERITED = 0;

	/** The stream is redirected to the platform's null device. */
	var NUL = 1;

	/** The stream is connected to the calling application (i.e. it becomes a pipe). */
	var APP = 2;

	/** The stream is redirected to/from the `stdinSource`/`stdoutSource`/`stderrSource` stream. */
	var REDIRECT = 3;
}

/**
 * Options for `SDLProcess.createWithProperties`.
 *
 * Every field is optional; unspecified fields use the platform's default
 * behavior (inherited streams, no working directory override, foreground
 * execution).
 */
typedef SDLProcessCreateOptions = {
	/** The working directory for the child process. */
	?workingDirectory:String,

	/** How to set up the child's standard input. */
	?stdinOption:SDLProcessIO,

	/** Source stream when `stdinOption` is `REDIRECT`. */
	?stdinSource:SDLIOStream,

	/** How to set up the child's standard output. */
	?stdoutOption:SDLProcessIO,

	/** Destination stream when `stdoutOption` is `REDIRECT`. */
	?stdoutSource:SDLIOStream,

	/** How to set up the child's standard error. */
	?stderrOption:SDLProcessIO,

	/** Destination stream when `stderrOption` is `REDIRECT`. */
	?stderrSource:SDLIOStream,

	/** If `true`, merge the child's stderr into its stdout. */
	?stderrToStdout:Bool,

	/** If `true`, run the child in the background and do not wait for it to exit. */
	?background:Bool,

	/** An application-defined command line string, retrievable from the child's environment. */
	?cmdline:String
}

/**
 * The result of a call to `SDLProcess.read`.
 *
 * Contains the bytes read from the process's stdout (or combined stdout+stderr)
 * plus the current exit code if the process has finished.
 */
typedef SDLProcessReadResult = {
	/** The bytes read from the process. May be empty if only the exit code changed. */
	data:haxe.io.Bytes,

	/** The exit code of the process, or -1 if it has not exited yet. */
	exitCode:Int
}

@:noCompletion
class SDLProcessNative {
	@:hlNative("sdl3", "create_process") public static function create(args:hl.NativeArray<hl.Bytes>, pipeStdio:Bool):SDLProcessPtr
		return null;

	@:hlNative("sdl3", "create_process_with_properties") public static function createWithProperties(args:hl.NativeArray<hl.Bytes>, workingDirectory:hl.Bytes,
			stdinOption:Int, stdinSource:SDLIOStreamPtr, stdoutOption:Int, stdoutSource:SDLIOStreamPtr, stderrOption:Int, stderrSource:SDLIOStreamPtr,
			stderrToStdout:Bool, background:Bool, cmdline:hl.Bytes):SDLProcessPtr
		return null;

	@:hlNative("sdl3", "get_process_pid") public static function getPid(p:SDLProcessPtr):Int
		return 0;

	@:hlNative("sdl3", "get_process_stderr") public static function getStderr(p:SDLProcessPtr):SDLIOStreamPtr
		return null;

	@:hlNative("sdl3", "process_runs_in_background") public static function runsInBackground(p:SDLProcessPtr):Bool
		return false;

	@:hlNative("sdl3", "read_process") public static function read(p:SDLProcessPtr, out:hl.NativeArray<Int>):hl.Bytes
		return null;

	@:hlNative("sdl3", "get_process_input") public static function getInput(p:SDLProcessPtr):SDLIOStreamPtr
		return null;

	@:hlNative("sdl3", "get_process_output") public static function getOutput(p:SDLProcessPtr):SDLIOStreamPtr
		return null;

	@:hlNative("sdl3", "kill_process") public static function kill(p:SDLProcessPtr, force:Bool):Bool
		return false;

	@:hlNative("sdl3", "wait_process") public static function wait(p:SDLProcessPtr, block:Bool, outExitCode:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "destroy_process") public static function destroyNative(p:SDLProcessPtr):Void {}
}

/**
 * External process management.
 *
 * Creates and controls child processes, with support for redirecting their
 * standard streams to `SDLIOStream`s so that input/output can be exchanged
 * from Haxe. Useful for launching external tools (ffmpeg, git, a browser,
 * etc.) and reading their output.
 *
 * Each instance represents a single child process. Call `destroy()` once you
 * are done with it, and be aware that `destroy()` will block until the child
 * terminates if it is still running.
 *
 * Corresponds to the SDL3 process API (`SDL_CreateProcess`,
 * `SDL_CreateProcessWithProperties`, `SDL_KillProcess`, `SDL_WaitProcess`,
 * and related functions).
 */
class SDLProcess {
	var ptr:SDLProcessPtr;

	function new(ptr:SDLProcessPtr)
		this.ptr = ptr;

	/**
	 * Creates a child process from an argument vector.
	 *
	 * The first element of `args` is the program to run; the rest are its
	 * arguments. Path resolution follows platform conventions; on Unix-like
	 * systems, `args[0]` must be an absolute path or found in `PATH`.
	 *
	 * @param args      The command line as an array of arguments.
	 * @param pipeStdio If `true`, the child's stdin/stdout/stderr are
	 *                  connected to streams retrievable via `getInput()`,
	 *                  `getOutput()`, and `getStderr()`. If `false`, they
	 *                  are inherited from the parent.
	 * @return A new `SDLProcess`, or `null` on failure.
	 */
	public static function create(args:Array<String>, pipeStdio:Bool = false):Null<SDLProcess> {
		var a = new hl.NativeArray<hl.Bytes>(args.length);
		for (i in 0...args.length)
			@:privateAccess a[i] = args[i].toUtf8();
		var p = SDLProcessNative.create(a, pipeStdio);
		return p == null ? null : new SDLProcess(p);
	}

	/**
	 * Creates a child process with fine-grained control over its environment.
	 *
	 * Allows setting the working directory, redirecting each standard stream
	 * to a specific `SDLIOStream`, merging stderr into stdout, and running
	 * the child in the background.
	 *
	 * @param args    The command line as an array of arguments.
	 * @param options Optional creation options; unspecified fields use
	 *                platform defaults.
	 * @return A new `SDLProcess`, or `null` on failure.
	 */
	public static function createWithProperties(args:Array<String>, ?options:SDLProcessCreateOptions):Null<SDLProcess> {
		var o:SDLProcessCreateOptions = options != null ? options : {};
		var a = new hl.NativeArray<hl.Bytes>(args.length);
		for (i in 0...args.length)
			@:privateAccess a[i] = args[i].toUtf8();

		@:privateAccess
		var p = SDLProcessNative.createWithProperties(a, o.workingDirectory == null ? null : o.workingDirectory.toUtf8(),
			o.stdinOption == null ? -1 : o.stdinOption, o.stdinSource == null ? null : @:privateAccess o.stdinSource.ptr,
			o.stdoutOption == null ? -1 : o.stdoutOption, o.stdoutSource == null ? null : @:privateAccess o.stdoutSource.ptr,
			o.stderrOption == null ? -1 : o.stderrOption, o.stderrSource == null ? null : @:privateAccess o.stderrSource.ptr, o.stderrToStdout == true,
			o.background == true, o.cmdline == null ? null : o.cmdline.toUtf8());
		return p == null ? null : new SDLProcess(p);
	}

	/** The process ID of the child process. */
	public var pid(get, never):Int;

	inline function get_pid()
		return SDLProcessNative.getPid(ptr);

	/** Whether this process was created in background mode (i.e. `background: true`). */
	public var runsInBackground(get, never):Bool;

	inline function get_runsInBackground()
		return SDLProcessNative.runsInBackground(ptr);

	/**
	 * Returns the stream connected to the child's standard input.
	 *
	 * Only available if the process was created with `pipeStdio = true` or
	 * an explicit `APP`/`REDIRECT` option for stdin.
	 *
	 * @return The input stream, or `null` if it is not exposed.
	 */
	public function getInput():Null<SDLIOStream> {
		var p = SDLProcessNative.getInput(ptr);
		return p == null ? null : @:privateAccess new SDLIOStream(p);
	}

	/**
	 * Returns the stream connected to the child's standard output.
	 *
	 * Only available if the process was created with `pipeStdio = true` or
	 * an explicit `APP`/`REDIRECT` option for stdout.
	 *
	 * @return The output stream, or `null` if it is not exposed.
	 */
	public function getOutput():Null<SDLIOStream> {
		var p = SDLProcessNative.getOutput(ptr);
		return p == null ? null : @:privateAccess new SDLIOStream(p);
	}

	/**
	 * Returns the stream connected to the child's standard error.
	 *
	 * Only available if the process was created with `pipeStdio = true` or
	 * an explicit `APP`/`REDIRECT` option for stderr.
	 *
	 * @return The error stream, or `null` if it is not exposed.
	 */
	public function getStderr():Null<SDLIOStream> {
		var p = SDLProcessNative.getStderr(ptr);
		return p == null ? null : @:privateAccess new SDLIOStream(p);
	}

	/**
	 * Reads any available output from the child process and reports its exit code.
	 *
	 * The returned `SDLProcessReadResult` contains whatever bytes are currently
	 * available from the child's stdout (or merged stdout+stderr) and the
	 * child's exit code if it has already exited (otherwise -1). Call this in
	 * a loop until it returns `null`.
	 *
	 * @return The next chunk of process output and the current exit code, or
	 *         `null` if the process has been fully drained and exited.
	 */
	public function read():Null<SDLProcessReadResult> {
		var o = new hl.NativeArray<Int>(2);
		var raw = SDLProcessNative.read(ptr, o);
		if (raw == null && o[0] == 0)
			return null;
		var len = o[0];
		var data = haxe.io.Bytes.alloc(len);
		if (raw != null)
			data.blit(0, raw.toBytes(len), 0, len);
		return {data: data, exitCode: o[1]};
	}

	/**
	 * Requests the child process to terminate.
	 *
	 * @param force If `true`, kill the process immediately. If `false`, ask
	 *              it to exit gracefully (on Unix this sends `SIGTERM`).
	 * @return `true` if the request was sent, `false` on failure.
	 */
	public function kill(force:Bool):Bool
		return SDLProcessNative.kill(ptr, force);

	/**
	 * Waits for the child process to exit and returns its exit code.
	 *
	 * @param block If `true`, wait indefinitely for the process to exit.
	 *              If `false`, return immediately if the process is still
	 *              running.
	 * @return The process exit code, or `null` if `block` was `false` and
	 *         the process has not exited yet (or on failure).
	 */
	public function waitProcess(block:Bool):Null<Int> {
		var o = new hl.NativeArray<Int>(1);
		if (!SDLProcessNative.wait(ptr, block, o))
			return null;
		return o[0];
	}

	/**
	 * Destroys the process handle and releases its resources.
	 *
	 * If the child is still running, this call **blocks** until it exits.
	 * The instance becomes unusable afterwards.
	 */
	public function destroy():Void {
		if (ptr != null)
			SDLProcessNative.destroyNative(ptr);
		ptr = null;
	}
}
