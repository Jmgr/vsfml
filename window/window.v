module window

import system

#include <SFML/Window/Window.h>

[typedef]
struct C.sfContextSettings {
pub:
	depthBits         int
	stencilBits       int
	antialiasingLevel int
	majorVersion      int
	minorVersion      int
	attributeFlags    u32
	sRgbCapable       int
}

// ContextSettings: structure defining the window's creation settings
pub type ContextSettings = C.sfContextSettings

// ContextAttribute: enumeration of the context attribute flags
pub enum ContextAttribute {
	default = 0 // Non-debug, compatibility context (this and the core attribute are mutually exclusive)
	core = 1 // Core attribute
	debug = 4 // Debug attribute
}

fn C.sfWindow_create(C.sfVideoMode, &char, u32, &C.sfContextSettings) &C.sfWindow
fn C.sfWindow_createUnicode(C.sfVideoMode, &u32, u32, &C.sfContextSettings) &C.sfWindow
fn C.sfWindow_createFromHandle(C.sfWindowHandle, &C.sfContextSettings) &C.sfWindow
fn C.sfWindow_destroy(&C.sfWindow)
fn C.sfWindow_close(&C.sfWindow)
fn C.sfWindow_isOpen(&C.sfWindow) int
fn C.sfWindow_getSettings(&C.sfWindow) C.sfContextSettings
fn C.sfWindow_pollEvent(&C.sfWindow, &C.sfEvent) int
fn C.sfWindow_waitEvent(&C.sfWindow, &C.sfEvent) int
fn C.sfWindow_getPosition(&C.sfWindow) C.sfVector2i
fn C.sfWindow_setPosition(&C.sfWindow, C.sfVector2i)
fn C.sfWindow_getSize(&C.sfWindow) C.sfVector2u
fn C.sfWindow_setSize(&C.sfWindow, C.sfVector2u)
fn C.sfWindow_setTitle(&C.sfWindow, &char)
fn C.sfWindow_setUnicodeTitle(&C.sfWindow, &u32)
fn C.sfWindow_setIcon(&C.sfWindow, u32, u32, &byte)
fn C.sfWindow_setVisible(&C.sfWindow, int)
fn C.sfWindow_setVerticalSyncEnabled(&C.sfWindow, int)
fn C.sfWindow_setMouseCursorVisible(&C.sfWindow, int)
fn C.sfWindow_setMouseCursorGrabbed(&C.sfWindow, int)
fn C.sfWindow_setMouseCursor(&C.sfWindow, &C.sfCursor)
fn C.sfWindow_setKeyRepeatEnabled(&C.sfWindow, int)
fn C.sfWindow_setFramerateLimit(&C.sfWindow, u32)
fn C.sfWindow_setJoystickThreshold(&C.sfWindow, f32)
fn C.sfWindow_setActive(&C.sfWindow, int) int
fn C.sfWindow_requestFocus(&C.sfWindow)
fn C.sfWindow_hasFocus(&C.sfWindow) int
fn C.sfWindow_display(&C.sfWindow)
fn C.sfWindow_getSystemHandle(&C.sfWindow) C.sfWindowHandle

// new_window: construct a new window
// This function creates the window with the size and pixel
// depth defined in mode. An optional style can be passed to
// customize the look and behaviour of the window (borders,
// title bar, resizable, closable, ...). If style contains
// Fullscreen, then mode must be a valid video mode.
// The fourth parameter is a pointer to a structure specifying
// advanced OpenGL context settings such as antialiasing,
// depth-buffer bits, etc.
pub fn new_window(params WindowNewWindowParams) ?&Window {
	unsafe {
		result := &Window(C.sfWindow_create(C.sfVideoMode(params.mode), params.title.str,
			u32(params.style), &C.sfContextSettings(params.settings)))
		if voidptr(result) == C.NULL {
			return error('new_window failed with mode=$params.mode title=$params.title style=$params.style')
		}
		return result
	}
}

// WindowNewWindowParams: parameters for new_window
pub struct WindowNewWindowParams {
pub:
	mode     VideoMode        [required] // video mode to use (defines the width, height and depth of the rendering area of the window)
	title    string           [required] // title of the window
	style    u32 = u32(WindowStyle.default_style) // window style
	settings &ContextSettings = C.NULL // additional settings for the underlying OpenGL context
}

// new_window_unicode: construct a new window (with a UTF-32 title)
// This function creates the window with the size and pixel
// depth defined in mode. An optional style can be passed to
// customize the look and behaviour of the window (borders,
// title bar, resizable, closable, ...). If style contains
// Fullscreen, then mode must be a valid video mode.
// The fourth parameter is a pointer to a structure specifying
// advanced OpenGL context settings such as antialiasing,
// depth-buffer bits, etc.
pub fn new_window_unicode(params WindowNewWindowUnicodeParams) ?&Window {
	unsafe {
		result := &Window(C.sfWindow_createUnicode(C.sfVideoMode(params.mode), &u32(params.title),
			u32(params.style), &C.sfContextSettings(params.settings)))
		if voidptr(result) == C.NULL {
			return error('new_window_unicode failed with mode=$params.mode style=$params.style')
		}
		return result
	}
}

// WindowNewWindowUnicodeParams: parameters for new_window_unicode
pub struct WindowNewWindowUnicodeParams {
pub:
	mode     VideoMode        [required] // video mode to use (defines the width, height and depth of the rendering area of the window)
	title    &u32             [required] // title of the window (UTF-32)
	style    u32 = u32(WindowStyle.default_style) // window style
	settings &ContextSettings = C.NULL // additional settings for the underlying OpenGL context
}

// new_window_from_handle: construct a window from an existing control
// Use this constructor if you want to create an OpenGL
// rendering area into an already existing control.
// The second parameter is a pointer to a structure specifying
// advanced OpenGL context settings such as antialiasing,
// depth-buffer bits, etc.
pub fn new_window_from_handle(params WindowNewWindowFromHandleParams) ?&Window {
	unsafe {
		result := &Window(C.sfWindow_createFromHandle(C.sfWindowHandle(params.handle),
			&C.sfContextSettings(params.settings)))
		if voidptr(result) == C.NULL {
			return error('new_window_from_handle failed with handle=$params.handle')
		}
		return result
	}
}

// WindowNewWindowFromHandleParams: parameters for new_window_from_handle
pub struct WindowNewWindowFromHandleParams {
pub:
	handle   WindowHandle     [required] // platform-specific handle of the control
	settings &ContextSettings = C.NULL // additional settings for the underlying OpenGL context
}

// free: destroy a window
[unsafe]
pub fn (w &Window) free() {
	unsafe {
		C.sfWindow_destroy(&C.sfWindow(w))
	}
}

// close: close a window and destroy all the attached resources
// After calling this function, the Window object remains
// valid, you must call destroy to actually delete it.
// All other functions such as pollEvent or display
// will still work (i.e. you don't have to test isOpen
// every time), and will have no effect on closed windows.
pub fn (w &Window) close() {
	unsafe {
		C.sfWindow_close(&C.sfWindow(w))
	}
}

// is_open: tell whether or not a window is opened
// This function returns whether or not the window exists.
// Note that a hidden window (sfWindow_setVisible(false)) will return
// true.
pub fn (w &Window) is_open() bool {
	unsafe {
		return C.sfWindow_isOpen(&C.sfWindow(w)) != 0
	}
}

// get_settings: get the settings of the OpenGL context of a window
// Note that these settings may be different from what was
// passed to the create function,
// if one or more settings were not supported. In this case,
// SFML chose the closest match.
pub fn (w &Window) get_settings() ContextSettings {
	unsafe {
		return ContextSettings(C.sfWindow_getSettings(&C.sfWindow(w)))
	}
}

// wait_event: wait for an event and return it
// This function is blocking: if there's no pending event then
// it will wait until an event is received.
// After this function returns (and no error occured),
// the event object is always valid and filled properly.
// This function is typically used when you have a thread that
// is dedicated to events handling: you want to make this thread
// sleep as long as no new event is received.
pub fn (w &Window) wait_event(event &Event) bool {
	unsafe {
		return C.sfWindow_waitEvent(&C.sfWindow(w), &C.sfEvent(event)) != 0
	}
}

// get_position: get the position of a window
pub fn (w &Window) get_position() system.Vector2i {
	unsafe {
		return system.Vector2i(C.sfWindow_getPosition(&C.sfWindow(w)))
	}
}

// set_position: change the position of a window on screen
// This function only works for top-level windows
// (i.e. it will be ignored for windows created from
// the handle of a child window/control).
pub fn (w &Window) set_position(position system.Vector2i) {
	unsafe {
		C.sfWindow_setPosition(&C.sfWindow(w), C.sfVector2i(position))
	}
}

// get_size: get the size of the rendering region of a window
// The size doesn't include the titlebar and borders
// of the window.
pub fn (w &Window) get_size() system.Vector2u {
	unsafe {
		return system.Vector2u(C.sfWindow_getSize(&C.sfWindow(w)))
	}
}

// set_size: change the size of the rendering region of a window
pub fn (w &Window) set_size(size system.Vector2u) {
	unsafe {
		C.sfWindow_setSize(&C.sfWindow(w), C.sfVector2u(size))
	}
}

// set_title: change the title of a window
pub fn (w &Window) set_title(title string) {
	unsafe {
		C.sfWindow_setTitle(&C.sfWindow(w), title.str)
	}
}

// set_unicode_title: change the title of a window (with a UTF-32 string)
pub fn (w &Window) set_unicode_title(title &u32) {
	unsafe {
		C.sfWindow_setUnicodeTitle(&C.sfWindow(w), &u32(title))
	}
}

// set_icon: change a window's icon
pub fn (w &Window) set_icon(params WindowSetIconParams) {
	unsafe {
		C.sfWindow_setIcon(&C.sfWindow(w), u32(params.width), u32(params.height), &byte(params.pixels))
	}
}

// WindowSetIconParams: parameters for set_icon
pub struct WindowSetIconParams {
pub:
	width  u32   [required] // icon's width, in pixels
	height u32   [required] // icon's height, in pixels
	pixels &byte [required] // pointer to the array of pixels in memory
}

// set_visible: show or hide a window
pub fn (w &Window) set_visible(visible bool) {
	unsafe {
		C.sfWindow_setVisible(&C.sfWindow(w), int(visible))
	}
}

// set_vertical_sync_enabled: enable or disable vertical synchronization
// Activating vertical synchronization will limit the number
// of frames displayed to the refresh rate of the monitor.
// This can avoid some visual artifacts, and limit the framerate
// to a good value (but not constant across different computers).
pub fn (w &Window) set_vertical_sync_enabled(enabled bool) {
	unsafe {
		C.sfWindow_setVerticalSyncEnabled(&C.sfWindow(w), int(enabled))
	}
}

// set_mouse_cursor_visible: show or hide the mouse cursor
pub fn (w &Window) set_mouse_cursor_visible(visible bool) {
	unsafe {
		C.sfWindow_setMouseCursorVisible(&C.sfWindow(w), int(visible))
	}
}

// set_mouse_cursor_grabbed: grab or release the mouse cursor
// If set, grabs the mouse cursor inside this window's client
// area so it may no longer be moved outside its bounds.
// Note that grabbing is only active while the window has
// focus and calling this function for fullscreen windows
// won't have any effect (fullscreen windows always grab the
// cursor).
pub fn (w &Window) set_mouse_cursor_grabbed(grabbed bool) {
	unsafe {
		C.sfWindow_setMouseCursorGrabbed(&C.sfWindow(w), int(grabbed))
	}
}

// set_mouse_cursor: set the displayed cursor to a native system cursor
// Upon window creation, the arrow cursor is used by default.
pub fn (w &Window) set_mouse_cursor(cursor &Cursor) {
	unsafe {
		C.sfWindow_setMouseCursor(&C.sfWindow(w), &C.sfCursor(cursor))
	}
}

// set_key_repeat_enabled: enable or disable automatic key-repeat
// If key repeat is enabled, you will receive repeated
// KeyPress events while keeping a key pressed. If it is disabled,
// you will only get a single event when the key is pressed.
// Key repeat is enabled by default.
pub fn (w &Window) set_key_repeat_enabled(enabled bool) {
	unsafe {
		C.sfWindow_setKeyRepeatEnabled(&C.sfWindow(w), int(enabled))
	}
}

// set_framerate_limit: limit the framerate to a maximum fixed frequency
// If a limit is set, the window will use a small delay after
// each call to display to ensure that the current frame
// lasted long enough to match the framerate limit.
pub fn (w &Window) set_framerate_limit(limit u32) {
	unsafe {
		C.sfWindow_setFramerateLimit(&C.sfWindow(w), u32(limit))
	}
}

// set_joystick_threshold: change the joystick threshold
// The joystick threshold is the value below which
// no JoyMoved event will be generated.
pub fn (w &Window) set_joystick_threshold(threshold f32) {
	unsafe {
		C.sfWindow_setJoystickThreshold(&C.sfWindow(w), f32(threshold))
	}
}

// set_active: activate or deactivate a window as the current target
// for OpenGL rendering
// A window is active only on the current thread, if you want to
// make it active on another thread you have to deactivate it
// on the previous thread first if it was active.
// Only one window can be active on a thread at a time, thus
// the window previously active (if any) automatically gets deactivated.
// This is not to be confused with requestFocus().
pub fn (w &Window) set_active(active bool) bool {
	unsafe {
		return C.sfWindow_setActive(&C.sfWindow(w), int(active)) != 0
	}
}

// request_focus: request the current window to be made the active
// foreground window
// At any given time, only one window may have the input focus
// to receive input events such as keystrokes or mouse events.
// If a window requests focus, it only hints to the operating
// system, that it would like to be focused. The operating system
// is free to deny the request.
// This is not to be confused with setActive().
pub fn (w &Window) request_focus() {
	unsafe {
		C.sfWindow_requestFocus(&C.sfWindow(w))
	}
}

// has_focus: check whether the window has the input focus
// At any given time, only one window may have the input focus
// to receive input events such as keystrokes or most mouse
// events.
pub fn (w &Window) has_focus() bool {
	unsafe {
		return C.sfWindow_hasFocus(&C.sfWindow(w)) != 0
	}
}

// display: display on screen what has been rendered to the
// window so far
// This function is typically called after all OpenGL rendering
// has been done for the current frame, in order to show
// it on screen.
pub fn (w &Window) display() {
	unsafe {
		C.sfWindow_display(&C.sfWindow(w))
	}
}

// get_system_handle: get the OS-specific handle of the window
// The type of the returned handle is WindowHandle,
// which is a typedef to the handle type defined by the OS.
// You shouldn't need to use this function, unless you have
// very specific stuff to implement that SFML doesn't support,
// or implement a temporary workaround until a bug is fixed.
pub fn (w &Window) get_system_handle() WindowHandle {
	unsafe {
		return WindowHandle(C.sfWindow_getSystemHandle(&C.sfWindow(w)))
	}
}
