module window

#include <SFML/Window/Joystick.h>

// JoystickAxis: axes supported by SFML joysticks
pub enum JoystickAxis {
	x // The X axis
	y // The Y axis
	z // The Z axis
	r // The R axis
	u // The U axis
	v // The V axis
	pov_x // The X axis of the point-of-view hat
	pov_y // The Y axis of the point-of-view hat
}

fn C.sfJoystick_isConnected(u32) int
fn C.sfJoystick_hasAxis(u32, C.sfJoystickAxis) int
fn C.sfJoystick_isButtonPressed(u32, u32) int
fn C.sfJoystick_getAxisPosition(u32, C.sfJoystickAxis) f32
fn C.sfJoystick_getIdentification(u32) C.sfJoystickIdentification
fn C.sfJoystick_update()

// joystick_is_connected: check if a joystick is connected
pub fn joystick_is_connected(joystick u32) bool {
	unsafe {
		return C.sfJoystick_isConnected(u32(joystick)) != 0
	}
}

// joystick_has_axis: check if a joystick supports a given axis
// If the joystick is not connected, this function returns false.
pub fn joystick_has_axis(joystick u32, axis JoystickAxis) bool {
	unsafe {
		return C.sfJoystick_hasAxis(u32(joystick), *&C.sfJoystickAxis(&axis)) != 0
	}
}

// joystick_is_button_pressed: check if a joystick button is pressed
// If the joystick is not connected, this function returns false.
pub fn joystick_is_button_pressed(joystick u32, button u32) bool {
	unsafe {
		return C.sfJoystick_isButtonPressed(u32(joystick), u32(button)) != 0
	}
}

// joystick_get_axis_position: get the current position of a joystick axis
// If the joystick is not connected, this function returns 0.
pub fn joystick_get_axis_position(joystick u32, axis JoystickAxis) f32 {
	unsafe {
		return f32(C.sfJoystick_getAxisPosition(u32(joystick), *&C.sfJoystickAxis(&axis)))
	}
}

// joystick_get_identification: get the joystick information
// The result of this function will only remain valid until
// the next time the function is called.
pub fn joystick_get_identification(joystick u32) JoystickIdentification {
	unsafe {
		return JoystickIdentification(C.sfJoystick_getIdentification(u32(joystick)))
	}
}

// joystick_update: update the states of all joysticks
// This function is used internally by SFML, so you normally
// don't have to call it explicitely. However, you may need to
// call it if you have no window yet (or no window at all):
// in this case the joysticks states are not updated automatically.
pub fn joystick_update() {
	unsafe {
		C.sfJoystick_update()
	}
}
