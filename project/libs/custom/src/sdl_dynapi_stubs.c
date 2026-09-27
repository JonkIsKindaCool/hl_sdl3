#ifdef _MSC_VER
#pragma warning(push)
#pragma warning(disable: 4028 4024) 
#endif

void SDL_GetAndroidActivity_REAL(void) {}
void SDL_GetAndroidCachePath_REAL(void) {}
void SDL_GetAndroidExternalStoragePath_REAL(void) {}
void SDL_GetAndroidExternalStorageState_REAL(void) {}
void SDL_GetAndroidInternalStoragePath_REAL(void) {}
void SDL_GetAndroidJNIEnv_REAL(void) {}
void SDL_GetAndroidSDKVersion_REAL(void) {}
void SDL_IsChromebook_REAL(void) {}
void SDL_IsDeXMode_REAL(void) {}
void SDL_RequestAndroidPermission_REAL(void) {}
void SDL_SendAndroidBackButton_REAL(void) {}
void SDL_SendAndroidMessage_REAL(void) {}
void SDL_ShowAndroidToast_REAL(void) {}
void JNI_OnLoad_REAL(void) {}

void SDL_GDKResumeGPU_REAL(void) {}
void SDL_GDKSuspendComplete_REAL(void) {}
void SDL_GDKSuspendGPU_REAL(void) {}
void SDL_GetGDKDefaultUser_REAL(void) {}

void SDL_SetLinuxThreadPriority_REAL(void) {}
void SDL_SetLinuxThreadPriorityAndPolicy_REAL(void) {}

void SDL_SetX11EventHook_REAL(void) {}

void SDL_GetWindowFromEvent_REAL(void) {}

#ifdef _MSC_VER
#pragma warning(pop)
#endif