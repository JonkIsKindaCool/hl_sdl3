package hl.bindings.sdl3;

/**
 * Physical key positions on a keyboard.
 *
 * Unlike keycodes (which depend on the active keyboard layout), scancodes
 * identify the physical location of a key and are stable across layouts.
 * They match the USB HID usage table plus a few platform-specific extras.
 *
 * Use these constants when you want a key binding to follow the physical
 * position of a key (e.g. WASD movement stays on the same physical keys
 * regardless of whether the user has a QWERTY, AZERTY, or Dvorak layout).
 *
 * Corresponds to `SDL_Scancode` in SDL3.
 */
class SDLScancode {
	/** Unknown or invalid scancode. */
	public static inline var UNKNOWN = 0;

	/** The `A` key. */
	public static inline var A = 4;

	/** The `B` key. */
	public static inline var B = 5;

	/** The `C` key. */
	public static inline var C = 6;

	/** The `D` key. */
	public static inline var D = 7;

	/** The `E` key. */
	public static inline var E = 8;

	/** The `F` key. */
	public static inline var F = 9;

	/** The `G` key. */
	public static inline var G = 10;

	/** The `H` key. */
	public static inline var H = 11;

	/** The `I` key. */
	public static inline var I = 12;

	/** The `J` key. */
	public static inline var J = 13;

	/** The `K` key. */
	public static inline var K = 14;

	/** The `L` key. */
	public static inline var L = 15;

	/** The `M` key. */
	public static inline var M = 16;

	/** The `N` key. */
	public static inline var N = 17;

	/** The `O` key. */
	public static inline var O = 18;

	/** The `P` key. */
	public static inline var P = 19;

	/** The `Q` key. */
	public static inline var Q = 20;

	/** The `R` key. */
	public static inline var R = 21;

	/** The `S` key. */
	public static inline var S = 22;

	/** The `T` key. */
	public static inline var T = 23;

	/** The `U` key. */
	public static inline var U = 24;

	/** The `V` key. */
	public static inline var V = 25;

	/** The `W` key. */
	public static inline var W = 26;

	/** The `X` key. */
	public static inline var X = 27;

	/** The `Y` key. */
	public static inline var Y = 28;

	/** The `Z` key. */
	public static inline var Z = 29;

	/** The `1` key on the top row. */
	public static inline var K1 = 30;

	/** The `2` key on the top row. */
	public static inline var K2 = 31;

	/** The `3` key on the top row. */
	public static inline var K3 = 32;

	/** The `4` key on the top row. */
	public static inline var K4 = 33;

	/** The `5` key on the top row. */
	public static inline var K5 = 34;

	/** The `6` key on the top row. */
	public static inline var K6 = 35;

	/** The `7` key on the top row. */
	public static inline var K7 = 36;

	/** The `8` key on the top row. */
	public static inline var K8 = 37;

	/** The `9` key on the top row. */
	public static inline var K9 = 38;

	/** The `0` key on the top row. */
	public static inline var K0 = 39;

	/** The Return / Enter key. */
	public static inline var RETURN = 40;

	/** The Escape key. */
	public static inline var ESCAPE = 41;

	/** The Backspace key. */
	public static inline var BACKSPACE = 42;

	/** The Tab key. */
	public static inline var TAB = 43;

	/** The Space bar. */
	public static inline var SPACE = 44;

	/** The `-` / `_` key. */
	public static inline var MINUS = 45;

	/** The `=` / `+` key. */
	public static inline var EQUALS = 46;

	/** The `[` / `{` key. */
	public static inline var LEFTBRACKET = 47;

	/** The `]` / `}` key. */
	public static inline var RIGHTBRACKET = 48;

	/** The `\` / `|` key (US ANSI). */
	public static inline var BACKSLASH = 49;

	/** Non-US `#` / `~` key (JIS keyboards). */
	public static inline var NONUSHASH = 50;

	/** The `;` / `:` key. */
	public static inline var SEMICOLON = 51;

	/** The `'` / `"` key. */
	public static inline var APOSTROPHE = 52;

	/** The `` ` `` / `~` key. */
	public static inline var GRAVE = 53;

	/** The `,` / `<` key. */
	public static inline var COMMA = 54;

	/** The `.` / `>` key. */
	public static inline var PERIOD = 55;

	/** The `/` / `?` key. */
	public static inline var SLASH = 56;

	/** The Caps Lock key. */
	public static inline var CAPSLOCK = 57;

	/** The F1 function key. */
	public static inline var F1 = 58;

	/** The F2 function key. */
	public static inline var F2 = 59;

	/** The F3 function key. */
	public static inline var F3 = 60;

	/** The F4 function key. */
	public static inline var F4 = 61;

	/** The F5 function key. */
	public static inline var F5 = 62;

	/** The F6 function key. */
	public static inline var F6 = 63;

	/** The F7 function key. */
	public static inline var F7 = 64;

	/** The F8 function key. */
	public static inline var F8 = 65;

	/** The F9 function key. */
	public static inline var F9 = 66;

	/** The F10 function key. */
	public static inline var F10 = 67;

	/** The F11 function key. */
	public static inline var F11 = 68;

	/** The F12 function key. */
	public static inline var F12 = 69;

	/** The Print Screen key. */
	public static inline var PRINTSCREEN = 70;

	/** The Scroll Lock key. */
	public static inline var SCROLLLOCK = 71;

	/** The Pause / Break key. */
	public static inline var PAUSE = 72;

	/** The Insert key. */
	public static inline var INSERT = 73;

	/** The Home key. */
	public static inline var HOME = 74;

	/** The Page Up key. */
	public static inline var PAGEUP = 75;

	/** The Delete key. */
	public static inline var DELETE = 76;

	/** The End key. */
	public static inline var END = 77;

	/** The Page Down key. */
	public static inline var PAGEDOWN = 78;

	/** The right arrow key. */
	public static inline var RIGHT = 79;

	/** The left arrow key. */
	public static inline var LEFT = 80;

	/** The down arrow key. */
	public static inline var DOWN = 81;

	/** The up arrow key. */
	public static inline var UP = 82;

	/** The Num Lock / Clear key. */
	public static inline var NUMLOCKCLEAR = 83;

	/** Keypad `/`. */
	public static inline var KP_DIVIDE = 84;

	/** Keypad `*`. */
	public static inline var KP_MULTIPLY = 85;

	/** Keypad `-`. */
	public static inline var KP_MINUS = 86;

	/** Keypad `+`. */
	public static inline var KP_PLUS = 87;

	/** Keypad Enter. */
	public static inline var KP_ENTER = 88;

	/** Keypad `1`. */
	public static inline var KP_1 = 89;

	/** Keypad `2`. */
	public static inline var KP_2 = 90;

	/** Keypad `3`. */
	public static inline var KP_3 = 91;

	/** Keypad `4`. */
	public static inline var KP_4 = 92;

	/** Keypad `5`. */
	public static inline var KP_5 = 93;

	/** Keypad `6`. */
	public static inline var KP_6 = 94;

	/** Keypad `7`. */
	public static inline var KP_7 = 95;

	/** Keypad `8`. */
	public static inline var KP_8 = 96;

	/** Keypad `9`. */
	public static inline var KP_9 = 97;

	/** Keypad `0`. */
	public static inline var KP_0 = 98;

	/** Keypad `.`. */
	public static inline var KP_PERIOD = 99;

	/** Non-US `\` / `|` key (ISO keyboards). */
	public static inline var NONUSBACKSLASH = 100;

	/** The Application / Menu key. */
	public static inline var APPLICATION = 101;

	/** The Power key. */
	public static inline var POWER = 102;

	/** Keypad `=`. */
	public static inline var KP_EQUALS = 103;

	/** The F13 function key. */
	public static inline var F13 = 104;

	/** The F14 function key. */
	public static inline var F14 = 105;

	/** The F15 function key. */
	public static inline var F15 = 106;

	/** The F16 function key. */
	public static inline var F16 = 107;

	/** The F17 function key. */
	public static inline var F17 = 108;

	/** The F18 function key. */
	public static inline var F18 = 109;

	/** The F19 function key. */
	public static inline var F19 = 110;

	/** The F20 function key. */
	public static inline var F20 = 111;

	/** The F21 function key. */
	public static inline var F21 = 112;

	/** The F22 function key. */
	public static inline var F22 = 113;

	/** The F23 function key. */
	public static inline var F23 = 114;

	/** The F24 function key. */
	public static inline var F24 = 115;

	/** The Execute key. */
	public static inline var EXECUTE = 116;

	/** The Help key. */
	public static inline var HELP = 117;

	/** The Menu key. */
	public static inline var MENU = 118;

	/** The Select key. */
	public static inline var SELECT = 119;

	/** The Stop key. */
	public static inline var STOP = 120;

	/** The Again key. */
	public static inline var AGAIN = 121;

	/** The Undo key. */
	public static inline var UNDO = 122;

	/** The Cut key. */
	public static inline var CUT = 123;

	/** The Copy key. */
	public static inline var COPY = 124;

	/** The Paste key. */
	public static inline var PASTE = 125;

	/** The Find key. */
	public static inline var FIND = 126;

	/** The Mute key. */
	public static inline var MUTE = 127;

	/** The Volume Up key. */
	public static inline var VOLUMEUP = 128;

	/** The Volume Down key. */
	public static inline var VOLUMEDOWN = 129;

	/** The "locking" Caps Lock key (sends a lock state change instead of a toggle). */
	public static inline var LOCKINGCAPSLOCK = 130;

	/** The "locking" Num Lock key. */
	public static inline var LOCKINGNUMLOCK = 131;

	/** The "locking" Scroll Lock key. */
	public static inline var LOCKINGSCROLLLOCK = 132;

	/** Keypad `,` (Brazilian keyboards). */
	public static inline var KP_COMMA = 133;

	/** Keypad `=` (AS/400 keyboards). */
	public static inline var KP_EQUALSAS400 = 134;

	/** International key 1 (varies by locale). */
	public static inline var INTERNATIONAL1 = 135;

	/** International key 2 (varies by locale). */
	public static inline var INTERNATIONAL2 = 136;

	/** International key 3 (e.g. Yen on JIS keyboards). */
	public static inline var INTERNATIONAL3 = 137;

	/** International key 4 (varies by locale). */
	public static inline var INTERNATIONAL4 = 138;

	/** International key 5 (varies by locale). */
	public static inline var INTERNATIONAL5 = 139;

	/** International key 6 (varies by locale). */
	public static inline var INTERNATIONAL6 = 140;

	/** International key 7 (varies by locale). */
	public static inline var INTERNATIONAL7 = 141;

	/** International key 8 (varies by locale). */
	public static inline var INTERNATIONAL8 = 142;

	/** International key 9 (varies by locale). */
	public static inline var INTERNATIONAL9 = 143;

	/** Language key 1 (e.g. Hiragana on JIS keyboards). */
	public static inline var LANG1 = 144;

	/** Language key 2 (e.g. Katakana on JIS keyboards). */
	public static inline var LANG2 = 145;

	/** Language key 3 (e.g. Hiragana/Katakana toggle). */
	public static inline var LANG3 = 146;

	/** Language key 4 (e.g. Henkan on JIS keyboards). */
	public static inline var LANG4 = 147;

	/** Language key 5 (e.g. Muhenkan on JIS keyboards). */
	public static inline var LANG5 = 148;

	/** Language key 6 (varies by locale). */
	public static inline var LANG6 = 149;

	/** Language key 7 (varies by locale). */
	public static inline var LANG7 = 150;

	/** Language key 8 (varies by locale). */
	public static inline var LANG8 = 151;

	/** Language key 9 (varies by locale). */
	public static inline var LANG9 = 152;

	/** The Alt Erase key. */
	public static inline var ALTERASE = 153;

	/** The SysReq key. */
	public static inline var SYSREQ = 154;

	/** The Cancel key. */
	public static inline var CANCEL = 155;

	/** The Clear key. */
	public static inline var CLEAR = 156;

	/** The Prior key. */
	public static inline var PRIOR = 157;

	/** The secondary Return key. */
	public static inline var RETURN2 = 158;

	/** The Separator key. */
	public static inline var SEPARATOR = 159;

	/** The Out key. */
	public static inline var OUT = 160;

	/** The Oper key. */
	public static inline var OPER = 161;

	/** The Clear/Again key. */
	public static inline var CLEARAGAIN = 162;

	/** The CrSel key. */
	public static inline var CRSEL = 163;

	/** The ExSel key. */
	public static inline var EXSEL = 164;

	/** Keypad `00`. */
	public static inline var KP_00 = 176;

	/** Keypad `000`. */
	public static inline var KP_000 = 177;

	/** The thousands separator key. */
	public static inline var THOUSANDSSEPARATOR = 178;

	/** The decimal separator key. */
	public static inline var DECIMALSEPARATOR = 179;

	/** The currency unit key. */
	public static inline var CURRENCYUNIT = 180;

	/** The currency subunit key. */
	public static inline var CURRENCYSUBUNIT = 181;

	/** Keypad `(`. */
	public static inline var KP_LEFTPAREN = 182;

	/** Keypad `)`. */
	public static inline var KP_RIGHTPAREN = 183;

	/** Keypad `{`. */
	public static inline var KP_LEFTBRACE = 184;

	/** Keypad `}`. */
	public static inline var KP_RIGHTBRACE = 185;

	/** Keypad Tab. */
	public static inline var KP_TAB = 186;

	/** Keypad Backspace. */
	public static inline var KP_BACKSPACE = 187;

	/** Keypad `A`. */
	public static inline var KP_A = 188;

	/** Keypad `B`. */
	public static inline var KP_B = 189;

	/** Keypad `C`. */
	public static inline var KP_C = 190;

	/** Keypad `D`. */
	public static inline var KP_D = 191;

	/** Keypad `E`. */
	public static inline var KP_E = 192;

	/** Keypad `F`. */
	public static inline var KP_F = 193;

	/** Keypad XOR. */
	public static inline var KP_XOR = 194;

	/** Keypad `^` (power). */
	public static inline var KP_POWER = 195;

	/** Keypad `%`. */
	public static inline var KP_PERCENT = 196;

	/** Keypad `<`. */
	public static inline var KP_LESS = 197;

	/** Keypad `>`. */
	public static inline var KP_GREATER = 198;

	/** Keypad `&`. */
	public static inline var KP_AMPERSAND = 199;

	/** Keypad `&&`. */
	public static inline var KP_DBLAMPERSAND = 200;

	/** Keypad `|`. */
	public static inline var KP_VERTICALBAR = 201;

	/** Keypad `||`. */
	public static inline var KP_DBLVERTICALBAR = 202;

	/** Keypad `:`. */
	public static inline var KP_COLON = 203;

	/** Keypad `#`. */
	public static inline var KP_HASH = 204;

	/** Keypad Space. */
	public static inline var KP_SPACE = 205;

	/** Keypad `@`. */
	public static inline var KP_AT = 206;

	/** Keypad `!`. */
	public static inline var KP_EXCLAM = 207;

	/** Keypad memory store. */
	public static inline var KP_MEMSTORE = 208;

	/** Keypad memory recall. */
	public static inline var KP_MEMRECALL = 209;

	/** Keypad memory clear. */
	public static inline var KP_MEMCLEAR = 210;

	/** Keypad memory add. */
	public static inline var KP_MEMADD = 211;

	/** Keypad memory subtract. */
	public static inline var KP_MEMSUBTRACT = 212;

	/** Keypad memory multiply. */
	public static inline var KP_MEMMULTIPLY = 213;

	/** Keypad memory divide. */
	public static inline var KP_MEMDIVIDE = 214;

	/** Keypad `±`. */
	public static inline var KP_PLUSMINUS = 215;

	/** Keypad Clear. */
	public static inline var KP_CLEAR = 216;

	/** Keypad Clear Entry. */
	public static inline var KP_CLEARENTRY = 217;

	/** Keypad binary. */
	public static inline var KP_BINARY = 218;

	/** Keypad octal. */
	public static inline var KP_OCTAL = 219;

	/** Keypad decimal. */
	public static inline var KP_DECIMAL = 220;

	/** Keypad hexadecimal. */
	public static inline var KP_HEXADECIMAL = 221;

	/** The left Ctrl key. */
	public static inline var LCTRL = 224;

	/** The left Shift key. */
	public static inline var LSHIFT = 225;

	/** The left Alt key. */
	public static inline var LALT = 226;

	/** The left GUI / Windows / Command key. */
	public static inline var LGUI = 227;

	/** The right Ctrl key. */
	public static inline var RCTRL = 228;

	/** The right Shift key. */
	public static inline var RSHIFT = 229;

	/** The right Alt key (AltGr). */
	public static inline var RALT = 230;

	/** The right GUI / Windows / Command key. */
	public static inline var RGUI = 231;

	/** The Mode key (AltGr on some layouts). */
	public static inline var MODE = 257;

	/** The Sleep key. */
	public static inline var SLEEP = 258;

	/** The Wake key. */
	public static inline var WAKE = 259;

	/** The Channel Increment key. */
	public static inline var CHANNEL_INCREMENT = 260;

	/** The Channel Decrement key. */
	public static inline var CHANNEL_DECREMENT = 261;

	/** The Media Play key. */
	public static inline var MEDIA_PLAY = 262;

	/** The Media Pause key. */
	public static inline var MEDIA_PAUSE = 263;

	/** The Media Record key. */
	public static inline var MEDIA_RECORD = 264;

	/** The Media Fast Forward key. */
	public static inline var MEDIA_FAST_FORWARD = 265;

	/** The Media Rewind key. */
	public static inline var MEDIA_REWIND = 266;

	/** The Media Next Track key. */
	public static inline var MEDIA_NEXT_TRACK = 267;

	/** The Media Previous Track key. */
	public static inline var MEDIA_PREVIOUS_TRACK = 268;

	/** The Media Stop key. */
	public static inline var MEDIA_STOP = 269;

	/** The Media Eject key. */
	public static inline var MEDIA_EJECT = 270;

	/** The Media Play/Pause toggle key. */
	public static inline var MEDIA_PLAY_PAUSE = 271;

	/** The Media Select key. */
	public static inline var MEDIA_SELECT = 272;

	/** The AC New key. */
	public static inline var AC_NEW = 273;

	/** The AC Open key. */
	public static inline var AC_OPEN = 274;

	/** The AC Close key. */
	public static inline var AC_CLOSE = 275;

	/** The AC Exit key. */
	public static inline var AC_EXIT = 276;

	/** The AC Save key. */
	public static inline var AC_SAVE = 277;

	/** The AC Print key. */
	public static inline var AC_PRINT = 278;

	/** The AC Properties key. */
	public static inline var AC_PROPERTIES = 279;

	/** The AC Search key. */
	public static inline var AC_SEARCH = 280;

	/** The AC Home key. */
	public static inline var AC_HOME = 281;

	/** The AC Back key. */
	public static inline var AC_BACK = 282;

	/** The AC Forward key. */
	public static inline var AC_FORWARD = 283;

	/** The AC Stop key. */
	public static inline var AC_STOP = 284;

	/** The AC Refresh key. */
	public static inline var AC_REFRESH = 285;

	/** The AC Bookmarks key. */
	public static inline var AC_BOOKMARKS = 286;

	/** The Soft Left key (mobile). */
	public static inline var SOFTLEFT = 287;

	/** The Soft Right key (mobile). */
	public static inline var SOFTRIGHT = 288;

	/** The Call key (mobile). */
	public static inline var CALL = 289;

	/** The End Call key (mobile). */
	public static inline var ENDCALL = 290;

	/** Reserved range start (do not use). */
	public static inline var RESERVED = 400;

	/** Total number of defined scancodes (not a valid scancode). */
	public static inline var COUNT = 512;
}
