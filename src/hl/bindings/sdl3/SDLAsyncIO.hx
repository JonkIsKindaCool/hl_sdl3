package hl.bindings.sdl3;

import haxe.Int64;
import haxe.io.Bytes;

@:noCompletion
@:noDoc
typedef SDLAsyncIOPtr = hl.Abstract<"SDL_AsyncIO">;

@:noCompletion
@:noDoc
typedef SDLAsyncIOQueuePtr = hl.Abstract<"SDL_AsyncIOQueue">;

@:noCompletion
@:noDoc
typedef SDLAsyncIOOutcomePtr = hl.Abstract<"SDL_AsyncIOOutcome">;

/**
 * The type of asynchronous task that was completed.
 * Corresponds to `SDL_AsyncIOTaskType` in SDL3.
 */
enum abstract SDLAsyncIOTaskType(Int) from Int to Int {
	/** A read operation. */
	var READ = 0;

	/** A write operation. */
	var WRITE = 1;

	/** A close operation. */
	var CLOSE = 2;
}

/**
 * The result of an asynchronous task.
 * Corresponds to `SDL_AsyncIOResult` in SDL3.
 */
enum abstract SDLAsyncIOResult(Int) from Int to Int {
	/** The task completed successfully. */
	var COMPLETE = 0;

	/** The task failed. */
	var FAILURE = 1;

	/** The task was canceled. */
	var CANCELED = 2;
}

/**
 * Information about a completed asynchronous task.
 * Passed to callbacks registered with an `SDLAsyncIOQueue`.
 */
typedef SDLAsyncIOCompletion = {
	/** The type of operation that generated this task. */
	type:SDLAsyncIOTaskType,

	/** The result of the operation. */
	result:SDLAsyncIOResult,

	/** The file offset where the operation took place. */
	offset:Int64,

	/** The number of bytes originally requested. */
	bytesRequested:Int64,

	/** The number of bytes actually transferred. */
	bytesTransferred:Int64,

	/** The data read or written. `null` if not applicable. */
	data:Null<Bytes>
}

@:noCompletion
class SDLAsyncIONative {
	@:hlNative("sdl3", "asyncio_from_file") public static function fromFile(path:hl.Bytes, mode:hl.Bytes):SDLAsyncIOPtr
		return null;

	@:hlNative("sdl3", "get_asyncio_size") public static function getSize(a:SDLAsyncIOPtr):Int64
		return 0;

	@:hlNative("sdl3", "read_asyncio") public static function read(a:SDLAsyncIOPtr, ptr:hl.Bytes, offset:Int64, size:Int64, q:SDLAsyncIOQueuePtr,
			userdata:Int64):Bool
		return false;

	@:hlNative("sdl3", "write_asyncio") public static function write(a:SDLAsyncIOPtr, ptr:hl.Bytes, offset:Int64, size:Int64, q:SDLAsyncIOQueuePtr,
			userdata:Int64):Bool
		return false;

	@:hlNative("sdl3", "close_asyncio") public static function close(a:SDLAsyncIOPtr, flush:Bool, q:SDLAsyncIOQueuePtr, userdata:Int64):Bool
		return false;

	@:hlNative("sdl3", "load_file_async") public static function loadFile(path:hl.Bytes, q:SDLAsyncIOQueuePtr, userdata:Int64):Bool
		return false;

	@:hlNative("sdl3", "create_asyncio_queue") public static function createQueue():SDLAsyncIOQueuePtr
		return null;

	@:hlNative("sdl3", "destroy_asyncio_queue") public static function destroyQueue(q:SDLAsyncIOQueuePtr):Void {}

	@:hlNative("sdl3", "signal_asyncio_queue") public static function signalQueue(q:SDLAsyncIOQueuePtr):Void {}

	@:hlNative("sdl3", "asyncio_outcome_alloc") public static function outcomeAlloc():SDLAsyncIOOutcomePtr
		return null;

	@:hlNative("sdl3", "get_asyncio_result") public static function getResult(q:SDLAsyncIOQueuePtr, o:SDLAsyncIOOutcomePtr):Bool
		return false;

	@:hlNative("sdl3", "wait_asyncio_result") public static function waitResult(q:SDLAsyncIOQueuePtr, o:SDLAsyncIOOutcomePtr, timeoutMS:Int):Bool
		return false;

	@:hlNative("sdl3", "outcome_type") public static function outcomeType(o:SDLAsyncIOOutcomePtr):Int
		return 0;

	@:hlNative("sdl3", "outcome_result") public static function outcomeResult(o:SDLAsyncIOOutcomePtr):Int
		return 0;

	@:hlNative("sdl3", "outcome_buffer") public static function outcomeBuffer(o:SDLAsyncIOOutcomePtr):hl.Bytes
		return null;

	@:hlNative("sdl3", "outcome_offset") public static function outcomeOffset(o:SDLAsyncIOOutcomePtr):Int64
		return 0;

	@:hlNative("sdl3", "outcome_bytes_requested") public static function outcomeBytesRequested(o:SDLAsyncIOOutcomePtr):Int64
		return 0;

	@:hlNative("sdl3", "outcome_bytes_transferred") public static function outcomeBytesTransferred(o:SDLAsyncIOOutcomePtr):Int64
		return 0;

	@:hlNative("sdl3", "outcome_userdata") public static function outcomeUserdata(o:SDLAsyncIOOutcomePtr):Int64
		return 0;

	@:hlNative("sdl3", "free") public static function free(p:hl.Bytes):Void {}
}

private typedef SDLTask = {
	var cb:SDLAsyncIOCompletion->Void;

	var keep:Null<Bytes>;

	var isLoadFile:Bool;
}

/**
 * A queue that manages multiple asynchronous I/O tasks.
 * Allows enqueuing operations and retrieving their results.
 * Corresponds to `SDL_AsyncIOQueue` in SDL3.
 */
class SDLAsyncIOQueue {
	var ptr:SDLAsyncIOQueuePtr;
	var outcome:SDLAsyncIOOutcomePtr;
	var tasks:Map<Int, SDLTask> = new Map();
	var nextId = 1;
	var disposed = false;

	/**
	 * Creates a new asynchronous I/O queue.
	 * Corresponds to `SDL_CreateAsyncIOQueue`.
	 * @throws String if creation fails.
	 */
	public function new() {
		ptr = SDLAsyncIONative.createQueue();
		if (ptr == null)
			throw "SDL_CreateAsyncIOQueue failed";
		outcome = SDLAsyncIONative.outcomeAlloc();
	}

	function raw():SDLAsyncIOQueuePtr
		return ptr;

	function register(cb:SDLAsyncIOCompletion->Void, keep:Null<Bytes>, isLoadFile = false):Int {
		var id = nextId++;
		tasks.set(id, {cb: cb, keep: keep, isLoadFile: isLoadFile});
		return id;
	}

	function unregister(id:Int):Void
		tasks.remove(id);

	/**
	 * Loads the entire contents of a file asynchronously into memory.
	 * Corresponds to `SDL_LoadFileAsync`.
	 * @param path The file path.
	 * @param cb Callback invoked upon completion. The data is available in `data`.
	 * @return `true` if the task was successfully enqueued.
	 */
	public function loadFile(path:String, cb:SDLAsyncIOCompletion->Void):Bool {
		var id = register(cb, null, true);
		if (!SDLAsyncIONative.loadFile(@:privateAccess path.toUtf8(), ptr, Int64.ofInt(id))) {
			unregister(id);
			return false;
		}
		return true;
	}

	/**
	 * Polls the queue in a non-blocking manner and executes callbacks for completed tasks.
	 * Corresponds to `SDL_GetAsyncIOResult`.
	 * @return The number of tasks processed.
	 */
	public function poll():Int {
		var n = 0;
		while (SDLAsyncIONative.getResult(ptr, outcome)) {
			dispatch();
			n++;
		}
		return n;
	}

	/**
	 * Blocks the current thread until a task is completed or the timeout expires.
	 * Corresponds to `SDL_WaitAsyncIOResult`.
	 * @param timeoutMS Timeout in milliseconds. Negative for indefinite wait.
	 * @return `true` if a task was processed, `false` if the timeout expired.
	 */
	public function wait(timeoutMS:Int = -1):Bool {
		if (!SDLAsyncIONative.waitResult(ptr, outcome, timeoutMS))
			return false;
		dispatch();
		return true;
	}

	/**
	 * Wakes up any thread blocked in `wait()`.
	 * Corresponds to `SDL_SignalAsyncIOQueue`.
	 */
	public function signal():Void
		SDLAsyncIONative.signalQueue(ptr);

	function dispatch():Void {
		var id = Int64.toInt(SDLAsyncIONative.outcomeUserdata(outcome));
		var task = tasks.get(id);
		tasks.remove(id);
		if (task == null)
			return;

		var type:SDLAsyncIOTaskType = SDLAsyncIONative.outcomeType(outcome);
		var result:SDLAsyncIOResult = SDLAsyncIONative.outcomeResult(outcome);
		var transferred = SDLAsyncIONative.outcomeBytesTransferred(outcome);

		var data:Null<Bytes> = task.keep;
		if (task.isLoadFile) {
			var buf = SDLAsyncIONative.outcomeBuffer(outcome);
			if (buf != null) {
				if (result == COMPLETE) {
					var len = Int64.toInt(transferred);
					data = Bytes.alloc(len);
					data.blit(0, buf.toBytes(len), 0, len);
				}
				SDLAsyncIONative.free(buf);
			}
		}

		task.cb({
			type: type,
			result: result,
			offset: SDLAsyncIONative.outcomeOffset(outcome),
			bytesRequested: SDLAsyncIONative.outcomeBytesRequested(outcome),
			bytesTransferred: transferred,
			data: data
		});
	}

	/**
	 * Destroys the queue and frees its resources.
	 * Corresponds to `SDL_DestroyAsyncIOQueue`.
	 * Blocks until all pending tasks have completed.
	 */
	public function dispose():Void {
		if (disposed)
			return;
		disposed = true;
		SDLAsyncIONative.destroyQueue(ptr);
		ptr = null;
		tasks = new Map();
	}
}

/**
 * A handle for asynchronous I/O operations on a file.
 * Corresponds to `SDL_AsyncIO` in SDL3.
 */
class SDLAsyncIO {
	var ptr:SDLAsyncIOPtr;

	/** The queue associated with this object. */
	public var queue(default, null):SDLAsyncIOQueue;

	function new(ptr:SDLAsyncIOPtr, queue:SDLAsyncIOQueue) {
		this.ptr = ptr;
		this.queue = queue;
	}

	/**
	 * Opens a file for asynchronous I/O.
	 * Corresponds to `SDL_AsyncIOFromFile`.
	 * @param path The file path.
	 * @param mode The open mode (similar to fopen). E.g. "r", "w", "r+".
	 * @param queue The queue to associate tasks with.
	 * @return A new instance, or `null` on failure.
	 */
	public static function open(path:String, mode:String, queue:SDLAsyncIOQueue):Null<SDLAsyncIO> {
		@:privateAccess
		var p = SDLAsyncIONative.fromFile(path.toUtf8(), mode.toUtf8());
		return p == null ? null : new SDLAsyncIO(p, queue);
	}

	/**
	 * Gets the size of the file.
	 * Corresponds to `SDL_GetAsyncIOSize`.
	 * @return The size in bytes, or a negative value on error.
	 */
	public function getSize():Int64
		return SDLAsyncIONative.getSize(ptr);

	/**
	 * Starts an asynchronous read operation.
	 * Corresponds to `SDL_ReadAsyncIO`.
	 * @param offset The position to read from.
	 * @param size The maximum number of bytes to read.
	 * @param cb Callback invoked upon completion. The data is available in `data`.
	 * @return `true` if the task was successfully enqueued.
	 */
	public function read(offset:Int64, size:Int, cb:SDLAsyncIOCompletion->Void):Bool {
		var buf = Bytes.alloc(size);
		@:privateAccess
		var id = queue.register(cb, buf);
		@:privateAccess
		var ok = SDLAsyncIONative.read(ptr, hl.Bytes.fromBytes(buf), offset, Int64.ofInt(size), queue.raw(), Int64.ofInt(id));
		if (!ok)
			@:privateAccess queue.unregister(id);
		return ok;
	}

	/**
	 * Starts an asynchronous write operation.
	 * Corresponds to `SDL_WriteAsyncIO`.
	 * @param offset The position to write to.
	 * @param data The data to write. Must not be modified until the callback runs.
	 * @param cb Callback invoked upon completion.
	 * @return `true` if the task was successfully enqueued.
	 */
	public function write(offset:Int64, data:Bytes, cb:SDLAsyncIOCompletion->Void):Bool {
		@:privateAccess
		var id = queue.register(cb, data);
		@:privateAccess
		var ok = SDLAsyncIONative.write(ptr, hl.Bytes.fromBytes(data), offset, Int64.ofInt(data.length), queue.raw(), Int64.ofInt(id));
		if (!ok) {
			@:privateAccess
			queue.unregister(id);
		}
		return ok;
	}

	/**
	 * Closes the file asynchronously.
	 * Corresponds to `SDL_CloseAsyncIO`.
	 * @param flush If `true`, ensures data is flushed to disk.
	 * @param cb Optional callback invoked upon completion.
	 * @return `true` if the task was successfully enqueued. After this, the object is no longer valid.
	 */
	public function close(flush:Bool, ?cb:SDLAsyncIOCompletion->Void):Bool {
		@:privateAccess
		var id = queue.register(cb != null ? cb : function(_) {}, null);

		@:privateAccess
		var ok = SDLAsyncIONative.close(ptr, flush, queue.raw(), Int64.ofInt(id));
		@:privateAccess
		if (!ok)
			queue.unregister(id);
		else
			ptr = null;
		return ok;
	}
}
