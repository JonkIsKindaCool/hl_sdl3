#include "SDL3/SDL_audio.h"

#include "hashlink_macros.h"

HL_PRIM SDL_AudioSpec* HL_NAME(audio_spec_alloc)(int format, int channels,
                                                 int freq) {
    SDL_AudioSpec* s = (SDL_AudioSpec*)hl_gc_alloc_noptr(sizeof(SDL_AudioSpec));
    s->format = (SDL_AudioFormat)format;
    s->channels = channels;
    s->freq = freq;
    return s;
}
DEFINE_PRIM(_ABSTRACT(SDL_AudioSpec), audio_spec_alloc, _I32 _I32 _I32);

HL_PRIM int HL_NAME(audio_spec_format)(SDL_AudioSpec* s) {
    return (int)s->format;
}
DEFINE_PRIM(_I32, audio_spec_format, _ABSTRACT(SDL_AudioSpec));
HL_PRIM int HL_NAME(audio_spec_channels)(SDL_AudioSpec* s) {
    return s->channels;
}
DEFINE_PRIM(_I32, audio_spec_channels, _ABSTRACT(SDL_AudioSpec));
HL_PRIM int HL_NAME(audio_spec_freq)(SDL_AudioSpec* s) { return s->freq; }
DEFINE_PRIM(_I32, audio_spec_freq, _ABSTRACT(SDL_AudioSpec));

HL_PRIM int HL_NAME(get_num_audio_drivers)() {
    return SDL_GetNumAudioDrivers();
}
DEFINE_PRIM(_I32, get_num_audio_drivers, _NO_ARG);

HL_PRIM vbyte* HL_NAME(get_audio_driver)(int index) {
    return (vbyte*)SDL_GetAudioDriver(index);
}
DEFINE_PRIM(_BYTES, get_audio_driver, _I32);

HL_PRIM vbyte* HL_NAME(get_current_audio_driver)() {
    return (vbyte*)SDL_GetCurrentAudioDriver();
}
DEFINE_PRIM(_BYTES, get_current_audio_driver, _NO_ARG);

static varray* ids_to_array(SDL_AudioDeviceID* ids, int count) {
    if (!ids) return hl_alloc_array(&hlt_i32, 0);
    varray* a = hl_alloc_array(&hlt_i32, count);
    int* p = hl_aptr(a, int);
    for (int i = 0; i < count; i++) p[i] = (int)ids[i];
    SDL_free(ids);
    return a;
}

HL_PRIM varray* HL_NAME(get_audio_playback_devices)() {
    int count = 0;
    SDL_AudioDeviceID* ids = SDL_GetAudioPlaybackDevices(&count);
    return ids_to_array(ids, count);
}
DEFINE_PRIM(_ARR, get_audio_playback_devices, _NO_ARG);

HL_PRIM varray* HL_NAME(get_audio_recording_devices)() {
    int count = 0;
    SDL_AudioDeviceID* ids = SDL_GetAudioRecordingDevices(&count);
    return ids_to_array(ids, count);
}
DEFINE_PRIM(_ARR, get_audio_recording_devices, _NO_ARG);

HL_PRIM vbyte* HL_NAME(get_audio_device_name)(int devid) {
    return (vbyte*)SDL_GetAudioDeviceName((SDL_AudioDeviceID)devid);
}
DEFINE_PRIM(_BYTES, get_audio_device_name, _I32);

HL_PRIM int HL_NAME(get_audio_device_format)(int devid, SDL_AudioSpec* spec) {
    int frames = 0;
    if (!SDL_GetAudioDeviceFormat((SDL_AudioDeviceID)devid, spec, &frames))
        return -1;
    return frames;
}
DEFINE_PRIM(_I32, get_audio_device_format, _I32 _ABSTRACT(SDL_AudioSpec));

HL_PRIM varray* HL_NAME(get_audio_device_channel_map)(int devid) {
    int count = 0;
    int* map = SDL_GetAudioDeviceChannelMap((SDL_AudioDeviceID)devid, &count);
    if (!map) return NULL;
    varray* a = hl_alloc_array(&hlt_i32, count);
    memcpy(hl_aptr(a, int), map, sizeof(int) * count);
    SDL_free(map);
    return a;
}
DEFINE_PRIM(_ARR, get_audio_device_channel_map, _I32);

HL_PRIM int HL_NAME(open_audio_device)(int devid, SDL_AudioSpec* spec) {
    return (int)SDL_OpenAudioDevice((SDL_AudioDeviceID)devid, spec);
}
DEFINE_PRIM(_I32, open_audio_device, _I32 _ABSTRACT(SDL_AudioSpec));

HL_PRIM bool HL_NAME(is_audio_device_physical)(int devid) {
    return SDL_IsAudioDevicePhysical((SDL_AudioDeviceID)devid);
}
DEFINE_PRIM(_BOOL, is_audio_device_physical, _I32);

HL_PRIM bool HL_NAME(is_audio_device_playback)(int devid) {
    return SDL_IsAudioDevicePlayback((SDL_AudioDeviceID)devid);
}
DEFINE_PRIM(_BOOL, is_audio_device_playback, _I32);

HL_PRIM bool HL_NAME(pause_audio_device)(int devid) {
    return SDL_PauseAudioDevice((SDL_AudioDeviceID)devid);
}
DEFINE_PRIM(_BOOL, pause_audio_device, _I32);

HL_PRIM bool HL_NAME(resume_audio_device)(int devid) {
    return SDL_ResumeAudioDevice((SDL_AudioDeviceID)devid);
}
DEFINE_PRIM(_BOOL, resume_audio_device, _I32);

HL_PRIM bool HL_NAME(audio_device_paused)(int devid) {
    return SDL_AudioDevicePaused((SDL_AudioDeviceID)devid);
}
DEFINE_PRIM(_BOOL, audio_device_paused, _I32);

HL_PRIM double HL_NAME(get_audio_device_gain)(int devid) {
    return (double)SDL_GetAudioDeviceGain((SDL_AudioDeviceID)devid);
}
DEFINE_PRIM(_F64, get_audio_device_gain, _I32);

HL_PRIM bool HL_NAME(set_audio_device_gain)(int devid, double gain) {
    return SDL_SetAudioDeviceGain((SDL_AudioDeviceID)devid, (float)gain);
}
DEFINE_PRIM(_BOOL, set_audio_device_gain, _I32 _F64);

HL_PRIM void HL_NAME(close_audio_device)(int devid) {
    hl_blocking(true);
    SDL_CloseAudioDevice((SDL_AudioDeviceID)devid);
    hl_blocking(false);
}
DEFINE_PRIM(_VOID, close_audio_device, _I32);

HL_PRIM bool HL_NAME(bind_audio_stream)(int devid, SDL_AudioStream* s) {
    return SDL_BindAudioStream((SDL_AudioDeviceID)devid, s);
}
DEFINE_PRIM(_BOOL, bind_audio_stream, _I32 _ABSTRACT(SDL_AudioStream));

HL_PRIM void HL_NAME(unbind_audio_stream)(SDL_AudioStream* s) {
    SDL_UnbindAudioStream(s);
}
DEFINE_PRIM(_VOID, unbind_audio_stream, _ABSTRACT(SDL_AudioStream));

HL_PRIM int HL_NAME(get_audio_stream_device)(SDL_AudioStream* s) {
    return (int)SDL_GetAudioStreamDevice(s);
}
DEFINE_PRIM(_I32, get_audio_stream_device, _ABSTRACT(SDL_AudioStream));

HL_PRIM SDL_AudioStream* HL_NAME(create_audio_stream)(SDL_AudioSpec* src,
                                                      SDL_AudioSpec* dst) {
    return SDL_CreateAudioStream(src, dst);
}
DEFINE_PRIM(_ABSTRACT(SDL_AudioStream), create_audio_stream,
            _ABSTRACT(SDL_AudioSpec) _ABSTRACT(SDL_AudioSpec));

HL_PRIM SDL_AudioStream* HL_NAME(open_audio_device_stream)(
    int devid, SDL_AudioSpec* spec) {
    return SDL_OpenAudioDeviceStream((SDL_AudioDeviceID)devid, spec, NULL,
                                     NULL);
}
DEFINE_PRIM(_ABSTRACT(SDL_AudioStream), open_audio_device_stream,
            _I32 _ABSTRACT(SDL_AudioSpec));

HL_PRIM void HL_NAME(destroy_audio_stream)(SDL_AudioStream* s) {
    SDL_DestroyAudioStream(s);
}
DEFINE_PRIM(_VOID, destroy_audio_stream, _ABSTRACT(SDL_AudioStream));

HL_PRIM bool HL_NAME(get_audio_stream_format)(SDL_AudioStream* s,
                                              SDL_AudioSpec* src,
                                              SDL_AudioSpec* dst) {
    return SDL_GetAudioStreamFormat(s, src, dst);
}
DEFINE_PRIM(_BOOL, get_audio_stream_format,
            _ABSTRACT(SDL_AudioStream) _ABSTRACT(SDL_AudioSpec)
                _ABSTRACT(SDL_AudioSpec));

HL_PRIM bool HL_NAME(set_audio_stream_format)(SDL_AudioStream* s,
                                              SDL_AudioSpec* src,
                                              SDL_AudioSpec* dst) {
    return SDL_SetAudioStreamFormat(s, src, dst);
}
DEFINE_PRIM(_BOOL, set_audio_stream_format,
            _ABSTRACT(SDL_AudioStream) _ABSTRACT(SDL_AudioSpec)
                _ABSTRACT(SDL_AudioSpec));

HL_PRIM double HL_NAME(get_audio_stream_frequency_ratio)(SDL_AudioStream* s) {
    return (double)SDL_GetAudioStreamFrequencyRatio(s);
}
DEFINE_PRIM(_F64, get_audio_stream_frequency_ratio, _ABSTRACT(SDL_AudioStream));

HL_PRIM bool HL_NAME(set_audio_stream_frequency_ratio)(SDL_AudioStream* s,
                                                       double r) {
    return SDL_SetAudioStreamFrequencyRatio(s, (float)r);
}
DEFINE_PRIM(_BOOL, set_audio_stream_frequency_ratio,
            _ABSTRACT(SDL_AudioStream) _F64);

HL_PRIM double HL_NAME(get_audio_stream_gain)(SDL_AudioStream* s) {
    return (double)SDL_GetAudioStreamGain(s);
}
DEFINE_PRIM(_F64, get_audio_stream_gain, _ABSTRACT(SDL_AudioStream));

HL_PRIM bool HL_NAME(set_audio_stream_gain)(SDL_AudioStream* s, double g) {
    return SDL_SetAudioStreamGain(s, (float)g);
}
DEFINE_PRIM(_BOOL, set_audio_stream_gain, _ABSTRACT(SDL_AudioStream) _F64);

static varray* copy_map(int* map, int count) {
    if (!map) return NULL;
    varray* a = hl_alloc_array(&hlt_i32, count);
    memcpy(hl_aptr(a, int), map, sizeof(int) * count);
    SDL_free(map);
    return a;
}

HL_PRIM varray* HL_NAME(get_audio_stream_input_channel_map)(
    SDL_AudioStream* s) {
    int count = 0;
    int* m = SDL_GetAudioStreamInputChannelMap(s, &count);
    return copy_map(m, count);
}
DEFINE_PRIM(_ARR, get_audio_stream_input_channel_map,
            _ABSTRACT(SDL_AudioStream));

HL_PRIM varray* HL_NAME(get_audio_stream_output_channel_map)(
    SDL_AudioStream* s) {
    int count = 0;
    int* m = SDL_GetAudioStreamOutputChannelMap(s, &count);
    return copy_map(m, count);
}
DEFINE_PRIM(_ARR, get_audio_stream_output_channel_map,
            _ABSTRACT(SDL_AudioStream));

HL_PRIM bool HL_NAME(set_audio_stream_input_channel_map)(SDL_AudioStream* s,
                                                         varray* map) {
    return SDL_SetAudioStreamInputChannelMap(s, map ? hl_aptr(map, int) : NULL,
                                             map ? map->size : 0);
}
DEFINE_PRIM(_BOOL, set_audio_stream_input_channel_map,
            _ABSTRACT(SDL_AudioStream) _ARR);

HL_PRIM bool HL_NAME(set_audio_stream_output_channel_map)(SDL_AudioStream* s,
                                                          varray* map) {
    return SDL_SetAudioStreamOutputChannelMap(s, map ? hl_aptr(map, int) : NULL,
                                              map ? map->size : 0);
}
DEFINE_PRIM(_BOOL, set_audio_stream_output_channel_map,
            _ABSTRACT(SDL_AudioStream) _ARR);

HL_PRIM bool HL_NAME(put_audio_stream_data)(SDL_AudioStream* s, vbyte* buf,
                                            int len) {
    return SDL_PutAudioStreamData(s, buf, len);
}
DEFINE_PRIM(_BOOL, put_audio_stream_data,
            _ABSTRACT(SDL_AudioStream) _BYTES _I32);

HL_PRIM int HL_NAME(get_audio_stream_data)(SDL_AudioStream* s, vbyte* buf,
                                           int len) {
    return SDL_GetAudioStreamData(s, buf, len);
}
DEFINE_PRIM(_I32, get_audio_stream_data,
            _ABSTRACT(SDL_AudioStream) _BYTES _I32);

HL_PRIM int HL_NAME(get_audio_stream_available)(SDL_AudioStream* s) {
    return SDL_GetAudioStreamAvailable(s);
}
DEFINE_PRIM(_I32, get_audio_stream_available, _ABSTRACT(SDL_AudioStream));

HL_PRIM int HL_NAME(get_audio_stream_queued)(SDL_AudioStream* s) {
    return SDL_GetAudioStreamQueued(s);
}
DEFINE_PRIM(_I32, get_audio_stream_queued, _ABSTRACT(SDL_AudioStream));

HL_PRIM bool HL_NAME(flush_audio_stream)(SDL_AudioStream* s) {
    return SDL_FlushAudioStream(s);
}
DEFINE_PRIM(_BOOL, flush_audio_stream, _ABSTRACT(SDL_AudioStream));

HL_PRIM bool HL_NAME(clear_audio_stream)(SDL_AudioStream* s) {
    return SDL_ClearAudioStream(s);
}
DEFINE_PRIM(_BOOL, clear_audio_stream, _ABSTRACT(SDL_AudioStream));

HL_PRIM bool HL_NAME(pause_audio_stream_device)(SDL_AudioStream* s) {
    return SDL_PauseAudioStreamDevice(s);
}
DEFINE_PRIM(_BOOL, pause_audio_stream_device, _ABSTRACT(SDL_AudioStream));

HL_PRIM bool HL_NAME(resume_audio_stream_device)(SDL_AudioStream* s) {
    return SDL_ResumeAudioStreamDevice(s);
}
DEFINE_PRIM(_BOOL, resume_audio_stream_device, _ABSTRACT(SDL_AudioStream));

HL_PRIM bool HL_NAME(audio_stream_device_paused)(SDL_AudioStream* s) {
    return SDL_AudioStreamDevicePaused(s);
}
DEFINE_PRIM(_BOOL, audio_stream_device_paused, _ABSTRACT(SDL_AudioStream));

HL_PRIM bool HL_NAME(lock_audio_stream)(SDL_AudioStream* s) {
    return SDL_LockAudioStream(s);
}
DEFINE_PRIM(_BOOL, lock_audio_stream, _ABSTRACT(SDL_AudioStream));

HL_PRIM bool HL_NAME(unlock_audio_stream)(SDL_AudioStream* s) {
    return SDL_UnlockAudioStream(s);
}
DEFINE_PRIM(_BOOL, unlock_audio_stream, _ABSTRACT(SDL_AudioStream));

struct hl_wav {
    SDL_AudioSpec spec;
    Uint8* buf;
    Uint32 len;
};

HL_PRIM hl_wav* HL_NAME(wav_load)(vbyte* path) {
    hl_wav* w = (hl_wav*)SDL_malloc(sizeof(hl_wav));
    if (!w) return NULL;
    if (!SDL_LoadWAV((const char*)path, &w->spec, &w->buf, &w->len)) {
        SDL_free(w);
        return NULL;
    }
    return w;
}
DEFINE_PRIM(_ABSTRACT(SDL_WavData), wav_load, _BYTES);

HL_PRIM int HL_NAME(wav_format)(hl_wav* w) { return (int)w->spec.format; }
DEFINE_PRIM(_I32, wav_format, _ABSTRACT(SDL_WavData));
HL_PRIM int HL_NAME(wav_channels)(hl_wav* w) { return w->spec.channels; }
DEFINE_PRIM(_I32, wav_channels, _ABSTRACT(SDL_WavData));
HL_PRIM int HL_NAME(wav_freq)(hl_wav* w) { return w->spec.freq; }
DEFINE_PRIM(_I32, wav_freq, _ABSTRACT(SDL_WavData));
HL_PRIM int HL_NAME(wav_length)(hl_wav* w) { return (int)w->len; }
DEFINE_PRIM(_I32, wav_length, _ABSTRACT(SDL_WavData));

HL_PRIM void HL_NAME(wav_copy)(hl_wav* w, vbyte* dst) {
    memcpy(dst, w->buf, w->len);
}
DEFINE_PRIM(_VOID, wav_copy, _ABSTRACT(SDL_WavData) _BYTES);

HL_PRIM void HL_NAME(wav_free)(hl_wav* w) {
    if (!w) return;
    SDL_free(w->buf);
    SDL_free(w);
}
DEFINE_PRIM(_VOID, wav_free, _ABSTRACT(SDL_WavData));

HL_PRIM bool HL_NAME(mix_audio)(vbyte* dst, vbyte* src, int format, int len,
                                double volume) {
    return SDL_MixAudio((Uint8*)dst, (const Uint8*)src, (SDL_AudioFormat)format,
                        (Uint32)len, (float)volume);
}
DEFINE_PRIM(_BOOL, mix_audio, _BYTES _BYTES _I32 _I32 _F64);

HL_PRIM vbyte* HL_NAME(get_audio_format_name)(int format) {
    return (vbyte*)SDL_GetAudioFormatName((SDL_AudioFormat)format);
}
DEFINE_PRIM(_BYTES, get_audio_format_name, _I32);

HL_PRIM int HL_NAME(get_silence_value_for_format)(int format) {
    return SDL_GetSilenceValueForFormat((SDL_AudioFormat)format);
}
DEFINE_PRIM(_I32, get_silence_value_for_format, _I32);