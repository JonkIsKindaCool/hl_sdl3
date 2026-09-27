package hl.bindings.sdl3;

@:noDoc typedef SDLHidDevicePtr = hl.Abstract<"SDL_hid_device">;
@:noDoc typedef SDLHidDeviceInfoListPtr = hl.Abstract<"SDL_HidDeviceInfoList">;

/**
 * The bus a HID device is connected through.
 * Corresponds to `SDL_hid_bus_type` in SDL3.
 */
enum abstract SDLHidBusType(Int) from Int to Int {
	/** Unknown or unrecognized bus type. */
	var UNKNOWN = 0;

	/** USB bus. */
	var USB = 1;

	/** Bluetooth bus. */
	var BLUETOOTH = 2;

	/** I²C bus. */
	var I2C = 3;

	/** SPI bus. */
	var SPI = 4;
}

/**
 * Metadata about a HID device returned by `SDLHid.enumerate()`.
 *
 * All string fields may be `null` when the platform does not expose the
 * corresponding information.
 */
typedef SDLHidDeviceInfo = {
	/** Platform-specific path that can be passed to `SDLHidDevice.openPath()`. */
	path:Null<String>,

	/** USB vendor ID. */
	vendorId:Int,

	/** USB product ID. */
	productId:Int,

	/** Device serial number. */
	serialNumber:Null<String>,

	/** Device release (BCD) number. */
	releaseNumber:Int,

	/** Manufacturer name. */
	manufacturerString:Null<String>,

	/** Product name. */
	productString:Null<String>,

	/** HID usage page (USB spec). */
	usagePage:Int,

	/** HID usage within the usage page. */
	usage:Int,

	/** USB interface number. */
	interfaceNumber:Int,

	/** USB interface class. */
	interfaceClass:Int,

	/** USB interface subclass. */
	interfaceSubclass:Int,

	/** USB interface protocol. */
	interfaceProtocol:Int,

	/** Bus the device is connected through. */
	busType:SDLHidBusType
}

@:noCompletion
class SDLHidNative {
	@:hlNative("sdl3", "hid_init") public static function init():Int
		return 0;

	@:hlNative("sdl3", "hid_exit") public static function exit():Int
		return 0;

	@:hlNative("sdl3", "hid_device_change_count") public static function changeCount():Int
		return 0;

	@:hlNative("sdl3", "hid_enumerate") public static function enumerate(vendorId:Int, productId:Int):SDLHidDeviceInfoListPtr
		return null;

	@:hlNative("sdl3", "hid_free_enumeration") public static function freeEnumeration(list:SDLHidDeviceInfoListPtr):Void {}

	@:hlNative("sdl3", "hid_device_info_next") public static function infoNext(info:SDLHidDeviceInfoListPtr):SDLHidDeviceInfoListPtr
		return null;

	@:hlNative("sdl3", "hid_device_info_path") public static function infoPath(info:SDLHidDeviceInfoListPtr):hl.Bytes
		return null;

	@:hlNative("sdl3", "hid_device_info_vendor_id") public static function infoVendorId(info:SDLHidDeviceInfoListPtr):Int
		return 0;

	@:hlNative("sdl3", "hid_device_info_product_id") public static function infoProductId(info:SDLHidDeviceInfoListPtr):Int
		return 0;

	@:hlNative("sdl3", "hid_device_info_serial_number") public static function infoSerialNumber(info:SDLHidDeviceInfoListPtr):hl.Bytes
		return null;

	@:hlNative("sdl3", "hid_device_info_release_number") public static function infoReleaseNumber(info:SDLHidDeviceInfoListPtr):Int
		return 0;

	@:hlNative("sdl3", "hid_device_info_manufacturer_string") public static function infoManufacturerString(info:SDLHidDeviceInfoListPtr):hl.Bytes
		return null;

	@:hlNative("sdl3", "hid_device_info_product_string") public static function infoProductString(info:SDLHidDeviceInfoListPtr):hl.Bytes
		return null;

	@:hlNative("sdl3", "hid_device_info_usage_page") public static function infoUsagePage(info:SDLHidDeviceInfoListPtr):Int
		return 0;

	@:hlNative("sdl3", "hid_device_info_usage") public static function infoUsage(info:SDLHidDeviceInfoListPtr):Int
		return 0;

	@:hlNative("sdl3", "hid_device_info_interface_number") public static function infoInterfaceNumber(info:SDLHidDeviceInfoListPtr):Int
		return 0;

	@:hlNative("sdl3", "hid_device_info_interface_class") public static function infoInterfaceClass(info:SDLHidDeviceInfoListPtr):Int
		return 0;

	@:hlNative("sdl3", "hid_device_info_interface_subclass") public static function infoInterfaceSubclass(info:SDLHidDeviceInfoListPtr):Int
		return 0;

	@:hlNative("sdl3", "hid_device_info_interface_protocol") public static function infoInterfaceProtocol(info:SDLHidDeviceInfoListPtr):Int
		return 0;

	@:hlNative("sdl3", "hid_device_info_bus_type") public static function infoBusType(info:SDLHidDeviceInfoListPtr):Int
		return 0;

	@:hlNative("sdl3", "hid_open") public static function open(vendorId:Int, productId:Int, serial:hl.Bytes):SDLHidDevicePtr
		return null;

	@:hlNative("sdl3", "hid_open_path") public static function openPath(path:hl.Bytes):SDLHidDevicePtr
		return null;

	@:hlNative("sdl3", "hid_write") public static function write(dev:SDLHidDevicePtr, data:hl.Bytes, length:Int):Int
		return 0;

	@:hlNative("sdl3", "hid_read_timeout") public static function readTimeout(dev:SDLHidDevicePtr, data:hl.Bytes, length:Int, ms:Int):Int
		return 0;

	@:hlNative("sdl3", "hid_read") public static function read(dev:SDLHidDevicePtr, data:hl.Bytes, length:Int):Int
		return 0;

	@:hlNative("sdl3", "hid_set_nonblocking") public static function setNonblocking(dev:SDLHidDevicePtr, nonblock:Int):Int
		return 0;

	@:hlNative("sdl3", "hid_send_feature_report") public static function sendFeatureReport(dev:SDLHidDevicePtr, data:hl.Bytes, length:Int):Int
		return 0;

	@:hlNative("sdl3", "hid_get_feature_report") public static function getFeatureReport(dev:SDLHidDevicePtr, data:hl.Bytes, length:Int):Int
		return 0;

	@:hlNative("sdl3", "hid_get_input_report") public static function getInputReport(dev:SDLHidDevicePtr, data:hl.Bytes, length:Int):Int
		return 0;

	@:hlNative("sdl3", "hid_close") public static function close(dev:SDLHidDevicePtr):Int
		return 0;

	@:hlNative("sdl3", "hid_get_manufacturer_string") public static function getManufacturerString(dev:SDLHidDevicePtr, maxlen:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "hid_get_product_string") public static function getProductString(dev:SDLHidDevicePtr, maxlen:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "hid_get_serial_number_string") public static function getSerialNumberString(dev:SDLHidDevicePtr, maxlen:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "hid_get_indexed_string") public static function getIndexedString(dev:SDLHidDevicePtr, index:Int, maxlen:Int):hl.Bytes
		return null;

	@:hlNative("sdl3", "hid_get_device_info") public static function getDeviceInfo(dev:SDLHidDevicePtr):SDLHidDeviceInfoListPtr
		return null;

	@:hlNative("sdl3", "hid_get_report_descriptor") public static function getReportDescriptor(dev:SDLHidDevicePtr, buf:hl.Bytes, bufSize:Int):Int
		return 0;

	@:hlNative("sdl3", "hid_ble_scan") public static function bleScan(active:Bool):Void {}
}

/**
 * Static HID API: initialization, device enumeration, and BLE scanning.
 *
 * This is a low-level interface to USB/Bluetooth HID devices. Use it only
 * if you need raw access; for gamepads and joysticks use the corresponding
 * SDL subsystems instead.
 *
 * Corresponds to the SDL3 HIDAPI interface.
 */
class SDLHid {
	static inline function str(b:hl.Bytes):Null<String>
		@:privateAccess return b == null ? null : String.fromUTF8(b);

	/**
	 * Initializes the HIDAPI library.
	 *
	 * This is called automatically when needed, but may be called explicitly
	 * to check for errors. It is safe to call multiple times; each successful
	 * call must be balanced by a call to `exit()`.
	 *
	 * @return 0 on success, -1 on failure.
	 */
	public static function init():Int
		return SDLHidNative.init();

	/**
	 * Finalizes the HIDAPI library.
	 *
	 * Should be called once for every call to `init()`. If `init()` was
	 * called implicitly, this is handled automatically.
	 *
	 * @return 0 on success, -1 on failure.
	 */
	public static function exit():Int
		return SDLHidNative.exit();

	/**
	 * Returns a counter that increments each time a HID device is added or
	 * removed from the system.
	 *
	 * Poll this value to know when to re-enumerate devices.
	 *
	 * @return The current device change counter.
	 */
	public static function deviceChangeCount():Int
		return SDLHidNative.changeCount();

	@:allow(hl.bindings.sdl3)
	static function readInfo(p:SDLHidDeviceInfoListPtr):SDLHidDeviceInfo {
		return {
			path: str(SDLHidNative.infoPath(p)),
			vendorId: SDLHidNative.infoVendorId(p),
			productId: SDLHidNative.infoProductId(p),
			serialNumber: str(SDLHidNative.infoSerialNumber(p)),
			releaseNumber: SDLHidNative.infoReleaseNumber(p),
			manufacturerString: str(SDLHidNative.infoManufacturerString(p)),
			productString: str(SDLHidNative.infoProductString(p)),
			usagePage: SDLHidNative.infoUsagePage(p),
			usage: SDLHidNative.infoUsage(p),
			interfaceNumber: SDLHidNative.infoInterfaceNumber(p),
			interfaceClass: SDLHidNative.infoInterfaceClass(p),
			interfaceSubclass: SDLHidNative.infoInterfaceSubclass(p),
			interfaceProtocol: SDLHidNative.infoInterfaceProtocol(p),
			busType: SDLHidNative.infoBusType(p)
		};
	}

	/**
	 * Enumerates connected HID devices.
	 *
	 * @param vendorId  Optional vendor ID to filter by. Use 0 for any.
	 * @param productId Optional product ID to filter by. Use 0 for any.
	 * @return An array of `SDLHidDeviceInfo` entries for matching devices.
	 */
	public static function enumerate(vendorId:Int = 0, productId:Int = 0):Array<SDLHidDeviceInfo> {
		var list = SDLHidNative.enumerate(vendorId, productId);
		var r = [];
		var p = list;
		while (p != null) {
			r.push(readInfo(p));
			p = SDLHidNative.infoNext(p);
		}
		if (list != null)
			SDLHidNative.freeEnumeration(list);
		return r;
	}

	/**
	 * Starts or stops a Bluetooth LE scan for HID devices.
	 *
	 * @param active `true` to start scanning, `false` to stop.
	 */
	public static function bleScan(active:Bool):Void
		SDLHidNative.bleScan(active);
}

/**
 * An open handle to a raw HID device.
 *
 * Provides read/write access and control-transfer helpers. Remember to
 * `close()` the handle when done.
 */
class SDLHidDevice {
	var ptr:SDLHidDevicePtr;

	function new(ptr:SDLHidDevicePtr)
		this.ptr = ptr;

	/**
	 * Opens a HID device by vendor/product ID.
	 *
	 * @param vendorId     The USB vendor ID.
	 * @param productId    The USB product ID.
	 * @param serialNumber Optional serial number to disambiguate between
	 *                     multiple identical devices.
	 * @return A new device handle, or `null` on failure.
	 */
	public static function open(vendorId:Int, productId:Int, ?serialNumber:String):Null<SDLHidDevice> {
		@:privateAccess var p = SDLHidNative.open(vendorId, productId, serialNumber == null ? null : serialNumber.toUtf8());
		return p == null ? null : new SDLHidDevice(p);
	}

	/**
	 * Opens a HID device by its platform-specific path.
	 *
	 * The path is the value returned in `SDLHidDeviceInfo.path`.
	 *
	 * @param path The device path.
	 * @return A new device handle, or `null` on failure.
	 */
	public static function openPath(path:String):Null<SDLHidDevice> {
		@:privateAccess var p = SDLHidNative.openPath(path.toUtf8());
		return p == null ? null : new SDLHidDevice(p);
	}

	/**
	 * Writes an Output report to the device.
	 *
	 * The first byte of `data` must be the report number (0 for devices
	 * that do not use numbered reports).
	 *
	 * @param data The report data.
	 * @return The number of bytes written, or -1 on failure.
	 */
	public function write(data:haxe.io.Bytes):Int
		return SDLHidNative.write(ptr, hl.Bytes.fromBytes(data), data.length);

	/**
	 * Reads an Input report from the device, waiting up to `timeoutMs`.
	 *
	 * @param maxLength Maximum number of bytes to read.
	 * @param timeoutMs Timeout in milliseconds. 0 returns immediately; negative
	 *                  waits indefinitely.
	 * @return The bytes read, or `null` on failure.
	 */
	public function readTimeout(maxLength:Int, timeoutMs:Int):Null<haxe.io.Bytes> {
		var buf = haxe.io.Bytes.alloc(maxLength);
		var n = SDLHidNative.readTimeout(ptr, hl.Bytes.fromBytes(buf), maxLength, timeoutMs);
		if (n < 0)
			return null;
		return buf.sub(0, n);
	}

	/**
	 * Reads an Input report from the device.
	 *
	 * Blocking behavior depends on `setNonblocking()`.
	 *
	 * @param maxLength Maximum number of bytes to read.
	 * @return The bytes read, or `null` on failure.
	 */
	public function read(maxLength:Int):Null<haxe.io.Bytes> {
		var buf = haxe.io.Bytes.alloc(maxLength);
		var n = SDLHidNative.read(ptr, hl.Bytes.fromBytes(buf), maxLength);
		if (n < 0)
			return null;
		return buf.sub(0, n);
	}

	/**
	 * Sets whether reads on this device are non-blocking.
	 *
	 * @param nonblock `true` to make reads non-blocking.
	 * @return `true` on success.
	 */
	public function setNonblocking(nonblock:Bool):Bool
		return SDLHidNative.setNonblocking(ptr, nonblock ? 1 : 0) == 0;

	/**
	 * Sends a Feature report to the device.
	 *
	 * @param data The report data. The first byte is the report number.
	 * @return The number of bytes written, or -1 on failure.
	 */
	public function sendFeatureReport(data:haxe.io.Bytes):Int
		return SDLHidNative.sendFeatureReport(ptr, hl.Bytes.fromBytes(data), data.length);

	/**
	 * Retrieves a Feature report from the device.
	 *
	 * @param reportId  The report number to request.
	 * @param maxLength Maximum number of bytes to read.
	 * @return The report bytes, or `null` on failure.
	 */
	public function getFeatureReport(reportId:Int, maxLength:Int):Null<haxe.io.Bytes> {
		var buf = haxe.io.Bytes.alloc(maxLength);
		buf.set(0, reportId);
		var n = SDLHidNative.getFeatureReport(ptr, hl.Bytes.fromBytes(buf), maxLength);
		if (n < 0)
			return null;
		return buf.sub(0, n);
	}

	/**
	 * Retrieves an Input report without waiting for one to be produced.
	 *
	 * @param reportId  The report number to request.
	 * @param maxLength Maximum number of bytes to read.
	 * @return The report bytes, or `null` on failure.
	 */
	public function getInputReport(reportId:Int, maxLength:Int):Null<haxe.io.Bytes> {
		var buf = haxe.io.Bytes.alloc(maxLength);
		buf.set(0, reportId);
		var n = SDLHidNative.getInputReport(ptr, hl.Bytes.fromBytes(buf), maxLength);
		if (n < 0)
			return null;
		return buf.sub(0, n);
	}

	/**
	 * Returns the manufacturer name string, if the device exposes one.
	 *
	 * @param maxlen Maximum number of bytes to reserve for the string.
	 * @return The manufacturer string, or `null` on failure.
	 */
	public function getManufacturerString(maxlen:Int = 256):Null<String>
		@:privateAccess return String.fromUTF8(SDLHidNative.getManufacturerString(ptr, maxlen));

	/**
	 * Returns the product name string, if the device exposes one.
	 *
	 * @param maxlen Maximum number of bytes to reserve for the string.
	 * @return The product string, or `null` on failure.
	 */
	public function getProductString(maxlen:Int = 256):Null<String>
		@:privateAccess return String.fromUTF8(SDLHidNative.getProductString(ptr, maxlen));

	/**
	 * Returns the serial number string, if the device exposes one.
	 *
	 * @param maxlen Maximum number of bytes to reserve for the string.
	 * @return The serial number string, or `null` on failure.
	 */
	public function getSerialNumberString(maxlen:Int = 256):Null<String>
		@:privateAccess return String.fromUTF8(SDLHidNative.getSerialNumberString(ptr, maxlen));

	/**
	 * Returns an indexed string descriptor from the device.
	 *
	 * @param index  The string descriptor index.
	 * @param maxlen Maximum number of bytes to reserve for the string.
	 * @return The indexed string, or `null` on failure.
	 */
	public function getIndexedString(index:Int, maxlen:Int = 256):Null<String>
		@:privateAccess return String.fromUTF8(SDLHidNative.getIndexedString(ptr, index, maxlen));

	/**
	 * Returns the metadata for this device, matching the format used by
	 * `SDLHid.enumerate()`.
	 *
	 * @return The device information, or `null` on failure.
	 */
	public function getDeviceInfo():Null<SDLHidDeviceInfo> {
		var p = SDLHidNative.getDeviceInfo(ptr);
		return p == null ? null : SDLHid.readInfo(p);
	}

	/**
	 * Returns the HID report descriptor for this device.
	 *
	 * @param maxSize Maximum number of bytes to reserve for the descriptor.
	 * @return The descriptor bytes, or `null` on failure.
	 */
	public function getReportDescriptor(maxSize:Int = 4096):Null<haxe.io.Bytes> {
		var buf = haxe.io.Bytes.alloc(maxSize);
		var n = SDLHidNative.getReportDescriptor(ptr, hl.Bytes.fromBytes(buf), maxSize);
		if (n < 0)
			return null;
		return buf.sub(0, n);
	}

	/**
	 * Closes the device handle and releases its resources.
	 *
	 * Safe to call multiple times; the handle becomes unusable afterwards.
	 */
	public function close():Void {
		if (ptr != null)
			SDLHidNative.close(ptr);
		ptr = null;
	}
}
