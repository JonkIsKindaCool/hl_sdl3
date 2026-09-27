#include "SDL3/SDL_system.h"

#include "hashlink_macros.h"

HL_PRIM bool HL_NAME(is_tablet)() { return SDL_IsTablet(); }
DEFINE_PRIM(_BOOL, is_tablet, _NO_ARG);

HL_PRIM bool HL_NAME(is_tv)() { return SDL_IsTV(); }
DEFINE_PRIM(_BOOL, is_tv, _NO_ARG);

HL_PRIM int HL_NAME(get_sandbox)() { return (int)SDL_GetSandbox(); }
DEFINE_PRIM(_I32, get_sandbox, _NO_ARG);

HL_PRIM void HL_NAME(on_application_will_terminate)() {
    SDL_OnApplicationWillTerminate();
}
DEFINE_PRIM(_VOID, on_application_will_terminate, _NO_ARG);

HL_PRIM void HL_NAME(on_application_did_receive_memory_warning)() {
    SDL_OnApplicationDidReceiveMemoryWarning();
}
DEFINE_PRIM(_VOID, on_application_did_receive_memory_warning, _NO_ARG);

HL_PRIM void HL_NAME(on_application_will_enter_background)() {
    SDL_OnApplicationWillEnterBackground();
}
DEFINE_PRIM(_VOID, on_application_will_enter_background, _NO_ARG);

HL_PRIM void HL_NAME(on_application_did_enter_background)() {
    SDL_OnApplicationDidEnterBackground();
}
DEFINE_PRIM(_VOID, on_application_did_enter_background, _NO_ARG);

HL_PRIM void HL_NAME(on_application_will_enter_foreground)() {
    SDL_OnApplicationWillEnterForeground();
}
DEFINE_PRIM(_VOID, on_application_will_enter_foreground, _NO_ARG);

HL_PRIM void HL_NAME(on_application_did_enter_foreground)() {
    SDL_OnApplicationDidEnterForeground();
}
DEFINE_PRIM(_VOID, on_application_did_enter_foreground, _NO_ARG);