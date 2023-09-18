module window

#include <SFML/Window/VideoMode.h>

[typedef]
pub struct C.sfVideoMode {
pub:
	width        int
	height       int
	bitsPerPixel int
}

// VideoMode: defines a video mode (width, height, bpp, frequency)
// and provides functions for getting modes supported
// by the display device
pub type VideoMode = C.sfVideoMode

fn C.sfVideoMode_getDesktopMode() C.sfVideoMode
fn C.sfVideoMode_getFullscreenModes(&usize) &C.sfVideoMode
fn C.sfVideoMode_isValid(C.sfVideoMode) int

// videomode_get_desktop_mode: get the current desktop video mode
pub fn videomode_get_desktop_mode() VideoMode {
	unsafe {
		return VideoMode(C.sfVideoMode_getDesktopMode())
	}
}

// videomode_get_fullscreen_modes: retrieve all the video modes supported in fullscreen mode
// When creating a fullscreen window, the video mode is restricted
// to be compatible with what the graphics driver and monitor
// support. This function returns the complete list of all video
// modes that can be used in fullscreen mode.
// The returned array is sorted from best to worst, so that
// the first element will always give the best mode (higher
// width, height and bits-per-pixel).
pub fn videomode_get_fullscreen_modes(count &u64) !&VideoMode {
	unsafe {
		result := &VideoMode(C.sfVideoMode_getFullscreenModes(&usize(count)))
		if voidptr(result) == C.NULL {
			return error('get_fullscreen_modes failed')
		}
		return result
	}
}

// is_valid: tell whether or not a video mode is valid
// The validity of video modes is only relevant when using
// fullscreen windows; otherwise any video mode can be used
// with no restriction.
pub fn (v VideoMode) is_valid() bool {
	unsafe {
		return C.sfVideoMode_isValid(*&C.sfVideoMode(&v)) != 0
	}
}
