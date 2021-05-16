module window

import system

#include <SFML/Window/Cursor.h>

// CursorType: enumeration of the native system cursor types
// Refer to the following table to determine which cursor
// is available on which platform.
// Type                               | Linux | Mac OS X | Windows
// ------------------------------------|:-----:|:--------:|:--------:
// CursorArrow                  |  yes  |    yes   |   yes
// CursorArrowWait              |  no   |    no    |   yes
// CursorWait                   |  yes  |    no    |   yes
// CursorText                   |  yes  |    yes   |   yes
// CursorHand                   |  yes  |    yes   |   yes
// CursorSizeHorizontal         |  yes  |    yes   |   yes
// CursorSizeVertical           |  yes  |    yes   |   yes
// CursorSizeTopLeftBottomRight |  no   |    no    |   yes
// CursorSizeBottomLeftTopRight |  no   |    no    |   yes
// CursorSizeAll                |  yes  |    no    |   yes
// CursorCross                  |  yes  |    yes   |   yes
// CursorHelp                   |  yes  |    no    |   yes
// CursorNotAllowed             |  yes  |    yes   |   yes
pub enum CursorType {
	arrow // Arrow cursor (default)
	arrow_wait // Busy arrow cursor
	wait // Busy cursor
	text // I-beam, cursor when hovering over a field allowing text entry
	hand // Pointing hand cursor
	size_horizontal // Horizontal double arrow cursor
	size_vertical // Vertical double arrow cursor
	size_top_left_bottom_right // Double arrow cursor going from top-left to bottom-right
	size_bottom_left_top_right // Double arrow cursor going from bottom-left to top-right
	size_all // Combination of SizeHorizontal and SizeVertical
	cross // Crosshair cursor
	help // Help cursor
	not_allowed // Action not allowed cursor
}

fn C.sfCursor_createFromPixels(&byte, C.sfVector2u, C.sfVector2u) &C.sfCursor
fn C.sfCursor_createFromSystem(C.sfCursorType) &C.sfCursor
fn C.sfCursor_destroy(&C.sfCursor)

// new_cursor_from_pixels: create a cursor with the provided image
pub fn new_cursor_from_pixels(params CursorNewCursorFromPixelsParams) ?&Cursor {
	unsafe {
		result := &Cursor(C.sfCursor_createFromPixels(&byte(params.pixels), C.sfVector2u(params.size),
			C.sfVector2u(params.hotspot)))
		if voidptr(result) == C.NULL {
			return error('new_cursor_from_pixels failed with size=$params.size hotspot=$params.hotspot')
		}
		return result
	}
}

// CursorNewCursorFromPixelsParams: parameters for new_cursor_from_pixels
pub struct CursorNewCursorFromPixelsParams {
pub:
	pixels  &byte           [required] // array of pixels of the image
	size    system.Vector2u [required] // width and height of the image
	hotspot system.Vector2u [required] // (x,y) location of the hotspot
}

// new_cursor_from_system: create a native system cursor
// Refer to the list of cursor available on each system
// (see CursorType) to know whether a given cursor is
// expected to load successfully or is not supported by
// the operating system.
pub fn new_cursor_from_system(params CursorNewCursorFromSystemParams) ?&Cursor {
	unsafe {
		result := &Cursor(C.sfCursor_createFromSystem(C.sfCursorType(params.cursor_type)))
		if voidptr(result) == C.NULL {
			return error('new_cursor_from_system failed with cursor_type=$params.cursor_type')
		}
		return result
	}
}

// CursorNewCursorFromSystemParams: parameters for new_cursor_from_system
pub struct CursorNewCursorFromSystemParams {
pub:
	cursor_type CursorType [required] // native system cursor type
}

// free: destroy a cursor
[unsafe]
pub fn (c &Cursor) free() {
	unsafe {
		C.sfCursor_destroy(&C.sfCursor(c))
	}
}
