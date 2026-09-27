#include "hashlink_macros.h"
#include "SDL3/SDL_hidapi.h"
#include <string.h>
#include <wchar.h>

static vbyte* copy_str(const char* s) {
	if (!s)
		return NULL;
	return hl_copy_bytes((const vbyte*)s, (int)strlen(s) + 1);
}

static vbyte* copy_wstr(const wchar_t* s) {
	if (!s)
		return NULL;
	char tmp[2048];
	int o = 0;
	for (int i = 0; s[i] && o < (int)sizeof(tmp) - 4; i++) {
		unsigned int cp = (unsigned int)s[i];
		if (cp < 0x80) {
			tmp[o++] = (char)cp;
		} else if (cp < 0x800) {
			tmp[o++] = (char)(0xC0 | (cp >> 6));
			tmp[o++] = (char)(0x80 | (cp & 0x3F));
		} else if (cp < 0x10000) {
			tmp[o++] = (char)(0xE0 | (cp >> 12));
			tmp[o++] = (char)(0x80 | ((cp >> 6) & 0x3F));
			tmp[o++] = (char)(0x80 | (cp & 0x3F));
		} else {
			tmp[o++] = (char)(0xF0 | (cp >> 18));
			tmp[o++] = (char)(0x80 | ((cp >> 12) & 0x3F));
			tmp[o++] = (char)(0x80 | ((cp >> 6) & 0x3F));
			tmp[o++] = (char)(0x80 | (cp & 0x3F));
		}
	}
	tmp[o] = 0;
	return hl_copy_bytes((const vbyte*)tmp, o + 1);
}

HL_PRIM int HL_NAME(hid_init)() { return SDL_hid_init(); }
DEFINE_PRIM(_I32, hid_init, _NO_ARG);

HL_PRIM int HL_NAME(hid_exit)() { return SDL_hid_exit(); }
DEFINE_PRIM(_I32, hid_exit, _NO_ARG);

HL_PRIM int HL_NAME(hid_device_change_count)() { return (int)SDL_hid_device_change_count(); }
DEFINE_PRIM(_I32, hid_device_change_count, _NO_ARG);

HL_PRIM SDL_hid_device_info* HL_NAME(hid_enumerate)(int vendorId, int productId) {
	return SDL_hid_enumerate((unsigned short)vendorId, (unsigned short)productId);
}
DEFINE_PRIM(_ABSTRACT(SDL_HidDeviceInfoList), hid_enumerate, _I32 _I32);

HL_PRIM void HL_NAME(hid_free_enumeration)(SDL_hid_device_info* list) { SDL_hid_free_enumeration(list); }
DEFINE_PRIM(_VOID, hid_free_enumeration, _ABSTRACT(SDL_HidDeviceInfoList));

HL_PRIM SDL_hid_device_info* HL_NAME(hid_device_info_next)(SDL_hid_device_info* info) { return info->next; }
DEFINE_PRIM(_ABSTRACT(SDL_HidDeviceInfoList), hid_device_info_next, _ABSTRACT(SDL_HidDeviceInfoList));

HL_PRIM vbyte* HL_NAME(hid_device_info_path)(SDL_hid_device_info* info) { return copy_str(info->path); }
DEFINE_PRIM(_BYTES, hid_device_info_path, _ABSTRACT(SDL_HidDeviceInfoList));

HL_PRIM int HL_NAME(hid_device_info_vendor_id)(SDL_hid_device_info* info) { return info->vendor_id; }
DEFINE_PRIM(_I32, hid_device_info_vendor_id, _ABSTRACT(SDL_HidDeviceInfoList));

HL_PRIM int HL_NAME(hid_device_info_product_id)(SDL_hid_device_info* info) { return info->product_id; }
DEFINE_PRIM(_I32, hid_device_info_product_id, _ABSTRACT(SDL_HidDeviceInfoList));

HL_PRIM vbyte* HL_NAME(hid_device_info_serial_number)(SDL_hid_device_info* info) { return copy_wstr(info->serial_number); }
DEFINE_PRIM(_BYTES, hid_device_info_serial_number, _ABSTRACT(SDL_HidDeviceInfoList));

HL_PRIM int HL_NAME(hid_device_info_release_number)(SDL_hid_device_info* info) { return info->release_number; }
DEFINE_PRIM(_I32, hid_device_info_release_number, _ABSTRACT(SDL_HidDeviceInfoList));

HL_PRIM vbyte* HL_NAME(hid_device_info_manufacturer_string)(SDL_hid_device_info* info) { return copy_wstr(info->manufacturer_string); }
DEFINE_PRIM(_BYTES, hid_device_info_manufacturer_string, _ABSTRACT(SDL_HidDeviceInfoList));

HL_PRIM vbyte* HL_NAME(hid_device_info_product_string)(SDL_hid_device_info* info) { return copy_wstr(info->product_string); }
DEFINE_PRIM(_BYTES, hid_device_info_product_string, _ABSTRACT(SDL_HidDeviceInfoList));

HL_PRIM int HL_NAME(hid_device_info_usage_page)(SDL_hid_device_info* info) { return info->usage_page; }
DEFINE_PRIM(_I32, hid_device_info_usage_page, _ABSTRACT(SDL_HidDeviceInfoList));

HL_PRIM int HL_NAME(hid_device_info_usage)(SDL_hid_device_info* info) { return info->usage; }
DEFINE_PRIM(_I32, hid_device_info_usage, _ABSTRACT(SDL_HidDeviceInfoList));

HL_PRIM int HL_NAME(hid_device_info_interface_number)(SDL_hid_device_info* info) { return info->interface_number; }
DEFINE_PRIM(_I32, hid_device_info_interface_number, _ABSTRACT(SDL_HidDeviceInfoList));

HL_PRIM int HL_NAME(hid_device_info_interface_class)(SDL_hid_device_info* info) { return info->interface_class; }
DEFINE_PRIM(_I32, hid_device_info_interface_class, _ABSTRACT(SDL_HidDeviceInfoList));

HL_PRIM int HL_NAME(hid_device_info_interface_subclass)(SDL_hid_device_info* info) { return info->interface_subclass; }
DEFINE_PRIM(_I32, hid_device_info_interface_subclass, _ABSTRACT(SDL_HidDeviceInfoList));

HL_PRIM int HL_NAME(hid_device_info_interface_protocol)(SDL_hid_device_info* info) { return info->interface_protocol; }
DEFINE_PRIM(_I32, hid_device_info_interface_protocol, _ABSTRACT(SDL_HidDeviceInfoList));

HL_PRIM int HL_NAME(hid_device_info_bus_type)(SDL_hid_device_info* info) { return (int)info->bus_type; }
DEFINE_PRIM(_I32, hid_device_info_bus_type, _ABSTRACT(SDL_HidDeviceInfoList));

static wchar_t* utf8_to_wchar(const char* s) {
	int len = (int)strlen(s);
	wchar_t* w = (wchar_t*)SDL_malloc(sizeof(wchar_t) * (len + 1));
	int wi = 0, i = 0;
	while (i < len) {
		unsigned char c = (unsigned char)s[i];
		unsigned int cp;
		int extra;
		if (c < 0x80) {
			cp = c;
			extra = 0;
		} else if ((c & 0xE0) == 0xC0) {
			cp = c & 0x1F;
			extra = 1;
		} else if ((c & 0xF0) == 0xE0) {
			cp = c & 0x0F;
			extra = 2;
		} else {
			cp = c & 0x07;
			extra = 3;
		}
		i++;
		for (int k = 0; k < extra && i < len; k++, i++)
			cp = (cp << 6) | ((unsigned char)s[i] & 0x3F);
		w[wi++] = (wchar_t)cp;
	}
	w[wi] = 0;
	return w;
}

HL_PRIM SDL_hid_device* HL_NAME(hid_open)(int vendorId, int productId, vbyte* serialUtf8) {
	if (!serialUtf8)
		return SDL_hid_open((unsigned short)vendorId, (unsigned short)productId, NULL);
	wchar_t* w = utf8_to_wchar((const char*)serialUtf8);
	SDL_hid_device* d = SDL_hid_open((unsigned short)vendorId, (unsigned short)productId, w);
	SDL_free(w);
	return d;
}
DEFINE_PRIM(_ABSTRACT(SDL_hid_device), hid_open, _I32 _I32 _BYTES);

HL_PRIM SDL_hid_device* HL_NAME(hid_open_path)(vbyte* path) { return SDL_hid_open_path((const char*)path); }
DEFINE_PRIM(_ABSTRACT(SDL_hid_device), hid_open_path, _BYTES);

HL_PRIM int HL_NAME(hid_write)(SDL_hid_device* dev, vbyte* data, int length) {
	return SDL_hid_write(dev, (const unsigned char*)data, (size_t)length);
}
DEFINE_PRIM(_I32, hid_write, _ABSTRACT(SDL_hid_device) _BYTES _I32);

HL_PRIM int HL_NAME(hid_read_timeout)(SDL_hid_device* dev, vbyte* data, int length, int ms) {
	hl_blocking(true);
	int r = SDL_hid_read_timeout(dev, (unsigned char*)data, (size_t)length, ms);
	hl_blocking(false);
	return r;
}
DEFINE_PRIM(_I32, hid_read_timeout, _ABSTRACT(SDL_hid_device) _BYTES _I32 _I32);

HL_PRIM int HL_NAME(hid_read)(SDL_hid_device* dev, vbyte* data, int length) {
	return SDL_hid_read(dev, (unsigned char*)data, (size_t)length);
}
DEFINE_PRIM(_I32, hid_read, _ABSTRACT(SDL_hid_device) _BYTES _I32);

HL_PRIM int HL_NAME(hid_set_nonblocking)(SDL_hid_device* dev, int nonblock) { return SDL_hid_set_nonblocking(dev, nonblock); }
DEFINE_PRIM(_I32, hid_set_nonblocking, _ABSTRACT(SDL_hid_device) _I32);

HL_PRIM int HL_NAME(hid_send_feature_report)(SDL_hid_device* dev, vbyte* data, int length) {
	return SDL_hid_send_feature_report(dev, (const unsigned char*)data, (size_t)length);
}
DEFINE_PRIM(_I32, hid_send_feature_report, _ABSTRACT(SDL_hid_device) _BYTES _I32);

HL_PRIM int HL_NAME(hid_get_feature_report)(SDL_hid_device* dev, vbyte* data, int length) {
	return SDL_hid_get_feature_report(dev, (unsigned char*)data, (size_t)length);
}
DEFINE_PRIM(_I32, hid_get_feature_report, _ABSTRACT(SDL_hid_device) _BYTES _I32);

HL_PRIM int HL_NAME(hid_get_input_report)(SDL_hid_device* dev, vbyte* data, int length) {
	return SDL_hid_get_input_report(dev, (unsigned char*)data, (size_t)length);
}
DEFINE_PRIM(_I32, hid_get_input_report, _ABSTRACT(SDL_hid_device) _BYTES _I32);

HL_PRIM int HL_NAME(hid_close)(SDL_hid_device* dev) { return SDL_hid_close(dev); }
DEFINE_PRIM(_I32, hid_close, _ABSTRACT(SDL_hid_device));

static vbyte* get_wstring(SDL_hid_device* dev, int kind, int stringIndex, int maxlen) {
	wchar_t* buf = (wchar_t*)SDL_malloc(sizeof(wchar_t) * maxlen);
	int r = -1;
	switch (kind) {
	case 0:
		r = SDL_hid_get_manufacturer_string(dev, buf, (size_t)maxlen);
		break;
	case 1:
		r = SDL_hid_get_product_string(dev, buf, (size_t)maxlen);
		break;
	case 2:
		r = SDL_hid_get_serial_number_string(dev, buf, (size_t)maxlen);
		break;
	case 3:
		r = SDL_hid_get_indexed_string(dev, stringIndex, buf, (size_t)maxlen);
		break;
	}
	vbyte* out = r == 0 ? copy_wstr(buf) : NULL;
	SDL_free(buf);
	return out;
}

HL_PRIM vbyte* HL_NAME(hid_get_manufacturer_string)(SDL_hid_device* dev, int maxlen) { return get_wstring(dev, 0, 0, maxlen); }
DEFINE_PRIM(_BYTES, hid_get_manufacturer_string, _ABSTRACT(SDL_hid_device) _I32);

HL_PRIM vbyte* HL_NAME(hid_get_product_string)(SDL_hid_device* dev, int maxlen) { return get_wstring(dev, 1, 0, maxlen); }
DEFINE_PRIM(_BYTES, hid_get_product_string, _ABSTRACT(SDL_hid_device) _I32);

HL_PRIM vbyte* HL_NAME(hid_get_serial_number_string)(SDL_hid_device* dev, int maxlen) { return get_wstring(dev, 2, 0, maxlen); }
DEFINE_PRIM(_BYTES, hid_get_serial_number_string, _ABSTRACT(SDL_hid_device) _I32);

HL_PRIM vbyte* HL_NAME(hid_get_indexed_string)(SDL_hid_device* dev, int stringIndex, int maxlen) {
	return get_wstring(dev, 3, stringIndex, maxlen);
}
DEFINE_PRIM(_BYTES, hid_get_indexed_string, _ABSTRACT(SDL_hid_device) _I32 _I32);

HL_PRIM SDL_hid_device_info* HL_NAME(hid_get_device_info)(SDL_hid_device* dev) { return SDL_hid_get_device_info(dev); }
DEFINE_PRIM(_ABSTRACT(SDL_HidDeviceInfoList), hid_get_device_info, _ABSTRACT(SDL_hid_device));

HL_PRIM int HL_NAME(hid_get_report_descriptor)(SDL_hid_device* dev, vbyte* buf, int bufSize) {
	return SDL_hid_get_report_descriptor(dev, (unsigned char*)buf, (size_t)bufSize);
}
DEFINE_PRIM(_I32, hid_get_report_descriptor, _ABSTRACT(SDL_hid_device) _BYTES _I32);

HL_PRIM void HL_NAME(hid_ble_scan)(bool active) { SDL_hid_ble_scan(active); }
DEFINE_PRIM(_VOID, hid_ble_scan, _BOOL);
