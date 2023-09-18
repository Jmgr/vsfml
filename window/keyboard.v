module window

#include <SFML/Window/Keyboard.h>

// KeyCode: key codes
pub enum KeyCode {
	unknown = -1 // Unhandled key
	a // The A key
	b // The B key
	c // The C key
	d // The D key
	e // The E key
	f // The F key
	g // The G key
	h // The H key
	i // The I key
	j // The J key
	k // The K key
	l // The L key
	m // The M key
	n // The N key
	o // The O key
	p // The P key
	q // The Q key
	r // The R key
	s // The S key
	t // The T key
	u // The U key
	v // The V key
	w // The W key
	x // The X key
	y // The Y key
	z // The Z key
	num0 // The 0 key
	num1 // The 1 key
	num2 // The 2 key
	num3 // The 3 key
	num4 // The 4 key
	num5 // The 5 key
	num6 // The 6 key
	num7 // The 7 key
	num8 // The 8 key
	num9 // The 9 key
	escape // The Escape key
	l_control // The left Control key
	l_shift // The left Shift key
	l_alt // The left Alt key
	l_system // The left OS specific key: window (Windows and Linux), apple (MacOS X), ...
	r_control // The right Control key
	r_shift // The right Shift key
	r_alt // The right Alt key
	r_system // The right OS specific key: window (Windows and Linux), apple (MacOS X), ...
	menu // The Menu key
	l_bracket // The [ key
	r_bracket // The ] key
	semicolon // The ; key
	comma // The , key
	period // The . key
	quote // The ' key
	slash // The / key
	backslash // The \ key
	tilde // The ~ key
	equal // The = key
	hyphen // The - key (hyphen)
	space // The Space key
	enter // The Enter/Return key
	backspace // The Backspace key
	tab // The Tabulation key
	page_up // The Page up key
	page_down // The Page down key
	end // The End key
	home // The Home key
	insert // The Insert key
	delete // The Delete key
	add // The + key
	subtract // The - key (minus, usually from numpad)
	multiply // The * key
	divide // The / key
	left // Left arrow
	right // Right arrow
	up // Up arrow
	down // Down arrow
	numpad0 // The numpad 0 key
	numpad1 // The numpad 1 key
	numpad2 // The numpad 2 key
	numpad3 // The numpad 3 key
	numpad4 // The numpad 4 key
	numpad5 // The numpad 5 key
	numpad6 // The numpad 6 key
	numpad7 // The numpad 7 key
	numpad8 // The numpad 8 key
	numpad9 // The numpad 9 key
	f1 // The F1 key
	f2 // The F2 key
	f3 // The F3 key
	f4 // The F4 key
	f5 // The F5 key
	f6 // The F6 key
	f7 // The F7 key
	f8 // The F8 key
	f9 // The F8 key
	f10 // The F10 key
	f11 // The F11 key
	f12 // The F12 key
	f13 // The F13 key
	f14 // The F14 key
	f15 // The F15 key
	pause // The Pause key
}

fn C.sfKeyboard_isKeyPressed(C.sfKeyCode) int
fn C.sfKeyboard_setVirtualKeyboardVisible(int)

// keyboard_is_key_pressed: check if a key is pressed
pub fn keyboard_is_key_pressed(key KeyCode) bool {
	unsafe {
		return C.sfKeyboard_isKeyPressed(*&C.sfKeyCode(&key)) != 0
	}
}

// keyboard_set_virtual_keyboard_visible: show or hide the virtual keyboard.
// Warning: the virtual keyboard is not supported on all systems.
// It will typically be implemented on mobile OSes (Android, iOS)
// but not on desktop OSes (Windows, Linux, ...).
// If the virtual keyboard is not available, this function does nothing.
pub fn keyboard_set_virtual_keyboard_visible(visible bool) {
	unsafe {
		C.sfKeyboard_setVirtualKeyboardVisible(int(visible))
	}
}
