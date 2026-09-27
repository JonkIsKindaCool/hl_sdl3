#include "SDL3/SDL_camera.h"

#include "hashlink_macros.h"

HL_PRIM SDL_CameraSpec* HL_NAME(camera_spec_alloc)(int format, int colorspace,
                                                   int width, int height,
                                                   int fpsNum, int fpsDen) {
    SDL_CameraSpec* s =
        (SDL_CameraSpec*)hl_gc_alloc_noptr(sizeof(SDL_CameraSpec));
    s->format = (SDL_PixelFormat)format;
    s->colorspace = (SDL_Colorspace)colorspace;
    s->width = width;
    s->height = height;
    s->framerate_numerator = fpsNum;
    s->framerate_denominator = fpsDen;
    return s;
}
DEFINE_PRIM(_ABSTRACT(SDL_CameraSpec), camera_spec_alloc,
            _I32 _I32 _I32 _I32 _I32 _I32);

HL_PRIM int HL_NAME(camera_spec_format)(SDL_CameraSpec* s) {
    return (int)s->format;
}
DEFINE_PRIM(_I32, camera_spec_format, _ABSTRACT(SDL_CameraSpec));
HL_PRIM int HL_NAME(camera_spec_colorspace)(SDL_CameraSpec* s) {
    return (int)s->colorspace;
}
DEFINE_PRIM(_I32, camera_spec_colorspace, _ABSTRACT(SDL_CameraSpec));
HL_PRIM int HL_NAME(camera_spec_width)(SDL_CameraSpec* s) { return s->width; }
DEFINE_PRIM(_I32, camera_spec_width, _ABSTRACT(SDL_CameraSpec));
HL_PRIM int HL_NAME(camera_spec_height)(SDL_CameraSpec* s) { return s->height; }
DEFINE_PRIM(_I32, camera_spec_height, _ABSTRACT(SDL_CameraSpec));
HL_PRIM int HL_NAME(camera_spec_fps_num)(SDL_CameraSpec* s) {
    return s->framerate_numerator;
}
DEFINE_PRIM(_I32, camera_spec_fps_num, _ABSTRACT(SDL_CameraSpec));
HL_PRIM int HL_NAME(camera_spec_fps_den)(SDL_CameraSpec* s) {
    return s->framerate_denominator;
}
DEFINE_PRIM(_I32, camera_spec_fps_den, _ABSTRACT(SDL_CameraSpec));

HL_PRIM int HL_NAME(get_num_camera_drivers)() {
    return SDL_GetNumCameraDrivers();
}
DEFINE_PRIM(_I32, get_num_camera_drivers, _NO_ARG);

HL_PRIM vbyte* HL_NAME(get_camera_driver)(int index) {
    return (vbyte*)SDL_GetCameraDriver(index);
}
DEFINE_PRIM(_BYTES, get_camera_driver, _I32);

HL_PRIM vbyte* HL_NAME(get_current_camera_driver)() {
    return (vbyte*)SDL_GetCurrentCameraDriver();
}
DEFINE_PRIM(_BYTES, get_current_camera_driver, _NO_ARG);

HL_PRIM varray* HL_NAME(get_cameras)() {
    int count = 0;
    SDL_CameraID* ids = SDL_GetCameras(&count);
    if (!ids) return hl_alloc_array(&hlt_i32, 0);
    varray* a = hl_alloc_array(&hlt_i32, count);
    int* p = hl_aptr(a, int);
    for (int i = 0; i < count; i++) p[i] = (int)ids[i];
    SDL_free(ids);
    return a;
}
DEFINE_PRIM(_ARR, get_cameras, _NO_ARG);

HL_PRIM varray* HL_NAME(get_camera_supported_formats)(int id) {
    int count = 0;
    SDL_CameraSpec** specs =
        SDL_GetCameraSupportedFormats((SDL_CameraID)id, &count);
    if (!specs) return hl_alloc_array(&hlt_i32, 0);
    varray* a = hl_alloc_array(&hlt_i32, count * 6);
    int* p = hl_aptr(a, int);
    for (int i = 0; i < count; i++) {
        SDL_CameraSpec* s = specs[i];
        p[i * 6 + 0] = (int)s->format;
        p[i * 6 + 1] = (int)s->colorspace;
        p[i * 6 + 2] = s->width;
        p[i * 6 + 3] = s->height;
        p[i * 6 + 4] = s->framerate_numerator;
        p[i * 6 + 5] = s->framerate_denominator;
    }
    SDL_free(specs);
    return a;
}
DEFINE_PRIM(_ARR, get_camera_supported_formats, _I32);

HL_PRIM vbyte* HL_NAME(get_camera_name)(int id) {
    return (vbyte*)SDL_GetCameraName((SDL_CameraID)id);
}
DEFINE_PRIM(_BYTES, get_camera_name, _I32);

HL_PRIM int HL_NAME(get_camera_position)(int id) {
    return (int)SDL_GetCameraPosition((SDL_CameraID)id);
}
DEFINE_PRIM(_I32, get_camera_position, _I32);

HL_PRIM SDL_Camera* HL_NAME(open_camera)(int id, SDL_CameraSpec* spec) {
    return SDL_OpenCamera((SDL_CameraID)id, spec);
}
DEFINE_PRIM(_ABSTRACT(SDL_Camera), open_camera, _I32 _ABSTRACT(SDL_CameraSpec));

HL_PRIM int HL_NAME(get_camera_permission_state)(SDL_Camera* c) {
    return (int)SDL_GetCameraPermissionState(c);
}
DEFINE_PRIM(_I32, get_camera_permission_state, _ABSTRACT(SDL_Camera));

HL_PRIM int HL_NAME(get_camera_id)(SDL_Camera* c) {
    return (int)SDL_GetCameraID(c);
}
DEFINE_PRIM(_I32, get_camera_id, _ABSTRACT(SDL_Camera));

HL_PRIM bool HL_NAME(get_camera_format)(SDL_Camera* c, SDL_CameraSpec* spec) {
    return SDL_GetCameraFormat(c, spec);
}
DEFINE_PRIM(_BOOL, get_camera_format,
            _ABSTRACT(SDL_Camera) _ABSTRACT(SDL_CameraSpec));

HL_PRIM void HL_NAME(close_camera)(SDL_Camera* c) { SDL_CloseCamera(c); }
DEFINE_PRIM(_VOID, close_camera, _ABSTRACT(SDL_Camera));

HL_PRIM Uint64* HL_NAME(camera_timestamp_alloc)() {
    Uint64* t = (Uint64*)hl_gc_alloc_noptr(sizeof(Uint64));
    *t = 0;
    return t;
}
DEFINE_PRIM(_ABSTRACT(SDL_CameraTimestamp), camera_timestamp_alloc, _NO_ARG);

HL_PRIM int64 HL_NAME(camera_timestamp_get)(Uint64* t) { return (int64)*t; }
DEFINE_PRIM(_I64, camera_timestamp_get, _ABSTRACT(SDL_CameraTimestamp));

HL_PRIM SDL_Surface* HL_NAME(acquire_camera_frame)(SDL_Camera* c,
                                                   Uint64* timestamp) {
    return SDL_AcquireCameraFrame(c, timestamp);
}
DEFINE_PRIM(_ABSTRACT(SDL_Surface), acquire_camera_frame,
            _ABSTRACT(SDL_Camera) _ABSTRACT(SDL_CameraTimestamp));

HL_PRIM void HL_NAME(release_camera_frame)(SDL_Camera* c, SDL_Surface* frame) {
    SDL_ReleaseCameraFrame(c, frame);
}
DEFINE_PRIM(_VOID, release_camera_frame,
            _ABSTRACT(SDL_Camera) _ABSTRACT(SDL_Surface));

HL_PRIM int HL_NAME(camera_frame_width)(SDL_Surface* s) { return s->w; }
DEFINE_PRIM(_I32, camera_frame_width, _ABSTRACT(SDL_Surface));
HL_PRIM int HL_NAME(camera_frame_height)(SDL_Surface* s) { return s->h; }
DEFINE_PRIM(_I32, camera_frame_height, _ABSTRACT(SDL_Surface));
HL_PRIM int HL_NAME(camera_frame_pitch)(SDL_Surface* s) { return s->pitch; }
DEFINE_PRIM(_I32, camera_frame_pitch, _ABSTRACT(SDL_Surface));
HL_PRIM int HL_NAME(camera_frame_format)(SDL_Surface* s) {
    return (int)s->format;
}
DEFINE_PRIM(_I32, camera_frame_format, _ABSTRACT(SDL_Surface));

HL_PRIM vbyte* HL_NAME(camera_frame_pixels)(SDL_Surface* s) {
    return (vbyte*)s->pixels;
}
DEFINE_PRIM(_BYTES, camera_frame_pixels, _ABSTRACT(SDL_Surface));

HL_PRIM void HL_NAME(camera_frame_copy)(SDL_Surface* s, vbyte* dst) {
    memcpy(dst, s->pixels, (size_t)s->pitch * (size_t)s->h);
}
DEFINE_PRIM(_VOID, camera_frame_copy, _ABSTRACT(SDL_Surface) _BYTES);