module graphics

#include <SFML/Graphics/Rect.h>

[typedef]
struct C.sfFloatRect {
pub:
	left   f32
	top    f32
	width  f32
	height f32
}

// FloatRect: and IntRect are utility classes for manipulating rectangles.
pub type FloatRect = C.sfFloatRect

[typedef]
struct C.sfIntRect {
pub:
	left   int
	top    int
	width  int
	height int
}

// IntRect
pub type IntRect = C.sfIntRect

fn C.sfFloatRect_contains(&C.sfFloatRect, f32, f32) int
fn C.sfIntRect_contains(&C.sfIntRect, int, int) int
fn C.sfFloatRect_intersects(&C.sfFloatRect, &C.sfFloatRect, &C.sfFloatRect) int
fn C.sfIntRect_intersects(&C.sfIntRect, &C.sfIntRect, &C.sfIntRect) int

// contains: check if a point is inside a rectangle's area
pub fn (f &FloatRect) contains(x f32, y f32) bool {
	unsafe {
		return C.sfFloatRect_contains(&C.sfFloatRect(f), f32(x), f32(y)) != 0
	}
}

// contains
pub fn (i &IntRect) contains(x int, y int) bool {
	unsafe {
		return C.sfIntRect_contains(&C.sfIntRect(i), int(x), int(y)) != 0
	}
}

// intersects: check intersection between two rectangles
pub fn (f &FloatRect) intersects(rect2 &FloatRect, intersection &FloatRect) bool {
	unsafe {
		return C.sfFloatRect_intersects(&C.sfFloatRect(f), &C.sfFloatRect(rect2), &C.sfFloatRect(intersection)) != 0
	}
}

// intersects
pub fn (i &IntRect) intersects(rect2 &IntRect, intersection &IntRect) bool {
	unsafe {
		return C.sfIntRect_intersects(&C.sfIntRect(i), &C.sfIntRect(rect2), &C.sfIntRect(intersection)) != 0
	}
}
