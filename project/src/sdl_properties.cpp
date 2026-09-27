#include "hashlink_macros.h"
#include "SDL3/SDL_properties.h"
#include <string.h>
#include <string>
#include <vector>

static vbyte* copy_str(const char* s) {
	if (!s)
		return NULL;
	return hl_copy_bytes((const vbyte*)s, (int)strlen(s) + 1);
}

HL_PRIM int HL_NAME(get_global_properties)() { return (int)SDL_GetGlobalProperties(); }
DEFINE_PRIM(_I32, get_global_properties, _NO_ARG);

HL_PRIM int HL_NAME(create_properties)() { return (int)SDL_CreateProperties(); }
DEFINE_PRIM(_I32, create_properties, _NO_ARG);

HL_PRIM bool HL_NAME(copy_properties)(int src, int dst) { return SDL_CopyProperties((SDL_PropertiesID)src, (SDL_PropertiesID)dst); }
DEFINE_PRIM(_BOOL, copy_properties, _I32 _I32);

HL_PRIM bool HL_NAME(lock_properties)(int props) { return SDL_LockProperties((SDL_PropertiesID)props); }
DEFINE_PRIM(_BOOL, lock_properties, _I32);

HL_PRIM void HL_NAME(unlock_properties)(int props) { SDL_UnlockProperties((SDL_PropertiesID)props); }
DEFINE_PRIM(_VOID, unlock_properties, _I32);

HL_PRIM bool HL_NAME(set_pointer_property)(int props, vbyte* name, vbyte* value) {
	return SDL_SetPointerProperty((SDL_PropertiesID)props, (const char*)name, (void*)value);
}
DEFINE_PRIM(_BOOL, set_pointer_property, _I32 _BYTES _BYTES);

HL_PRIM bool HL_NAME(set_string_property)(int props, vbyte* name, vbyte* value) {
	return SDL_SetStringProperty((SDL_PropertiesID)props, (const char*)name, (const char*)value);
}
DEFINE_PRIM(_BOOL, set_string_property, _I32 _BYTES _BYTES);

HL_PRIM bool HL_NAME(set_number_property)(int props, vbyte* name, int hi, int lo) {
	Sint64 v = ((Sint64)(Uint32)hi << 32) | (Uint32)lo;
	return SDL_SetNumberProperty((SDL_PropertiesID)props, (const char*)name, v);
}
DEFINE_PRIM(_BOOL, set_number_property, _I32 _BYTES _I32 _I32);

HL_PRIM bool HL_NAME(set_float_property)(int props, vbyte* name, double value) {
	return SDL_SetFloatProperty((SDL_PropertiesID)props, (const char*)name, (float)value);
}
DEFINE_PRIM(_BOOL, set_float_property, _I32 _BYTES _F64);

HL_PRIM bool HL_NAME(set_boolean_property)(int props, vbyte* name, bool value) {
	return SDL_SetBooleanProperty((SDL_PropertiesID)props, (const char*)name, value);
}
DEFINE_PRIM(_BOOL, set_boolean_property, _I32 _BYTES _BOOL);

HL_PRIM bool HL_NAME(has_property)(int props, vbyte* name) { return SDL_HasProperty((SDL_PropertiesID)props, (const char*)name); }
DEFINE_PRIM(_BOOL, has_property, _I32 _BYTES);

HL_PRIM int HL_NAME(get_property_type)(int props, vbyte* name) { return (int)SDL_GetPropertyType((SDL_PropertiesID)props, (const char*)name); }
DEFINE_PRIM(_I32, get_property_type, _I32 _BYTES);

HL_PRIM vbyte* HL_NAME(get_pointer_property)(int props, vbyte* name, vbyte* defaultValue) {
	return (vbyte*)SDL_GetPointerProperty((SDL_PropertiesID)props, (const char*)name, (void*)defaultValue);
}
DEFINE_PRIM(_BYTES, get_pointer_property, _I32 _BYTES _BYTES);

HL_PRIM vbyte* HL_NAME(get_string_property)(int props, vbyte* name, vbyte* defaultValue) {
	return copy_str(SDL_GetStringProperty((SDL_PropertiesID)props, (const char*)name, (const char*)defaultValue));
}
DEFINE_PRIM(_BYTES, get_string_property, _I32 _BYTES _BYTES);

HL_PRIM void HL_NAME(get_number_property)(int props, vbyte* name, int defaultHi, int defaultLo, varray* out) {
	Sint64 def = ((Sint64)(Uint32)defaultHi << 32) | (Uint32)defaultLo;
	Sint64 v = SDL_GetNumberProperty((SDL_PropertiesID)props, (const char*)name, def);
	int* o = hl_aptr(out, int);
	o[0] = (int)(Uint32)((Uint64)v >> 32);
	o[1] = (int)(Uint32)((Uint64)v & 0xFFFFFFFFu);
}
DEFINE_PRIM(_VOID, get_number_property, _I32 _BYTES _I32 _I32 _ARR);

HL_PRIM double HL_NAME(get_float_property)(int props, vbyte* name, double defaultValue) {
	return (double)SDL_GetFloatProperty((SDL_PropertiesID)props, (const char*)name, (float)defaultValue);
}
DEFINE_PRIM(_F64, get_float_property, _I32 _BYTES _F64);

HL_PRIM bool HL_NAME(get_boolean_property)(int props, vbyte* name, bool defaultValue) {
	return SDL_GetBooleanProperty((SDL_PropertiesID)props, (const char*)name, defaultValue);
}
DEFINE_PRIM(_BOOL, get_boolean_property, _I32 _BYTES _BOOL);

HL_PRIM bool HL_NAME(clear_property)(int props, vbyte* name) { return SDL_ClearProperty((SDL_PropertiesID)props, (const char*)name); }
DEFINE_PRIM(_BOOL, clear_property, _I32 _BYTES);

static void SDLCALL enum_props_cb(void* userdata, SDL_PropertiesID props, const char* name) {
	std::vector<std::string>* names = (std::vector<std::string>*)userdata;
	names->push_back(name ? name : "");
}

HL_PRIM varray* HL_NAME(enumerate_properties)(int props) {
	std::vector<std::string> names;
	if (!SDL_EnumerateProperties((SDL_PropertiesID)props, enum_props_cb, &names))
		return NULL;
	varray* a = hl_alloc_array(&hlt_bytes, (int)names.size());
	vbyte** p = hl_aptr(a, vbyte*);
	for (size_t i = 0; i < names.size(); i++)
		p[i] = copy_str(names[i].c_str());
	return a;
}
DEFINE_PRIM(_ARR, enumerate_properties, _I32);

HL_PRIM void HL_NAME(destroy_properties)(int props) { SDL_DestroyProperties((SDL_PropertiesID)props); }
DEFINE_PRIM(_VOID, destroy_properties, _I32);
