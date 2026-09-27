import haxe.Int64;
import hl.bindings.sdl3.SDLEvent;
import hl.bindings.sdl3.SDLTimer;
import hl.bindings.sdl3.SDLInit;
import hl.bindings.sdl3.SDLRender.SDLRenderer;
import hl.bindings.sdl3.SDLWindow;

var window:SDLWindow;
var renderer:SDLRenderer;
var quit = false;
var x:Float = 100;
var y:Float = 100;
var size:Float = 50;
var angle:Float = 0;

function main() {
	if (!SDLInit.init(VIDEO | EVENTS | AUDIO)) {
		throw "SDL3 init error";
	}

	window = SDLWindow.create("2. Rendering", 800, 600, Std.int(HIGH_PIXEL_DENSITY));

	if (window == null) {
		throw "SDL3 Window Creation Error";
	}

	renderer = SDLRenderer.create(window);

	if (renderer == null) {
		throw "SDL3 Render Creation Error";
	}

	var prev:Int64 = SDLTimer.getTicks();

	while (!quit) {
		var now:Int64 = SDLTimer.getTicks();
		var delta:Float = (cast(now - prev)) / 1000.0;
		prev = now;

		if (delta > 0.1)
			delta = 0.1;

		SDLEventQueue.pump();
		while (true) {
			var ev:SDLEvent = SDLEventQueue.poll();
			if (ev == null)
				break;
			handleEvent(ev);
		}

		update(delta);

		renderer.setDrawColor(12, 75, 125, 255);
		renderer.clear();

		render(renderer);

		renderer.present();

		SDLTimer.delay(16);
	}

	window.destroy();
	renderer.destroy();

	SDLInit.quit();
}

function update(dt:Float) {
	angle += dt * 5.0;
	x = 350 + Math.sin(angle) * 100;
	y = 250 + Math.cos(angle) * 100;
}

function render(render:SDLRenderer) {
	render.setDrawColor(255, 0, 125, 255);
	render.fillRect({
		x: x,
		y: y,
		w: size,
		h: size
	});
}

function handleEvent(ev:SDLEvent) {
	switch (ev) {
		case Quit:
			quit = true;
		case Window(WINDOW_CLOSE_REQUESTED, windowID, data1, data2):
			quit = true;
		case _:
	}
}
