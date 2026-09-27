package hl.bindings.sdl3;

/**
 * Logical keycodes used by SDL keyboard events.
 *
 * Unlike scancodes (which identify the physical key location), keycodes
 * represent the symbol printed on the key according to the active keyboard
 * layout. Use the constants in this class to compare against the `key` field
 * of a `SDLEvent.Key` event.
 *
 * Two special bit masks are used internally:
 * - `EXTENDED_MASK` marks keycodes outside the ASCII range.
 * - `SCANCODE_MASK` is used to encode scancodes in the same numeric space.
 *
 * Corresponds to `SDL_Keycode` in SDL3.
 */
class SDLKeycode {
	/** Marks keycodes beyond the basic ASCII range (e.g. function keys, arrows). */
	public static inline var EXTENDED_MASK = (1 << 29);

	/** Marks values that actually encode a scancode rather than a keycode. */
	public static inline var SCANCODE_MASK = (1 << 30);

	/** Unknown or invalid key. */
	public static inline var UNKNOWN = 0x00000000;

	/** The Return / Enter key. */
	public static inline var RETURN = 0x0000000d;

	/** The Escape key. */
	public static inline var ESCAPE = 0x0000001b;

	/** The Backspace key. */
	public static inline var BACKSPACE = 0x00000008;

	/** The Tab key. */
	public static inline var TAB = 0x00000009;

	/** The Space bar. */
	public static inline var SPACE = 0x00000020;

	/** `!` */
	public static inline var EXCLAIM = 0x00000021;

	/** `"` */
	public static inline var DBLAPOSTROPHE = 0x00000022;

	/** `#` */
	public static inline var HASH = 0x00000023;

	/** `$` */
	public static inline var DOLLAR = 0x00000024;

	/** `%` */
	public static inline var PERCENT = 0x00000025;

	/** `&` */
	public static inline var AMPERSAND = 0x00000026;

	/** `'` */
	public static inline var APOSTROPHE = 0x00000027;

	/** `(` */
	public static inline var LEFTPAREN = 0x00000028;

	/** `)` */
	public static inline var RIGHTPAREN = 0x00000029;

	/** `*` */
	public static inline var ASTERISK = 0x0000002a;

	/** `+` */
	public static inline var PLUS = 0x0000002b;

	/** `,` */
	public static inline var COMMA = 0x0000002c;

	/** `-` */
	public static inline var MINUS = 0x0000002d;

	/** `.` */
	public static inline var PERIOD = 0x0000002e;

	/** `/` */
	public static inline var SLASH = 0x0000002f;

	/** The `0` key. */
	public static inline var K0 = 0x00000030;

	/** The `1` key. */
	public static inline var K1 = 0x00000031;

	/** The `2` key. */
	public static inline var K2 = 0x00000032;

	/** The `3` key. */
	public static inline var K3 = 0x00000033;

	/** The `4` key. */
	public static inline var K4 = 0x00000034;

	/** The `5` key. */
	public static inline var K5 = 0x00000035;

	/** The `6` key. */
	public static inline var K6 = 0x00000036;

	/** The `7` key. */
	public static inline var K7 = 0x00000037;

	/** The `8` key. */
	public static inline var K8 = 0x00000038;

	/** The `9` key. */
	public static inline var K9 = 0x00000039;

	/** `:` */
	public static inline var COLON = 0x0000003a;

	/** `;` */
	public static inline var SEMICOLON = 0x0000003b;

	/** `<` */
	public static inline var LESS = 0x0000003c;

	/** `=` */
	public static inline var EQUALS = 0x0000003d;

	/** `>` */
	public static inline var GREATER = 0x0000003e;

	/** `?` */
	public static inline var QUESTION = 0x0000003f;

	/** `@` */
	public static inline var AT = 0x00000040;

	/** `[` */
	public static inline var LEFTBRACKET = 0x0000005b;

	/** `\` */
	public static inline var BACKSLASH = 0x0000005c;

	/** `]` */
	public static inline var RIGHTBRACKET = 0x0000005d;

	/** `^` */
	public static inline var CARET = 0x0000005e;

	/** `_` */
	public static inline var UNDERSCORE = 0x0000005f;

	/** `` ` `` */
	public static inline var GRAVE = 0x00000060;

	/** The `A` key. */
	public static inline var A = 0x00000061;

	/** The `B` key. */
	public static inline var B = 0x00000062;

	/** The `C` key. */
	public static inline var C = 0x00000063;

	/** The `D` key. */
	public static inline var D = 0x00000064;

	/** The `E` key. */
	public static inline var E = 0x00000065;

	/** The `F` key. */
	public static inline var F = 0x00000066;

	/** The `G` key. */
	public static inline var G = 0x00000067;

	/** The `H` key. */
	public static inline var H = 0x00000068;

	/** The `I` key. */
	public static inline var I = 0x00000069;

	/** The `J` key. */
	public static inline var J = 0x0000006a;

	/** The `K` key. */
	public static inline var K = 0x0000006b;

	/** The `L` key. */
	public static inline var L = 0x0000006c;

	/** The `M` key. */
	public static inline var M = 0x0000006d;

	/** The `N` key. */
	public static inline var N = 0x0000006e;

	/** The `O` key. */
	public static inline var O = 0x0000006f;

	/** The `P` key. */
	public static inline var P = 0x00000070;

	/** The `Q` key. */
	public static inline var Q = 0x00000071;

	/** The `R` key. */
	public static inline var R = 0x00000072;

	/** The `S` key. */
	public static inline var S = 0x00000073;

	/** The `T` key. */
	public static inline var T = 0x00000074;

	/** The `U` key. */
	public static inline var U = 0x00000075;

	/** The `V` key. */
	public static inline var V = 0x00000076;

	/** The `W` key. */
	public static inline var W = 0x00000077;

	/** The `X` key. */
	public static inline var X = 0x00000078;

	/** The `Y` key. */
	public static inline var Y = 0x00000079;

	/** The `Z` key. */
	public static inline var Z = 0x0000007a;

	/** `{` */
	public static inline var LEFTBRACE = 0x0000007b;

	/** `|` */
	public static inline var PIPE = 0x0000007c;

	/** `}` */
	public static inline var RIGHTBRACE = 0x0000007d;

	/** `~` */
	public static inline var TILDE = 0x0000007e;

	/** The Delete key. */
	public static inline var DELETE = 0x0000007f;

	/** The `±` key on international keyboards. */
	public static inline var PLUSMINUS = 0x000000b1;

	/** The Caps Lock key. */
	public static inline var CAPSLOCK = 0x40000039;

	/** The F1 function key. */
	public static inline var F1 = 0x4000003a;

	/** The F2 function key. */
	public static inline var F2 = 0x4000003b;

	/** The F3 function key. */
	public static inline var F3 = 0x4000003c;

	/** The F4 function key. */
	public static inline var F4 = 0x4000003d;

	/** The F5 function key. */
	public static inline var F5 = 0x4000003e;

	/** The F6 function key. */
	public static inline var F6 = 0x4000003f;

	/** The F7 function key. */
	public static inline var F7 = 0x40000040;

	/** The F8 function key. */
	public static inline var F8 = 0x40000041;

	/** The F9 function key. */
	public static inline var F9 = 0x40000042;

	/** The F10 function key. */
	public static inline var F10 = 0x40000043;

	/** The F11 function key. */
	public static inline var F11 = 0x40000044;

	/** The F12 function key. */
	public static inline var F12 = 0x40000045;

	/** The Print Screen key. */
	public static inline var PRINTSCREEN = 0x40000046;

	/** The Scroll Lock key. */
	public static inline var SCROLLLOCK = 0x40000047;

	/** The Pause / Break key. */
	public static inline var PAUSE = 0x40000048;

	/** The Insert key. */
	public static inline var INSERT = 0x40000049;

	/** The Home key. */
	public static inline var HOME = 0x4000004a;

	/** The Page Up key. */
	public static inline var PAGEUP = 0x4000004b;

	/** The End key. */
	public static inline var END = 0x4000004d;

	/** The Page Down key. */
	public static inline var PAGEDOWN = 0x4000004e;

	/** The right arrow key. */
	public static inline var RIGHT = 0x4000004f;

	/** The left arrow key. */
	public static inline var LEFT = 0x40000050;

	/** The down arrow key. */
	public static inline var DOWN = 0x40000051;

	/** The up arrow key. */
	public static inline var UP = 0x40000052;

	/** The Num Lock / Clear key. */
	public static inline var NUMLOCKCLEAR = 0x40000053;

	/** Keypad `/`. */
	public static inline var KP_DIVIDE = 0x40000054;

	/** Keypad `*`. */
	public static inline var KP_MULTIPLY = 0x40000055;

	/** Keypad `-`. */
	public static inline var KP_MINUS = 0x40000056;

	/** Keypad `+`. */
	public static inline var KP_PLUS = 0x40000057;

	/** Keypad Enter. */
	public static inline var KP_ENTER = 0x40000058;

	/** Keypad `1`. */
	public static inline var KP_1 = 0x40000059;

	/** Keypad `2`. */
	public static inline var KP_2 = 0x4000005a;

	/** Keypad `3`. */
	public static inline var KP_3 = 0x4000005b;

	/** Keypad `4`. */
	public static inline var KP_4 = 0x4000005c;

	/** Keypad `5`. */
	public static inline var KP_5 = 0x4000005d;

	/** Keypad `6`. */
	public static inline var KP_6 = 0x4000005e;

	/** Keypad `7`. */
	public static inline var KP_7 = 0x4000005f;

	/** Keypad `8`. */
	public static inline var KP_8 = 0x40000060;

	/** Keypad `9`. */
	public static inline var KP_9 = 0x40000061;

	/** Keypad `0`. */
	public static inline var KP_0 = 0x40000062;

	/** Keypad `.`. */
	public static inline var KP_PERIOD = 0x40000063;

	/** The Application / Menu key. */
	public static inline var APPLICATION = 0x40000065;

	/** The Power key. */
	public static inline var POWER = 0x40000066;

	/** Keypad `=`. */
	public static inline var KP_EQUALS = 0x40000067;

	/** The F13 function key. */
	public static inline var F13 = 0x40000068;

	/** The F14 function key. */
	public static inline var F14 = 0x40000069;

	/** The F15 function key. */
	public static inline var F15 = 0x4000006a;

	/** The F16 function key. */
	public static inline var F16 = 0x4000006b;

	/** The F17 function key. */
	public static inline var F17 = 0x4000006c;

	/** The F18 function key. */
	public static inline var F18 = 0x4000006d;

	/** The F19 function key. */
	public static inline var F19 = 0x4000006e;

	/** The F20 function key. */
	public static inline var F20 = 0x4000006f;

	/** The F21 function key. */
	public static inline var F21 = 0x40000070;

	/** The F22 function key. */
	public static inline var F22 = 0x40000071;

	/** The F23 function key. */
	public static inline var F23 = 0x40000072;

	/** The F24 function key. */
	public static inline var F24 = 0x40000073;

	/** The Execute key. */
	public static inline var EXECUTE = 0x40000074;

	/** The Help key. */
	public static inline var HELP = 0x40000075;

	/** The Menu key. */
	public static inline var MENU = 0x40000076;

	/** The Select key. */
	public static inline var SELECT = 0x40000077;

	/** The Stop key. */
	public static inline var STOP = 0x40000078;

	/** The Again key. */
	public static inline var AGAIN = 0x40000079;

	/** The Undo key. */
	public static inline var UNDO = 0x4000007a;

	/** The Cut key. */
	public static inline var CUT = 0x4000007b;

	/** The Copy key. */
	public static inline var COPY = 0x4000007c;

	/** The Paste key. */
	public static inline var PASTE = 0x4000007d;

	/** The Find key. */
	public static inline var FIND = 0x4000007e;

	/** The Mute key. */
	public static inline var MUTE = 0x4000007f;

	/** The Volume Up key. */
	public static inline var VOLUMEUP = 0x40000080;

	/** The Volume Down key. */
	public static inline var VOLUMEDOWN = 0x40000081;

	/** Keypad `,` (Brazilian keyboards). */
	public static inline var KP_COMMA = 0x40000085;

	/** Keypad `=` (AS/400 keyboards). */
	public static inline var KP_EQUALSAS400 = 0x40000086;

	/** The Alt Erase key. */
	public static inline var ALTERASE = 0x40000099;

	/** The SysReq key. */
	public static inline var SYSREQ = 0x4000009a;

	/** The Cancel key. */
	public static inline var CANCEL = 0x4000009b;

	/** The Clear key. */
	public static inline var CLEAR = 0x4000009c;

	/** The Prior key. */
	public static inline var PRIOR = 0x4000009d;

	/** The secondary Return key. */
	public static inline var RETURN2 = 0x4000009e;

	/** The Separator key. */
	public static inline var SEPARATOR = 0x4000009f;

	/** The Out key. */
	public static inline var OUT = 0x400000a0;

	/** The Oper key. */
	public static inline var OPER = 0x400000a1;

	/** The Clear/Again key. */
	public static inline var CLEARAGAIN = 0x400000a2;

	/** The CrSel key. */
	public static inline var CRSEL = 0x400000a3;

	/** The ExSel key. */
	public static inline var EXSEL = 0x400000a4;

	/** Keypad `00`. */
	public static inline var KP_00 = 0x400000b0;

	/** Keypad `000`. */
	public static inline var KP_000 = 0x400000b1;

	/** The thousands separator key. */
	public static inline var THOUSANDSSEPARATOR = 0x400000b2;

	/** The decimal separator key. */
	public static inline var DECIMALSEPARATOR = 0x400000b3;

	/** The currency unit key. */
	public static inline var CURRENCYUNIT = 0x400000b4;

	/** The currency subunit key. */
	public static inline var CURRENCYSUBUNIT = 0x400000b5;

	/** Keypad `(`. */
	public static inline var KP_LEFTPAREN = 0x400000b6;

	/** Keypad `)`. */
	public static inline var KP_RIGHTPAREN = 0x400000b7;

	/** Keypad `{`. */
	public static inline var KP_LEFTBRACE = 0x400000b8;

	/** Keypad `}`. */
	public static inline var KP_RIGHTBRACE = 0x400000b9;

	/** Keypad Tab. */
	public static inline var KP_TAB = 0x400000ba;

	/** Keypad Backspace. */
	public static inline var KP_BACKSPACE = 0x400000bb;

	/** Keypad `A`. */
	public static inline var KP_A = 0x400000bc;

	/** Keypad `B`. */
	public static inline var KP_B = 0x400000bd;

	/** Keypad `C`. */
	public static inline var KP_C = 0x400000be;

	/** Keypad `D`. */
	public static inline var KP_D = 0x400000bf;

	/** Keypad `E`. */
	public static inline var KP_E = 0x400000c0;

	/** Keypad `F`. */
	public static inline var KP_F = 0x400000c1;

	/** Keypad XOR. */
	public static inline var KP_XOR = 0x400000c2;

	/** Keypad `^` (power). */
	public static inline var KP_POWER = 0x400000c3;

	/** Keypad `%`. */
	public static inline var KP_PERCENT = 0x400000c4;

	/** Keypad `<`. */
	public static inline var KP_LESS = 0x400000c5;

	/** Keypad `>`. */
	public static inline var KP_GREATER = 0x400000c6;

	/** Keypad `&`. */
	public static inline var KP_AMPERSAND = 0x400000c7;

	/** Keypad `&&`. */
	public static inline var KP_DBLAMPERSAND = 0x400000c8;

	/** Keypad `|`. */
	public static inline var KP_VERTICALBAR = 0x400000c9;

	/** Keypad `||`. */
	public static inline var KP_DBLVERTICALBAR = 0x400000ca;

	/** Keypad `:`. */
	public static inline var KP_COLON = 0x400000cb;

	/** Keypad `#`. */
	public static inline var KP_HASH = 0x400000cc;

	/** Keypad Space. */
	public static inline var KP_SPACE = 0x400000cd;

	/** Keypad `@`. */
	public static inline var KP_AT = 0x400000ce;

	/** Keypad `!`. */
	public static inline var KP_EXCLAM = 0x400000cf;

	/** Keypad memory store. */
	public static inline var KP_MEMSTORE = 0x400000d0;

	/** Keypad memory recall. */
	public static inline var KP_MEMRECALL = 0x400000d1;

	/** Keypad memory clear. */
	public static inline var KP_MEMCLEAR = 0x400000d2;

	/** Keypad memory add. */
	public static inline var KP_MEMADD = 0x400000d3;

	/** Keypad memory subtract. */
	public static inline var KP_MEMSUBTRACT = 0x400000d4;

	/** Keypad memory multiply. */
	public static inline var KP_MEMMULTIPLY = 0x400000d5;

	/** Keypad memory divide. */
	public static inline var KP_MEMDIVIDE = 0x400000d6;

	/** Keypad `±`. */
	public static inline var KP_PLUSMINUS = 0x400000d7;

	/** Keypad Clear. */
	public static inline var KP_CLEAR = 0x400000d8;

	/** Keypad Clear Entry. */
	public static inline var KP_CLEARENTRY = 0x400000d9;

	/** Keypad binary. */
	public static inline var KP_BINARY = 0x400000da;

	/** Keypad octal. */
	public static inline var KP_OCTAL = 0x400000db;

	/** Keypad decimal. */
	public static inline var KP_DECIMAL = 0x400000dc;

	/** Keypad hexadecimal. */
	public static inline var KP_HEXADECIMAL = 0x400000dd;

	/** The left Ctrl key. */
	public static inline var LCTRL = 0x400000e0;

	/** The left Shift key. */
	public static inline var LSHIFT = 0x400000e1;

	/** The left Alt key. */
	public static inline var LALT = 0x400000e2;

	/** The left GUI / Windows / Command key. */
	public static inline var LGUI = 0x400000e3;

	/** The right Ctrl key. */
	public static inline var RCTRL = 0x400000e4;

	/** The right Shift key. */
	public static inline var RSHIFT = 0x400000e5;

	/** The right Alt key (AltGr). */
	public static inline var RALT = 0x400000e6;

	/** The right GUI / Windows / Command key. */
	public static inline var RGUI = 0x400000e7;

	/** The Mode key (AltGr on some layouts). */
	public static inline var MODE = 0x40000101;

	/** The Sleep key. */
	public static inline var SLEEP = 0x40000102;

	/** The Wake key. */
	public static inline var WAKE = 0x40000103;

	/** The Channel Increment key. */
	public static inline var CHANNEL_INCREMENT = 0x40000104;

	/** The Channel Decrement key. */
	public static inline var CHANNEL_DECREMENT = 0x40000105;

	/** The Media Play key. */
	public static inline var MEDIA_PLAY = 0x40000106;

	/** The Media Pause key. */
	public static inline var MEDIA_PAUSE = 0x40000107;

	/** The Media Record key. */
	public static inline var MEDIA_RECORD = 0x40000108;

	/** The Media Fast Forward key. */
	public static inline var MEDIA_FAST_FORWARD = 0x40000109;

	/** The Media Rewind key. */
	public static inline var MEDIA_REWIND = 0x4000010a;

	/** The Media Next Track key. */
	public static inline var MEDIA_NEXT_TRACK = 0x4000010b;

	/** The Media Previous Track key. */
	public static inline var MEDIA_PREVIOUS_TRACK = 0x4000010c;

	/** The Media Stop key. */
	public static inline var MEDIA_STOP = 0x4000010d;

	/** The Media Eject key. */
	public static inline var MEDIA_EJECT = 0x4000010e;

	/** The Media Play/Pause toggle key. */
	public static inline var MEDIA_PLAY_PAUSE = 0x4000010f;

	/** The Media Select key. */
	public static inline var MEDIA_SELECT = 0x40000110;

	/** The AC New key. */
	public static inline var AC_NEW = 0x40000111;

	/** The AC Open key. */
	public static inline var AC_OPEN = 0x40000112;

	/** The AC Close key. */
	public static inline var AC_CLOSE = 0x40000113;

	/** The AC Exit key. */
	public static inline var AC_EXIT = 0x40000114;

	/** The AC Save key. */
	public static inline var AC_SAVE = 0x40000115;

	/** The AC Print key. */
	public static inline var AC_PRINT = 0x40000116;

	/** The AC Properties key. */
	public static inline var AC_PROPERTIES = 0x40000117;

	/** The AC Search key. */
	public static inline var AC_SEARCH = 0x40000118;

	/** The AC Home key. */
	public static inline var AC_HOME = 0x40000119;

	/** The AC Back key. */
	public static inline var AC_BACK = 0x4000011a;

	/** The AC Forward key. */
	public static inline var AC_FORWARD = 0x4000011b;

	/** The AC Stop key. */
	public static inline var AC_STOP = 0x4000011c;

	/** The AC Refresh key. */
	public static inline var AC_REFRESH = 0x4000011d;

	/** The AC Bookmarks key. */
	public static inline var AC_BOOKMARKS = 0x4000011e;

	/** The Soft Left key (mobile). */
	public static inline var SOFTLEFT = 0x4000011f;

	/** The Soft Right key (mobile). */
	public static inline var SOFTRIGHT = 0x40000120;

	/** The Call key (mobile). */
	public static inline var CALL = 0x40000121;

	/** The End Call key (mobile). */
	public static inline var ENDCALL = 0x40000122;

	/** The Left Tab key. */
	public static inline var LEFT_TAB = 0x20000001;

	/** The Level 5 Shift key. */
	public static inline var LEVEL5_SHIFT = 0x20000002;

	/** The Multi-key Compose key. */
	public static inline var MULTI_KEY_COMPOSE = 0x20000003;

	/** The left Meta key. */
	public static inline var LMETA = 0x20000004;

	/** The right Meta key. */
	public static inline var RMETA = 0x20000005;

	/** The left Hyper key. */
	public static inline var LHYPER = 0x20000006;

	/** The right Hyper key. */
	public static inline var RHYPER = 0x20000007;
}
