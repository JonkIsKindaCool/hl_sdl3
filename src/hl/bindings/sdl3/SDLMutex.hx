package hl.bindings.sdl3;

typedef SDLMutexPtr = hl.Abstract<"SDL_Mutex">;
typedef SDLRWLockPtr = hl.Abstract<"SDL_RWLock">;
typedef SDLSemaphorePtr = hl.Abstract<"SDL_Semaphore">;
typedef SDLConditionPtr = hl.Abstract<"SDL_Condition">;
typedef SDLInitStatePtr = hl.Abstract<"SDL_InitState">;

/**
 * The lifecycle status of an `SDLInitState`.
 *
 * Used to coordinate one-time initialization/shutdown across multiple
 * threads without the caller having to manage its own mutex.
 *
 * Corresponds to `SDL_InitStatus` in SDL3.
 */
enum abstract SDLInitStatus(Int) from Int to Int {
	/** The resource has not been initialized yet. */
	var UNINITIALIZED = 0;

	/** The resource is currently being initialized by another thread. */
	var INITIALIZING = 1;

	/** The resource has been initialized and is ready to use. */
	var INITIALIZED = 2;

	/** The resource is currently being shut down by another thread. */
	var UNINITIALIZING = 3;
}

@:noCompletion
class SDLMutexNative {
	@:hlNative("sdl3", "create_mutex") public static function createMutex():SDLMutexPtr
		return null;

	@:hlNative("sdl3", "lock_mutex") public static function lockMutex(m:SDLMutexPtr):Void {}

	@:hlNative("sdl3", "try_lock_mutex") public static function tryLockMutex(m:SDLMutexPtr):Bool
		return false;

	@:hlNative("sdl3", "unlock_mutex") public static function unlockMutex(m:SDLMutexPtr):Void {}

	@:hlNative("sdl3", "destroy_mutex") public static function destroyMutex(m:SDLMutexPtr):Void {}

	@:hlNative("sdl3", "create_rwlock") public static function createRWLock():SDLRWLockPtr
		return null;

	@:hlNative("sdl3", "lock_rwlock_for_reading") public static function lockRWLockForReading(l:SDLRWLockPtr):Void {}

	@:hlNative("sdl3", "lock_rwlock_for_writing") public static function lockRWLockForWriting(l:SDLRWLockPtr):Void {}

	@:hlNative("sdl3", "try_lock_rwlock_for_reading") public static function tryLockRWLockForReading(l:SDLRWLockPtr):Bool
		return false;

	@:hlNative("sdl3", "try_lock_rwlock_for_writing") public static function tryLockRWLockForWriting(l:SDLRWLockPtr):Bool
		return false;

	@:hlNative("sdl3", "unlock_rwlock") public static function unlockRWLock(l:SDLRWLockPtr):Void {}

	@:hlNative("sdl3", "destroy_rwlock") public static function destroyRWLock(l:SDLRWLockPtr):Void {}

	@:hlNative("sdl3", "create_semaphore") public static function createSemaphore(initialValue:Int):SDLSemaphorePtr
		return null;

	@:hlNative("sdl3", "destroy_semaphore") public static function destroySemaphore(s:SDLSemaphorePtr):Void {}

	@:hlNative("sdl3", "wait_semaphore") public static function waitSemaphore(s:SDLSemaphorePtr):Void {}

	@:hlNative("sdl3", "try_wait_semaphore") public static function tryWaitSemaphore(s:SDLSemaphorePtr):Bool
		return false;

	@:hlNative("sdl3", "wait_semaphore_timeout") public static function waitSemaphoreTimeout(s:SDLSemaphorePtr, timeoutMs:Int):Bool
		return false;

	@:hlNative("sdl3", "signal_semaphore") public static function signalSemaphore(s:SDLSemaphorePtr):Void {}

	@:hlNative("sdl3", "get_semaphore_value") public static function getSemaphoreValue(s:SDLSemaphorePtr):Int
		return 0;

	@:hlNative("sdl3", "create_condition") public static function createCondition():SDLConditionPtr
		return null;

	@:hlNative("sdl3", "destroy_condition") public static function destroyCondition(c:SDLConditionPtr):Void {}

	@:hlNative("sdl3", "signal_condition") public static function signalCondition(c:SDLConditionPtr):Void {}

	@:hlNative("sdl3", "broadcast_condition") public static function broadcastCondition(c:SDLConditionPtr):Void {}

	@:hlNative("sdl3", "wait_condition") public static function waitCondition(c:SDLConditionPtr, m:SDLMutexPtr):Void {}

	@:hlNative("sdl3", "wait_condition_timeout") public static function waitConditionTimeout(c:SDLConditionPtr, m:SDLMutexPtr, timeoutMs:Int):Bool
		return false;

	@:hlNative("sdl3", "init_state_alloc") public static function initStateAlloc():SDLInitStatePtr
		return null;

	@:hlNative("sdl3", "should_init") public static function shouldInit(state:SDLInitStatePtr):Bool
		return false;

	@:hlNative("sdl3", "should_quit") public static function shouldQuit(state:SDLInitStatePtr):Bool
		return false;

	@:hlNative("sdl3", "set_initialized") public static function setInitialized(state:SDLInitStatePtr, initialized:Bool):Void {}

	@:hlNative("sdl3", "get_init_status") public static function getInitStatus(state:SDLInitStatePtr):Int
		return 0;
}

/**
 * A mutually-exclusive lock (mutex).
 *
 * Only one thread may hold the mutex at a time. Use `lock()` / `unlock()` to
 * guard a critical section, or `tryLock()` to attempt to acquire it without
 * blocking. Remember to `destroy()` the mutex when it is no longer needed.
 *
 * Corresponds to `SDL_Mutex` in SDL3.
 */
class SDLMutex {
	var ptr:SDLMutexPtr;

	/** Creates a new unlocked mutex. */
	public function new()
		ptr = SDLMutexNative.createMutex();

	/**
	 * Acquires the mutex, blocking until it becomes available.
	 *
	 * Must be paired with a matching call to `unlock()`.
	 */
	public function lock():Void
		SDLMutexNative.lockMutex(ptr);

	/**
	 * Attempts to acquire the mutex without blocking.
	 *
	 * @return `true` if the lock was acquired, `false` if it was already held.
	 */
	public function tryLock():Bool
		return SDLMutexNative.tryLockMutex(ptr);

	/**
	 * Releases the mutex.
	 *
	 * Must be called by the same thread that acquired it with `lock()` or a
	 * successful `tryLock()`.
	 */
	public function unlock():Void
		SDLMutexNative.unlockMutex(ptr);

	/**
	 * Destroys the mutex and releases its resources.
	 *
	 * Safe to call multiple times; the instance becomes unusable afterwards.
	 * The mutex must not be held by any thread at the time of destruction.
	 */
	public function destroy():Void {
		if (ptr != null)
			SDLMutexNative.destroyMutex(ptr);
		ptr = null;
	}

	@:allow(hl.bindings.sdl3)
	function raw():SDLMutexPtr
		return ptr;
}

/**
 * A reader-writer lock.
 *
 * Multiple threads may hold the lock simultaneously for reading, but a
 * writer holds it exclusively. Useful when reads are much more frequent than
 * writes.
 *
 * Corresponds to `SDL_RWLock` in SDL3.
 */
class SDLRWLock {
	var ptr:SDLRWLockPtr;

	/** Creates a new unlocked reader-writer lock. */
	public function new()
		ptr = SDLMutexNative.createRWLock();

	/**
	 * Acquires the lock for reading, blocking until it becomes available.
	 *
	 * Multiple readers may hold the lock at the same time, but writers are
	 * blocked. Must be paired with a matching call to `unlock()`.
	 */
	public function lockForReading():Void
		SDLMutexNative.lockRWLockForReading(ptr);

	/**
	 * Acquires the lock for writing, blocking until it becomes available.
	 *
	 * A writer holds the lock exclusively: no readers or other writers may
	 * hold it concurrently. Must be paired with a matching call to `unlock()`.
	 */
	public function lockForWriting():Void
		SDLMutexNative.lockRWLockForWriting(ptr);

	/**
	 * Attempts to acquire the lock for reading without blocking.
	 *
	 * @return `true` if the lock was acquired, `false` otherwise.
	 */
	public function tryLockForReading():Bool
		return SDLMutexNative.tryLockRWLockForReading(ptr);

	/**
	 * Attempts to acquire the lock for writing without blocking.
	 *
	 * @return `true` if the lock was acquired, `false` otherwise.
	 */
	public function tryLockForWriting():Bool
		return SDLMutexNative.tryLockRWLockForWriting(ptr);

	/**
	 * Releases the lock, whether it was acquired for reading or for writing.
	 */
	public function unlock():Void
		SDLMutexNative.unlockRWLock(ptr);

	/**
	 * Destroys the lock and releases its resources.
	 *
	 * Safe to call multiple times; the instance becomes unusable afterwards.
	 * The lock must not be held by any thread at the time of destruction.
	 */
	public function destroy():Void {
		if (ptr != null)
			SDLMutexNative.destroyRWLock(ptr);
		ptr = null;
	}
}

/**
 * A counting semaphore.
 *
 * Holds a non-negative integer value. `wait()` decrements it (blocking if it
 * is zero), `signal()` increments it. Useful for producer/consumer queues and
 * for limiting the number of threads that can access a resource.
 *
 * Corresponds to `SDL_Semaphore` in SDL3.
 */
class SDLSemaphore {
	var ptr:SDLSemaphorePtr;

	/**
	 * Creates a new semaphore with the given initial value.
	 *
	 * @param initialValue The starting count; must be non-negative.
	 */
	public function new(initialValue:Int = 0)
		ptr = SDLMutexNative.createSemaphore(initialValue);

	/**
	 * Decrements the semaphore value, blocking if it would become negative.
	 */
	public function wait():Void
		SDLMutexNative.waitSemaphore(ptr);

	/**
	 * Attempts to decrement the semaphore value without blocking.
	 *
	 * @return `true` if the value was successfully decremented, `false` if
	 *         the semaphore was zero.
	 */
	public function tryWait():Bool
		return SDLMutexNative.tryWaitSemaphore(ptr);

	/**
	 * Decrements the semaphore value, waiting up to `timeoutMs` milliseconds.
	 *
	 * @param timeoutMs Maximum wait time, in milliseconds.
	 * @return `true` if the value was decremented, `false` if the timeout
	 *         expired first.
	 */
	public function waitTimeout(timeoutMs:Int):Bool
		return SDLMutexNative.waitSemaphoreTimeout(ptr, timeoutMs);

	/**
	 * Increments the semaphore value, waking one waiting thread if any.
	 */
	public function signal():Void
		SDLMutexNative.signalSemaphore(ptr);

	/** The current semaphore value. */
	public var value(get, never):Int;

	inline function get_value()
		return SDLMutexNative.getSemaphoreValue(ptr);

	/**
	 * Destroys the semaphore and releases its resources.
	 *
	 * Safe to call multiple times; the instance becomes unusable afterwards.
	 * No thread must be waiting on the semaphore at the time of destruction.
	 */
	public function destroy():Void {
		if (ptr != null)
			SDLMutexNative.destroySemaphore(ptr);
		ptr = null;
	}
}

/**
 * A condition variable.
 *
 * Used together with a `SDLMutex` to let threads wait for a condition to
 * become true without busy-looping. The typical pattern is:
 *
 * ```
 * mutex.lock();
 * while (!condition) cond.wait(mutex);
 * // ... consume the condition ...
 * mutex.unlock();
 * ```
 *
 * Corresponds to `SDL_Condition` in SDL3.
 */
class SDLCondition {
	var ptr:SDLConditionPtr;

	/** Creates a new condition variable. */
	public function new()
		ptr = SDLMutexNative.createCondition();

	/**
	 * Wakes up one thread waiting on this condition variable.
	 *
	 * If no thread is waiting, this is a no-op.
	 */
	public function signal():Void
		SDLMutexNative.signalCondition(ptr);

	/**
	 * Wakes up every thread currently waiting on this condition variable.
	 */
	public function broadcast():Void
		SDLMutexNative.broadcastCondition(ptr);

	/**
	 * Atomically releases `mutex` and waits until the condition is signaled.
	 *
	 * The calling thread must hold `mutex` before calling this. When the
	 * function returns, `mutex` is re-acquired.
	 *
	 * @param mutex The mutex associated with the condition.
	 */
	public function wait(mutex:SDLMutex):Void
		SDLMutexNative.waitCondition(ptr, @:privateAccess mutex.raw());

	/**
	 * Like `wait()`, but gives up after `timeoutMs` milliseconds.
	 *
	 * @param mutex     The mutex associated with the condition.
	 * @param timeoutMs Maximum wait time, in milliseconds.
	 * @return `true` if the condition was signaled, `false` on timeout.
	 */
	public function waitTimeout(mutex:SDLMutex, timeoutMs:Int):Bool
		return SDLMutexNative.waitConditionTimeout(ptr, @:privateAccess mutex.raw(), timeoutMs);

	/**
	 * Destroys the condition variable and releases its resources.
	 *
	 * Safe to call multiple times; the instance becomes unusable afterwards.
	 * No thread must be waiting on it at the time of destruction.
	 */
	public function destroy():Void {
		if (ptr != null)
			SDLMutexNative.destroyCondition(ptr);
		ptr = null;
	}
}

/**
 * Thread-safe one-time initialization / shutdown.
 *
 * Coordinates "initialize once, on first use" logic across multiple threads
 * without requiring the caller to own a mutex. `shouldInit()` returns `true`
 * to exactly one caller, who then performs the initialization and reports
 * the result with `setInitialized()`. Any other thread that calls
 * `shouldInit()` meanwhile will block until the initialization is complete.
 *
 * Typical usage:
 *
 * ```
 * static var init = new SDLInitState();
 *
 * function initSystem():Bool {
 *     if (!init.shouldInit()) return true;
 *     var ok = doInitTasks();
 *     init.setInitialized(ok);
 *     return ok;
 * }
 * ```
 *
 * Corresponds to `SDL_InitState` in SDL3.
 */
class SDLInitState {
	var ptr:SDLInitStatePtr;

	/** Creates a new init state, initially `UNINITIALIZED`. */
	public function new()
		ptr = SDLMutexNative.initStateAlloc();

	/**
	 * Claims the responsibility to perform the initialization.
	 *
	 * @return `true` if the calling thread should now run the initialization
	 *         tasks and then call `setInitialized()`. `false` if another
	 *         thread is doing so (in which case this call blocks until that
	 *         initialization finishes) or if it is already initialized.
	 */
	public function shouldInit():Bool
		return SDLMutexNative.shouldInit(ptr);

	/**
	 * Claims the responsibility to perform the shutdown.
	 *
	 * @return `true` if the calling thread should now tear down the resource
	 *         and then call `setInitialized(false)`.
	 */
	public function shouldQuit():Bool
		return SDLMutexNative.shouldQuit(ptr);

	/**
	 * Reports the outcome of the initialization or shutdown.
	 *
	 * @param initialized Pass `true` after successful initialization, `false`
	 *                    after shutdown (or after a failed initialization).
	 */
	public function setInitialized(initialized:Bool):Void
		SDLMutexNative.setInitialized(ptr, initialized);

	/** The current lifecycle status of this init state. */
	public var status(get, never):SDLInitStatus;

	inline function get_status():SDLInitStatus
		return SDLMutexNative.getInitStatus(ptr);
}
