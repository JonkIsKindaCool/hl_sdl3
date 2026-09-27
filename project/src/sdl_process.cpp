#include "hashlink_macros.h"
#include "SDL3/SDL_process.h"
#include <string.h>
#include <vector>

HL_PRIM SDL_Process* HL_NAME(create_process)(varray* args, bool pipeStdio) {
	int n = args->size;
	vbyte** src = hl_aptr(args, vbyte*);
	std::vector<const char*> argv;
	argv.resize(n + 1);
	for (int i = 0; i < n; i++)
		argv[i] = (const char*)src[i];
	argv[n] = NULL;
	return SDL_CreateProcess(argv.data(), pipeStdio);
}
DEFINE_PRIM(_ABSTRACT(SDL_Process), create_process, _ARR _BOOL);

HL_PRIM SDL_Process* HL_NAME(create_process_with_properties)(varray* args, vbyte* workingDirectory, int stdinOption, SDL_IOStream* stdinSource,
	int stdoutOption, SDL_IOStream* stdoutSource, int stderrOption, SDL_IOStream* stderrSource, bool stderrToStdout, bool background,
	vbyte* cmdline) {
	int n = args ? args->size : 0;
	std::vector<const char*> argv;
	if (n > 0) {
		vbyte** src = hl_aptr(args, vbyte*);
		argv.resize(n + 1);
		for (int i = 0; i < n; i++)
			argv[i] = (const char*)src[i];
		argv[n] = NULL;
	}

	SDL_PropertiesID props = SDL_CreateProperties();
	if (n > 0)
		SDL_SetPointerProperty(props, SDL_PROP_PROCESS_CREATE_ARGS_POINTER, (void*)argv.data());
	if (workingDirectory)
		SDL_SetStringProperty(props, SDL_PROP_PROCESS_CREATE_WORKING_DIRECTORY_STRING, (const char*)workingDirectory);
	if (stdinOption >= 0)
		SDL_SetNumberProperty(props, SDL_PROP_PROCESS_CREATE_STDIN_NUMBER, stdinOption);
	if (stdinSource)
		SDL_SetPointerProperty(props, SDL_PROP_PROCESS_CREATE_STDIN_POINTER, stdinSource);
	if (stdoutOption >= 0)
		SDL_SetNumberProperty(props, SDL_PROP_PROCESS_CREATE_STDOUT_NUMBER, stdoutOption);
	if (stdoutSource)
		SDL_SetPointerProperty(props, SDL_PROP_PROCESS_CREATE_STDOUT_POINTER, stdoutSource);
	if (stderrOption >= 0)
		SDL_SetNumberProperty(props, SDL_PROP_PROCESS_CREATE_STDERR_NUMBER, stderrOption);
	if (stderrSource)
		SDL_SetPointerProperty(props, SDL_PROP_PROCESS_CREATE_STDERR_POINTER, stderrSource);
	SDL_SetBooleanProperty(props, SDL_PROP_PROCESS_CREATE_STDERR_TO_STDOUT_BOOLEAN, stderrToStdout);
	SDL_SetBooleanProperty(props, SDL_PROP_PROCESS_CREATE_BACKGROUND_BOOLEAN, background);
	if (cmdline)
		SDL_SetStringProperty(props, SDL_PROP_PROCESS_CREATE_CMDLINE_STRING, (const char*)cmdline);

	SDL_Process* p = SDL_CreateProcessWithProperties(props);
	SDL_DestroyProperties(props);
	return p;
}
DEFINE_PRIM(_ABSTRACT(SDL_Process), create_process_with_properties,
	_ARR _BYTES _I32 _ABSTRACT(SDL_IOStream) _I32 _ABSTRACT(SDL_IOStream) _I32 _ABSTRACT(SDL_IOStream) _BOOL _BOOL _BYTES);

HL_PRIM int HL_NAME(get_process_pid)(SDL_Process* process) {
	SDL_PropertiesID props = SDL_GetProcessProperties(process);
	if (!props)
		return 0;
	return (int)SDL_GetNumberProperty(props, SDL_PROP_PROCESS_PID_NUMBER, 0);
}
DEFINE_PRIM(_I32, get_process_pid, _ABSTRACT(SDL_Process));

HL_PRIM SDL_IOStream* HL_NAME(get_process_stderr)(SDL_Process* process) {
	SDL_PropertiesID props = SDL_GetProcessProperties(process);
	if (!props)
		return NULL;
	return (SDL_IOStream*)SDL_GetPointerProperty(props, SDL_PROP_PROCESS_STDERR_POINTER, NULL);
}
DEFINE_PRIM(_ABSTRACT(SDL_IOStream), get_process_stderr, _ABSTRACT(SDL_Process));

HL_PRIM bool HL_NAME(process_runs_in_background)(SDL_Process* process) {
	SDL_PropertiesID props = SDL_GetProcessProperties(process);
	if (!props)
		return false;
	return SDL_GetBooleanProperty(props, SDL_PROP_PROCESS_BACKGROUND_BOOLEAN, false);
}
DEFINE_PRIM(_BOOL, process_runs_in_background, _ABSTRACT(SDL_Process));

HL_PRIM vbyte* HL_NAME(read_process)(SDL_Process* process, varray* out) {
	size_t datasize = 0;
	int exitcode = 0;
	hl_blocking(true);
	void* data = SDL_ReadProcess(process, &datasize, &exitcode);
	hl_blocking(false);
	int* o = hl_aptr(out, int);
	o[0] = (int)datasize;
	o[1] = exitcode;
	if (!data)
		return NULL;
	vbyte* r = hl_copy_bytes((const vbyte*)data, (int)datasize);
	SDL_free(data);
	return r;
}
DEFINE_PRIM(_BYTES, read_process, _ABSTRACT(SDL_Process) _ARR);

HL_PRIM SDL_IOStream* HL_NAME(get_process_input)(SDL_Process* process) { return SDL_GetProcessInput(process); }
DEFINE_PRIM(_ABSTRACT(SDL_IOStream), get_process_input, _ABSTRACT(SDL_Process));

HL_PRIM SDL_IOStream* HL_NAME(get_process_output)(SDL_Process* process) { return SDL_GetProcessOutput(process); }
DEFINE_PRIM(_ABSTRACT(SDL_IOStream), get_process_output, _ABSTRACT(SDL_Process));

HL_PRIM bool HL_NAME(kill_process)(SDL_Process* process, bool force) { return SDL_KillProcess(process, force); }
DEFINE_PRIM(_BOOL, kill_process, _ABSTRACT(SDL_Process) _BOOL);

HL_PRIM bool HL_NAME(wait_process)(SDL_Process* process, bool block, varray* outExitCode) {
	int exitcode = 0;
	if (block)
		hl_blocking(true);
	bool r = SDL_WaitProcess(process, block, &exitcode);
	if (block)
		hl_blocking(false);
	hl_aptr(outExitCode, int)[0] = exitcode;
	return r;
}
DEFINE_PRIM(_BOOL, wait_process, _ABSTRACT(SDL_Process) _BOOL _ARR);

HL_PRIM void HL_NAME(destroy_process)(SDL_Process* process) { SDL_DestroyProcess(process); }
DEFINE_PRIM(_VOID, destroy_process, _ABSTRACT(SDL_Process));
