#include "hashlink_macros.h"
#include "SDL3/SDL_pen.h"

HL_PRIM int HL_NAME(get_pen_device_type)(int instanceId) { return (int)SDL_GetPenDeviceType((SDL_PenID)instanceId); }
DEFINE_PRIM(_I32, get_pen_device_type, _I32);
