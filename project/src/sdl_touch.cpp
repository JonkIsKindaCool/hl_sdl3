#include "SDL3/SDL_touch.h"

#include <string.h>

#include "hashlink_macros.h"

static vbyte* copy_str(const char* s) {
    if (!s) return NULL;
    return hl_copy_bytes((const vbyte*)s, (int)strlen(s) + 1);
}

HL_PRIM varray* HL_NAME(get_touch_devices)() {
    int count = 0;
    SDL_TouchID* ids = SDL_GetTouchDevices(&count);
    if (!ids) return hl_alloc_array(&hlt_i32, 0);
    varray* a = hl_alloc_array(&hlt_i32, count * 2);
    int* p = hl_aptr(a, int);
    for (int i = 0; i < count; i++) {
        Uint64 id = (Uint64)ids[i];
        p[i * 2 + 0] = (int)(Uint32)(id >> 32);
        p[i * 2 + 1] = (int)(Uint32)(id & 0xFFFFFFFFu);
    }
    SDL_free(ids);
    return a;
}
DEFINE_PRIM(_ARR, get_touch_devices, _NO_ARG);

HL_PRIM vbyte* HL_NAME(get_touch_device_name)(int64 touchID) {
    return copy_str(SDL_GetTouchDeviceName((SDL_TouchID)touchID));
}
DEFINE_PRIM(_BYTES, get_touch_device_name, _I64);

HL_PRIM int HL_NAME(get_touch_device_type)(int64 touchID) {
    return (int)SDL_GetTouchDeviceType((SDL_TouchID)touchID);
}
DEFINE_PRIM(_I32, get_touch_device_type, _I64);

HL_PRIM int HL_NAME(get_touch_fingers_count)(int64 touchID) {
    int count = 0;
    SDL_Finger** fingers = SDL_GetTouchFingers((SDL_TouchID)touchID, &count);
    if (fingers) SDL_free(fingers);
    return count;
}
DEFINE_PRIM(_I32, get_touch_fingers_count, _I64);

HL_PRIM bool HL_NAME(get_touch_fingers)(int64 touchID, varray* out) {
    int count = 0;
    SDL_Finger** fingers = SDL_GetTouchFingers((SDL_TouchID)touchID, &count);
    if (!fingers) return false;
    int n = out->size / 4;
    if (n > count) n = count;
    double* o = hl_aptr(out, double);
    for (int i = 0; i < n; i++) {
        SDL_Finger* f = fingers[i];
        o[i * 4 + 0] = (double)f->id;
        o[i * 4 + 1] = (double)f->x;
        o[i * 4 + 2] = (double)f->y;
        o[i * 4 + 3] = (double)f->pressure;
    }
    SDL_free(fingers);
    return true;
}
DEFINE_PRIM(_BOOL, get_touch_fingers, _I64 _ARR);