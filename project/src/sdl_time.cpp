#include "SDL3/SDL_time.h"

#include <string.h>

#include "hashlink_macros.h"

HL_PRIM SDL_DateTime* HL_NAME(date_time_alloc)() {
    SDL_DateTime* dt = (SDL_DateTime*)hl_gc_alloc_noptr(sizeof(SDL_DateTime));
    memset(dt, 0, sizeof(SDL_DateTime));
    return dt;
}
DEFINE_PRIM(_ABSTRACT(SDL_DateTime), date_time_alloc, _NO_ARG);

HL_PRIM int HL_NAME(date_time_year)(SDL_DateTime* dt) { return dt->year; }
DEFINE_PRIM(_I32, date_time_year, _ABSTRACT(SDL_DateTime));

HL_PRIM int HL_NAME(date_time_month)(SDL_DateTime* dt) { return dt->month; }
DEFINE_PRIM(_I32, date_time_month, _ABSTRACT(SDL_DateTime));

HL_PRIM int HL_NAME(date_time_day)(SDL_DateTime* dt) { return dt->day; }
DEFINE_PRIM(_I32, date_time_day, _ABSTRACT(SDL_DateTime));

HL_PRIM int HL_NAME(date_time_hour)(SDL_DateTime* dt) { return dt->hour; }
DEFINE_PRIM(_I32, date_time_hour, _ABSTRACT(SDL_DateTime));

HL_PRIM int HL_NAME(date_time_minute)(SDL_DateTime* dt) { return dt->minute; }
DEFINE_PRIM(_I32, date_time_minute, _ABSTRACT(SDL_DateTime));

HL_PRIM int HL_NAME(date_time_second)(SDL_DateTime* dt) { return dt->second; }
DEFINE_PRIM(_I32, date_time_second, _ABSTRACT(SDL_DateTime));

HL_PRIM int HL_NAME(date_time_nanosecond)(SDL_DateTime* dt) {
    return dt->nanosecond;
}
DEFINE_PRIM(_I32, date_time_nanosecond, _ABSTRACT(SDL_DateTime));

HL_PRIM int HL_NAME(date_time_day_of_week)(SDL_DateTime* dt) {
    return dt->day_of_week;
}
DEFINE_PRIM(_I32, date_time_day_of_week, _ABSTRACT(SDL_DateTime));

HL_PRIM int HL_NAME(date_time_utc_offset)(SDL_DateTime* dt) {
    return dt->utc_offset;
}
DEFINE_PRIM(_I32, date_time_utc_offset, _ABSTRACT(SDL_DateTime));

HL_PRIM void HL_NAME(date_time_set)(SDL_DateTime* dt, int year, int month,
                                    int day, int hour, int minute, int second,
                                    int nanosecond, int dayOfWeek,
                                    int utcOffset) {
    dt->year = year;
    dt->month = month;
    dt->day = day;
    dt->hour = hour;
    dt->minute = minute;
    dt->second = second;
    dt->nanosecond = nanosecond;
    dt->day_of_week = dayOfWeek;
    dt->utc_offset = utcOffset;
}
DEFINE_PRIM(_VOID, date_time_set,
            _ABSTRACT(SDL_DateTime)
                _I32 _I32 _I32 _I32 _I32 _I32 _I32 _I32 _I32);

HL_PRIM void HL_NAME(get_date_time_locale_preferences)(varray* out) {
    SDL_DateFormat df = SDL_DATE_FORMAT_YYYYMMDD;
    SDL_TimeFormat tf = SDL_TIME_FORMAT_24HR;
    bool ok = SDL_GetDateTimeLocalePreferences(&df, &tf);
    int* o = hl_aptr(out, int);
    o[0] = ok ? 1 : 0;
    o[1] = (int)df;
    o[2] = (int)tf;
}
DEFINE_PRIM(_VOID, get_date_time_locale_preferences, _ARR);

HL_PRIM bool HL_NAME(get_current_time)(varray* out) {
    SDL_Time t = 0;
    bool ok = SDL_GetCurrentTime(&t);
    int* o = hl_aptr(out, int);
    o[0] = (int)(Uint32)((Uint64)t >> 32);
    o[1] = (int)(Uint32)((Uint64)t & 0xFFFFFFFFu);
    return ok;
}
DEFINE_PRIM(_BOOL, get_current_time, _ARR);

HL_PRIM bool HL_NAME(time_to_date_time)(int64 ticks, SDL_DateTime* dt,
                                        bool localTime) {
    return SDL_TimeToDateTime((SDL_Time)ticks, dt, localTime);
}
DEFINE_PRIM(_BOOL, time_to_date_time, _I64 _ABSTRACT(SDL_DateTime) _BOOL);

HL_PRIM bool HL_NAME(date_time_to_time)(SDL_DateTime* dt, varray* out) {
    SDL_Time t = 0;
    bool ok = SDL_DateTimeToTime(dt, &t);
    int* o = hl_aptr(out, int);
    o[0] = (int)(Uint32)((Uint64)t >> 32);
    o[1] = (int)(Uint32)((Uint64)t & 0xFFFFFFFFu);
    return ok;
}
DEFINE_PRIM(_BOOL, date_time_to_time, _ABSTRACT(SDL_DateTime) _ARR);

HL_PRIM void HL_NAME(time_to_windows)(int64 ticks, varray* out) {
    Uint32 lo = 0, hi = 0;
    SDL_TimeToWindows((SDL_Time)ticks, &lo, &hi);
    int* o = hl_aptr(out, int);
    o[0] = (int)lo;
    o[1] = (int)hi;
}
DEFINE_PRIM(_VOID, time_to_windows, _I64 _ARR);

HL_PRIM int64 HL_NAME(time_from_windows)(int lo, int hi) {
    return (int64)SDL_TimeFromWindows((Uint32)lo, (Uint32)hi);
}
DEFINE_PRIM(_I64, time_from_windows, _I32 _I32);

HL_PRIM int HL_NAME(get_days_in_month)(int year, int month) {
    return SDL_GetDaysInMonth(year, month);
}
DEFINE_PRIM(_I32, get_days_in_month, _I32 _I32);

HL_PRIM int HL_NAME(get_day_of_year)(int year, int month, int day) {
    return SDL_GetDayOfYear(year, month, day);
}
DEFINE_PRIM(_I32, get_day_of_year, _I32 _I32 _I32);

HL_PRIM int HL_NAME(get_day_of_week)(int year, int month, int day) {
    return SDL_GetDayOfWeek(year, month, day);
}
DEFINE_PRIM(_I32, get_day_of_week, _I32 _I32 _I32);