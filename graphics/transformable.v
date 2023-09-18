module graphics

import system

#include <SFML/Graphics/Transformable.h>

fn C.sfTransformable_create() &C.sfTransformable
fn C.sfTransformable_copy(&C.sfTransformable) &C.sfTransformable
fn C.sfTransformable_destroy(&C.sfTransformable)
fn C.sfTransformable_setPosition(&C.sfTransformable, C.sfVector2f)
fn C.sfTransformable_setRotation(&C.sfTransformable, f32)
fn C.sfTransformable_setScale(&C.sfTransformable, C.sfVector2f)
fn C.sfTransformable_setOrigin(&C.sfTransformable, C.sfVector2f)
fn C.sfTransformable_getPosition(&C.sfTransformable) C.sfVector2f
fn C.sfTransformable_getRotation(&C.sfTransformable) f32
fn C.sfTransformable_getScale(&C.sfTransformable) C.sfVector2f
fn C.sfTransformable_getOrigin(&C.sfTransformable) C.sfVector2f
fn C.sfTransformable_move(&C.sfTransformable, C.sfVector2f)
fn C.sfTransformable_rotate(&C.sfTransformable, f32)
fn C.sfTransformable_scale(&C.sfTransformable, C.sfVector2f)
fn C.sfTransformable_getTransform(&C.sfTransformable) C.sfTransform
fn C.sfTransformable_getInverseTransform(&C.sfTransformable) C.sfTransform

// new_transformable: create a new transformable
pub fn new_transformable() !&Transformable {
	unsafe {
		result := &Transformable(C.sfTransformable_create())
		if voidptr(result) == C.NULL {
			return error('new_transformable failed')
		}
		return result
	}
}

// copy: copy an existing transformable
pub fn (t &Transformable) copy() !&Transformable {
	unsafe {
		result := &Transformable(C.sfTransformable_copy(&C.sfTransformable(t)))
		if voidptr(result) == C.NULL {
			return error('copy failed')
		}
		return result
	}
}

// free: destroy an existing transformable
[unsafe]
pub fn (t &Transformable) free() {
	unsafe {
		C.sfTransformable_destroy(&C.sfTransformable(t))
	}
}

// set_position: set the position of a transformable
// This function completely overwrites the previous position.
// See move to apply an offset based on the previous position instead.
// The default position of a transformable Transformable object is (0, 0).
pub fn (t &Transformable) set_position(position system.Vector2f) {
	unsafe {
		C.sfTransformable_setPosition(&C.sfTransformable(t), *&C.sfVector2f(&position))
	}
}

// set_rotation: set the orientation of a transformable
// This function completely overwrites the previous rotation.
// See rotate to add an angle based on the previous rotation instead.
// The default rotation of a transformable Transformable object is 0.
pub fn (t &Transformable) set_rotation(angle f32) {
	unsafe {
		C.sfTransformable_setRotation(&C.sfTransformable(t), f32(angle))
	}
}

// set_scale: set the scale factors of a transformable
// This function completely overwrites the previous scale.
// See scale to add a factor based on the previous scale instead.
// The default scale of a transformable Transformable object is (1, 1).
pub fn (t &Transformable) set_scale(scale system.Vector2f) {
	unsafe {
		C.sfTransformable_setScale(&C.sfTransformable(t), *&C.sfVector2f(&scale))
	}
}

// set_origin: set the local origin of a transformable
// The origin of an object defines the center point for
// all transformations (position, scale, rotation).
// The coordinates of this point must be relative to the
// top-left corner of the object, and ignore all
// transformations (position, scale, rotation).
// The default origin of a transformable Transformable object is (0, 0).
pub fn (t &Transformable) set_origin(origin system.Vector2f) {
	unsafe {
		C.sfTransformable_setOrigin(&C.sfTransformable(t), *&C.sfVector2f(&origin))
	}
}

// get_position: get the position of a transformable
pub fn (t &Transformable) get_position() system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfTransformable_getPosition(&C.sfTransformable(t)))
	}
}

// get_rotation: get the orientation of a transformable
// The rotation is always in the range [0, 360].
pub fn (t &Transformable) get_rotation() f32 {
	unsafe {
		return f32(C.sfTransformable_getRotation(&C.sfTransformable(t)))
	}
}

// get_scale: get the current scale of a transformable
pub fn (t &Transformable) get_scale() system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfTransformable_getScale(&C.sfTransformable(t)))
	}
}

// get_origin: get the local origin of a transformable
pub fn (t &Transformable) get_origin() system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfTransformable_getOrigin(&C.sfTransformable(t)))
	}
}

// move: move a transformable by a given offset
// This function adds to the current position of the object,
// unlike setPosition which overwrites it.
pub fn (t &Transformable) move(offset system.Vector2f) {
	unsafe {
		C.sfTransformable_move(&C.sfTransformable(t), *&C.sfVector2f(&offset))
	}
}

// rotate: rotate a transformable
// This function adds to the current rotation of the object,
// unlike setRotation which overwrites it.
pub fn (t &Transformable) rotate(angle f32) {
	unsafe {
		C.sfTransformable_rotate(&C.sfTransformable(t), f32(angle))
	}
}

// scale: scale a transformable
// This function multiplies the current scale of the object,
// unlike setScale which overwrites it.
pub fn (t &Transformable) scale(factors system.Vector2f) {
	unsafe {
		C.sfTransformable_scale(&C.sfTransformable(t), *&C.sfVector2f(&factors))
	}
}

// get_transform: get the combined transform of a transformable
pub fn (t &Transformable) get_transform() Transform {
	unsafe {
		return Transform(C.sfTransformable_getTransform(&C.sfTransformable(t)))
	}
}

// get_inverse_transform: get the inverse of the combined transform of a transformable
pub fn (t &Transformable) get_inverse_transform() Transform {
	unsafe {
		return Transform(C.sfTransformable_getInverseTransform(&C.sfTransformable(t)))
	}
}
