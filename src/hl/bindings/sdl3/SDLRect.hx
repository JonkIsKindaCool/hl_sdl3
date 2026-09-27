package hl.bindings.sdl3;

/**
 * An integer 2D point.
 */
typedef SDLPoint = {
	/** X coordinate. */
	x:Int,

	/** Y coordinate. */
	y:Int
}

/**
 * A floating-point 2D point.
 */
typedef SDLFPoint = {
	/** X coordinate. */
	x:Float,

	/** Y coordinate. */
	y:Float
}

/**
 * An integer rectangle.
 *
 * `(x, y)` is the top-left corner; `w` and `h` are the width and height.
 */
typedef SDLRect = {
	/** X coordinate of the top-left corner. */
	x:Int,

	/** Y coordinate of the top-left corner. */
	y:Int,

	/** Width of the rectangle. */
	w:Int,

	/** Height of the rectangle. */
	h:Int
}

/**
 * A floating-point rectangle.
 *
 * `(x, y)` is the top-left corner; `w` and `h` are the width and height.
 */
typedef SDLFRect = {
	/** X coordinate of the top-left corner. */
	x:Float,

	/** Y coordinate of the top-left corner. */
	y:Float,

	/** Width of the rectangle. */
	w:Float,

	/** Height of the rectangle. */
	h:Float
}

/**
 * An integer line segment from `(x1, y1)` to `(x2, y2)`.
 */
typedef SDLLine = {
	/** X coordinate of the start point. */
	x1:Int,

	/** Y coordinate of the start point. */
	y1:Int,

	/** X coordinate of the end point. */
	x2:Int,

	/** Y coordinate of the end point. */
	y2:Int
}

/**
 * A floating-point line segment from `(x1, y1)` to `(x2, y2)`.
 */
typedef SDLFLine = {
	/** X coordinate of the start point. */
	x1:Float,

	/** Y coordinate of the start point. */
	y1:Float,

	/** X coordinate of the end point. */
	x2:Float,

	/** Y coordinate of the end point. */
	y2:Float
}

@:noCompletion
class SDLRectNative {
	@:hlNative("sdl3", "has_rect_intersection") public static function hasIntersection(a:hl.NativeArray<Int>, b:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "get_rect_intersection") public static function getIntersection(a:hl.NativeArray<Int>, b:hl.NativeArray<Int>,
			out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "get_rect_union") public static function getUnion(a:hl.NativeArray<Int>, b:hl.NativeArray<Int>, out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "get_rect_enclosing_points") public static function getEnclosingPoints(pointsXY:hl.NativeArray<Int>, clip:hl.NativeArray<Int>,
			out:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "get_rect_and_line_intersection") public static function getAndLineIntersection(rect:hl.NativeArray<Int>, line:hl.NativeArray<Int>):Bool
		return false;

	@:hlNative("sdl3", "has_rect_intersection_float") public static function hasIntersectionFloat(a:hl.NativeArray<Float>, b:hl.NativeArray<Float>):Bool
		return false;

	@:hlNative("sdl3", "get_rect_intersection_float") public static function getIntersectionFloat(a:hl.NativeArray<Float>, b:hl.NativeArray<Float>,
			out:hl.NativeArray<Float>):Bool
		return false;

	@:hlNative("sdl3", "get_rect_union_float") public static function getUnionFloat(a:hl.NativeArray<Float>, b:hl.NativeArray<Float>,
			out:hl.NativeArray<Float>):Bool
		return false;

	@:hlNative("sdl3", "get_rect_enclosing_points_float") public static function getEnclosingPointsFloat(pointsXY:hl.NativeArray<Float>,
			clip:hl.NativeArray<Float>, out:hl.NativeArray<Float>):Bool
		return false;

	@:hlNative("sdl3", "get_rect_and_line_intersection_float") public static function getAndLineIntersectionFloat(rect:hl.NativeArray<Float>,
			line:hl.NativeArray<Float>):Bool
		return false;
}

/**
 * Geometry helpers for `SDLRect` / `SDLFRect`.
 *
 * Provides intersection, union, enclosing, containment, and equality tests,
 * both for the integer (`SDLRect` / `SDLLine`) and floating-point
 * (`SDLFRect` / `SDLFLine`) variants. Also includes a few pure-Haxe
 * helpers (`rectToFRect`, `pointInRect`, `rectEmpty`, `rectsEqual`, and
 * friends) that do not require a native call.
 *
 * Corresponds to `SDL_HasRectIntersection`, `SDL_GetRectIntersection`,
 * `SDL_GetRectUnion`, `SDL_GetRectEnclosingPoints`, `SDL_GetRectAndLineIntersection`,
 * `SDL_PointInRect`, `SDL_RectEmpty`, `SDL_RectsEqual`, and related functions
 * in SDL3.
 */
class SDLRectTools {
	static inline function rectArr(r:SDLRect):hl.NativeArray<Int> {
		var a = new hl.NativeArray<Int>(4);
		a[0] = r.x;
		a[1] = r.y;
		a[2] = r.w;
		a[3] = r.h;
		return a;
	}

	static inline function frectArr(r:SDLFRect):hl.NativeArray<Float> {
		var a = new hl.NativeArray<Float>(4);
		a[0] = r.x;
		a[1] = r.y;
		a[2] = r.w;
		a[3] = r.h;
		return a;
	}

	static inline function readRect(a:hl.NativeArray<Int>):SDLRect
		return {
			x: a[0],
			y: a[1],
			w: a[2],
			h: a[3]
		};

	static inline function readFRect(a:hl.NativeArray<Float>):SDLFRect
		return {
			x: a[0],
			y: a[1],
			w: a[2],
			h: a[3]
		};

	/**
	 * Converts an integer rectangle to a floating-point rectangle.
	 *
	 * @param r The source rectangle.
	 * @return The equivalent floating-point rectangle.
	 */
	public static inline function rectToFRect(r:SDLRect):SDLFRect
		return {
			x: r.x,
			y: r.y,
			w: r.w,
			h: r.h
		};

	/**
	 * Checks whether a point lies inside a rectangle.
	 *
	 * The left and top edges are inclusive; the right and bottom edges are
	 * exclusive.
	 *
	 * @param p The point to test.
	 * @param r The rectangle to test against.
	 * @return `true` if `p` is inside `r`.
	 */
	public static inline function pointInRect(p:SDLPoint, r:SDLRect):Bool
		return p.x >= r.x && p.x < (r.x + r.w) && p.y >= r.y && p.y < (r.y + r.h);

	/**
	 * Checks whether a rectangle is empty (has non-positive width or height).
	 *
	 * @param r The rectangle to test (may be `null`).
	 * @return `true` if `r` is `null`, or `w <= 0`, or `h <= 0`.
	 */
	public static inline function rectEmpty(r:Null<SDLRect>):Bool
		return r == null || r.w <= 0 || r.h <= 0;

	/**
	 * Checks whether two integer rectangles are equal component by component.
	 *
	 * @param a The first rectangle.
	 * @param b The second rectangle.
	 * @return `true` if `x`, `y`, `w`, and `h` all match.
	 */
	public static inline function rectsEqual(a:SDLRect, b:SDLRect):Bool
		return a.x == b.x && a.y == b.y && a.w == b.w && a.h == b.h;

	/**
	 * Checks whether a point lies inside a floating-point rectangle.
	 *
	 * Both edges are inclusive on the float variant.
	 *
	 * @param p The point to test.
	 * @param r The rectangle to test against.
	 * @return `true` if `p` is inside `r`.
	 */
	public static inline function pointInRectFloat(p:SDLFPoint, r:SDLFRect):Bool
		return p.x >= r.x && p.x <= (r.x + r.w) && p.y >= r.y && p.y <= (r.y + r.h);

	/**
	 * Checks whether a floating-point rectangle is empty.
	 *
	 * @param r The rectangle to test (may be `null`).
	 * @return `true` if `r` is `null`, or `w < 0`, or `h < 0`.
	 */
	public static inline function rectEmptyFloat(r:Null<SDLFRect>):Bool
		return r == null || r.w < 0 || r.h < 0;

	/**
	 * Checks whether two floating-point rectangles are equal within an epsilon.
	 *
	 * @param a       The first rectangle.
	 * @param b       The second rectangle.
	 * @param epsilon Maximum absolute difference allowed per component.
	 *                Negative values are clamped to 0.
	 * @return `true` if every component differs by no more than `epsilon`.
	 */
	public static function rectsEqualEpsilon(a:SDLFRect, b:SDLFRect, epsilon:Float):Bool {
		if (epsilon < 0)
			epsilon = 0;
		return Math.abs(a.x - b.x) <= epsilon && Math.abs(a.y - b.y) <= epsilon && Math.abs(a.w - b.w) <= epsilon && Math.abs(a.h - b.h) <= epsilon;
	}

	/**
	 * Checks whether two floating-point rectangles are equal within a small
	 * default epsilon (`~1.19e-7`, corresponding to the float epsilon).
	 *
	 * @param a The first rectangle.
	 * @param b The second rectangle.
	 * @return `true` if the rectangles are equal within epsilon.
	 */
	public static inline function rectsEqualFloat(a:SDLFRect, b:SDLFRect):Bool
		return rectsEqualEpsilon(a, b, 1.19209290E-07);

	/**
	 * Checks whether two integer rectangles overlap.
	 *
	 * @param a The first rectangle.
	 * @param b The second rectangle.
	 * @return `true` if the rectangles have any overlap.
	 */
	public static function hasIntersection(a:SDLRect, b:SDLRect):Bool
		return SDLRectNative.hasIntersection(rectArr(a), rectArr(b));

	/**
	 * Returns the intersection of two integer rectangles.
	 *
	 * @param a The first rectangle.
	 * @param b The second rectangle.
	 * @return The intersection, or `null` if the rectangles do not overlap.
	 */
	public static function getIntersection(a:SDLRect, b:SDLRect):Null<SDLRect> {
		var out = new hl.NativeArray<Int>(4);
		return SDLRectNative.getIntersection(rectArr(a), rectArr(b), out) ? readRect(out) : null;
	}

	/**
	 * Returns the smallest rectangle that encloses both given rectangles.
	 *
	 * @param a The first rectangle.
	 * @param b The second rectangle.
	 * @return The union, or `null` on failure.
	 */
	public static function getUnion(a:SDLRect, b:SDLRect):Null<SDLRect> {
		var out = new hl.NativeArray<Int>(4);
		return SDLRectNative.getUnion(rectArr(a), rectArr(b), out) ? readRect(out) : null;
	}

	/**
	 * Returns the smallest rectangle enclosing all given points.
	 *
	 * @param points The points to enclose. If empty, the function returns `null`.
	 * @param clip   Optional clipping rectangle; the result is intersected with it.
	 * @return The enclosing rectangle, or `null` if there are no points or on failure.
	 */
	public static function getEnclosingPoints(points:Array<SDLPoint>, ?clip:SDLRect):Null<SDLRect> {
		var xy = new hl.NativeArray<Int>(points.length * 2);
		for (i in 0...points.length) {
			xy[i * 2] = points[i].x;
			xy[i * 2 + 1] = points[i].y;
		}
		var out = new hl.NativeArray<Int>(4);
		var clipArr = clip == null ? null : rectArr(clip);
		return SDLRectNative.getEnclosingPoints(xy, clipArr, out) ? readRect(out) : null;
	}

	/**
	 * Clips a line segment against a rectangle (Cohen–Sutherland style).
	 *
	 * @param rect The clipping rectangle.
	 * @param line The line segment to clip.
	 * @return The clipped segment, or `null` if the line lies entirely
	 *         outside the rectangle.
	 */
	public static function getAndLineIntersection(rect:SDLRect, line:SDLLine):Null<SDLLine> {
		var l = new hl.NativeArray<Int>(4);
		l[0] = line.x1;
		l[1] = line.y1;
		l[2] = line.x2;
		l[3] = line.y2;
		if (!SDLRectNative.getAndLineIntersection(rectArr(rect), l))
			return null;
		return {
			x1: l[0],
			y1: l[1],
			x2: l[2],
			y2: l[3]
		};
	}

	/**
	 * Checks whether two floating-point rectangles overlap.
	 *
	 * @param a The first rectangle.
	 * @param b The second rectangle.
	 * @return `true` if the rectangles have any overlap.
	 */
	public static function hasIntersectionFloat(a:SDLFRect, b:SDLFRect):Bool
		return SDLRectNative.hasIntersectionFloat(frectArr(a), frectArr(b));

	/**
	 * Returns the intersection of two floating-point rectangles.
	 *
	 * @param a The first rectangle.
	 * @param b The second rectangle.
	 * @return The intersection, or `null` if the rectangles do not overlap.
	 */
	public static function getIntersectionFloat(a:SDLFRect, b:SDLFRect):Null<SDLFRect> {
		var out = new hl.NativeArray<Float>(4);
		return SDLRectNative.getIntersectionFloat(frectArr(a), frectArr(b), out) ? readFRect(out) : null;
	}

	/**
	 * Returns the smallest floating-point rectangle that encloses both given rectangles.
	 *
	 * @param a The first rectangle.
	 * @param b The second rectangle.
	 * @return The union, or `null` on failure.
	 */
	public static function getUnionFloat(a:SDLFRect, b:SDLFRect):Null<SDLFRect> {
		var out = new hl.NativeArray<Float>(4);
		return SDLRectNative.getUnionFloat(frectArr(a), frectArr(b), out) ? readFRect(out) : null;
	}

	/**
	 * Returns the smallest floating-point rectangle enclosing all given points.
	 *
	 * @param points The points to enclose. If empty, the function returns `null`.
	 * @param clip   Optional clipping rectangle; the result is intersected with it.
	 * @return The enclosing rectangle, or `null` if there are no points or on failure.
	 */
	public static function getEnclosingPointsFloat(points:Array<SDLFPoint>, ?clip:SDLFRect):Null<SDLFRect> {
		var xy = new hl.NativeArray<Float>(points.length * 2);
		for (i in 0...points.length) {
			xy[i * 2] = points[i].x;
			xy[i * 2 + 1] = points[i].y;
		}
		var out = new hl.NativeArray<Float>(4);
		var clipArr = clip == null ? null : frectArr(clip);
		return SDLRectNative.getEnclosingPointsFloat(xy, clipArr, out) ? readFRect(out) : null;
	}

	/**
	 * Clips a floating-point line segment against a rectangle.
	 *
	 * @param rect The clipping rectangle.
	 * @param line The line segment to clip.
	 * @return The clipped segment, or `null` if the line lies entirely
	 *         outside the rectangle.
	 */
	public static function getAndLineIntersectionFloat(rect:SDLFRect, line:SDLFLine):Null<SDLFLine> {
		var l = new hl.NativeArray<Float>(4);
		l[0] = line.x1;
		l[1] = line.y1;
		l[2] = line.x2;
		l[3] = line.y2;
		if (!SDLRectNative.getAndLineIntersectionFloat(frectArr(rect), l))
			return null;
		return {
			x1: l[0],
			y1: l[1],
			x2: l[2],
			y2: l[3]
		};
	}
}
