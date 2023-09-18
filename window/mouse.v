module window

import system

#include <SFML/Window/Mouse.h>

// MouseButton: mouse buttons
pub enum MouseButton {
	left // The left mouse button
	right // The right mouse button
	middle // The middle (wheel) mouse button
	xbutton1 // The first extra mouse button
	xbutton2 // The second extra mouse button
}

// MouseWheel: mouse wheels
pub enum MouseWheel {
	vertical_wheel // The vertical mouse wheel
	horizontal_wheel // The horizontal mouse wheel
}

fn C.sfMouse_isButtonPressed(C.sfMouseButton) int
fn C.sfMouse_getPosition(&C.sfWindow) C.sfVector2i
fn C.sfMouse_setPosition(C.sfVector2i, &C.sfWindow)

// mouse_is_button_pressed: check if a mouse button is pressed
pub fn mouse_is_button_pressed(button MouseButton) bool {
	unsafe {
		return C.sfMouse_isButtonPressed(*&C.sfMouseButton(&button)) != 0
	}
}

// mouse_get_position: get the current position of the mouse
// This function returns the current position of the mouse
// cursor relative to the given window, or desktop if NULL is passed.
pub fn mouse_get_position(relativeTo &Window) system.Vector2i {
	unsafe {
		return system.Vector2i(C.sfMouse_getPosition(&C.sfWindow(relativeTo)))
	}
}

// mouse_set_position: set the current position of the mouse
// This function sets the current position of the mouse
// cursor relative to the given window, or desktop if NULL is passed.
pub fn mouse_set_position(position system.Vector2i, relativeTo &Window) {
	unsafe {
		C.sfMouse_setPosition(*&C.sfVector2i(&position), &C.sfWindow(relativeTo))
	}
}
