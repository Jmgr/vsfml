module graphics

import window
import system

#include <SFML/Graphics/RenderWindow.h>

fn C.sfRenderWindow_create(C.sfVideoMode, &char, u32, &C.sfContextSettings) &C.sfRenderWindow
fn C.sfRenderWindow_createUnicode(C.sfVideoMode, &u32, u32, &C.sfContextSettings) &C.sfRenderWindow
fn C.sfRenderWindow_createFromHandle(C.sfWindowHandle, &C.sfContextSettings) &C.sfRenderWindow
fn C.sfRenderWindow_destroy(&C.sfRenderWindow)
fn C.sfRenderWindow_close(&C.sfRenderWindow)
fn C.sfRenderWindow_isOpen(&C.sfRenderWindow) int
fn C.sfRenderWindow_getSettings(&C.sfRenderWindow) C.sfContextSettings
fn C.sfRenderWindow_pollEvent(&C.sfRenderWindow, &C.sfEvent) int
fn C.sfRenderWindow_waitEvent(&C.sfRenderWindow, &C.sfEvent) int
fn C.sfRenderWindow_getPosition(&C.sfRenderWindow) C.sfVector2i
fn C.sfRenderWindow_setPosition(&C.sfRenderWindow, C.sfVector2i)
fn C.sfRenderWindow_getSize(&C.sfRenderWindow) C.sfVector2u
fn C.sfRenderWindow_setSize(&C.sfRenderWindow, C.sfVector2u)
fn C.sfRenderWindow_setTitle(&C.sfRenderWindow, &char)
fn C.sfRenderWindow_setUnicodeTitle(&C.sfRenderWindow, &u32)
fn C.sfRenderWindow_setIcon(&C.sfRenderWindow, u32, u32, &u8)
fn C.sfRenderWindow_setVisible(&C.sfRenderWindow, int)
fn C.sfRenderWindow_setVerticalSyncEnabled(&C.sfRenderWindow, int)
fn C.sfRenderWindow_setMouseCursorVisible(&C.sfRenderWindow, int)
fn C.sfRenderWindow_setMouseCursorGrabbed(&C.sfRenderWindow, int)
fn C.sfRenderWindow_setMouseCursor(&C.sfRenderWindow, &C.sfCursor)
fn C.sfRenderWindow_setKeyRepeatEnabled(&C.sfRenderWindow, int)
fn C.sfRenderWindow_setFramerateLimit(&C.sfRenderWindow, u32)
fn C.sfRenderWindow_setJoystickThreshold(&C.sfRenderWindow, f32)
fn C.sfRenderWindow_setActive(&C.sfRenderWindow, int) int
fn C.sfRenderWindow_requestFocus(&C.sfRenderWindow)
fn C.sfRenderWindow_hasFocus(&C.sfRenderWindow) int
fn C.sfRenderWindow_display(&C.sfRenderWindow)
fn C.sfRenderWindow_getSystemHandle(&C.sfRenderWindow) C.sfWindowHandle
fn C.sfRenderWindow_clear(&C.sfRenderWindow, C.sfColor)
fn C.sfRenderWindow_setView(&C.sfRenderWindow, &C.sfView)
fn C.sfRenderWindow_getView(&C.sfRenderWindow) &C.sfView
fn C.sfRenderWindow_getDefaultView(&C.sfRenderWindow) &C.sfView
fn C.sfRenderWindow_getViewport(&C.sfRenderWindow, &C.sfView) C.sfIntRect
fn C.sfRenderWindow_mapPixelToCoords(&C.sfRenderWindow, C.sfVector2i, &C.sfView) C.sfVector2f
fn C.sfRenderWindow_mapCoordsToPixel(&C.sfRenderWindow, C.sfVector2f, &C.sfView) C.sfVector2i
fn C.sfRenderWindow_drawSprite(&C.sfRenderWindow, &C.sfSprite, &C.sfRenderStates)
fn C.sfRenderWindow_drawText(&C.sfRenderWindow, &C.sfText, &C.sfRenderStates)
fn C.sfRenderWindow_drawShape(&C.sfRenderWindow, &C.sfShape, &C.sfRenderStates)
fn C.sfRenderWindow_drawCircleShape(&C.sfRenderWindow, &C.sfCircleShape, &C.sfRenderStates)
fn C.sfRenderWindow_drawConvexShape(&C.sfRenderWindow, &C.sfConvexShape, &C.sfRenderStates)
fn C.sfRenderWindow_drawRectangleShape(&C.sfRenderWindow, &C.sfRectangleShape, &C.sfRenderStates)
fn C.sfRenderWindow_drawVertexArray(&C.sfRenderWindow, &C.sfVertexArray, &C.sfRenderStates)
fn C.sfRenderWindow_drawVertexBuffer(&C.sfRenderWindow, &C.sfVertexBuffer, &C.sfRenderStates)
fn C.sfRenderWindow_drawPrimitives(&C.sfRenderWindow, &C.sfVertex, usize, C.sfPrimitiveType, &C.sfRenderStates)
fn C.sfRenderWindow_pushGLStates(&C.sfRenderWindow)
fn C.sfRenderWindow_popGLStates(&C.sfRenderWindow)
fn C.sfRenderWindow_resetGLStates(&C.sfRenderWindow)
fn C.sfMouse_getPositionRenderWindow(&C.sfRenderWindow) C.sfVector2i
fn C.sfMouse_setPositionRenderWindow(C.sfVector2i, &C.sfRenderWindow)
fn C.sfTouch_getPositionRenderWindow(u32, &C.sfRenderWindow) C.sfVector2i

// new_render_window: construct a new render window
pub fn new_render_window(params RenderWindowNewRenderWindowParams) !&RenderWindow {
	unsafe {
		result := &RenderWindow(C.sfRenderWindow_create(*&C.sfVideoMode(&params.mode), params.title.str,
			u32(params.style), &C.sfContextSettings(params.settings)))
		if voidptr(result) == C.NULL {
			return error('new_render_window failed with mode=$params.mode title=$params.title style=$params.style')
		}
		return result
	}
}

// RenderWindowNewRenderWindowParams: parameters for new_render_window
pub struct RenderWindowNewRenderWindowParams {
pub:
	mode     window.VideoMode        [required] // video mode to use
	title    string                  [required] // title of the window
	style    u32 = u32(window.WindowStyle.default_style) // window style
	settings &window.ContextSettings = C.NULL // creation settings (pass NULL to use default values)
}

// new_render_window_unicode: construct a new render window (with a UTF-32 title)
pub fn new_render_window_unicode(params RenderWindowNewRenderWindowUnicodeParams) !&RenderWindow {
	unsafe {
		result := &RenderWindow(C.sfRenderWindow_createUnicode(*&C.sfVideoMode(&params.mode),
			&u32(params.title), u32(params.style), &C.sfContextSettings(params.settings)))
		if voidptr(result) == C.NULL {
			return error('new_render_window_unicode failed with mode=$params.mode style=$params.style')
		}
		return result
	}
}

// RenderWindowNewRenderWindowUnicodeParams: parameters for new_render_window_unicode
pub struct RenderWindowNewRenderWindowUnicodeParams {
pub:
	mode     window.VideoMode        [required] // video mode to use
	title    &u32                    [required] // title of the window (UTF-32)
	style    u32 = u32(window.WindowStyle.default_style) // window style
	settings &window.ContextSettings = C.NULL // creation settings (pass NULL to use default values)
}

// new_render_window_from_handle: construct a render window from an existing control
pub fn new_render_window_from_handle(params RenderWindowNewRenderWindowFromHandleParams) !&RenderWindow {
	unsafe {
		result := &RenderWindow(C.sfRenderWindow_createFromHandle(*&C.sfWindowHandle(&params.handle),
			&C.sfContextSettings(params.settings)))
		if voidptr(result) == C.NULL {
			return error('new_render_window_from_handle failed with handle=$params.handle')
		}
		return result
	}
}

// RenderWindowNewRenderWindowFromHandleParams: parameters for new_render_window_from_handle
pub struct RenderWindowNewRenderWindowFromHandleParams {
pub:
	handle   window.WindowHandle     [required] // platform-specific handle of the control
	settings &window.ContextSettings = C.NULL // creation settings (pass NULL to use default values)
}

// free: destroy an existing render window
[unsafe]
pub fn (r &RenderWindow) free() {
	unsafe {
		C.sfRenderWindow_destroy(&C.sfRenderWindow(r))
	}
}

// close: close a render window (but doesn't destroy the internal data)
pub fn (r &RenderWindow) close() {
	unsafe {
		C.sfRenderWindow_close(&C.sfRenderWindow(r))
	}
}

// is_open: tell whether or not a render window is opened
pub fn (r &RenderWindow) is_open() bool {
	unsafe {
		return C.sfRenderWindow_isOpen(&C.sfRenderWindow(r)) != 0
	}
}

// get_settings: get the creation settings of a render window
pub fn (r &RenderWindow) get_settings() window.ContextSettings {
	unsafe {
		return window.ContextSettings(C.sfRenderWindow_getSettings(&C.sfRenderWindow(r)))
	}
}

// wait_event: wait for an event and return it
pub fn (r &RenderWindow) wait_event(event &window.Event) bool {
	unsafe {
		return C.sfRenderWindow_waitEvent(&C.sfRenderWindow(r), &C.sfEvent(event)) != 0
	}
}

// get_position: get the position of a render window
pub fn (r &RenderWindow) get_position() system.Vector2i {
	unsafe {
		return system.Vector2i(C.sfRenderWindow_getPosition(&C.sfRenderWindow(r)))
	}
}

// set_position: change the position of a render window on screen
// Only works for top-level windows
pub fn (r &RenderWindow) set_position(position system.Vector2i) {
	unsafe {
		C.sfRenderWindow_setPosition(&C.sfRenderWindow(r), *&C.sfVector2i(&position))
	}
}

// get_size: get the size of the rendering region of a render window
pub fn (r &RenderWindow) get_size() system.Vector2u {
	unsafe {
		return system.Vector2u(C.sfRenderWindow_getSize(&C.sfRenderWindow(r)))
	}
}

// set_size: change the size of the rendering region of a render window
pub fn (r &RenderWindow) set_size(size system.Vector2u) {
	unsafe {
		C.sfRenderWindow_setSize(&C.sfRenderWindow(r), *&C.sfVector2u(&size))
	}
}

// set_title: change the title of a render window
pub fn (r &RenderWindow) set_title(title string) {
	unsafe {
		C.sfRenderWindow_setTitle(&C.sfRenderWindow(r), title.str)
	}
}

// set_unicode_title: change the title of a render window (with a UTF-32 string)
pub fn (r &RenderWindow) set_unicode_title(title &u32) {
	unsafe {
		C.sfRenderWindow_setUnicodeTitle(&C.sfRenderWindow(r), &u32(title))
	}
}

// set_icon: change a render window's icon
pub fn (r &RenderWindow) set_icon(params RenderWindowSetIconParams) {
	unsafe {
		C.sfRenderWindow_setIcon(&C.sfRenderWindow(r), u32(params.width), u32(params.height),
			&u8(params.pixels))
	}
}

// RenderWindowSetIconParams: parameters for set_icon
pub struct RenderWindowSetIconParams {
pub:
	width  u32   [required] // icon's width, in pixels
	height u32   [required] // icon's height, in pixels
	pixels &u8 [required] // pointer to the pixels in memory, format must be RGBA 32 bits
}

// set_visible: show or hide a render window
pub fn (r &RenderWindow) set_visible(visible bool) {
	unsafe {
		C.sfRenderWindow_setVisible(&C.sfRenderWindow(r), int(visible))
	}
}

// set_vertical_sync_enabled: enable / disable vertical synchronization on a render window
pub fn (r &RenderWindow) set_vertical_sync_enabled(enabled bool) {
	unsafe {
		C.sfRenderWindow_setVerticalSyncEnabled(&C.sfRenderWindow(r), int(enabled))
	}
}

// set_mouse_cursor_visible: show or hide the mouse cursor on a render window
pub fn (r &RenderWindow) set_mouse_cursor_visible(show bool) {
	unsafe {
		C.sfRenderWindow_setMouseCursorVisible(&C.sfRenderWindow(r), int(show))
	}
}

// set_mouse_cursor_grabbed: grab or release the mouse cursor
// If set, grabs the mouse cursor inside this window's client
// area so it may no longer be moved outside its bounds.
// Note that grabbing is only active while the window has
// focus and calling this function for fullscreen windows
// won't have any effect (fullscreen windows always grab the
// cursor).
pub fn (r &RenderWindow) set_mouse_cursor_grabbed(grabbed bool) {
	unsafe {
		C.sfRenderWindow_setMouseCursorGrabbed(&C.sfRenderWindow(r), int(grabbed))
	}
}

// set_mouse_cursor: set the displayed cursor to a native system cursor
// Upon window creation, the arrow cursor is used by default.
pub fn (r &RenderWindow) set_mouse_cursor(cursor &window.Cursor) {
	unsafe {
		C.sfRenderWindow_setMouseCursor(&C.sfRenderWindow(r), &C.sfCursor(cursor))
	}
}

// set_key_repeat_enabled: enable or disable automatic key-repeat for keydown events
// Automatic key-repeat is enabled by default
pub fn (r &RenderWindow) set_key_repeat_enabled(enabled bool) {
	unsafe {
		C.sfRenderWindow_setKeyRepeatEnabled(&C.sfRenderWindow(r), int(enabled))
	}
}

// set_framerate_limit: limit the framerate to a maximum fixed frequency for a render window
pub fn (r &RenderWindow) set_framerate_limit(limit u32) {
	unsafe {
		C.sfRenderWindow_setFramerateLimit(&C.sfRenderWindow(r), u32(limit))
	}
}

// set_joystick_threshold: change the joystick threshold, ie. the value below which no move event will be generated
pub fn (r &RenderWindow) set_joystick_threshold(threshold f32) {
	unsafe {
		C.sfRenderWindow_setJoystickThreshold(&C.sfRenderWindow(r), f32(threshold))
	}
}

// set_active: activate or deactivate a render window as the current target for rendering
pub fn (r &RenderWindow) set_active(active bool) bool {
	unsafe {
		return C.sfRenderWindow_setActive(&C.sfRenderWindow(r), int(active)) != 0
	}
}

// request_focus
pub fn (r &RenderWindow) request_focus() {
	unsafe {
		C.sfRenderWindow_requestFocus(&C.sfRenderWindow(r))
	}
}

// has_focus: check whether the render window has the input focus
// At any given time, only one window may have the input focus
// to receive input events such as keystrokes or most mouse
// events.
pub fn (r &RenderWindow) has_focus() bool {
	unsafe {
		return C.sfRenderWindow_hasFocus(&C.sfRenderWindow(r)) != 0
	}
}

// display: display a render window on screen
pub fn (r &RenderWindow) display() {
	unsafe {
		C.sfRenderWindow_display(&C.sfRenderWindow(r))
	}
}

// get_system_handle: retrieve the OS-specific handle of a render window
pub fn (r &RenderWindow) get_system_handle() window.WindowHandle {
	unsafe {
		return window.WindowHandle(C.sfRenderWindow_getSystemHandle(&C.sfRenderWindow(r)))
	}
}

// clear: clear a render window with the given color
pub fn (r &RenderWindow) clear(color Color) {
	unsafe {
		C.sfRenderWindow_clear(&C.sfRenderWindow(r), *&C.sfColor(&color))
	}
}

// set_view: change the current active view of a render window
pub fn (r &RenderWindow) set_view(view &View) {
	unsafe {
		C.sfRenderWindow_setView(&C.sfRenderWindow(r), &C.sfView(view))
	}
}

// get_view: get the current active view of a render window
pub fn (r &RenderWindow) get_view() !&View {
	unsafe {
		result := &View(C.sfRenderWindow_getView(&C.sfRenderWindow(r)))
		if voidptr(result) == C.NULL {
			return error('get_view failed')
		}
		return result
	}
}

// get_default_view: get the default view of a render window
pub fn (r &RenderWindow) get_default_view() !&View {
	unsafe {
		result := &View(C.sfRenderWindow_getDefaultView(&C.sfRenderWindow(r)))
		if voidptr(result) == C.NULL {
			return error('get_default_view failed')
		}
		return result
	}
}

// get_viewport: get the viewport of a view applied to this target
pub fn (r &RenderWindow) get_viewport(view &View) IntRect {
	unsafe {
		return IntRect(C.sfRenderWindow_getViewport(&C.sfRenderWindow(r), &C.sfView(view)))
	}
}

// map_pixel_to_coords: convert a point from window coordinates to world coordinates
// This function finds the 2D position that matches the
// given pixel of the render-window. In other words, it does
// the inverse of what the graphics card does, to find the
// initial position of a rendered pixel.
// Initially, both coordinate systems (world units and target pixels)
// match perfectly. But if you define a custom view or resize your
// render-window, this assertion is not true anymore, ie. a point
// located at (10, 50) in your render-window may map to the point
// (150, 75) in your 2D world -- if the view is translated by (140, 25).
// This function is typically used to find which point (or object) is
// located below the mouse cursor.
// This version uses a custom view for calculations, see the other
// overload of the function if you want to use the current view of the
// render-window.
pub fn (r &RenderWindow) map_pixel_to_coords(point system.Vector2i, view &View) system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfRenderWindow_mapPixelToCoords(&C.sfRenderWindow(r),
			*&C.sfVector2i(&point), &C.sfView(view)))
	}
}

// map_coords_to_pixel: convert a point from world coordinates to window coordinates
// This function finds the pixel of the render-window that matches
// the given 2D point. In other words, it goes through the same process
// as the graphics card, to compute the final position of a rendered point.
// Initially, both coordinate systems (world units and target pixels)
// match perfectly. But if you define a custom view or resize your
// render-window, this assertion is not true anymore, ie. a point
// located at (150, 75) in your 2D world may map to the pixel
// (10, 50) of your render-window -- if the view is translated by (140, 25).
// This version uses a custom view for calculations, see the other
// overload of the function if you want to use the current view of the
// render-window.
pub fn (r &RenderWindow) map_coords_to_pixel(point system.Vector2f, view &View) system.Vector2i {
	unsafe {
		return system.Vector2i(C.sfRenderWindow_mapCoordsToPixel(&C.sfRenderWindow(r),
			*&C.sfVector2f(&point), &C.sfView(view)))
	}
}

// draw_sprite: draw a drawable object to the render-target
pub fn (r &RenderWindow) draw_sprite(params RenderWindowDrawSpriteParams) {
	unsafe {
		C.sfRenderWindow_drawSprite(&C.sfRenderWindow(r), &C.sfSprite(params.object),
			&C.sfRenderStates(params.states))
	}
}

// RenderWindowDrawSpriteParams: parameters for draw_sprite
pub struct RenderWindowDrawSpriteParams {
pub:
	object &Sprite       [required] // object to draw
	states &RenderStates = C.NULL // render states to use for drawing (NULL to use the default states)
}

// draw_text
pub fn (r &RenderWindow) draw_text(params RenderWindowDrawTextParams) {
	unsafe {
		C.sfRenderWindow_drawText(&C.sfRenderWindow(r), &C.sfText(params.object), &C.sfRenderStates(params.states))
	}
}

// RenderWindowDrawTextParams: parameters for draw_text
pub struct RenderWindowDrawTextParams {
pub:
	object &Text         [required]
	states &RenderStates = C.NULL
}

// draw_shape
pub fn (r &RenderWindow) draw_shape(params RenderWindowDrawShapeParams) {
	unsafe {
		C.sfRenderWindow_drawShape(&C.sfRenderWindow(r), &C.sfShape(params.object),
			&C.sfRenderStates(params.states))
	}
}

// RenderWindowDrawShapeParams: parameters for draw_shape
pub struct RenderWindowDrawShapeParams {
pub:
	object &Shape        [required]
	states &RenderStates = C.NULL
}

// draw_circle_shape
pub fn (r &RenderWindow) draw_circle_shape(params RenderWindowDrawCircleShapeParams) {
	unsafe {
		C.sfRenderWindow_drawCircleShape(&C.sfRenderWindow(r), &C.sfCircleShape(params.object),
			&C.sfRenderStates(params.states))
	}
}

// RenderWindowDrawCircleShapeParams: parameters for draw_circle_shape
pub struct RenderWindowDrawCircleShapeParams {
pub:
	object &CircleShape  [required]
	states &RenderStates = C.NULL
}

// draw_convex_shape
pub fn (r &RenderWindow) draw_convex_shape(params RenderWindowDrawConvexShapeParams) {
	unsafe {
		C.sfRenderWindow_drawConvexShape(&C.sfRenderWindow(r), &C.sfConvexShape(params.object),
			&C.sfRenderStates(params.states))
	}
}

// RenderWindowDrawConvexShapeParams: parameters for draw_convex_shape
pub struct RenderWindowDrawConvexShapeParams {
pub:
	object &ConvexShape  [required]
	states &RenderStates = C.NULL
}

// draw_rectangle_shape
pub fn (r &RenderWindow) draw_rectangle_shape(params RenderWindowDrawRectangleShapeParams) {
	unsafe {
		C.sfRenderWindow_drawRectangleShape(&C.sfRenderWindow(r), &C.sfRectangleShape(params.object),
			&C.sfRenderStates(params.states))
	}
}

// RenderWindowDrawRectangleShapeParams: parameters for draw_rectangle_shape
pub struct RenderWindowDrawRectangleShapeParams {
pub:
	object &RectangleShape [required]
	states &RenderStates = C.NULL
}

// draw_vertex_array
pub fn (r &RenderWindow) draw_vertex_array(params RenderWindowDrawVertexArrayParams) {
	unsafe {
		C.sfRenderWindow_drawVertexArray(&C.sfRenderWindow(r), &C.sfVertexArray(params.object),
			&C.sfRenderStates(params.states))
	}
}

// RenderWindowDrawVertexArrayParams: parameters for draw_vertex_array
pub struct RenderWindowDrawVertexArrayParams {
pub:
	object &VertexArray  [required]
	states &RenderStates = C.NULL
}

// draw_vertex_buffer
pub fn (r &RenderWindow) draw_vertex_buffer(params RenderWindowDrawVertexBufferParams) {
	unsafe {
		C.sfRenderWindow_drawVertexBuffer(&C.sfRenderWindow(r), &C.sfVertexBuffer(params.object),
			&C.sfRenderStates(params.states))
	}
}

// RenderWindowDrawVertexBufferParams: parameters for draw_vertex_buffer
pub struct RenderWindowDrawVertexBufferParams {
pub:
	object &VertexBuffer [required]
	states &RenderStates = C.NULL
}

// draw_primitives: draw primitives defined by an array of vertices to a render window
pub fn (r &RenderWindow) draw_primitives(params RenderWindowDrawPrimitivesParams) {
	unsafe {
		C.sfRenderWindow_drawPrimitives(&C.sfRenderWindow(r), &C.sfVertex(params.vertices),
			usize(params.vertex_count), *&C.sfPrimitiveType(&params.primitive_type), &C.sfRenderStates(params.states))
	}
}

// RenderWindowDrawPrimitivesParams: parameters for draw_primitives
pub struct RenderWindowDrawPrimitivesParams {
pub:
	vertices       &Vertex       [required] // pointer to the vertices
	vertex_count   u64           [required] // number of vertices in the array
	primitive_type PrimitiveType [required] // type of primitives to draw
	states         &RenderStates = C.NULL // render states to use for drawing (NULL to use the default states)
}

// push_gl_states: save the current OpenGL render states and matrices
// This function can be used when you mix SFML drawing
// and direct OpenGL rendering. Combined with popGLStates,
// it ensures that:
pub fn (r &RenderWindow) push_gl_states() {
	unsafe {
		C.sfRenderWindow_pushGLStates(&C.sfRenderWindow(r))
	}
}

// pop_gl_states: restore the previously saved OpenGL render states and matrices
// See the description of pushGLStates to get a detailed
// description of these functions.
pub fn (r &RenderWindow) pop_gl_states() {
	unsafe {
		C.sfRenderWindow_popGLStates(&C.sfRenderWindow(r))
	}
}

// reset_gl_states: reset the internal OpenGL states so that the target is ready for drawing
// This function can be used when you mix SFML drawing
// and direct OpenGL rendering, if you choose not to use
// pushGLStates/popGLStates. It makes sure that all OpenGL
// states needed by SFML are set, so that subsequent draw*()
// calls will work as expected.
pub fn (r &RenderWindow) reset_gl_states() {
	unsafe {
		C.sfRenderWindow_resetGLStates(&C.sfRenderWindow(r))
	}
}

// mouse_get_position_render_window: get the current position of the mouse relative to a render-window
// This function returns the current position of the mouse
// cursor relative to the given render-window, or desktop if NULL is passed.
pub fn mouse_get_position_render_window(relativeTo &RenderWindow) system.Vector2i {
	unsafe {
		return system.Vector2i(C.sfMouse_getPositionRenderWindow(&C.sfRenderWindow(relativeTo)))
	}
}

// mouse_set_position_render_window: set the current position of the mouse relative to a render window
// This function sets the current position of the mouse
// cursor relative to the given render-window, or desktop if NULL is passed.
pub fn mouse_set_position_render_window(position system.Vector2i, relativeTo &RenderWindow) {
	unsafe {
		C.sfMouse_setPositionRenderWindow(*&C.sfVector2i(&position), &C.sfRenderWindow(relativeTo))
	}
}

// touch_get_position_render_window: get the current position of a touch in window coordinates
// This function returns the current touch position
// relative to the given render window, or desktop if NULL is passed.
pub fn touch_get_position_render_window(finger u32, relativeTo &RenderWindow) system.Vector2i {
	unsafe {
		return system.Vector2i(C.sfTouch_getPositionRenderWindow(u32(finger), &C.sfRenderWindow(relativeTo)))
	}
}
