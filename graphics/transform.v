module graphics

import system

#include <SFML/Graphics/Transform.h>

[typedef]
struct C.sfTransform {
pub:
	matrix [9]f32
}

// Transform: encapsulate a 3x3 transform matrix
pub type Transform = C.sfTransform

fn C.sfTransform_fromMatrix(f32, f32, f32, f32, f32, f32, f32, f32, f32) C.sfTransform
fn C.sfTransform_getMatrix(&C.sfTransform, &f32)
fn C.sfTransform_getInverse(&C.sfTransform) C.sfTransform
fn C.sfTransform_transformPoint(&C.sfTransform, C.sfVector2f) C.sfVector2f
fn C.sfTransform_transformRect(&C.sfTransform, C.sfFloatRect) C.sfFloatRect
fn C.sfTransform_combine(&C.sfTransform, &C.sfTransform)
fn C.sfTransform_translate(&C.sfTransform, f32, f32)
fn C.sfTransform_rotate(&C.sfTransform, f32)
fn C.sfTransform_rotateWithCenter(&C.sfTransform, f32, f32, f32)
fn C.sfTransform_scale(&C.sfTransform, f32, f32)
fn C.sfTransform_scaleWithCenter(&C.sfTransform, f32, f32, f32, f32)
fn C.sfTransform_equal(&C.sfTransform, &C.sfTransform) int

// transform_from_matrix: create a new transform from a matrix
pub fn transform_from_matrix(a00 f32, a01 f32, a02 f32, a10 f32, a11 f32, a12 f32, a20 f32, a21 f32, a22 f32) Transform {
	unsafe {
		return Transform(C.sfTransform_fromMatrix(f32(a00), f32(a01), f32(a02), f32(a10),
			f32(a11), f32(a12), f32(a20), f32(a21), f32(a22)))
	}
}

// get_matrix: return the 4x4 matrix of a transform
// This function fills an array of 16 floats with the transform
// converted as a 4x4 matrix, which is directly compatible with
// OpenGL functions.
pub fn (t &Transform) get_matrix(matrix &f32) {
	unsafe {
		C.sfTransform_getMatrix(&C.sfTransform(t), &f32(matrix))
	}
}

// get_inverse: return the inverse of a transform
// If the inverse cannot be computed, a new identity transform
// is returned.
pub fn (t &Transform) get_inverse() Transform {
	unsafe {
		return Transform(C.sfTransform_getInverse(&C.sfTransform(t)))
	}
}

// transform_point: apply a transform to a 2D point
pub fn (t &Transform) transform_point(point system.Vector2f) system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfTransform_transformPoint(&C.sfTransform(t), *&C.sfVector2f(&point)))
	}
}

// transform_rect: apply a transform to a rectangle
// Since SFML doesn't provide support for oriented rectangles,
// the result of this function is always an axis-aligned
// rectangle. Which means that if the transform contains a
// rotation, the bounding rectangle of the transformed rectangle
// is returned.
pub fn (t &Transform) transform_rect(rectangle FloatRect) FloatRect {
	unsafe {
		return FloatRect(C.sfTransform_transformRect(&C.sfTransform(t), *&C.sfFloatRect(&rectangle)))
	}
}

// combine: combine two transforms
// The result is a transform that is equivalent to applying
pub fn (t &Transform) combine(other &Transform) {
	unsafe {
		C.sfTransform_combine(&C.sfTransform(t), &C.sfTransform(other))
	}
}

// translate: combine a transform with a translation
pub fn (t &Transform) translate(x f32, y f32) {
	unsafe {
		C.sfTransform_translate(&C.sfTransform(t), f32(x), f32(y))
	}
}

// rotate: combine the current transform with a rotation
pub fn (t &Transform) rotate(angle f32) {
	unsafe {
		C.sfTransform_rotate(&C.sfTransform(t), f32(angle))
	}
}

// rotate_with_center: combine the current transform with a rotation
// The center of rotation is provided for convenience as a second
// argument, so that you can build rotations around arbitrary points
// more easily (and efficiently) than the usual
// [translate(-center), rotate(angle), translate(center)].
pub fn (t &Transform) rotate_with_center(params TransformRotateWithCenterParams) {
	unsafe {
		C.sfTransform_rotateWithCenter(&C.sfTransform(t), f32(params.angle), f32(params.center_x),
			f32(params.center_y))
	}
}

// TransformRotateWithCenterParams: parameters for rotate_with_center
pub struct TransformRotateWithCenterParams {
pub:
	angle    f32 [required] // rotation angle, in degrees
	center_x f32 [required] // x coordinate of the center of rotation
	center_y f32 [required] // y coordinate of the center of rotation
}

// scale: combine the current transform with a scaling
pub fn (t &Transform) scale(scaleX f32, scaleY f32) {
	unsafe {
		C.sfTransform_scale(&C.sfTransform(t), f32(scaleX), f32(scaleY))
	}
}

// scale_with_center: combine the current transform with a scaling
// The center of scaling is provided for convenience as a second
// argument, so that you can build scaling around arbitrary points
// more easily (and efficiently) than the usual
// [translate(-center), scale(factors), translate(center)]
pub fn (t &Transform) scale_with_center(params TransformScaleWithCenterParams) {
	unsafe {
		C.sfTransform_scaleWithCenter(&C.sfTransform(t), f32(params.scale_x), f32(params.scale_y),
			f32(params.center_x), f32(params.center_y))
	}
}

// TransformScaleWithCenterParams: parameters for scale_with_center
pub struct TransformScaleWithCenterParams {
pub:
	scale_x  f32 [required] // scaling factor on X axis
	scale_y  f32 [required] // scaling factor on Y axis
	center_x f32 [required] // x coordinate of the center of scaling
	center_y f32 [required] // y coordinate of the center of scaling
}

// equal: compare two transforms for equality
// Performs an element-wise comparison of the elements of the
// left transform with the elements of the right transform.
pub fn (t &Transform) equal(right &Transform) bool {
	unsafe {
		return C.sfTransform_equal(&C.sfTransform(t), &C.sfTransform(right)) != 0
	}
}
