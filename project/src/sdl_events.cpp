#include "SDL3/SDL_events.h"

#include <string.h>

#include "hashlink_macros.h"

#define EV_INTS 18
#define EV_FLOATS 6

static void put64(int* I, int idx, Uint64 v) {
    I[idx] = (int)(Uint32)(v >> 32);
    I[idx + 1] = (int)(Uint32)(v & 0xFFFFFFFFu);
}

HL_PRIM vbyte* HL_NAME(event_alloc)() {
    vbyte* p = (vbyte*)hl_gc_alloc_noptr(sizeof(SDL_Event));
    memset(p, 0, sizeof(SDL_Event));
    return p;
}
DEFINE_PRIM(_BYTES, event_alloc, _NO_ARG);

HL_PRIM int HL_NAME(event_type)(vbyte* p) { return (int)((SDL_Event*)p)->type; }
DEFINE_PRIM(_I32, event_type, _BYTES);

HL_PRIM void HL_NAME(event_decode)(vbyte* p, varray* ints, varray* floats) {
    SDL_Event* e = (SDL_Event*)p;
    int* I = hl_aptr(ints, int);
    double* F = hl_aptr(floats, double);
    for (int i = 0; i < ints->size; i++) I[i] = 0;
    for (int i = 0; i < floats->size; i++) F[i] = 0;
    put64(I, 16, e->common.timestamp);

    Uint32 t = e->type;

    if (t >= SDL_EVENT_DISPLAY_FIRST && t <= SDL_EVENT_DISPLAY_LAST) {
        I[0] = (int)e->display.displayID;
        I[1] = e->display.data1;
        I[2] = e->display.data2;
        return;
    }
    if (t >= SDL_EVENT_WINDOW_FIRST && t <= SDL_EVENT_WINDOW_LAST) {
        I[0] = (int)e->window.windowID;
        I[1] = e->window.data1;
        I[2] = e->window.data2;
        return;
    }
    if (t >= SDL_EVENT_USER) {
        I[0] = (int)e->user.windowID;
        I[1] = e->user.code;
        return;
    }

    switch (t) {
        case SDL_EVENT_KEYBOARD_ADDED:
        case SDL_EVENT_KEYBOARD_REMOVED:
            I[0] = (int)e->kdevice.which;
            break;
        case SDL_EVENT_KEY_DOWN:
        case SDL_EVENT_KEY_UP:
            I[0] = (int)e->key.windowID;
            I[1] = (int)e->key.which;
            I[2] = (int)e->key.scancode;
            I[3] = (int)e->key.key;
            I[4] = (int)e->key.mod;
            I[5] = (int)e->key.raw;
            I[6] = e->key.down;
            I[7] = e->key.repeat;
            break;
        case SDL_EVENT_TEXT_EDITING:
            I[0] = (int)e->edit.windowID;
            I[1] = e->edit.start;
            I[2] = e->edit.length;
            break;
        case SDL_EVENT_TEXT_INPUT:
            I[0] = (int)e->text.windowID;
            break;
        case SDL_EVENT_MOUSE_ADDED:
        case SDL_EVENT_MOUSE_REMOVED:
            I[0] = (int)e->mdevice.which;
            break;
        case SDL_EVENT_MOUSE_MOTION:
            I[0] = (int)e->motion.windowID;
            I[1] = (int)e->motion.which;
            I[2] = (int)e->motion.state;
            F[0] = e->motion.x;
            F[1] = e->motion.y;
            F[2] = e->motion.xrel;
            F[3] = e->motion.yrel;
            break;
        case SDL_EVENT_MOUSE_BUTTON_DOWN:
        case SDL_EVENT_MOUSE_BUTTON_UP:
            I[0] = (int)e->button.windowID;
            I[1] = (int)e->button.which;
            I[2] = e->button.button;
            I[3] = e->button.down;
            I[4] = e->button.clicks;
            F[0] = e->button.x;
            F[1] = e->button.y;
            break;
        case SDL_EVENT_MOUSE_WHEEL:
            I[0] = (int)e->wheel.windowID;
            I[1] = (int)e->wheel.which;
            I[2] = (int)e->wheel.direction;
            I[3] = e->wheel.integer_x;
            I[4] = e->wheel.integer_y;
            F[0] = e->wheel.x;
            F[1] = e->wheel.y;
            F[2] = e->wheel.mouse_x;
            F[3] = e->wheel.mouse_y;
            break;

        case SDL_EVENT_JOYSTICK_AXIS_MOTION:
            I[0] = (int)e->jaxis.which;
            I[1] = e->jaxis.axis;
            I[2] = e->jaxis.value;
            break;
        case SDL_EVENT_JOYSTICK_BALL_MOTION:
            I[0] = (int)e->jball.which;
            I[1] = e->jball.ball;
            I[2] = e->jball.xrel;
            I[3] = e->jball.yrel;
            break;
        case SDL_EVENT_JOYSTICK_HAT_MOTION:
            I[0] = (int)e->jhat.which;
            I[1] = e->jhat.hat;
            I[2] = e->jhat.value;
            break;
        case SDL_EVENT_JOYSTICK_BUTTON_DOWN:
        case SDL_EVENT_JOYSTICK_BUTTON_UP:
            I[0] = (int)e->jbutton.which;
            I[1] = e->jbutton.button;
            I[2] = e->jbutton.down;
            break;
        case SDL_EVENT_JOYSTICK_ADDED:
        case SDL_EVENT_JOYSTICK_REMOVED:
        case SDL_EVENT_JOYSTICK_UPDATE_COMPLETE:
            I[0] = (int)e->jdevice.which;
            break;
        case SDL_EVENT_JOYSTICK_BATTERY_UPDATED:
            I[0] = (int)e->jbattery.which;
            I[1] = (int)e->jbattery.state;
            I[2] = e->jbattery.percent;
            break;

        case SDL_EVENT_GAMEPAD_AXIS_MOTION:
            I[0] = (int)e->gaxis.which;
            I[1] = e->gaxis.axis;
            I[2] = e->gaxis.value;
            break;
        case SDL_EVENT_GAMEPAD_BUTTON_DOWN:
        case SDL_EVENT_GAMEPAD_BUTTON_UP:
            I[0] = (int)e->gbutton.which;
            I[1] = e->gbutton.button;
            I[2] = e->gbutton.down;
            break;
        case SDL_EVENT_GAMEPAD_ADDED:
        case SDL_EVENT_GAMEPAD_REMOVED:
        case SDL_EVENT_GAMEPAD_REMAPPED:
        case SDL_EVENT_GAMEPAD_UPDATE_COMPLETE:
        case SDL_EVENT_GAMEPAD_STEAM_HANDLE_UPDATED:
            I[0] = (int)e->gdevice.which;
            break;
        case SDL_EVENT_GAMEPAD_TOUCHPAD_DOWN:
        case SDL_EVENT_GAMEPAD_TOUCHPAD_MOTION:
        case SDL_EVENT_GAMEPAD_TOUCHPAD_UP:
            I[0] = (int)e->gtouchpad.which;
            I[1] = e->gtouchpad.touchpad;
            I[2] = e->gtouchpad.finger;
            F[0] = e->gtouchpad.x;
            F[1] = e->gtouchpad.y;
            F[2] = e->gtouchpad.pressure;
            break;
        case SDL_EVENT_GAMEPAD_SENSOR_UPDATE:
            I[0] = (int)e->gsensor.which;
            I[1] = e->gsensor.sensor;
            put64(I, 12, e->gsensor.sensor_timestamp);
            F[0] = e->gsensor.data[0];
            F[1] = e->gsensor.data[1];
            F[2] = e->gsensor.data[2];
            break;

        case SDL_EVENT_FINGER_DOWN:
        case SDL_EVENT_FINGER_UP:
        case SDL_EVENT_FINGER_MOTION:
        case SDL_EVENT_FINGER_CANCELED:
            I[0] = (int)e->tfinger.windowID;
            put64(I, 12, e->tfinger.touchID);
            put64(I, 14, e->tfinger.fingerID);
            F[0] = e->tfinger.x;
            F[1] = e->tfinger.y;
            F[2] = e->tfinger.dx;
            F[3] = e->tfinger.dy;
            F[4] = e->tfinger.pressure;
            break;
        case SDL_EVENT_PINCH_BEGIN:
        case SDL_EVENT_PINCH_UPDATE:
        case SDL_EVENT_PINCH_END:
            I[0] = (int)e->pinch.windowID;
            F[0] = e->pinch.scale;
            break;

        case SDL_EVENT_PEN_PROXIMITY_IN:
        case SDL_EVENT_PEN_PROXIMITY_OUT:
            I[0] = (int)e->pproximity.windowID;
            I[1] = (int)e->pproximity.which;
            I[2] = (int)e->pproximity.pen_state;
            break;
        case SDL_EVENT_PEN_MOTION:
            I[0] = (int)e->pmotion.windowID;
            I[1] = (int)e->pmotion.which;
            I[2] = (int)e->pmotion.pen_state;
            F[0] = e->pmotion.x;
            F[1] = e->pmotion.y;
            break;
        case SDL_EVENT_PEN_DOWN:
        case SDL_EVENT_PEN_UP:
            I[0] = (int)e->ptouch.windowID;
            I[1] = (int)e->ptouch.which;
            I[2] = (int)e->ptouch.pen_state;
            I[3] = e->ptouch.eraser;
            I[4] = e->ptouch.down;
            F[0] = e->ptouch.x;
            F[1] = e->ptouch.y;
            break;
        case SDL_EVENT_PEN_BUTTON_DOWN:
        case SDL_EVENT_PEN_BUTTON_UP:
            I[0] = (int)e->pbutton.windowID;
            I[1] = (int)e->pbutton.which;
            I[2] = (int)e->pbutton.pen_state;
            I[3] = e->pbutton.button;
            I[4] = e->pbutton.down;
            F[0] = e->pbutton.x;
            F[1] = e->pbutton.y;
            break;
        case SDL_EVENT_PEN_AXIS:
            I[0] = (int)e->paxis.windowID;
            I[1] = (int)e->paxis.which;
            I[2] = (int)e->paxis.pen_state;
            I[3] = (int)e->paxis.axis;
            F[0] = e->paxis.x;
            F[1] = e->paxis.y;
            F[2] = e->paxis.value;
            break;

        case SDL_EVENT_CLIPBOARD_UPDATE:
            I[0] = e->clipboard.owner;
            break;
        case SDL_EVENT_DROP_FILE:
        case SDL_EVENT_DROP_TEXT:
        case SDL_EVENT_DROP_BEGIN:
        case SDL_EVENT_DROP_COMPLETE:
        case SDL_EVENT_DROP_POSITION:
            I[0] = (int)e->drop.windowID;
            F[0] = e->drop.x;
            F[1] = e->drop.y;
            break;
        case SDL_EVENT_AUDIO_DEVICE_ADDED:
        case SDL_EVENT_AUDIO_DEVICE_REMOVED:
        case SDL_EVENT_AUDIO_DEVICE_FORMAT_CHANGED:
            I[0] = (int)e->adevice.which;
            I[1] = e->adevice.recording;
            break;
        case SDL_EVENT_CAMERA_DEVICE_ADDED:
        case SDL_EVENT_CAMERA_DEVICE_REMOVED:
        case SDL_EVENT_CAMERA_DEVICE_APPROVED:
        case SDL_EVENT_CAMERA_DEVICE_DENIED:
            I[0] = (int)e->cdevice.which;
            break;
        case SDL_EVENT_SENSOR_UPDATE:
            I[0] = (int)e->sensor.which;
            put64(I, 12, e->sensor.sensor_timestamp);
            for (int i = 0; i < 6; i++) F[i] = e->sensor.data[i];
            break;
        case SDL_EVENT_RENDER_TARGETS_RESET:
        case SDL_EVENT_RENDER_DEVICE_RESET:
        case SDL_EVENT_RENDER_DEVICE_LOST:
            I[0] = (int)e->render.windowID;
            break;
        default:
            break;
    }
}
DEFINE_PRIM(_VOID, event_decode, _BYTES _ARR _ARR);

HL_PRIM vbyte* HL_NAME(event_text)(vbyte* p, int idx) {
    SDL_Event* e = (SDL_Event*)p;
    const char* s = NULL;
    switch (e->type) {
        case SDL_EVENT_TEXT_EDITING:
            s = e->edit.text;
            break;
        case SDL_EVENT_TEXT_INPUT:
            s = e->text.text;
            break;
        case SDL_EVENT_DROP_FILE:
        case SDL_EVENT_DROP_TEXT:
        case SDL_EVENT_DROP_BEGIN:
        case SDL_EVENT_DROP_COMPLETE:
        case SDL_EVENT_DROP_POSITION:
            s = idx == 0 ? e->drop.source : e->drop.data;
            break;
        default:
            break;
    }
    if (!s) return NULL;
    return hl_copy_bytes((const vbyte*)s, (int)strlen(s) + 1);
}
DEFINE_PRIM(_BYTES, event_text, _BYTES _I32);

HL_PRIM void HL_NAME(pump_events)() { SDL_PumpEvents(); }
DEFINE_PRIM(_VOID, pump_events, _NO_ARG);

HL_PRIM bool HL_NAME(poll_event)(vbyte* p) {
    return SDL_PollEvent((SDL_Event*)p);
}
DEFINE_PRIM(_BOOL, poll_event, _BYTES);

HL_PRIM bool HL_NAME(wait_event)(vbyte* p) {
    hl_blocking(true);
    bool r = SDL_WaitEvent((SDL_Event*)p);
    hl_blocking(false);
    return r;
}
DEFINE_PRIM(_BOOL, wait_event, _BYTES);

HL_PRIM bool HL_NAME(wait_event_timeout)(vbyte* p, int ms) {
    hl_blocking(true);
    bool r = SDL_WaitEventTimeout((SDL_Event*)p, (Sint32)ms);
    hl_blocking(false);
    return r;
}
DEFINE_PRIM(_BOOL, wait_event_timeout, _BYTES _I32);

HL_PRIM int HL_NAME(count_events)(int minType, int maxType) {
    return SDL_PeepEvents(NULL, 0, SDL_PEEKEVENT, (Uint32)minType,
                          (Uint32)maxType);
}
DEFINE_PRIM(_I32, count_events, _I32 _I32);

HL_PRIM bool HL_NAME(has_event)(int type) { return SDL_HasEvent((Uint32)type); }
DEFINE_PRIM(_BOOL, has_event, _I32);

HL_PRIM bool HL_NAME(has_events)(int minType, int maxType) {
    return SDL_HasEvents((Uint32)minType, (Uint32)maxType);
}
DEFINE_PRIM(_BOOL, has_events, _I32 _I32);

HL_PRIM void HL_NAME(flush_event)(int type) { SDL_FlushEvent((Uint32)type); }
DEFINE_PRIM(_VOID, flush_event, _I32);

HL_PRIM void HL_NAME(flush_events)(int minType, int maxType) {
    SDL_FlushEvents((Uint32)minType, (Uint32)maxType);
}
DEFINE_PRIM(_VOID, flush_events, _I32 _I32);

HL_PRIM void HL_NAME(set_event_enabled)(int type, bool enabled) {
    SDL_SetEventEnabled((Uint32)type, enabled);
}
DEFINE_PRIM(_VOID, set_event_enabled, _I32 _BOOL);

HL_PRIM bool HL_NAME(event_enabled)(int type) {
    return SDL_EventEnabled((Uint32)type);
}
DEFINE_PRIM(_BOOL, event_enabled, _I32);

HL_PRIM int HL_NAME(register_events)(int n) {
    return (int)SDL_RegisterEvents(n);
}
DEFINE_PRIM(_I32, register_events, _I32);

HL_PRIM bool HL_NAME(push_user_event)(int type, int windowID, int code) {
    SDL_Event e;
    SDL_zero(e);
    e.type = (Uint32)type;
    e.user.windowID = (SDL_WindowID)windowID;
    e.user.code = code;
    return SDL_PushEvent(&e);
}
DEFINE_PRIM(_BOOL, push_user_event, _I32 _I32 _I32);

HL_PRIM bool HL_NAME(push_quit_event)() {
    SDL_Event e;
    SDL_zero(e);
    e.type = SDL_EVENT_QUIT;
    return SDL_PushEvent(&e);
}
DEFINE_PRIM(_BOOL, push_quit_event, _NO_ARG);

HL_PRIM vbyte* HL_NAME(event_description)(vbyte* p) {
    char buf[512];
    SDL_GetEventDescription((SDL_Event*)p, buf, (int)sizeof(buf));
    return hl_copy_bytes((const vbyte*)buf, (int)strlen(buf) + 1);
}
DEFINE_PRIM(_BYTES, event_description, _BYTES);

HL_PRIM SDL_Window* HL_NAME(get_window_from_event)(vbyte* p) {
    return SDL_GetWindowFromEvent((SDL_Event*)p);
}
DEFINE_PRIM(_ABSTRACT(SDL_Window), get_window_from_event, _BYTES);

static SDL_Mutex* lc_mutex = NULL;
static int lc_queue[32];
static int lc_count = 0;

static bool SDLCALL lifecycle_watch(void* userdata, SDL_Event* e) {
    switch (e->type) {
        case SDL_EVENT_TERMINATING:
        case SDL_EVENT_LOW_MEMORY:
        case SDL_EVENT_WILL_ENTER_BACKGROUND:
        case SDL_EVENT_DID_ENTER_BACKGROUND:
        case SDL_EVENT_WILL_ENTER_FOREGROUND:
        case SDL_EVENT_DID_ENTER_FOREGROUND:
            SDL_LockMutex(lc_mutex);
            if (lc_count < 32) lc_queue[lc_count++] = (int)e->type;
            SDL_UnlockMutex(lc_mutex);
            break;
        default:
            break;
    }
    return true;
}

HL_PRIM bool HL_NAME(lifecycle_watch_install)() {
    if (!lc_mutex) lc_mutex = SDL_CreateMutex();
    return SDL_AddEventWatch(lifecycle_watch, NULL);
}
DEFINE_PRIM(_BOOL, lifecycle_watch_install, _NO_ARG);

HL_PRIM void HL_NAME(lifecycle_watch_remove)() {
    SDL_RemoveEventWatch(lifecycle_watch, NULL);
}
DEFINE_PRIM(_VOID, lifecycle_watch_remove, _NO_ARG);

HL_PRIM int HL_NAME(lifecycle_poll)() {
    if (!lc_mutex) return 0;
    int r = 0;
    SDL_LockMutex(lc_mutex);
    if (lc_count > 0) {
        r = lc_queue[0];
        for (int i = 1; i < lc_count; i++) lc_queue[i - 1] = lc_queue[i];
        lc_count--;
    }
    SDL_UnlockMutex(lc_mutex);
    return r;
}
DEFINE_PRIM(_I32, lifecycle_poll, _NO_ARG);