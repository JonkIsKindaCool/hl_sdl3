#include "SDL3/SDL_haptic.h"

#include <string.h>

#include "hashlink_macros.h"

#define HE_INTS 40

static vbyte* copy_str(const char* s) {
    if (!s) return NULL;
    return hl_copy_bytes((const vbyte*)s, (int)strlen(s) + 1);
}

static varray* ids_to_array(SDL_HapticID* ids, int count) {
    if (!ids) return hl_alloc_array(&hlt_i32, 0);
    varray* a = hl_alloc_array(&hlt_i32, count);
    int* p = hl_aptr(a, int);
    for (int i = 0; i < count; i++) p[i] = (int)ids[i];
    SDL_free(ids);
    return a;
}

static void build_effect(varray* ints, varray* data, SDL_HapticEffect* e,
                         Uint16** owned_data) {
    int* I = hl_aptr(ints, int);
    memset(e, 0, sizeof(SDL_HapticEffect));
    *owned_data = NULL;

    Uint16 type = (Uint16)I[0];
    e->type = type;

    SDL_HapticDirection dir;
    dir.type = (Uint8)I[1];
    dir.dir[0] = I[2];
    dir.dir[1] = I[3];
    dir.dir[2] = I[4];

    switch (type) {
        case SDL_HAPTIC_CONSTANT:
            e->constant.type = type;
            e->constant.direction = dir;
            e->constant.length = (Uint32)I[5];
            e->constant.delay = (Uint16)I[6];
            e->constant.button = (Uint16)I[7];
            e->constant.interval = (Uint16)I[8];
            e->constant.level = (Sint16)I[13];
            e->constant.attack_length = (Uint16)I[9];
            e->constant.attack_level = (Uint16)I[10];
            e->constant.fade_length = (Uint16)I[11];
            e->constant.fade_level = (Uint16)I[12];
            break;
        case SDL_HAPTIC_SINE:
        case SDL_HAPTIC_SQUARE:
        case SDL_HAPTIC_TRIANGLE:
        case SDL_HAPTIC_SAWTOOTHUP:
        case SDL_HAPTIC_SAWTOOTHDOWN:
            e->periodic.type = type;
            e->periodic.direction = dir;
            e->periodic.length = (Uint32)I[5];
            e->periodic.delay = (Uint16)I[6];
            e->periodic.button = (Uint16)I[7];
            e->periodic.interval = (Uint16)I[8];
            e->periodic.period = (Uint16)I[15];
            e->periodic.magnitude = (Sint16)I[16];
            e->periodic.offset = (Sint16)I[17];
            e->periodic.phase = (Uint16)I[18];
            e->periodic.attack_length = (Uint16)I[9];
            e->periodic.attack_level = (Uint16)I[10];
            e->periodic.fade_length = (Uint16)I[11];
            e->periodic.fade_level = (Uint16)I[12];
            break;
        case SDL_HAPTIC_SPRING:
        case SDL_HAPTIC_DAMPER:
        case SDL_HAPTIC_INERTIA:
        case SDL_HAPTIC_FRICTION:
            e->condition.type = type;
            e->condition.direction = dir;
            e->condition.length = (Uint32)I[5];
            e->condition.delay = (Uint16)I[6];
            e->condition.button = (Uint16)I[7];
            e->condition.interval = (Uint16)I[8];
            for (int a = 0; a < 3; a++) {
                e->condition.right_sat[a] = (Uint16)I[21 + a];
                e->condition.left_sat[a] = (Uint16)I[24 + a];
                e->condition.right_coeff[a] = (Sint16)I[27 + a];
                e->condition.left_coeff[a] = (Sint16)I[30 + a];
                e->condition.deadband[a] = (Uint16)I[33 + a];
                e->condition.center[a] = (Sint16)I[36 + a];
            }
            break;
        case SDL_HAPTIC_RAMP:
            e->ramp.type = type;
            e->ramp.direction = dir;
            e->ramp.length = (Uint32)I[5];
            e->ramp.delay = (Uint16)I[6];
            e->ramp.button = (Uint16)I[7];
            e->ramp.interval = (Uint16)I[8];
            e->ramp.start = (Sint16)I[13];
            e->ramp.end = (Sint16)I[14];
            e->ramp.attack_length = (Uint16)I[9];
            e->ramp.attack_level = (Uint16)I[10];
            e->ramp.fade_length = (Uint16)I[11];
            e->ramp.fade_level = (Uint16)I[12];
            break;
        case SDL_HAPTIC_LEFTRIGHT:
            e->leftright.type = type;
            e->leftright.length = (Uint32)I[5];
            e->leftright.large_magnitude = (Uint16)I[13];
            e->leftright.small_magnitude = (Uint16)I[14];
            break;
        case SDL_HAPTIC_CUSTOM:
            e->custom.type = type;
            e->custom.direction = dir;
            e->custom.length = (Uint32)I[5];
            e->custom.delay = (Uint16)I[6];
            e->custom.button = (Uint16)I[7];
            e->custom.interval = (Uint16)I[8];
            e->custom.channels = (Uint8)I[19];
            e->custom.period = (Uint16)I[15];
            e->custom.samples = (Uint16)I[20];
            e->custom.attack_length = (Uint16)I[9];
            e->custom.attack_level = (Uint16)I[10];
            e->custom.fade_length = (Uint16)I[11];
            e->custom.fade_level = (Uint16)I[12];
            if (data && data->size > 0) {
                int n = data->size;
                int* src = hl_aptr(data, int);
                Uint16* buf = (Uint16*)SDL_malloc(sizeof(Uint16) * n);
                for (int k = 0; k < n; k++) buf[k] = (Uint16)src[k];
                e->custom.data = buf;
                *owned_data = buf;
            }
            break;
        default:
            break;
    }
}

HL_PRIM varray* HL_NAME(get_haptics)() {
    int count = 0;
    SDL_HapticID* ids = SDL_GetHaptics(&count);
    return ids_to_array(ids, count);
}
DEFINE_PRIM(_ARR, get_haptics, _NO_ARG);

HL_PRIM vbyte* HL_NAME(get_haptic_name_for_id)(int id) {
    return copy_str(SDL_GetHapticNameForID((SDL_HapticID)id));
}
DEFINE_PRIM(_BYTES, get_haptic_name_for_id, _I32);

HL_PRIM SDL_Haptic* HL_NAME(open_haptic)(int id) {
    return SDL_OpenHaptic((SDL_HapticID)id);
}
DEFINE_PRIM(_ABSTRACT(SDL_Haptic), open_haptic, _I32);

HL_PRIM SDL_Haptic* HL_NAME(get_haptic_from_id)(int id) {
    return SDL_GetHapticFromID((SDL_HapticID)id);
}
DEFINE_PRIM(_ABSTRACT(SDL_Haptic), get_haptic_from_id, _I32);

HL_PRIM int HL_NAME(get_haptic_id)(SDL_Haptic* h) {
    return (int)SDL_GetHapticID(h);
}
DEFINE_PRIM(_I32, get_haptic_id, _ABSTRACT(SDL_Haptic));

HL_PRIM vbyte* HL_NAME(get_haptic_name)(SDL_Haptic* h) {
    return copy_str(SDL_GetHapticName(h));
}
DEFINE_PRIM(_BYTES, get_haptic_name, _ABSTRACT(SDL_Haptic));

HL_PRIM bool HL_NAME(is_mouse_haptic)() { return SDL_IsMouseHaptic(); }
DEFINE_PRIM(_BOOL, is_mouse_haptic, _NO_ARG);

HL_PRIM SDL_Haptic* HL_NAME(open_haptic_from_mouse)() {
    return SDL_OpenHapticFromMouse();
}
DEFINE_PRIM(_ABSTRACT(SDL_Haptic), open_haptic_from_mouse, _NO_ARG);

HL_PRIM bool HL_NAME(is_joystick_haptic)(SDL_Joystick* j) {
    return SDL_IsJoystickHaptic(j);
}
DEFINE_PRIM(_BOOL, is_joystick_haptic, _ABSTRACT(SDL_Joystick));

HL_PRIM SDL_Haptic* HL_NAME(open_haptic_from_joystick)(SDL_Joystick* j) {
    return SDL_OpenHapticFromJoystick(j);
}
DEFINE_PRIM(_ABSTRACT(SDL_Haptic), open_haptic_from_joystick,
            _ABSTRACT(SDL_Joystick));

HL_PRIM void HL_NAME(close_haptic)(SDL_Haptic* h) { SDL_CloseHaptic(h); }
DEFINE_PRIM(_VOID, close_haptic, _ABSTRACT(SDL_Haptic));

HL_PRIM int HL_NAME(get_max_haptic_effects)(SDL_Haptic* h) {
    return SDL_GetMaxHapticEffects(h);
}
DEFINE_PRIM(_I32, get_max_haptic_effects, _ABSTRACT(SDL_Haptic));

HL_PRIM int HL_NAME(get_max_haptic_effects_playing)(SDL_Haptic* h) {
    return SDL_GetMaxHapticEffectsPlaying(h);
}
DEFINE_PRIM(_I32, get_max_haptic_effects_playing, _ABSTRACT(SDL_Haptic));

HL_PRIM int HL_NAME(get_haptic_features)(SDL_Haptic* h) {
    return (int)SDL_GetHapticFeatures(h);
}
DEFINE_PRIM(_I32, get_haptic_features, _ABSTRACT(SDL_Haptic));

HL_PRIM int HL_NAME(get_num_haptic_axes)(SDL_Haptic* h) {
    return SDL_GetNumHapticAxes(h);
}
DEFINE_PRIM(_I32, get_num_haptic_axes, _ABSTRACT(SDL_Haptic));

HL_PRIM bool HL_NAME(haptic_effect_supported)(SDL_Haptic* h, varray* ints) {
    SDL_HapticEffect e;
    Uint16* owned = NULL;
    build_effect(ints, NULL, &e, &owned);
    bool r = SDL_HapticEffectSupported(h, &e);
    SDL_free(owned);
    return r;
}
DEFINE_PRIM(_BOOL, haptic_effect_supported, _ABSTRACT(SDL_Haptic) _ARR);

HL_PRIM int HL_NAME(create_haptic_effect)(SDL_Haptic* h, varray* ints,
                                          varray* data) {
    SDL_HapticEffect e;
    Uint16* owned = NULL;
    build_effect(ints, data, &e, &owned);
    int id = SDL_CreateHapticEffect(h, &e);
    SDL_free(owned);
    return id;
}
DEFINE_PRIM(_I32, create_haptic_effect, _ABSTRACT(SDL_Haptic) _ARR _ARR);

HL_PRIM bool HL_NAME(update_haptic_effect)(SDL_Haptic* h, int effect,
                                           varray* ints, varray* data) {
    SDL_HapticEffect e;
    Uint16* owned = NULL;
    build_effect(ints, data, &e, &owned);
    bool r = SDL_UpdateHapticEffect(h, (SDL_HapticEffectID)effect, &e);
    SDL_free(owned);
    return r;
}
DEFINE_PRIM(_BOOL, update_haptic_effect, _ABSTRACT(SDL_Haptic) _I32 _ARR _ARR);

HL_PRIM bool HL_NAME(run_haptic_effect)(SDL_Haptic* h, int effect,
                                        int iterations) {
    return SDL_RunHapticEffect(h, (SDL_HapticEffectID)effect,
                               (Uint32)iterations);
}
DEFINE_PRIM(_BOOL, run_haptic_effect, _ABSTRACT(SDL_Haptic) _I32 _I32);

HL_PRIM bool HL_NAME(stop_haptic_effect)(SDL_Haptic* h, int effect) {
    return SDL_StopHapticEffect(h, (SDL_HapticEffectID)effect);
}
DEFINE_PRIM(_BOOL, stop_haptic_effect, _ABSTRACT(SDL_Haptic) _I32);

HL_PRIM void HL_NAME(destroy_haptic_effect)(SDL_Haptic* h, int effect) {
    SDL_DestroyHapticEffect(h, (SDL_HapticEffectID)effect);
}
DEFINE_PRIM(_VOID, destroy_haptic_effect, _ABSTRACT(SDL_Haptic) _I32);

HL_PRIM bool HL_NAME(get_haptic_effect_status)(SDL_Haptic* h, int effect) {
    return SDL_GetHapticEffectStatus(h, (SDL_HapticEffectID)effect);
}
DEFINE_PRIM(_BOOL, get_haptic_effect_status, _ABSTRACT(SDL_Haptic) _I32);

HL_PRIM bool HL_NAME(set_haptic_gain)(SDL_Haptic* h, int gain) {
    return SDL_SetHapticGain(h, gain);
}
DEFINE_PRIM(_BOOL, set_haptic_gain, _ABSTRACT(SDL_Haptic) _I32);

HL_PRIM bool HL_NAME(set_haptic_autocenter)(SDL_Haptic* h, int autocenter) {
    return SDL_SetHapticAutocenter(h, autocenter);
}
DEFINE_PRIM(_BOOL, set_haptic_autocenter, _ABSTRACT(SDL_Haptic) _I32);

HL_PRIM bool HL_NAME(pause_haptic)(SDL_Haptic* h) { return SDL_PauseHaptic(h); }
DEFINE_PRIM(_BOOL, pause_haptic, _ABSTRACT(SDL_Haptic));

HL_PRIM bool HL_NAME(resume_haptic)(SDL_Haptic* h) {
    return SDL_ResumeHaptic(h);
}
DEFINE_PRIM(_BOOL, resume_haptic, _ABSTRACT(SDL_Haptic));

HL_PRIM bool HL_NAME(stop_haptic_effects)(SDL_Haptic* h) {
    return SDL_StopHapticEffects(h);
}
DEFINE_PRIM(_BOOL, stop_haptic_effects, _ABSTRACT(SDL_Haptic));

HL_PRIM bool HL_NAME(haptic_rumble_supported)(SDL_Haptic* h) {
    return SDL_HapticRumbleSupported(h);
}
DEFINE_PRIM(_BOOL, haptic_rumble_supported, _ABSTRACT(SDL_Haptic));

HL_PRIM bool HL_NAME(init_haptic_rumble)(SDL_Haptic* h) {
    return SDL_InitHapticRumble(h);
}
DEFINE_PRIM(_BOOL, init_haptic_rumble, _ABSTRACT(SDL_Haptic));

HL_PRIM bool HL_NAME(play_haptic_rumble)(SDL_Haptic* h, double strength,
                                         int lengthMs) {
    return SDL_PlayHapticRumble(h, (float)strength, (Uint32)lengthMs);
}
DEFINE_PRIM(_BOOL, play_haptic_rumble, _ABSTRACT(SDL_Haptic) _F64 _I32);

HL_PRIM bool HL_NAME(stop_haptic_rumble)(SDL_Haptic* h) {
    return SDL_StopHapticRumble(h);
}
DEFINE_PRIM(_BOOL, stop_haptic_rumble, _ABSTRACT(SDL_Haptic));
