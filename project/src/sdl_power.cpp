#include "hashlink_macros.h"
#include "SDL3/SDL_power.h"

HL_PRIM int HL_NAME(get_power_info)(varray* out) {
	int seconds = -1, percent = -1;
	SDL_PowerState state = SDL_GetPowerInfo(&seconds, &percent);
	int* o = hl_aptr(out, int);
	o[0] = seconds;
	o[1] = percent;
	return (int)state;
}
DEFINE_PRIM(_I32, get_power_info, _ARR);
