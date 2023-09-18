// window: provides OpenGL-based windows, and abstractions for events and input handling
module window

#flag -lcsfml-window

#include <SFML/Window/WindowHandle.h>

#flag -I @VROOT/window/c
#flag @VROOT/window/c/window.c
#include "window.h"

// WindowStyle: enumeration of window creation styles
pub enum WindowStyle {
	@none         = 0 ///< No border / title bar (this flag and all others are mutually exclusive)
	titlebar      = 1 ///< Title bar + fixed border
	resize        = 2 ///< Titlebar + resizable border + maximize button
	close         = 4 ///< Titlebar + close button
	fullscreen    = 8 ///< Fullscreen mode (this flag and all others are mutually exclusive)
	default_style = 7 ///< Default window style
}

fn C.pollEventWindow(&Window, &int, &voidptr) int
