module graphics

import vsfml.system

#include <SFML/Graphics/View.h>

fn C.sfView_create() &C.sfView
fn C.sfView_createFromRect(C.sfFloatRect) &C.sfView
fn C.sfView_copy(&C.sfView) &C.sfView
fn C.sfView_destroy(&C.sfView)
fn C.sfView_setCenter(&C.sfView, C.sfVector2f)
fn C.sfView_setSize(&C.sfView, C.sfVector2f)
fn C.sfView_setRotation(&C.sfView, f32)
fn C.sfView_setViewport(&C.sfView, C.sfFloatRect)
fn C.sfView_reset(&C.sfView, C.sfFloatRect)
fn C.sfView_getCenter(&C.sfView) C.sfVector2f
fn C.sfView_getSize(&C.sfView) C.sfVector2f
fn C.sfView_getRotation(&C.sfView) f32
fn C.sfView_getViewport(&C.sfView) C.sfFloatRect
fn C.sfView_move(&C.sfView, C.sfVector2f)
fn C.sfView_rotate(&C.sfView, f32)
fn C.sfView_zoom(&C.sfView, f32)

// new_view: create a default view
// This function creates a default view of (0, 0, 1000, 1000)
pub fn new_view() !&View {
	unsafe {
		result := &View(C.sfView_create())
		if voidptr(result) == C.NULL {
			return error('new_view failed')
		}
		return result
	}
}

// new_view_from_rect: construct a view from a rectangle
pub fn new_view_from_rect(params ViewNewViewFromRectParams) !&View {
	unsafe {
		result := &View(C.sfView_createFromRect(*&C.sfFloatRect(&params.rectangle)))
		if voidptr(result) == C.NULL {
			return error('new_view_from_rect failed with rectangle=${params.rectangle}')
		}
		return result
	}
}

// ViewNewViewFromRectParams: parameters for new_view_from_rect
pub struct ViewNewViewFromRectParams {
pub:
	rectangle FloatRect [required] // rectangle defining the zone to display
}

// copy: copy an existing view
pub fn (v &View) copy() !&View {
	unsafe {
		result := &View(C.sfView_copy(&C.sfView(v)))
		if voidptr(result) == C.NULL {
			return error('copy failed')
		}
		return result
	}
}

// free: destroy an existing view
[unsafe]
pub fn (v &View) free() {
	unsafe {
		C.sfView_destroy(&C.sfView(v))
	}
}

// set_center: set the center of a view
pub fn (v &View) set_center(center system.Vector2f) {
	unsafe {
		C.sfView_setCenter(&C.sfView(v), *&C.sfVector2f(&center))
	}
}

// set_size: set the size of a view
pub fn (v &View) set_size(size system.Vector2f) {
	unsafe {
		C.sfView_setSize(&C.sfView(v), *&C.sfVector2f(&size))
	}
}

// set_rotation: set the orientation of a view
// The default rotation of a view is 0 degree.
pub fn (v &View) set_rotation(angle f32) {
	unsafe {
		C.sfView_setRotation(&C.sfView(v), f32(angle))
	}
}

// set_viewport: set the target viewport of a view
// The viewport is the rectangle into which the contents of the
// view are displayed, expressed as a factor (between 0 and 1)
// of the size of the render target to which the view is applied.
// For example, a view which takes the left side of the target would
// be defined by a rect of (0, 0, 0.5, 1).
// By default, a view has a viewport which covers the entire target.
pub fn (v &View) set_viewport(viewport FloatRect) {
	unsafe {
		C.sfView_setViewport(&C.sfView(v), *&C.sfFloatRect(&viewport))
	}
}

// reset: reset a view to the given rectangle
// Note that this function resets the rotation angle to 0.
pub fn (v &View) reset(rectangle FloatRect) {
	unsafe {
		C.sfView_reset(&C.sfView(v), *&C.sfFloatRect(&rectangle))
	}
}

// get_center: get the center of a view
pub fn (v &View) get_center() system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfView_getCenter(&C.sfView(v)))
	}
}

// get_size: get the size of a view
pub fn (v &View) get_size() system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfView_getSize(&C.sfView(v)))
	}
}

// get_rotation: get the current orientation of a view
pub fn (v &View) get_rotation() f32 {
	unsafe {
		return f32(C.sfView_getRotation(&C.sfView(v)))
	}
}

// get_viewport: get the target viewport rectangle of a view
pub fn (v &View) get_viewport() FloatRect {
	unsafe {
		return FloatRect(C.sfView_getViewport(&C.sfView(v)))
	}
}

// move: move a view relatively to its current position
pub fn (v &View) move(offset system.Vector2f) {
	unsafe {
		C.sfView_move(&C.sfView(v), *&C.sfVector2f(&offset))
	}
}

// rotate: rotate a view relatively to its current orientation
pub fn (v &View) rotate(angle f32) {
	unsafe {
		C.sfView_rotate(&C.sfView(v), f32(angle))
	}
}

// zoom: resize a view rectangle relatively to its current size
// Resizing the view simulates a zoom, as the zone displayed on
// screen grows or shrinks.
pub fn (v &View) zoom(factor f32) {
	unsafe {
		C.sfView_zoom(&C.sfView(v), f32(factor))
	}
}
