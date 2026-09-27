#pragma once
#define HL_NAME(n) sdl3_##n

#include <hl.h>

#undef HL_PRIM
#ifdef _WIN32
#define HL_PRIM extern "C" __declspec(dllexport)
#else
#define HL_PRIM extern "C" __attribute__((visibility("default")))
#endif

#undef DEFINE_PRIM_WITH_NAME
#ifdef STATIC_HDLL
#define DEFINE_PRIM_WITH_NAME(t, name, args, realName)
#else
#define DEFINE_PRIM_WITH_NAME(t, name, args, realName)              \
    HL_EXTERN_C HL_EXPORT void* hlp_##realName(const char** sign) { \
        *sign = _FUN(t, args);                                      \
        return (void*)(&HL_NAME(realName));                         \
    }
#endif