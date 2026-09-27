#include "hashlink_macros.h"
#include "SDL3/SDL_rect.h"
#include <vector>

static inline SDL_Rect read_rect(int* a) { SDL_Rect r; r.x = a[0]; r.y = a[1]; r.w = a[2]; r.h = a[3]; return r; }
static inline void write_rect(int* a, const SDL_Rect& r) { a[0] = r.x; a[1] = r.y; a[2] = r.w; a[3] = r.h; }
static inline SDL_FRect read_frect(double* a) { SDL_FRect r; r.x = (float)a[0]; r.y = (float)a[1]; r.w = (float)a[2]; r.h = (float)a[3]; return r; }
static inline void write_frect(double* a, const SDL_FRect& r) { a[0] = r.x; a[1] = r.y; a[2] = r.w; a[3] = r.h; }

HL_PRIM bool HL_NAME(has_rect_intersection)(varray* a, varray* b) {
	SDL_Rect ra = read_rect(hl_aptr(a, int));
	SDL_Rect rb = read_rect(hl_aptr(b, int));
	return SDL_HasRectIntersection(&ra, &rb);
}
DEFINE_PRIM(_BOOL, has_rect_intersection, _ARR _ARR);

HL_PRIM bool HL_NAME(get_rect_intersection)(varray* a, varray* b, varray* out) {
	SDL_Rect ra = read_rect(hl_aptr(a, int));
	SDL_Rect rb = read_rect(hl_aptr(b, int));
	SDL_Rect result;
	bool ok = SDL_GetRectIntersection(&ra, &rb, &result);
	if (ok)
		write_rect(hl_aptr(out, int), result);
	return ok;
}
DEFINE_PRIM(_BOOL, get_rect_intersection, _ARR _ARR _ARR);

HL_PRIM bool HL_NAME(get_rect_union)(varray* a, varray* b, varray* out) {
	SDL_Rect ra = read_rect(hl_aptr(a, int));
	SDL_Rect rb = read_rect(hl_aptr(b, int));
	SDL_Rect result;
	bool ok = SDL_GetRectUnion(&ra, &rb, &result);
	if (ok)
		write_rect(hl_aptr(out, int), result);
	return ok;
}
DEFINE_PRIM(_BOOL, get_rect_union, _ARR _ARR _ARR);

HL_PRIM bool HL_NAME(get_rect_enclosing_points)(varray* pointsXY, varray* clip, varray* out) {
	int count = pointsXY->size / 2;
	int* px = hl_aptr(pointsXY, int);
	std::vector<SDL_Point> points;
	points.resize(count);
	for (int i = 0; i < count; i++) {
		points[i].x = px[i * 2];
		points[i].y = px[i * 2 + 1];
	}
	SDL_Rect clipRect;
	SDL_Rect* clipPtr = NULL;
	if (clip) {
		clipRect = read_rect(hl_aptr(clip, int));
		clipPtr = &clipRect;
	}
	SDL_Rect result;
	bool ok = SDL_GetRectEnclosingPoints(points.data(), count, clipPtr, &result);
	if (ok)
		write_rect(hl_aptr(out, int), result);
	return ok;
}
DEFINE_PRIM(_BOOL, get_rect_enclosing_points, _ARR _ARR _ARR);

HL_PRIM bool HL_NAME(get_rect_and_line_intersection)(varray* rect, varray* line) {
	SDL_Rect r = read_rect(hl_aptr(rect, int));
	int* l = hl_aptr(line, int);
	int x1 = l[0], y1 = l[1], x2 = l[2], y2 = l[3];
	bool ok = SDL_GetRectAndLineIntersection(&r, &x1, &y1, &x2, &y2);
	l[0] = x1;
	l[1] = y1;
	l[2] = x2;
	l[3] = y2;
	return ok;
}
DEFINE_PRIM(_BOOL, get_rect_and_line_intersection, _ARR _ARR);

HL_PRIM bool HL_NAME(has_rect_intersection_float)(varray* a, varray* b) {
	SDL_FRect ra = read_frect(hl_aptr(a, double));
	SDL_FRect rb = read_frect(hl_aptr(b, double));
	return SDL_HasRectIntersectionFloat(&ra, &rb);
}
DEFINE_PRIM(_BOOL, has_rect_intersection_float, _ARR _ARR);

HL_PRIM bool HL_NAME(get_rect_intersection_float)(varray* a, varray* b, varray* out) {
	SDL_FRect ra = read_frect(hl_aptr(a, double));
	SDL_FRect rb = read_frect(hl_aptr(b, double));
	SDL_FRect result;
	bool ok = SDL_GetRectIntersectionFloat(&ra, &rb, &result);
	if (ok)
		write_frect(hl_aptr(out, double), result);
	return ok;
}
DEFINE_PRIM(_BOOL, get_rect_intersection_float, _ARR _ARR _ARR);

HL_PRIM bool HL_NAME(get_rect_union_float)(varray* a, varray* b, varray* out) {
	SDL_FRect ra = read_frect(hl_aptr(a, double));
	SDL_FRect rb = read_frect(hl_aptr(b, double));
	SDL_FRect result;
	bool ok = SDL_GetRectUnionFloat(&ra, &rb, &result);
	if (ok)
		write_frect(hl_aptr(out, double), result);
	return ok;
}
DEFINE_PRIM(_BOOL, get_rect_union_float, _ARR _ARR _ARR);

HL_PRIM bool HL_NAME(get_rect_enclosing_points_float)(varray* pointsXY, varray* clip, varray* out) {
	int count = pointsXY->size / 2;
	double* px = hl_aptr(pointsXY, double);
	std::vector<SDL_FPoint> points;
	points.resize(count);
	for (int i = 0; i < count; i++) {
		points[i].x = (float)px[i * 2];
		points[i].y = (float)px[i * 2 + 1];
	}
	SDL_FRect clipRect;
	SDL_FRect* clipPtr = NULL;
	if (clip) {
		clipRect = read_frect(hl_aptr(clip, double));
		clipPtr = &clipRect;
	}
	SDL_FRect result;
	bool ok = SDL_GetRectEnclosingPointsFloat(points.data(), count, clipPtr, &result);
	if (ok)
		write_frect(hl_aptr(out, double), result);
	return ok;
}
DEFINE_PRIM(_BOOL, get_rect_enclosing_points_float, _ARR _ARR _ARR);

HL_PRIM bool HL_NAME(get_rect_and_line_intersection_float)(varray* rect, varray* line) {
	SDL_FRect r = read_frect(hl_aptr(rect, double));
	double* l = hl_aptr(line, double);
	float x1 = (float)l[0], y1 = (float)l[1], x2 = (float)l[2], y2 = (float)l[3];
	bool ok = SDL_GetRectAndLineIntersectionFloat(&r, &x1, &y1, &x2, &y2);
	l[0] = x1;
	l[1] = y1;
	l[2] = x2;
	l[3] = y2;
	return ok;
}
DEFINE_PRIM(_BOOL, get_rect_and_line_intersection_float, _ARR _ARR);
