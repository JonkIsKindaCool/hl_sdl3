import hl.bindings.sdl3.SDLEvent;
import hl.bindings.sdl3.SDLTimer;
import hl.bindings.sdl3.SDLInit;
import hl.bindings.sdl3.SDLRender.SDLRenderer;
import hl.bindings.sdl3.SDLWindow;

var window:SDLWindow;
var renderer:SDLRenderer;
var quit = false;

function main() {
	if (!SDLInit.init(VIDEO | EVENTS | AUDIO)) {
		throw "SDL3 init error";
	}

	window = SDLWindow.create("1. Basic Window", 800, 600, Std.int(HIGH_PIXEL_DENSITY | RESIZABLE));

	if (window == null) {
		throw "SDL3 Window Creation Error";
	}

	renderer = SDLRenderer.create(window);

	if (renderer == null) {
		throw "SDL3 Render Creation Error";
	}

	while (!quit) {
		SDLEventQueue.pump();
		while (true) {
			var ev:SDLEvent = SDLEventQueue.poll();
			if (ev == null)
				break;
			handleEvent(ev);
		}

		renderer.setDrawColor(0, 0, 0, 1);
		renderer.clear();

		renderer.present();

		SDLTimer.delay(Std.int(1000 / 60));
	}

	window.destroy();
	renderer.destroy();

	SDLInit.quit();
}

function handleEvent(ev:SDLEvent) {
    switch (ev){
        case Quit:
            quit = true;
        case Window(WINDOW_CLOSE_REQUESTED, windowID, data1, data2):
            quit = true;
        case _:
    }
}