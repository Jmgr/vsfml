module window

import vsfml.system

#include <SFML/Window/Touch.h>

fn C.sfTouch_isDown(u32) int
fn C.sfTouch_getPosition(u32, &C.sfWindow) C.sfVector2i

// touch_is_down: check if a touch event is currently down
pub fn touch_is_down(finger u32) bool {
	unsafe {
		return C.sfTouch_isDown(u32(finger)) != 0
	}
}

// touch_get_position: get the current position of a touch in window coordinates
// This function returns the current touch position
// relative to the given window, or desktop if NULL is passed.
pub fn touch_get_position(finger u32, relativeTo &Window) system.Vector2i {
	unsafe {
		return system.Vector2i(C.sfTouch_getPosition(u32(finger), &C.sfWindow(relativeTo)))
	}
}
