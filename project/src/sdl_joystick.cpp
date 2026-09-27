#include "hashlink_macros.h"
#include "SDL3/SDL_joystick.h"
#include <string.h>

static vbyte* copy_str(const char* s) {
	if (!s)
		return NULL;
	return hl_copy_bytes((const vbyte*)s, (int)strlen(s) + 1);
}

static varray* ids_to_array(SDL_JoystickID* ids, int count) {
	if (!ids)
		return hl_alloc_array(&hlt_i32, 0);
	varray* a = hl_alloc_array(&hlt_i32, count);
	int* p = hl_aptr(a, int);
	for (int i = 0; i < count; i++)
		p[i] = (int)ids[i];
	SDL_free(ids);
	return a;
}

HL_PRIM void HL_NAME(lock_joysticks)() { SDL_LockJoysticks(); }
DEFINE_PRIM(_VOID, lock_joysticks, _NO_ARG);

HL_PRIM void HL_NAME(unlock_joysticks)() { SDL_UnlockJoysticks(); }
DEFINE_PRIM(_VOID, unlock_joysticks, _NO_ARG);

HL_PRIM bool HL_NAME(has_joystick)() { return SDL_HasJoystick(); }
DEFINE_PRIM(_BOOL, has_joystick, _NO_ARG);

HL_PRIM varray* HL_NAME(get_joysticks)() {
	int count = 0;
	SDL_JoystickID* ids = SDL_GetJoysticks(&count);
	return ids_to_array(ids, count);
}
DEFINE_PRIM(_ARR, get_joysticks, _NO_ARG);

HL_PRIM vbyte* HL_NAME(get_joystick_name_for_id)(int id) { return copy_str(SDL_GetJoystickNameForID((SDL_JoystickID)id)); }
DEFINE_PRIM(_BYTES, get_joystick_name_for_id, _I32);

HL_PRIM vbyte* HL_NAME(get_joystick_path_for_id)(int id) { return copy_str(SDL_GetJoystickPathForID((SDL_JoystickID)id)); }
DEFINE_PRIM(_BYTES, get_joystick_path_for_id, _I32);

HL_PRIM int HL_NAME(get_joystick_player_index_for_id)(int id) { return SDL_GetJoystickPlayerIndexForID((SDL_JoystickID)id); }
DEFINE_PRIM(_I32, get_joystick_player_index_for_id, _I32);

HL_PRIM void HL_NAME(get_joystick_guid_for_id)(int id, vbyte* out16) {
	SDL_GUID g = SDL_GetJoystickGUIDForID((SDL_JoystickID)id);
	memcpy(out16, g.data, 16);
}
DEFINE_PRIM(_VOID, get_joystick_guid_for_id, _I32 _BYTES);

HL_PRIM int HL_NAME(get_joystick_vendor_for_id)(int id) { return SDL_GetJoystickVendorForID((SDL_JoystickID)id); }
DEFINE_PRIM(_I32, get_joystick_vendor_for_id, _I32);
HL_PRIM int HL_NAME(get_joystick_product_for_id)(int id) { return SDL_GetJoystickProductForID((SDL_JoystickID)id); }
DEFINE_PRIM(_I32, get_joystick_product_for_id, _I32);
HL_PRIM int HL_NAME(get_joystick_product_version_for_id)(int id) { return SDL_GetJoystickProductVersionForID((SDL_JoystickID)id); }
DEFINE_PRIM(_I32, get_joystick_product_version_for_id, _I32);
HL_PRIM int HL_NAME(get_joystick_type_for_id)(int id) { return (int)SDL_GetJoystickTypeForID((SDL_JoystickID)id); }
DEFINE_PRIM(_I32, get_joystick_type_for_id, _I32);

HL_PRIM SDL_Joystick* HL_NAME(open_joystick)(int id) { return SDL_OpenJoystick((SDL_JoystickID)id); }
DEFINE_PRIM(_ABSTRACT(SDL_Joystick), open_joystick, _I32);

HL_PRIM SDL_Joystick* HL_NAME(get_joystick_from_id)(int id) { return SDL_GetJoystickFromID((SDL_JoystickID)id); }
DEFINE_PRIM(_ABSTRACT(SDL_Joystick), get_joystick_from_id, _I32);

HL_PRIM SDL_Joystick* HL_NAME(get_joystick_from_player_index)(int idx) { return SDL_GetJoystickFromPlayerIndex(idx); }
DEFINE_PRIM(_ABSTRACT(SDL_Joystick), get_joystick_from_player_index, _I32);

HL_PRIM int HL_NAME(attach_virtual_joystick)(int type, int vendorId, int productId, int naxes, int nbuttons, int nballs, int nhats,
	int buttonMask, int axisMask, vbyte* name) {
	SDL_VirtualJoystickDesc desc;
	SDL_zero(desc);
	desc.version = (Uint32)sizeof(SDL_VirtualJoystickDesc);
	desc.type = (Uint16)type;
	desc.vendor_id = (Uint16)vendorId;
	desc.product_id = (Uint16)productId;
	desc.naxes = (Uint16)naxes;
	desc.nbuttons = (Uint16)nbuttons;
	desc.nballs = (Uint16)nballs;
	desc.nhats = (Uint16)nhats;
	desc.button_mask = (Uint32)buttonMask;
	desc.axis_mask = (Uint32)axisMask;
	desc.name = (const char*)name;
	return (int)SDL_AttachVirtualJoystick(&desc);
}
DEFINE_PRIM(_I32, attach_virtual_joystick, _I32 _I32 _I32 _I32 _I32 _I32 _I32 _I32 _I32 _BYTES);

HL_PRIM bool HL_NAME(detach_virtual_joystick)(int id) { return SDL_DetachVirtualJoystick((SDL_JoystickID)id); }
DEFINE_PRIM(_BOOL, detach_virtual_joystick, _I32);

HL_PRIM bool HL_NAME(is_joystick_virtual)(int id) { return SDL_IsJoystickVirtual((SDL_JoystickID)id); }
DEFINE_PRIM(_BOOL, is_joystick_virtual, _I32);

HL_PRIM bool HL_NAME(set_joystick_virtual_axis)(SDL_Joystick* j, int axis, int value) { return SDL_SetJoystickVirtualAxis(j, axis, (Sint16)value); }
DEFINE_PRIM(_BOOL, set_joystick_virtual_axis, _ABSTRACT(SDL_Joystick) _I32 _I32);

HL_PRIM bool HL_NAME(set_joystick_virtual_ball)(SDL_Joystick* j, int ball, int xrel, int yrel) {
	return SDL_SetJoystickVirtualBall(j, ball, (Sint16)xrel, (Sint16)yrel);
}
DEFINE_PRIM(_BOOL, set_joystick_virtual_ball, _ABSTRACT(SDL_Joystick) _I32 _I32 _I32);

HL_PRIM bool HL_NAME(set_joystick_virtual_button)(SDL_Joystick* j, int button, bool down) { return SDL_SetJoystickVirtualButton(j, button, down); }
DEFINE_PRIM(_BOOL, set_joystick_virtual_button, _ABSTRACT(SDL_Joystick) _I32 _BOOL);

HL_PRIM bool HL_NAME(set_joystick_virtual_hat)(SDL_Joystick* j, int hat, int value) { return SDL_SetJoystickVirtualHat(j, hat, (Uint8)value); }
DEFINE_PRIM(_BOOL, set_joystick_virtual_hat, _ABSTRACT(SDL_Joystick) _I32 _I32);

HL_PRIM bool HL_NAME(set_joystick_virtual_touchpad)(SDL_Joystick* j, int touchpad, int finger, bool down, double x, double y, double pressure) {
	return SDL_SetJoystickVirtualTouchpad(j, touchpad, finger, down, (float)x, (float)y, (float)pressure);
}
DEFINE_PRIM(_BOOL, set_joystick_virtual_touchpad, _ABSTRACT(SDL_Joystick) _I32 _I32 _BOOL _F64 _F64 _F64);

HL_PRIM bool HL_NAME(send_joystick_virtual_sensor_data)(SDL_Joystick* j, int sensorType, int tsHi, int tsLo, varray* data) {
	Uint64 ts = ((Uint64)(Uint32)tsHi << 32) | (Uint32)tsLo;
	int n = data->size;
	float tmp[16];
	if (n > 16)
		n = 16;
	double* src = hl_aptr(data, double);
	for (int i = 0; i < n; i++)
		tmp[i] = (float)src[i];
	return SDL_SendJoystickVirtualSensorData(j, (SDL_SensorType)sensorType, ts, tmp, n);
}
DEFINE_PRIM(_BOOL, send_joystick_virtual_sensor_data, _ABSTRACT(SDL_Joystick) _I32 _I32 _I32 _ARR);

HL_PRIM int HL_NAME(joystick_capabilities)(SDL_Joystick* j) {
	SDL_PropertiesID p = SDL_GetJoystickProperties(j);
	if (!p)
		return 0;
	int r = 0;
	if (SDL_GetBooleanProperty(p, SDL_PROP_JOYSTICK_CAP_MONO_LED_BOOLEAN, false)) r |= 1;
	if (SDL_GetBooleanProperty(p, SDL_PROP_JOYSTICK_CAP_RGB_LED_BOOLEAN, false)) r |= 2;
	if (SDL_GetBooleanProperty(p, SDL_PROP_JOYSTICK_CAP_PLAYER_LED_BOOLEAN, false)) r |= 4;
	if (SDL_GetBooleanProperty(p, SDL_PROP_JOYSTICK_CAP_RUMBLE_BOOLEAN, false)) r |= 8;
	if (SDL_GetBooleanProperty(p, SDL_PROP_JOYSTICK_CAP_TRIGGER_RUMBLE_BOOLEAN, false)) r |= 16;
	return r;
}
DEFINE_PRIM(_I32, joystick_capabilities, _ABSTRACT(SDL_Joystick));

HL_PRIM vbyte* HL_NAME(get_joystick_name)(SDL_Joystick* j) { return copy_str(SDL_GetJoystickName(j)); }
DEFINE_PRIM(_BYTES, get_joystick_name, _ABSTRACT(SDL_Joystick));

HL_PRIM vbyte* HL_NAME(get_joystick_path)(SDL_Joystick* j) { return copy_str(SDL_GetJoystickPath(j)); }
DEFINE_PRIM(_BYTES, get_joystick_path, _ABSTRACT(SDL_Joystick));

HL_PRIM int HL_NAME(get_joystick_player_index)(SDL_Joystick* j) { return SDL_GetJoystickPlayerIndex(j); }
DEFINE_PRIM(_I32, get_joystick_player_index, _ABSTRACT(SDL_Joystick));

HL_PRIM bool HL_NAME(set_joystick_player_index)(SDL_Joystick* j, int idx) { return SDL_SetJoystickPlayerIndex(j, idx); }
DEFINE_PRIM(_BOOL, set_joystick_player_index, _ABSTRACT(SDL_Joystick) _I32);

HL_PRIM void HL_NAME(get_joystick_guid)(SDL_Joystick* j, vbyte* out16) {
	SDL_GUID g = SDL_GetJoystickGUID(j);
	memcpy(out16, g.data, 16);
}
DEFINE_PRIM(_VOID, get_joystick_guid, _ABSTRACT(SDL_Joystick) _BYTES);

HL_PRIM int HL_NAME(get_joystick_vendor)(SDL_Joystick* j) { return SDL_GetJoystickVendor(j); }
DEFINE_PRIM(_I32, get_joystick_vendor, _ABSTRACT(SDL_Joystick));
HL_PRIM int HL_NAME(get_joystick_product)(SDL_Joystick* j) { return SDL_GetJoystickProduct(j); }
DEFINE_PRIM(_I32, get_joystick_product, _ABSTRACT(SDL_Joystick));
HL_PRIM int HL_NAME(get_joystick_product_version)(SDL_Joystick* j) { return SDL_GetJoystickProductVersion(j); }
DEFINE_PRIM(_I32, get_joystick_product_version, _ABSTRACT(SDL_Joystick));
HL_PRIM int HL_NAME(get_joystick_firmware_version)(SDL_Joystick* j) { return SDL_GetJoystickFirmwareVersion(j); }
DEFINE_PRIM(_I32, get_joystick_firmware_version, _ABSTRACT(SDL_Joystick));

HL_PRIM vbyte* HL_NAME(get_joystick_serial)(SDL_Joystick* j) { return copy_str(SDL_GetJoystickSerial(j)); }
DEFINE_PRIM(_BYTES, get_joystick_serial, _ABSTRACT(SDL_Joystick));

HL_PRIM int HL_NAME(get_joystick_type)(SDL_Joystick* j) { return (int)SDL_GetJoystickType(j); }
DEFINE_PRIM(_I32, get_joystick_type, _ABSTRACT(SDL_Joystick));

HL_PRIM void HL_NAME(get_joystick_guid_info)(vbyte* guid16, varray* out) {
	SDL_GUID g;
	memcpy(g.data, guid16, 16);
	Uint16 vendor = 0, product = 0, version = 0, crc16 = 0;
	SDL_GetJoystickGUIDInfo(g, &vendor, &product, &version, &crc16);
	int* o = hl_aptr(out, int);
	o[0] = vendor;
	o[1] = product;
	o[2] = version;
	o[3] = crc16;
}
DEFINE_PRIM(_VOID, get_joystick_guid_info, _BYTES _ARR);

HL_PRIM bool HL_NAME(joystick_connected)(SDL_Joystick* j) { return SDL_JoystickConnected(j); }
DEFINE_PRIM(_BOOL, joystick_connected, _ABSTRACT(SDL_Joystick));

HL_PRIM int HL_NAME(get_joystick_id)(SDL_Joystick* j) { return (int)SDL_GetJoystickID(j); }
DEFINE_PRIM(_I32, get_joystick_id, _ABSTRACT(SDL_Joystick));

HL_PRIM int HL_NAME(get_num_joystick_axes)(SDL_Joystick* j) { return SDL_GetNumJoystickAxes(j); }
DEFINE_PRIM(_I32, get_num_joystick_axes, _ABSTRACT(SDL_Joystick));
HL_PRIM int HL_NAME(get_num_joystick_balls)(SDL_Joystick* j) { return SDL_GetNumJoystickBalls(j); }
DEFINE_PRIM(_I32, get_num_joystick_balls, _ABSTRACT(SDL_Joystick));
HL_PRIM int HL_NAME(get_num_joystick_hats)(SDL_Joystick* j) { return SDL_GetNumJoystickHats(j); }
DEFINE_PRIM(_I32, get_num_joystick_hats, _ABSTRACT(SDL_Joystick));
HL_PRIM int HL_NAME(get_num_joystick_buttons)(SDL_Joystick* j) { return SDL_GetNumJoystickButtons(j); }
DEFINE_PRIM(_I32, get_num_joystick_buttons, _ABSTRACT(SDL_Joystick));

HL_PRIM void HL_NAME(set_joystick_events_enabled)(bool enabled) { SDL_SetJoystickEventsEnabled(enabled); }
DEFINE_PRIM(_VOID, set_joystick_events_enabled, _BOOL);

HL_PRIM bool HL_NAME(joystick_events_enabled)() { return SDL_JoystickEventsEnabled(); }
DEFINE_PRIM(_BOOL, joystick_events_enabled, _NO_ARG);

HL_PRIM void HL_NAME(update_joysticks)() { SDL_UpdateJoysticks(); }
DEFINE_PRIM(_VOID, update_joysticks, _NO_ARG);

HL_PRIM int HL_NAME(get_joystick_axis)(SDL_Joystick* j, int axis) { return SDL_GetJoystickAxis(j, axis); }
DEFINE_PRIM(_I32, get_joystick_axis, _ABSTRACT(SDL_Joystick) _I32);

HL_PRIM bool HL_NAME(get_joystick_axis_initial_state)(SDL_Joystick* j, int axis, varray* out) {
	Sint16 state = 0;
	bool r = SDL_GetJoystickAxisInitialState(j, axis, &state);
	hl_aptr(out, int)[0] = state;
	return r;
}
DEFINE_PRIM(_BOOL, get_joystick_axis_initial_state, _ABSTRACT(SDL_Joystick) _I32 _ARR);

HL_PRIM bool HL_NAME(get_joystick_ball)(SDL_Joystick* j, int ball, varray* out) {
	int dx = 0, dy = 0;
	bool r = SDL_GetJoystickBall(j, ball, &dx, &dy);
	int* o = hl_aptr(out, int);
	o[0] = dx;
	o[1] = dy;
	return r;
}
DEFINE_PRIM(_BOOL, get_joystick_ball, _ABSTRACT(SDL_Joystick) _I32 _ARR);

HL_PRIM int HL_NAME(get_joystick_hat)(SDL_Joystick* j, int hat) { return SDL_GetJoystickHat(j, hat); }
DEFINE_PRIM(_I32, get_joystick_hat, _ABSTRACT(SDL_Joystick) _I32);

HL_PRIM bool HL_NAME(get_joystick_button)(SDL_Joystick* j, int button) { return SDL_GetJoystickButton(j, button); }
DEFINE_PRIM(_BOOL, get_joystick_button, _ABSTRACT(SDL_Joystick) _I32);

HL_PRIM bool HL_NAME(rumble_joystick)(SDL_Joystick* j, int low, int high, int durationMs) {
	return SDL_RumbleJoystick(j, (Uint16)low, (Uint16)high, (Uint32)durationMs);
}
DEFINE_PRIM(_BOOL, rumble_joystick, _ABSTRACT(SDL_Joystick) _I32 _I32 _I32);

HL_PRIM bool HL_NAME(rumble_joystick_triggers)(SDL_Joystick* j, int left, int right, int durationMs) {
	return SDL_RumbleJoystickTriggers(j, (Uint16)left, (Uint16)right, (Uint32)durationMs);
}
DEFINE_PRIM(_BOOL, rumble_joystick_triggers, _ABSTRACT(SDL_Joystick) _I32 _I32 _I32);

HL_PRIM bool HL_NAME(set_joystick_led)(SDL_Joystick* j, int r, int g, int b) { return SDL_SetJoystickLED(j, (Uint8)r, (Uint8)g, (Uint8)b); }
DEFINE_PRIM(_BOOL, set_joystick_led, _ABSTRACT(SDL_Joystick) _I32 _I32 _I32);

HL_PRIM bool HL_NAME(send_joystick_effect)(SDL_Joystick* j, vbyte* data, int size) { return SDL_SendJoystickEffect(j, data, size); }
DEFINE_PRIM(_BOOL, send_joystick_effect, _ABSTRACT(SDL_Joystick) _BYTES _I32);

HL_PRIM void HL_NAME(close_joystick)(SDL_Joystick* j) { SDL_CloseJoystick(j); }
DEFINE_PRIM(_VOID, close_joystick, _ABSTRACT(SDL_Joystick));

HL_PRIM int HL_NAME(get_joystick_connection_state)(SDL_Joystick* j) { return (int)SDL_GetJoystickConnectionState(j); }
DEFINE_PRIM(_I32, get_joystick_connection_state, _ABSTRACT(SDL_Joystick));

HL_PRIM void HL_NAME(get_joystick_power_info)(SDL_Joystick* j, varray* out) {
	int percent = -1;
	SDL_PowerState st = SDL_GetJoystickPowerInfo(j, &percent);
	int* o = hl_aptr(out, int);
	o[0] = (int)st;
	o[1] = percent;
}
DEFINE_PRIM(_VOID, get_joystick_power_info, _ABSTRACT(SDL_Joystick) _ARR);
