#include "hashlink_macros.h"
#include "SDL3/SDL_storage.h"
#include <string.h>

static vbyte* copy_str(const char* s) {
	if (!s)
		return NULL;
	return hl_copy_bytes((const vbyte*)s, (int)strlen(s) + 1);
}

HL_PRIM SDL_Storage* HL_NAME(open_title_storage)(vbyte* overridePath, int props) {
	return SDL_OpenTitleStorage((const char*)overridePath, (SDL_PropertiesID)props);
}
DEFINE_PRIM(_ABSTRACT(SDL_Storage), open_title_storage, _BYTES _I32);

HL_PRIM SDL_Storage* HL_NAME(open_user_storage)(vbyte* org, vbyte* app, int props) {
	return SDL_OpenUserStorage((const char*)org, (const char*)app, (SDL_PropertiesID)props);
}
DEFINE_PRIM(_ABSTRACT(SDL_Storage), open_user_storage, _BYTES _BYTES _I32);

HL_PRIM SDL_Storage* HL_NAME(open_file_storage)(vbyte* path) { return SDL_OpenFileStorage((const char*)path); }
DEFINE_PRIM(_ABSTRACT(SDL_Storage), open_file_storage, _BYTES);

HL_PRIM bool HL_NAME(close_storage)(SDL_Storage* s) { return SDL_CloseStorage(s); }
DEFINE_PRIM(_BOOL, close_storage, _ABSTRACT(SDL_Storage));

HL_PRIM bool HL_NAME(storage_ready)(SDL_Storage* s) { return SDL_StorageReady(s); }
DEFINE_PRIM(_BOOL, storage_ready, _ABSTRACT(SDL_Storage));

HL_PRIM bool HL_NAME(get_storage_file_size)(SDL_Storage* s, vbyte* path, varray* out) {
	Uint64 len = 0;
	bool ok = SDL_GetStorageFileSize(s, (const char*)path, &len);
	int* o = hl_aptr(out, int);
	o[0] = (int)(Uint32)(len >> 32);
	o[1] = (int)(Uint32)(len & 0xFFFFFFFFu);
	return ok;
}
DEFINE_PRIM(_BOOL, get_storage_file_size, _ABSTRACT(SDL_Storage) _BYTES _ARR);

HL_PRIM bool HL_NAME(read_storage_file)(SDL_Storage* s, vbyte* path, vbyte* destination, int lengthHi, int lengthLo) {
	Uint64 len = ((Uint64)(Uint32)lengthHi << 32) | (Uint32)lengthLo;
	hl_blocking(true);
	bool ok = SDL_ReadStorageFile(s, (const char*)path, destination, len);
	hl_blocking(false);
	return ok;
}
DEFINE_PRIM(_BOOL, read_storage_file, _ABSTRACT(SDL_Storage) _BYTES _BYTES _I32 _I32);

HL_PRIM bool HL_NAME(write_storage_file)(SDL_Storage* s, vbyte* path, vbyte* source, int lengthHi, int lengthLo) {
	Uint64 len = ((Uint64)(Uint32)lengthHi << 32) | (Uint32)lengthLo;
	hl_blocking(true);
	bool ok = SDL_WriteStorageFile(s, (const char*)path, source, len);
	hl_blocking(false);
	return ok;
}
DEFINE_PRIM(_BOOL, write_storage_file, _ABSTRACT(SDL_Storage) _BYTES _BYTES _I32 _I32);

HL_PRIM bool HL_NAME(create_storage_directory)(SDL_Storage* s, vbyte* path) {
	hl_blocking(true);
	bool ok = SDL_CreateStorageDirectory(s, (const char*)path);
	hl_blocking(false);
	return ok;
}
DEFINE_PRIM(_BOOL, create_storage_directory, _ABSTRACT(SDL_Storage) _BYTES);

struct storage_name_list {
	char** items;
	int count;
	bool failed;
};

static SDL_EnumerationResult SDLCALL storage_enum_cb(void* userdata, const char* dirname, const char* fname) {
	storage_name_list* l = (storage_name_list*)userdata;
	char** items = (char**)SDL_realloc(l->items, sizeof(char*) * (l->count + 1));
	if (!items) {
		l->failed = true;
		return SDL_ENUM_FAILURE;
	}
	l->items = items;
	l->items[l->count] = SDL_strdup(fname);
	if (!l->items[l->count]) {
		l->failed = true;
		return SDL_ENUM_FAILURE;
	}
	l->count++;
	return SDL_ENUM_CONTINUE;
}

HL_PRIM varray* HL_NAME(enumerate_storage_directory)(SDL_Storage* s, vbyte* path) {
	storage_name_list l = {NULL, 0, false};
	hl_blocking(true);
	bool ok = SDL_EnumerateStorageDirectory(s, (const char*)path, storage_enum_cb, &l);
	hl_blocking(false);

	varray* a = NULL;
	if (ok && !l.failed) {
		a = hl_alloc_array(&hlt_bytes, l.count);
		vbyte** p = hl_aptr(a, vbyte*);
		for (int i = 0; i < l.count; i++)
			p[i] = copy_str(l.items[i]);
	}
	for (int i = 0; i < l.count; i++)
		SDL_free(l.items[i]);
	SDL_free(l.items);
	return a;
}
DEFINE_PRIM(_ARR, enumerate_storage_directory, _ABSTRACT(SDL_Storage) _BYTES);

HL_PRIM bool HL_NAME(remove_storage_path)(SDL_Storage* s, vbyte* path) {
	hl_blocking(true);
	bool ok = SDL_RemoveStoragePath(s, (const char*)path);
	hl_blocking(false);
	return ok;
}
DEFINE_PRIM(_BOOL, remove_storage_path, _ABSTRACT(SDL_Storage) _BYTES);

HL_PRIM bool HL_NAME(rename_storage_path)(SDL_Storage* s, vbyte* oldpath, vbyte* newpath) {
	hl_blocking(true);
	bool ok = SDL_RenameStoragePath(s, (const char*)oldpath, (const char*)newpath);
	hl_blocking(false);
	return ok;
}
DEFINE_PRIM(_BOOL, rename_storage_path, _ABSTRACT(SDL_Storage) _BYTES _BYTES);

HL_PRIM bool HL_NAME(copy_storage_file)(SDL_Storage* s, vbyte* oldpath, vbyte* newpath) {
	hl_blocking(true);
	bool ok = SDL_CopyStorageFile(s, (const char*)oldpath, (const char*)newpath);
	hl_blocking(false);
	return ok;
}
DEFINE_PRIM(_BOOL, copy_storage_file, _ABSTRACT(SDL_Storage) _BYTES _BYTES);

/*
	out (int[9]), mismo layout que sdl_filesystem.cpp get_path_info:
	  out[0] tipo (0 none, 1 file, 2 directory, 3 other)
	  out[1..2]  tamaño en bytes (alto, bajo)
	  out[3..4]  create_time (ns, alto, bajo)
	  out[5..6]  modify_time
	  out[7..8]  access_time
*/
HL_PRIM bool HL_NAME(get_storage_path_info)(SDL_Storage* s, vbyte* path, varray* out) {
	SDL_PathInfo info;
	SDL_zero(info);
	bool ok = SDL_GetStoragePathInfo(s, (const char*)path, &info);
	int* o = hl_aptr(out, int);
	o[0] = (int)info.type;
	o[1] = (int)(Uint32)(info.size >> 32);
	o[2] = (int)(Uint32)(info.size & 0xFFFFFFFFu);
	Uint64 t[3] = {(Uint64)info.create_time, (Uint64)info.modify_time, (Uint64)info.access_time};
	for (int i = 0; i < 3; i++) {
		o[3 + i * 2] = (int)(Uint32)(t[i] >> 32);
		o[4 + i * 2] = (int)(Uint32)(t[i] & 0xFFFFFFFFu);
	}
	return ok;
}
DEFINE_PRIM(_BOOL, get_storage_path_info, _ABSTRACT(SDL_Storage) _BYTES _ARR);

HL_PRIM void HL_NAME(get_storage_space_remaining)(SDL_Storage* s, varray* out) {
	Uint64 v = SDL_GetStorageSpaceRemaining(s);
	int* o = hl_aptr(out, int);
	o[0] = (int)(Uint32)(v >> 32);
	o[1] = (int)(Uint32)(v & 0xFFFFFFFFu);
}
DEFINE_PRIM(_VOID, get_storage_space_remaining, _ABSTRACT(SDL_Storage) _ARR);

HL_PRIM varray* HL_NAME(glob_storage_directory)(SDL_Storage* s, vbyte* path, vbyte* pattern, int flags) {
	int count = 0;
	hl_blocking(true);
	char** list = SDL_GlobStorageDirectory(s, (const char*)path, (const char*)pattern, (SDL_GlobFlags)flags, &count);
	hl_blocking(false);
	if (!list)
		return NULL;
	varray* a = hl_alloc_array(&hlt_bytes, count);
	vbyte** p = hl_aptr(a, vbyte*);
	for (int i = 0; i < count; i++)
		p[i] = copy_str(list[i]);
	SDL_free(list);
	return a;
}
DEFINE_PRIM(_ARR, glob_storage_directory, _ABSTRACT(SDL_Storage) _BYTES _BYTES _I32);
