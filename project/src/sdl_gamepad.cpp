#include "SDL3/SDL_gamepad.h"

#include <string.h>

#include "hashlink_macros.h"

static vbyte* copy_str(const char* s) {
    if (!s) return NULL;
    return hl_copy_bytes((const vbyte*)s, (int)strlen(s) + 1);
}

static vbyte* take_str(char* s) {
    vbyte* r = copy_str(s);
    SDL_free(s);
    return r;
}

static varray* ids_to_array(SDL_JoystickID* ids, int count) {
    if (!ids) return hl_alloc_array(&hlt_i32, 0);
    varray* a = hl_alloc_array(&hlt_i32, count);
    int* p = hl_aptr(a, int);
    for (int i = 0; i < count; i++) p[i] = (int)ids[i];
    SDL_free(ids);
    return a;
}

HL_PRIM int HL_NAME(add_gamepad_mapping)(vbyte* mapping) {
    return SDL_AddGamepadMapping((const char*)mapping);
}
DEFINE_PRIM(_I32, add_gamepad_mapping, _BYTES);

HL_PRIM int HL_NAME(add_gamepad_mappings_from_file)(vbyte* file) {
    return SDL_AddGamepadMappingsFromFile((const char*)file);
}
DEFINE_PRIM(_I32, add_gamepad_mappings_from_file, _BYTES);

HL_PRIM bool HL_NAME(reload_gamepad_mappings)() {
    return SDL_ReloadGamepadMappings();
}
DEFINE_PRIM(_BOOL, reload_gamepad_mappings, _NO_ARG);

HL_PRIM varray* HL_NAME(get_gamepad_mappings)() {
    int count = 0;
    char** m = SDL_GetGamepadMappings(&count);
    if (!m) return NULL;
    varray* a = hl_alloc_array(&hlt_bytes, count);
    vbyte** p = hl_aptr(a, vbyte*);
    for (int i = 0; i < count; i++) p[i] = copy_str(m[i]);
    SDL_free(m);
    return a;
}
DEFINE_PRIM(_ARR, get_gamepad_mappings, _NO_ARG);

HL_PRIM vbyte* HL_NAME(get_gamepad_mapping_for_guid)(vbyte* guid16) {
    SDL_GUID g;
    memcpy(g.data, guid16, 16);
    return take_str(SDL_GetGamepadMappingForGUID(g));
}
DEFINE_PRIM(_BYTES, get_gamepad_mapping_for_guid, _BYTES);

HL_PRIM vbyte* HL_NAME(get_gamepad_mapping)(SDL_Gamepad* g) {
    return take_str(SDL_GetGamepadMapping(g));
}
DEFINE_PRIM(_BYTES, get_gamepad_mapping, _ABSTRACT(SDL_Gamepad));

HL_PRIM vbyte* HL_NAME(get_gamepad_mapping_for_id)(int id) {
    return take_str(SDL_GetGamepadMappingForID((SDL_JoystickID)id));
}
DEFINE_PRIM(_BYTES, get_gamepad_mapping_for_id, _I32);

HL_PRIM bool HL_NAME(set_gamepad_mapping)(int id, vbyte* mapping) {
    return SDL_SetGamepadMapping((SDL_JoystickID)id, (const char*)mapping);
}
DEFINE_PRIM(_BOOL, set_gamepad_mapping, _I32 _BYTES);

HL_PRIM bool HL_NAME(has_gamepad)() { return SDL_HasGamepad(); }
DEFINE_PRIM(_BOOL, has_gamepad, _NO_ARG);

HL_PRIM varray* HL_NAME(get_gamepads)() {
    int count = 0;
    SDL_JoystickID* ids = SDL_GetGamepads(&count);
    return ids_to_array(ids, count);
}
DEFINE_PRIM(_ARR, get_gamepads, _NO_ARG);

HL_PRIM bool HL_NAME(is_gamepad)(int id) {
    return SDL_IsGamepad((SDL_JoystickID)id);
}
DEFINE_PRIM(_BOOL, is_gamepad, _I32);

HL_PRIM vbyte* HL_NAME(get_gamepad_name_for_id)(int id) {
    return copy_str(SDL_GetGamepadNameForID((SDL_JoystickID)id));
}
DEFINE_PRIM(_BYTES, get_gamepad_name_for_id, _I32);

HL_PRIM vbyte* HL_NAME(get_gamepad_path_for_id)(int id) {
    return copy_str(SDL_GetGamepadPathForID((SDL_JoystickID)id));
}
DEFINE_PRIM(_BYTES, get_gamepad_path_for_id, _I32);

HL_PRIM int HL_NAME(get_gamepad_player_index_for_id)(int id) {
    return SDL_GetGamepadPlayerIndexForID((SDL_JoystickID)id);
}
DEFINE_PRIM(_I32, get_gamepad_player_index_for_id, _I32);

HL_PRIM void HL_NAME(get_gamepad_guid_for_id)(int id, vbyte* out16) {
    SDL_GUID g = SDL_GetGamepadGUIDForID((SDL_JoystickID)id);
    memcpy(out16, g.data, 16);
}
DEFINE_PRIM(_VOID, get_gamepad_guid_for_id, _I32 _BYTES);

HL_PRIM int HL_NAME(get_gamepad_vendor_for_id)(int id) {
    return SDL_GetGamepadVendorForID((SDL_JoystickID)id);
}
DEFINE_PRIM(_I32, get_gamepad_vendor_for_id, _I32);
HL_PRIM int HL_NAME(get_gamepad_product_for_id)(int id) {
    return SDL_GetGamepadProductForID((SDL_JoystickID)id);
}
DEFINE_PRIM(_I32, get_gamepad_product_for_id, _I32);
HL_PRIM int HL_NAME(get_gamepad_product_version_for_id)(int id) {
    return SDL_GetGamepadProductVersionForID((SDL_JoystickID)id);
}
DEFINE_PRIM(_I32, get_gamepad_product_version_for_id, _I32);
HL_PRIM int HL_NAME(get_gamepad_type_for_id)(int id) {
    return (int)SDL_GetGamepadTypeForID((SDL_JoystickID)id);
}
DEFINE_PRIM(_I32, get_gamepad_type_for_id, _I32);
HL_PRIM int HL_NAME(get_real_gamepad_type_for_id)(int id) {
    return (int)SDL_GetRealGamepadTypeForID((SDL_JoystickID)id);
}
DEFINE_PRIM(_I32, get_real_gamepad_type_for_id, _I32);

HL_PRIM SDL_Gamepad* HL_NAME(open_gamepad)(int id) {
    return SDL_OpenGamepad((SDL_JoystickID)id);
}
DEFINE_PRIM(_ABSTRACT(SDL_Gamepad), open_gamepad, _I32);

HL_PRIM SDL_Gamepad* HL_NAME(get_gamepad_from_id)(int id) {
    return SDL_GetGamepadFromID((SDL_JoystickID)id);
}
DEFINE_PRIM(_ABSTRACT(SDL_Gamepad), get_gamepad_from_id, _I32);

HL_PRIM SDL_Gamepad* HL_NAME(get_gamepad_from_player_index)(int idx) {
    return SDL_GetGamepadFromPlayerIndex(idx);
}
DEFINE_PRIM(_ABSTRACT(SDL_Gamepad), get_gamepad_from_player_index, _I32);

HL_PRIM void HL_NAME(close_gamepad)(SDL_Gamepad* g) { SDL_CloseGamepad(g); }
DEFINE_PRIM(_VOID, close_gamepad, _ABSTRACT(SDL_Gamepad));

HL_PRIM int HL_NAME(gamepad_capabilities)(SDL_Gamepad* g) {
    SDL_PropertiesID p = SDL_GetGamepadProperties(g);
    if (!p) return 0;
    int r = 0;
    if (SDL_GetBooleanProperty(p, SDL_PROP_GAMEPAD_CAP_MONO_LED_BOOLEAN, false))
        r |= 1;
    if (SDL_GetBooleanProperty(p, SDL_PROP_GAMEPAD_CAP_RGB_LED_BOOLEAN, false))
        r |= 2;
    if (SDL_GetBooleanProperty(p, SDL_PROP_GAMEPAD_CAP_PLAYER_LED_BOOLEAN,
                               false))
        r |= 4;
    if (SDL_GetBooleanProperty(p, SDL_PROP_GAMEPAD_CAP_RUMBLE_BOOLEAN, false))
        r |= 8;
    if (SDL_GetBooleanProperty(p, SDL_PROP_GAMEPAD_CAP_TRIGGER_RUMBLE_BOOLEAN,
                               false))
        r |= 16;
    return r;
}
DEFINE_PRIM(_I32, gamepad_capabilities, _ABSTRACT(SDL_Gamepad));

HL_PRIM int HL_NAME(get_gamepad_id)(SDL_Gamepad* g) {
    return (int)SDL_GetGamepadID(g);
}
DEFINE_PRIM(_I32, get_gamepad_id, _ABSTRACT(SDL_Gamepad));

HL_PRIM vbyte* HL_NAME(get_gamepad_name)(SDL_Gamepad* g) {
    return copy_str(SDL_GetGamepadName(g));
}
DEFINE_PRIM(_BYTES, get_gamepad_name, _ABSTRACT(SDL_Gamepad));

HL_PRIM vbyte* HL_NAME(get_gamepad_path)(SDL_Gamepad* g) {
    return copy_str(SDL_GetGamepadPath(g));
}
DEFINE_PRIM(_BYTES, get_gamepad_path, _ABSTRACT(SDL_Gamepad));

HL_PRIM int HL_NAME(get_gamepad_type)(SDL_Gamepad* g) {
    return (int)SDL_GetGamepadType(g);
}
DEFINE_PRIM(_I32, get_gamepad_type, _ABSTRACT(SDL_Gamepad));

HL_PRIM int HL_NAME(get_real_gamepad_type)(SDL_Gamepad* g) {
    return (int)SDL_GetRealGamepadType(g);
}
DEFINE_PRIM(_I32, get_real_gamepad_type, _ABSTRACT(SDL_Gamepad));

HL_PRIM int HL_NAME(get_gamepad_player_index)(SDL_Gamepad* g) {
    return SDL_GetGamepadPlayerIndex(g);
}
DEFINE_PRIM(_I32, get_gamepad_player_index, _ABSTRACT(SDL_Gamepad));

HL_PRIM bool HL_NAME(set_gamepad_player_index)(SDL_Gamepad* g, int idx) {
    return SDL_SetGamepadPlayerIndex(g, idx);
}
DEFINE_PRIM(_BOOL, set_gamepad_player_index, _ABSTRACT(SDL_Gamepad) _I32);

HL_PRIM int HL_NAME(get_gamepad_vendor)(SDL_Gamepad* g) {
    return SDL_GetGamepadVendor(g);
}
DEFINE_PRIM(_I32, get_gamepad_vendor, _ABSTRACT(SDL_Gamepad));
HL_PRIM int HL_NAME(get_gamepad_product)(SDL_Gamepad* g) {
    return SDL_GetGamepadProduct(g);
}
DEFINE_PRIM(_I32, get_gamepad_product, _ABSTRACT(SDL_Gamepad));
HL_PRIM int HL_NAME(get_gamepad_product_version)(SDL_Gamepad* g) {
    return SDL_GetGamepadProductVersion(g);
}
DEFINE_PRIM(_I32, get_gamepad_product_version, _ABSTRACT(SDL_Gamepad));
HL_PRIM int HL_NAME(get_gamepad_firmware_version)(SDL_Gamepad* g) {
    return SDL_GetGamepadFirmwareVersion(g);
}
DEFINE_PRIM(_I32, get_gamepad_firmware_version, _ABSTRACT(SDL_Gamepad));

HL_PRIM vbyte* HL_NAME(get_gamepad_serial)(SDL_Gamepad* g) {
    return copy_str(SDL_GetGamepadSerial(g));
}
DEFINE_PRIM(_BYTES, get_gamepad_serial, _ABSTRACT(SDL_Gamepad));

HL_PRIM void HL_NAME(get_gamepad_steam_handle)(SDL_Gamepad* g, varray* out) {
    Uint64 h = SDL_GetGamepadSteamHandle(g);
    int* o = hl_aptr(out, int);
    o[0] = (int)(Uint32)(h >> 32);
    o[1] = (int)(Uint32)(h & 0xFFFFFFFFu);
}
DEFINE_PRIM(_VOID, get_gamepad_steam_handle, _ABSTRACT(SDL_Gamepad) _ARR);

HL_PRIM int HL_NAME(get_gamepad_connection_state)(SDL_Gamepad* g) {
    return (int)SDL_GetGamepadConnectionState(g);
}
DEFINE_PRIM(_I32, get_gamepad_connection_state, _ABSTRACT(SDL_Gamepad));

HL_PRIM void HL_NAME(get_gamepad_power_info)(SDL_Gamepad* g, varray* out) {
    int percent = -1;
    SDL_PowerState st = SDL_GetGamepadPowerInfo(g, &percent);
    int* o = hl_aptr(out, int);
    o[0] = (int)st;
    o[1] = percent;
}
DEFINE_PRIM(_VOID, get_gamepad_power_info, _ABSTRACT(SDL_Gamepad) _ARR);

HL_PRIM bool HL_NAME(gamepad_connected)(SDL_Gamepad* g) {
    return SDL_GamepadConnected(g);
}
DEFINE_PRIM(_BOOL, gamepad_connected, _ABSTRACT(SDL_Gamepad));

HL_PRIM SDL_Joystick* HL_NAME(get_gamepad_joystick)(SDL_Gamepad* g) {
    return SDL_GetGamepadJoystick(g);
}
DEFINE_PRIM(_ABSTRACT(SDL_Joystick), get_gamepad_joystick,
            _ABSTRACT(SDL_Gamepad));

HL_PRIM void HL_NAME(set_gamepad_events_enabled)(bool enabled) {
    SDL_SetGamepadEventsEnabled(enabled);
}
DEFINE_PRIM(_VOID, set_gamepad_events_enabled, _BOOL);

HL_PRIM bool HL_NAME(gamepad_events_enabled)() {
    return SDL_GamepadEventsEnabled();
}
DEFINE_PRIM(_BOOL, gamepad_events_enabled, _NO_ARG);

HL_PRIM void HL_NAME(update_gamepads)() { SDL_UpdateGamepads(); }
DEFINE_PRIM(_VOID, update_gamepads, _NO_ARG);

HL_PRIM varray* HL_NAME(get_gamepad_bindings)(SDL_Gamepad* g) {
    int count = 0;
    SDL_GamepadBinding** b = SDL_GetGamepadBindings(g, &count);
    if (!b) return NULL;
    varray* a = hl_alloc_array(&hlt_i32, count * 8);
    int* p = hl_aptr(a, int);
    for (int i = 0; i < count; i++) {
        SDL_GamepadBinding* x = b[i];
        int* o = &p[i * 8];
        o[0] = (int)x->input_type;
        switch (x->input_type) {
            case SDL_GAMEPAD_BINDTYPE_BUTTON:
                o[1] = x->input.button;
                break;
            case SDL_GAMEPAD_BINDTYPE_AXIS:
                o[1] = x->input.axis.axis;
                o[2] = x->input.axis.axis_min;
                o[3] = x->input.axis.axis_max;
                break;
            case SDL_GAMEPAD_BINDTYPE_HAT:
                o[1] = x->input.hat.hat;
                o[2] = x->input.hat.hat_mask;
                break;
            default:
                break;
        }
        o[4] = (int)x->output_type;
        switch (x->output_type) {
            case SDL_GAMEPAD_BINDTYPE_BUTTON:
                o[5] = (int)x->output.button;
                break;
            case SDL_GAMEPAD_BINDTYPE_AXIS:
                o[5] = (int)x->output.axis.axis;
                o[6] = x->output.axis.axis_min;
                o[7] = x->output.axis.axis_max;
                break;
            default:
                break;
        }
    }
    SDL_free(b);
    return a;
}
DEFINE_PRIM(_ARR, get_gamepad_bindings, _ABSTRACT(SDL_Gamepad));

HL_PRIM int HL_NAME(get_gamepad_type_from_string)(vbyte* s) {
    return (int)SDL_GetGamepadTypeFromString((const char*)s);
}
DEFINE_PRIM(_I32, get_gamepad_type_from_string, _BYTES);

HL_PRIM vbyte* HL_NAME(get_gamepad_string_for_type)(int t) {
    return copy_str(SDL_GetGamepadStringForType((SDL_GamepadType)t));
}
DEFINE_PRIM(_BYTES, get_gamepad_string_for_type, _I32);

HL_PRIM int HL_NAME(get_gamepad_axis_from_string)(vbyte* s) {
    return (int)SDL_GetGamepadAxisFromString((const char*)s);
}
DEFINE_PRIM(_I32, get_gamepad_axis_from_string, _BYTES);

HL_PRIM vbyte* HL_NAME(get_gamepad_string_for_axis)(int a) {
    return copy_str(SDL_GetGamepadStringForAxis((SDL_GamepadAxis)a));
}
DEFINE_PRIM(_BYTES, get_gamepad_string_for_axis, _I32);

HL_PRIM int HL_NAME(get_gamepad_button_from_string)(vbyte* s) {
    return (int)SDL_GetGamepadButtonFromString((const char*)s);
}
DEFINE_PRIM(_I32, get_gamepad_button_from_string, _BYTES);

HL_PRIM vbyte* HL_NAME(get_gamepad_string_for_button)(int b) {
    return copy_str(SDL_GetGamepadStringForButton((SDL_GamepadButton)b));
}
DEFINE_PRIM(_BYTES, get_gamepad_string_for_button, _I32);

HL_PRIM int HL_NAME(get_gamepad_button_label_for_type)(int type, int button) {
    return (int)SDL_GetGamepadButtonLabelForType((SDL_GamepadType)type,
                                                 (SDL_GamepadButton)button);
}
DEFINE_PRIM(_I32, get_gamepad_button_label_for_type, _I32 _I32);

HL_PRIM int HL_NAME(get_gamepad_button_label)(SDL_Gamepad* g, int button) {
    return (int)SDL_GetGamepadButtonLabel(g, (SDL_GamepadButton)button);
}
DEFINE_PRIM(_I32, get_gamepad_button_label, _ABSTRACT(SDL_Gamepad) _I32);

HL_PRIM bool HL_NAME(gamepad_has_axis)(SDL_Gamepad* g, int axis) {
    return SDL_GamepadHasAxis(g, (SDL_GamepadAxis)axis);
}
DEFINE_PRIM(_BOOL, gamepad_has_axis, _ABSTRACT(SDL_Gamepad) _I32);

HL_PRIM int HL_NAME(get_gamepad_axis)(SDL_Gamepad* g, int axis) {
    return SDL_GetGamepadAxis(g, (SDL_GamepadAxis)axis);
}
DEFINE_PRIM(_I32, get_gamepad_axis, _ABSTRACT(SDL_Gamepad) _I32);

HL_PRIM bool HL_NAME(gamepad_has_button)(SDL_Gamepad* g, int button) {
    return SDL_GamepadHasButton(g, (SDL_GamepadButton)button);
}
DEFINE_PRIM(_BOOL, gamepad_has_button, _ABSTRACT(SDL_Gamepad) _I32);

HL_PRIM bool HL_NAME(get_gamepad_button)(SDL_Gamepad* g, int button) {
    return SDL_GetGamepadButton(g, (SDL_GamepadButton)button);
}
DEFINE_PRIM(_BOOL, get_gamepad_button, _ABSTRACT(SDL_Gamepad) _I32);

HL_PRIM int HL_NAME(get_num_gamepad_touchpads)(SDL_Gamepad* g) {
    return SDL_GetNumGamepadTouchpads(g);
}
DEFINE_PRIM(_I32, get_num_gamepad_touchpads, _ABSTRACT(SDL_Gamepad));

HL_PRIM int HL_NAME(get_num_gamepad_touchpad_fingers)(SDL_Gamepad* g,
                                                      int touchpad) {
    return SDL_GetNumGamepadTouchpadFingers(g, touchpad);
}
DEFINE_PRIM(_I32, get_num_gamepad_touchpad_fingers,
            _ABSTRACT(SDL_Gamepad) _I32);

HL_PRIM bool HL_NAME(get_gamepad_touchpad_finger)(SDL_Gamepad* g, int touchpad,
                                                  int finger, varray* out) {
    bool down = false;
    float x = 0, y = 0, pressure = 0;
    if (!SDL_GetGamepadTouchpadFinger(g, touchpad, finger, &down, &x, &y,
                                      &pressure))
        return false;
    double* o = hl_aptr(out, double);
    o[0] = down ? 1 : 0;
    o[1] = x;
    o[2] = y;
    o[3] = pressure;
    return true;
}
DEFINE_PRIM(_BOOL, get_gamepad_touchpad_finger,
            _ABSTRACT(SDL_Gamepad) _I32 _I32 _ARR);

HL_PRIM bool HL_NAME(gamepad_has_sensor)(SDL_Gamepad* g, int type) {
    return SDL_GamepadHasSensor(g, (SDL_SensorType)type);
}
DEFINE_PRIM(_BOOL, gamepad_has_sensor, _ABSTRACT(SDL_Gamepad) _I32);

HL_PRIM bool HL_NAME(set_gamepad_sensor_enabled)(SDL_Gamepad* g, int type,
                                                 bool enabled) {
    return SDL_SetGamepadSensorEnabled(g, (SDL_SensorType)type, enabled);
}
DEFINE_PRIM(_BOOL, set_gamepad_sensor_enabled,
            _ABSTRACT(SDL_Gamepad) _I32 _BOOL);

HL_PRIM bool HL_NAME(gamepad_sensor_enabled)(SDL_Gamepad* g, int type) {
    return SDL_GamepadSensorEnabled(g, (SDL_SensorType)type);
}
DEFINE_PRIM(_BOOL, gamepad_sensor_enabled, _ABSTRACT(SDL_Gamepad) _I32);

HL_PRIM double HL_NAME(get_gamepad_sensor_data_rate)(SDL_Gamepad* g, int type) {
    return (double)SDL_GetGamepadSensorDataRate(g, (SDL_SensorType)type);
}
DEFINE_PRIM(_F64, get_gamepad_sensor_data_rate, _ABSTRACT(SDL_Gamepad) _I32);

HL_PRIM bool HL_NAME(get_gamepad_sensor_data)(SDL_Gamepad* g, int type,
                                              varray* out) {
    int n = out->size;
    float tmp[16];
    if (n > 16) n = 16;
    if (!SDL_GetGamepadSensorData(g, (SDL_SensorType)type, tmp, n))
        return false;
    double* o = hl_aptr(out, double);
    for (int i = 0; i < n; i++) o[i] = tmp[i];
    return true;
}
DEFINE_PRIM(_BOOL, get_gamepad_sensor_data, _ABSTRACT(SDL_Gamepad) _I32 _ARR);

HL_PRIM bool HL_NAME(rumble_gamepad)(SDL_Gamepad* g, int low, int high,
                                     int durationMs) {
    return SDL_RumbleGamepad(g, (Uint16)low, (Uint16)high, (Uint32)durationMs);
}
DEFINE_PRIM(_BOOL, rumble_gamepad, _ABSTRACT(SDL_Gamepad) _I32 _I32 _I32);

HL_PRIM bool HL_NAME(rumble_gamepad_triggers)(SDL_Gamepad* g, int left,
                                              int right, int durationMs) {
    return SDL_RumbleGamepadTriggers(g, (Uint16)left, (Uint16)right,
                                     (Uint32)durationMs);
}
DEFINE_PRIM(_BOOL, rumble_gamepad_triggers,
            _ABSTRACT(SDL_Gamepad) _I32 _I32 _I32);

HL_PRIM bool HL_NAME(set_gamepad_led)(SDL_Gamepad* g, int r, int gr, int b) {
    return SDL_SetGamepadLED(g, (Uint8)r, (Uint8)gr, (Uint8)b);
}
DEFINE_PRIM(_BOOL, set_gamepad_led, _ABSTRACT(SDL_Gamepad) _I32 _I32 _I32);

HL_PRIM bool HL_NAME(send_gamepad_effect)(SDL_Gamepad* g, vbyte* data,
                                          int size) {
    return SDL_SendGamepadEffect(g, data, size);
}
DEFINE_PRIM(_BOOL, send_gamepad_effect, _ABSTRACT(SDL_Gamepad) _BYTES _I32);

HL_PRIM vbyte* HL_NAME(get_gamepad_apple_sf_symbols_name_for_button)(
    SDL_Gamepad* g, int button) {
    return copy_str(SDL_GetGamepadAppleSFSymbolsNameForButton(
        g, (SDL_GamepadButton)button));
}
DEFINE_PRIM(_BYTES, get_gamepad_apple_sf_symbols_name_for_button,
            _ABSTRACT(SDL_Gamepad) _I32);

HL_PRIM vbyte* HL_NAME(get_gamepad_apple_sf_symbols_name_for_axis)(
    SDL_Gamepad* g, int axis) {
    return copy_str(
        SDL_GetGamepadAppleSFSymbolsNameForAxis(g, (SDL_GamepadAxis)axis));
}
DEFINE_PRIM(_BYTES, get_gamepad_apple_sf_symbols_name_for_axis,
            _ABSTRACT(SDL_Gamepad) _I32);