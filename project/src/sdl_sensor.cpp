#include "hashlink_macros.h"
#include "SDL3/SDL_sensor.h"
#include <string.h>

static vbyte* copy_str(const char* s) {
	if (!s)
		return NULL;
	return hl_copy_bytes((const vbyte*)s, (int)strlen(s) + 1);
}

static varray* ids_to_array(SDL_SensorID* ids, int count) {
	if (!ids)
		return hl_alloc_array(&hlt_i32, 0);
	varray* a = hl_alloc_array(&hlt_i32, count);
	int* p = hl_aptr(a, int);
	for (int i = 0; i < count; i++)
		p[i] = (int)ids[i];
	SDL_free(ids);
	return a;
}

HL_PRIM varray* HL_NAME(get_sensors)() {
	int count = 0;
	SDL_SensorID* ids = SDL_GetSensors(&count);
	return ids_to_array(ids, count);
}
DEFINE_PRIM(_ARR, get_sensors, _NO_ARG);

HL_PRIM vbyte* HL_NAME(get_sensor_name_for_id)(int id) { return copy_str(SDL_GetSensorNameForID((SDL_SensorID)id)); }
DEFINE_PRIM(_BYTES, get_sensor_name_for_id, _I32);

HL_PRIM int HL_NAME(get_sensor_type_for_id)(int id) { return (int)SDL_GetSensorTypeForID((SDL_SensorID)id); }
DEFINE_PRIM(_I32, get_sensor_type_for_id, _I32);

HL_PRIM int HL_NAME(get_sensor_non_portable_type_for_id)(int id) { return SDL_GetSensorNonPortableTypeForID((SDL_SensorID)id); }
DEFINE_PRIM(_I32, get_sensor_non_portable_type_for_id, _I32);

HL_PRIM SDL_Sensor* HL_NAME(open_sensor)(int id) { return SDL_OpenSensor((SDL_SensorID)id); }
DEFINE_PRIM(_ABSTRACT(SDL_Sensor), open_sensor, _I32);

HL_PRIM SDL_Sensor* HL_NAME(get_sensor_from_id)(int id) { return SDL_GetSensorFromID((SDL_SensorID)id); }
DEFINE_PRIM(_ABSTRACT(SDL_Sensor), get_sensor_from_id, _I32);

HL_PRIM vbyte* HL_NAME(get_sensor_name)(SDL_Sensor* s) { return copy_str(SDL_GetSensorName(s)); }
DEFINE_PRIM(_BYTES, get_sensor_name, _ABSTRACT(SDL_Sensor));

HL_PRIM int HL_NAME(get_sensor_type)(SDL_Sensor* s) { return (int)SDL_GetSensorType(s); }
DEFINE_PRIM(_I32, get_sensor_type, _ABSTRACT(SDL_Sensor));

HL_PRIM int HL_NAME(get_sensor_non_portable_type)(SDL_Sensor* s) { return SDL_GetSensorNonPortableType(s); }
DEFINE_PRIM(_I32, get_sensor_non_portable_type, _ABSTRACT(SDL_Sensor));

HL_PRIM int HL_NAME(get_sensor_id)(SDL_Sensor* s) { return (int)SDL_GetSensorID(s); }
DEFINE_PRIM(_I32, get_sensor_id, _ABSTRACT(SDL_Sensor));

HL_PRIM bool HL_NAME(get_sensor_data)(SDL_Sensor* s, varray* out) {
	int n = out->size;
	float tmp[16];
	if (n > 16)
		n = 16;
	bool ok = SDL_GetSensorData(s, tmp, n);
	double* o = hl_aptr(out, double);
	for (int i = 0; i < n; i++)
		o[i] = tmp[i];
	return ok;
}
DEFINE_PRIM(_BOOL, get_sensor_data, _ABSTRACT(SDL_Sensor) _ARR);

HL_PRIM void HL_NAME(close_sensor)(SDL_Sensor* s) { SDL_CloseSensor(s); }
DEFINE_PRIM(_VOID, close_sensor, _ABSTRACT(SDL_Sensor));

HL_PRIM void HL_NAME(update_sensors)() { SDL_UpdateSensors(); }
DEFINE_PRIM(_VOID, update_sensors, _NO_ARG);
