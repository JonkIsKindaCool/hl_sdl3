package hl.bindings.sdl3;

typedef SDLTrayPtr = hl.Abstract<"SDL_Tray">;
typedef SDLTrayMenuPtr = hl.Abstract<"SDL_TrayMenu">;
typedef SDLTrayEntryPtr = hl.Abstract<"SDL_TrayEntry">;

/**
 * Flags controlling the behavior and appearance of a system tray entry.
 *
 * Corresponds to `SDL_TrayEntryFlags` in SDL3.
 */
enum abstract SDLTrayEntryFlags(Int) from Int to Int {
	/** Standard clickable menu item button. Corresponds to `SDL_TRAYENTRY_BUTTON`. */
	var BUTTON = 0x00000001;

	/** Toggleable checkbox menu item. Corresponds to `SDL_TRAYENTRY_CHECKBOX`. */
	var CHECKBOX = 0x00000002;

	/** Submenu container entry. Corresponds to `SDL_TRAYENTRY_SUBMENU`. */
	var SUBMENU = 0x00000004;

	/** Entry is disabled and non-interactive. Corresponds to `SDL_TRAYENTRY_DISABLED`. */
	var DISABLED = 0x80000000;

	/** Checkbox entry is currently checked. Corresponds to `SDL_TRAYENTRY_CHECKED`. */
	var CHECKED = 0x40000000;

	@:op(A | B) static function or(a:SDLTrayEntryFlags, b:SDLTrayEntryFlags):SDLTrayEntryFlags;

	/**
	 * Checks whether a specific tray entry flag is set.
	 *
	 * @param f The flag to test.
	 * @return `true` if the flag is present, `false` otherwise.
	 */
	public inline function has(f:SDLTrayEntryFlags):Bool
		return (this & f) != 0;
}

@:noCompletion
class SDLTrayNative {
	@:hlNative("sdl3", "create_tray") public static function create(icon:SDLSurfacePtr, tooltip:hl.Bytes):SDLTrayPtr
		return null;

	@:hlNative("sdl3", "set_tray_icon") public static function setIcon(tray:SDLTrayPtr, icon:SDLSurfacePtr):Void {}

	@:hlNative("sdl3", "set_tray_tooltip") public static function setTooltip(tray:SDLTrayPtr, tooltip:hl.Bytes):Void {}

	@:hlNative("sdl3", "destroy_tray") public static function destroyNative(tray:SDLTrayPtr):Void {}

	@:hlNative("sdl3", "update_trays") public static function update():Void {}

	@:hlNative("sdl3", "create_tray_menu") public static function createMenu(tray:SDLTrayPtr):SDLTrayMenuPtr
		return null;

	@:hlNative("sdl3", "create_tray_submenu") public static function createSubmenu(entry:SDLTrayEntryPtr):SDLTrayMenuPtr
		return null;

	@:hlNative("sdl3", "get_tray_menu") public static function getMenu(tray:SDLTrayPtr):SDLTrayMenuPtr
		return null;

	@:hlNative("sdl3", "get_tray_submenu") public static function getSubmenu(entry:SDLTrayEntryPtr):SDLTrayMenuPtr
		return null;

	@:hlNative("sdl3", "get_tray_menu_parent_tray") public static function menuParentTray(menu:SDLTrayMenuPtr):SDLTrayPtr
		return null;

	@:hlNative("sdl3", "get_tray_menu_parent_entry") public static function menuParentEntry(menu:SDLTrayMenuPtr):SDLTrayEntryPtr
		return null;

	@:hlNative("sdl3", "get_tray_entry_parent") public static function entryParent(entry:SDLTrayEntryPtr):SDLTrayMenuPtr
		return null;

	@:hlNative("sdl3", "get_tray_entries_count") public static function entriesCount(menu:SDLTrayMenuPtr):Int
		return 0;

	@:hlNative("sdl3", "get_tray_entry_at") public static function entryAt(menu:SDLTrayMenuPtr, index:Int):SDLTrayEntryPtr
		return null;

	@:hlNative("sdl3", "insert_tray_entry_at") public static function insert(menu:SDLTrayMenuPtr, pos:Int, label:hl.Bytes, flags:Int):SDLTrayEntryPtr
		return null;

	@:hlNative("sdl3", "remove_tray_entry") public static function remove(entry:SDLTrayEntryPtr):Void {}

	@:hlNative("sdl3", "set_tray_entry_label") public static function setLabel(entry:SDLTrayEntryPtr, label:hl.Bytes):Void {}

	@:hlNative("sdl3", "get_tray_entry_label") public static function getLabel(entry:SDLTrayEntryPtr):hl.Bytes
		return null;

	@:hlNative("sdl3", "set_tray_entry_checked") public static function setChecked(entry:SDLTrayEntryPtr, checked:Bool):Void {}

	@:hlNative("sdl3", "get_tray_entry_checked") public static function getChecked(entry:SDLTrayEntryPtr):Bool
		return false;

	@:hlNative("sdl3", "set_tray_entry_enabled") public static function setEnabled(entry:SDLTrayEntryPtr, enabled:Bool):Void {}

	@:hlNative("sdl3", "get_tray_entry_enabled") public static function getEnabled(entry:SDLTrayEntryPtr):Bool
		return false;

	@:hlNative("sdl3", "click_tray_entry") public static function click(entry:SDLTrayEntryPtr):Void {}

	@:hlNative("sdl3", "set_tray_entry_callback") public static function setCallback(entry:SDLTrayEntryPtr, id:Int):Void {}

	@:hlNative("sdl3", "clear_tray_entry_callback") public static function clearCallback(entry:SDLTrayEntryPtr):Void {}

	@:hlNative("sdl3", "tray_poll") public static function poll():Int
		return -1;
}

/**
 * System tray icon management.
 *
 * High-level Haxe wrapper representing a system tray icon in SDL3.
 * Corresponds to `SDL_Tray` in SDL3.
 */
class SDLTray {
	var ptr:SDLTrayPtr;

	@:allow(hl.bindings.sdl3)
	static var callbacks:Map<Int, Void->Void> = new Map();

	@:allow(hl.bindings.sdl3)
	static var nextId = 1;

	function new(ptr:SDLTrayPtr)
		this.ptr = ptr;

	/**
	 * Creates a new system tray icon with an optional icon image and tooltip.
	 *
	 * Corresponds to `SDL_CreateTray` in SDL3.
	 *
	 * @param icon    Optional surface containing the icon image.
	 * @param tooltip Optional tooltip text displayed when hovering over the tray icon.
	 * @return A new `SDLTray` instance, or `null` on failure.
	 */
	public static function create(?icon:SDLSurface, ?tooltip:String):Null<SDLTray> {
		@:privateAccess
		var p = SDLTrayNative.create(icon == null ? null : icon.ptr, tooltip == null ? null : tooltip.toUtf8());
		return p == null ? null : new SDLTray(p);
	}

	/**
	 * Updates the icon image for this system tray item.
	 *
	 * Corresponds to `SDL_SetTrayIcon` in SDL3.
	 *
	 * @param icon Optional surface containing the new icon image.
	 */
	public function setIcon(?icon:SDLSurface):Void
		SDLTrayNative.setIcon(ptr, icon == null ? null : @:privateAccess icon.ptr);

	/**
	 * Sets or updates the tooltip text for this system tray item.
	 *
	 * Corresponds to `SDL_SetTrayTooltip` in SDL3.
	 *
	 * @param tooltip Optional text to display as a tooltip.
	 */
	public function setTooltip(?tooltip:String):Void
		@:privateAccess SDLTrayNative.setTooltip(ptr, tooltip == null ? null : tooltip.toUtf8());

	/**
	 * Destroys this tray icon and all associated menus and entries.
	 *
	 * Corresponds to `SDL_DestroyTray` in SDL3.
	 */
	public function destroy():Void {
		if (ptr != null)
			SDLTrayNative.destroyNative(ptr);
		ptr = null;
	}

	/**
	 * Creates a popup menu associated with this system tray icon.
	 *
	 * Corresponds to `SDL_CreateTrayMenu` in SDL3.
	 *
	 * @return A new `SDLTrayMenu` instance.
	 */
	public function createMenu():SDLTrayMenu
		return new SDLTrayMenu(SDLTrayNative.createMenu(ptr));

	/**
	 * Gets the popup menu associated with this system tray icon.
	 *
	 * Corresponds to `SDL_GetTrayMenu` in SDL3.
	 *
	 * @return The existing `SDLTrayMenu`, or `null` if no menu exists.
	 */
	public function getMenu():Null<SDLTrayMenu> {
		var p = SDLTrayNative.getMenu(ptr);
		return p == null ? null : new SDLTrayMenu(p);
	}

	/**
	 * Forces an update to all active system tray icons and menus.
	 *
	 * Corresponds to `SDL_UpdateTrays` in SDL3.
	 */
	public static function update():Void
		SDLTrayNative.update();

	/**
	 * Polls pending tray entry callbacks and executes them on the calling thread.
	 *
	 * @return The number of tray callbacks processed during this call.
	 */
	public static function poll():Int {
		var n = 0;
		while (true) {
			var id = SDLTrayNative.poll();
			if (id < 0)
				break;
			var cb = callbacks.get(id);
			callbacks.remove(id);
			if (cb != null)
				cb();
			n++;
		}
		return n;
	}
}

/**
 * Represents a menu or submenu attached to a system tray icon or tray entry.
 *
 * Corresponds to `SDL_TrayMenu` in SDL3.
 */
class SDLTrayMenu {
	var ptr:SDLTrayMenuPtr;

	@:allow(hl.bindings.sdl3)
	function new(ptr:SDLTrayMenuPtr)
		this.ptr = ptr;

	/**
	 * Creates a submenu attached to a specific tray entry.
	 *
	 * Corresponds to `SDL_CreateTraySubmenu` in SDL3.
	 *
	 * @param entry The parent tray entry that will open this submenu.
	 * @return A new `SDLTrayMenu` instance, or `null` on failure.
	 */
	public function createSubmenu(entry:SDLTrayEntry):Null<SDLTrayMenu> {
		var p = SDLTrayNative.createSubmenu(@:privateAccess entry.ptr);
		return p == null ? null : new SDLTrayMenu(p);
	}

	/**
	 * Gets the submenu associated with a specific tray entry.
	 *
	 * Corresponds to `SDL_GetTraySubmenu` in SDL3.
	 *
	 * @param entry The tray entry.
	 * @return The `SDLTrayMenu` attached to the entry, or `null` if none exists.
	 */
	public function getSubmenu(entry:SDLTrayEntry):Null<SDLTrayMenu> {
		var p = SDLTrayNative.getSubmenu(@:privateAccess entry.ptr);
		return p == null ? null : new SDLTrayMenu(p);
	}

	/**
	 * Gets the parent system tray icon containing this menu.
	 *
	 * Corresponds to `SDL_GetTrayMenuParentTray` in SDL3.
	 *
	 * @return The parent `SDLTray`, or `null` if this is a submenu.
	 */
	public function getParentTray():Null<SDLTray> {
		var p = SDLTrayNative.menuParentTray(ptr);
		return p == null ? null : @:privateAccess new SDLTray(p);
	}

	/**
	 * Gets the parent tray entry containing this submenu.
	 *
	 * Corresponds to `SDL_GetTrayMenuParentEntry` in SDL3.
	 *
	 * @return The parent `SDLTrayEntry`, or `null` if this is a top-level tray menu.
	 */
	public function getParentEntry():Null<SDLTrayEntry> {
		var p = SDLTrayNative.menuParentEntry(ptr);
		return p == null ? null : @:privateAccess new SDLTrayEntry(p);
	}

	/**
	 * Gets the total number of entries in this menu.
	 *
	 * Corresponds to `SDL_GetTrayEntries` in SDL3.
	 *
	 * @return The entry count.
	 */
	public function getEntriesCount():Int
		return SDLTrayNative.entriesCount(ptr);

	/**
	 * Gets the tray entry at a specific zero-based index.
	 *
	 * Corresponds to `SDL_GetTrayEntries` in SDL3.
	 *
	 * @param index Zero-based index of the entry.
	 * @return The `SDLTrayEntry` at the specified position, or `null` if out of bounds.
	 */
	public function getEntryAt(index:Int):Null<SDLTrayEntry> {
		var p = SDLTrayNative.entryAt(ptr, index);
		return p == null ? null : @:privateAccess new SDLTrayEntry(p);
	}

	/**
	 * Gets an array containing all entries in this menu.
	 *
	 * Corresponds to `SDL_GetTrayEntries` in SDL3.
	 *
	 * @return An array of `SDLTrayEntry` items.
	 */
	public function getEntries():Array<SDLTrayEntry> {
		var n = getEntriesCount();
		var r = [];
		for (i in 0...n) {
			var e = getEntryAt(i);
			if (e != null)
				r.push(e);
		}
		return r;
	}

	/**
	 * Inserts a new entry into the menu at the specified position.
	 *
	 * Corresponds to `SDL_InsertTrayEntryAt` in SDL3.
	 *
	 * @param pos   Zero-based position to insert the entry, or `-1` to append at the end.
	 * @param label Text label for the entry, or `null` to create a separator.
	 * @param flags Entry type and status flags (default: `BUTTON`).
	 * @return The newly created `SDLTrayEntry`, or `null` on failure.
	 */
	public function insert(pos:Int, ?label:String, flags:SDLTrayEntryFlags = BUTTON):Null<SDLTrayEntry> {
		@:privateAccess
		var p = SDLTrayNative.insert(ptr, pos, label == null ? null : label.toUtf8(), flags);
		return p == null ? null : @:privateAccess new SDLTrayEntry(p);
	}

	/**
	 * Appends a new entry to the end of the menu.
	 *
	 * Corresponds to `SDL_InsertTrayEntryAt` in SDL3.
	 *
	 * @param label Text label for the entry.
	 * @param flags Entry type and status flags (default: `BUTTON`).
	 * @return The newly created `SDLTrayEntry`, or `null` on failure.
	 */
	public inline function append(?label:String, flags:SDLTrayEntryFlags = BUTTON):Null<SDLTrayEntry>
		return insert(-1, label, flags);

	/**
	 * Adds a horizontal separator line to the end of the menu.
	 *
	 * Corresponds to `SDL_InsertTrayEntryAt` with a `null` label in SDL3.
	 *
	 * @return The newly created separator `SDLTrayEntry`, or `null` on failure.
	 */
	public inline function addSeparator():Null<SDLTrayEntry>
		return insert(-1, null, BUTTON);
}

/**
 * Represents an individual item, button, checkbox, or separator within a system tray menu.
 *
 * Corresponds to `SDL_TrayEntry` in SDL3.
 */
class SDLTrayEntry {
	var ptr:SDLTrayEntryPtr;

	@:allow(hl.bindings.sdl3)
	function new(ptr:SDLTrayEntryPtr)
		this.ptr = ptr;

	/**
	 * Removes this entry from its parent menu and destroys it.
	 *
	 * Corresponds to `SDL_RemoveTrayEntry` in SDL3.
	 */
	public function remove():Void
		SDLTrayNative.remove(ptr);

	/**
	 * Sets the text label for this entry.
	 *
	 * Corresponds to `SDL_SetTrayEntryLabel` in SDL3.
	 *
	 * @param label The new text label to display.
	 */
	public function setLabel(label:String):Void
		@:privateAccess SDLTrayNative.setLabel(ptr, label.toUtf8());

	/**
	 * Gets the current text label of this entry.
	 *
	 * Corresponds to `SDL_GetTrayEntryLabel` in SDL3.
	 *
	 * @return The current label, or `null` if this entry is a separator.
	 */
	public function getLabel():Null<String> {
		var b = SDLTrayNative.getLabel(ptr);
		@:privateAccess
		return b == null ? null : String.fromUTF8(b);
	}

	/**
	 * Checks whether this entry is a menu separator line.
	 *
	 * @return `true` if the entry is a separator, `false` otherwise.
	 */
	public inline function isSeparator():Bool
		return getLabel() == null;

	/**
	 * Sets whether a checkbox entry is checked.
	 *
	 * Corresponds to `SDL_SetTrayEntryChecked` in SDL3.
	 *
	 * @param checked `true` to check the item, `false` to uncheck it.
	 */
	public function setChecked(checked:Bool):Void
		SDLTrayNative.setChecked(ptr, checked);

	/**
	 * Gets whether a checkbox entry is currently checked.
	 *
	 * Corresponds to `SDL_GetTrayEntryChecked` in SDL3.
	 *
	 * @return `true` if checked, `false` otherwise.
	 */
	public function isChecked():Bool
		return SDLTrayNative.getChecked(ptr);

	/**
	 * Sets whether this entry is enabled and interactable.
	 *
	 * Corresponds to `SDL_SetTrayEntryEnabled` in SDL3.
	 *
	 * @param enabled `true` to enable the entry, `false` to disable it.
	 */
	public function setEnabled(enabled:Bool):Void
		SDLTrayNative.setEnabled(ptr, enabled);

	/**
	 * Gets whether this entry is currently enabled.
	 *
	 * Corresponds to `SDL_GetTrayEntryEnabled` in SDL3.
	 *
	 * @return `true` if enabled, `false` otherwise.
	 */
	public function isEnabled():Bool
		return SDLTrayNative.getEnabled(ptr);

	/**
	 * Programmatically simulates a user click action on this entry.
	 *
	 * Corresponds to `SDL_ClickTrayEntry` in SDL3.
	 */
	public function click():Void
		SDLTrayNative.click(ptr);

	/**
	 * Gets the parent menu containing this entry.
	 *
	 * Corresponds to `SDL_GetTrayEntryParent` in SDL3.
	 *
	 * @return The parent `SDLTrayMenu`, or `null` on failure.
	 */
	public function getParent():Null<SDLTrayMenu> {
		var p = SDLTrayNative.entryParent(ptr);
		return p == null ? null : @:privateAccess new SDLTrayMenu(p);
	}

	/**
	 * Registers a callback function to execute when this entry is clicked or toggled.
	 *
	 * Corresponds to `SDL_SetTrayEntryCallback` in SDL3.
	 *
	 * @param cb The callback function to execute.
	 */
	public function setCallback(cb:Void->Void):Void {
		var id = SDLTray.nextId++;
		SDLTray.callbacks.set(id, cb);
		SDLTrayNative.setCallback(ptr, id);
	}

	/**
	 * Removes any registered click callback from this entry.
	 */
	public function clearCallback():Void
		SDLTrayNative.clearCallback(ptr);
}
