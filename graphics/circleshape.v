module graphics

import system

#include <SFML/Graphics/CircleShape.h>

fn C.sfCircleShape_create() &C.sfCircleShape
fn C.sfCircleShape_copy(&C.sfCircleShape) &C.sfCircleShape
fn C.sfCircleShape_destroy(&C.sfCircleShape)
fn C.sfCircleShape_setPosition(&C.sfCircleShape, C.sfVector2f)
fn C.sfCircleShape_setRotation(&C.sfCircleShape, f32)
fn C.sfCircleShape_setScale(&C.sfCircleShape, C.sfVector2f)
fn C.sfCircleShape_setOrigin(&C.sfCircleShape, C.sfVector2f)
fn C.sfCircleShape_getPosition(&C.sfCircleShape) C.sfVector2f
fn C.sfCircleShape_getRotation(&C.sfCircleShape) f32
fn C.sfCircleShape_getScale(&C.sfCircleShape) C.sfVector2f
fn C.sfCircleShape_getOrigin(&C.sfCircleShape) C.sfVector2f
fn C.sfCircleShape_move(&C.sfCircleShape, C.sfVector2f)
fn C.sfCircleShape_rotate(&C.sfCircleShape, f32)
fn C.sfCircleShape_scale(&C.sfCircleShape, C.sfVector2f)
fn C.sfCircleShape_getTransform(&C.sfCircleShape) C.sfTransform
fn C.sfCircleShape_getInverseTransform(&C.sfCircleShape) C.sfTransform
fn C.sfCircleShape_setTexture(&C.sfCircleShape, &C.sfTexture, int)
fn C.sfCircleShape_setTextureRect(&C.sfCircleShape, C.sfIntRect)
fn C.sfCircleShape_setFillColor(&C.sfCircleShape, C.sfColor)
fn C.sfCircleShape_setOutlineColor(&C.sfCircleShape, C.sfColor)
fn C.sfCircleShape_setOutlineThickness(&C.sfCircleShape, f32)
fn C.sfCircleShape_getTexture(&C.sfCircleShape) &C.sfTexture
fn C.sfCircleShape_getTextureRect(&C.sfCircleShape) C.sfIntRect
fn C.sfCircleShape_getFillColor(&C.sfCircleShape) C.sfColor
fn C.sfCircleShape_getOutlineColor(&C.sfCircleShape) C.sfColor
fn C.sfCircleShape_getOutlineThickness(&C.sfCircleShape) f32
fn C.sfCircleShape_getPointCount(&C.sfCircleShape) usize
fn C.sfCircleShape_getPoint(&C.sfCircleShape, usize) C.sfVector2f
fn C.sfCircleShape_setRadius(&C.sfCircleShape, f32)
fn C.sfCircleShape_getRadius(&C.sfCircleShape) f32
fn C.sfCircleShape_setPointCount(&C.sfCircleShape, usize)
fn C.sfCircleShape_getLocalBounds(&C.sfCircleShape) C.sfFloatRect
fn C.sfCircleShape_getGlobalBounds(&C.sfCircleShape) C.sfFloatRect

// new_circle_shape: create a new circle shape
pub fn new_circle_shape() !&CircleShape {
	unsafe {
		result := &CircleShape(C.sfCircleShape_create())
		if voidptr(result) == C.NULL {
			return error('new_circle_shape failed')
		}
		return result
	}
}

// copy: copy an existing circle shape
pub fn (c &CircleShape) copy() !&CircleShape {
	unsafe {
		result := &CircleShape(C.sfCircleShape_copy(&C.sfCircleShape(c)))
		if voidptr(result) == C.NULL {
			return error('copy failed')
		}
		return result
	}
}

// free: destroy an existing circle Shape
[unsafe]
pub fn (c &CircleShape) free() {
	unsafe {
		C.sfCircleShape_destroy(&C.sfCircleShape(c))
	}
}

// set_position: set the position of a circle shape
// This function completely overwrites the previous position.
// See move to apply an offset based on the previous position instead.
// The default position of a circle Shape object is (0, 0).
pub fn (c &CircleShape) set_position(position system.Vector2f) {
	unsafe {
		C.sfCircleShape_setPosition(&C.sfCircleShape(c), *&C.sfVector2f(&position))
	}
}

// set_rotation: set the orientation of a circle shape
// This function completely overwrites the previous rotation.
// See rotate to add an angle based on the previous rotation instead.
// The default rotation of a circle Shape object is 0.
pub fn (c &CircleShape) set_rotation(angle f32) {
	unsafe {
		C.sfCircleShape_setRotation(&C.sfCircleShape(c), f32(angle))
	}
}

// set_scale: set the scale factors of a circle shape
// This function completely overwrites the previous scale.
// See scale to add a factor based on the previous scale instead.
// The default scale of a circle Shape object is (1, 1).
pub fn (c &CircleShape) set_scale(scale system.Vector2f) {
	unsafe {
		C.sfCircleShape_setScale(&C.sfCircleShape(c), *&C.sfVector2f(&scale))
	}
}

// set_origin: set the local origin of a circle shape
// The origin of an object defines the center point for
// all transformations (position, scale, rotation).
// The coordinates of this point must be relative to the
// top-left corner of the object, and ignore all
// transformations (position, scale, rotation).
// The default origin of a circle Shape object is (0, 0).
pub fn (c &CircleShape) set_origin(origin system.Vector2f) {
	unsafe {
		C.sfCircleShape_setOrigin(&C.sfCircleShape(c), *&C.sfVector2f(&origin))
	}
}

// get_position: get the position of a circle shape
pub fn (c &CircleShape) get_position() system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfCircleShape_getPosition(&C.sfCircleShape(c)))
	}
}

// get_rotation: get the orientation of a circle shape
// The rotation is always in the range [0, 360].
pub fn (c &CircleShape) get_rotation() f32 {
	unsafe {
		return f32(C.sfCircleShape_getRotation(&C.sfCircleShape(c)))
	}
}

// get_scale: get the current scale of a circle shape
pub fn (c &CircleShape) get_scale() system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfCircleShape_getScale(&C.sfCircleShape(c)))
	}
}

// get_origin: get the local origin of a circle shape
pub fn (c &CircleShape) get_origin() system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfCircleShape_getOrigin(&C.sfCircleShape(c)))
	}
}

// move: move a circle shape by a given offset
// This function adds to the current position of the object,
// unlike setPosition which overwrites it.
pub fn (c &CircleShape) move(offset system.Vector2f) {
	unsafe {
		C.sfCircleShape_move(&C.sfCircleShape(c), *&C.sfVector2f(&offset))
	}
}

// rotate: rotate a circle shape
// This function adds to the current rotation of the object,
// unlike setRotation which overwrites it.
pub fn (c &CircleShape) rotate(angle f32) {
	unsafe {
		C.sfCircleShape_rotate(&C.sfCircleShape(c), f32(angle))
	}
}

// scale: scale a circle shape
// This function multiplies the current scale of the object,
// unlike setScale which overwrites it.
pub fn (c &CircleShape) scale(factors system.Vector2f) {
	unsafe {
		C.sfCircleShape_scale(&C.sfCircleShape(c), *&C.sfVector2f(&factors))
	}
}

// get_transform: get the combined transform of a circle shape
pub fn (c &CircleShape) get_transform() Transform {
	unsafe {
		return Transform(C.sfCircleShape_getTransform(&C.sfCircleShape(c)))
	}
}

// get_inverse_transform: get the inverse of the combined transform of a circle shape
pub fn (c &CircleShape) get_inverse_transform() Transform {
	unsafe {
		return Transform(C.sfCircleShape_getInverseTransform(&C.sfCircleShape(c)))
	}
}

// set_texture: change the source texture of a circle shape
// The texture argument refers to a texture that must
// exist as long as the shape uses it. Indeed, the shape
// doesn't store its own copy of the texture, but rather keeps
// a pointer to the one that you passed to this function.
// If the source texture is destroyed and the shape tries to
// use it, the behaviour is undefined.
pub fn (c &CircleShape) set_texture(texture &Texture, resetRect bool) {
	unsafe {
		C.sfCircleShape_setTexture(&C.sfCircleShape(c), &C.sfTexture(texture), int(resetRect))
	}
}

// set_texture_rect: set the sub-rectangle of the texture that a circle shape will display
// The texture rect is useful when you don't want to display
// the whole texture, but rather a part of it.
// By default, the texture rect covers the entire texture.
pub fn (c &CircleShape) set_texture_rect(rect IntRect) {
	unsafe {
		C.sfCircleShape_setTextureRect(&C.sfCircleShape(c), *&C.sfIntRect(&rect))
	}
}

// set_fill_color: set the fill color of a circle shape
// This color is modulated (multiplied) with the shape's
// texture if any. It can be used to colorize the shape,
// or change its global opacity.
// You can use Transparent to make the inside of
// the shape transparent, and have the outline alone.
// By default, the shape's fill color is opaque white.
pub fn (c &CircleShape) set_fill_color(color Color) {
	unsafe {
		C.sfCircleShape_setFillColor(&C.sfCircleShape(c), *&C.sfColor(&color))
	}
}

// set_outline_color: set the outline color of a circle shape
// You can use Transparent to disable the outline.
// By default, the shape's outline color is opaque white.
pub fn (c &CircleShape) set_outline_color(color Color) {
	unsafe {
		C.sfCircleShape_setOutlineColor(&C.sfCircleShape(c), *&C.sfColor(&color))
	}
}

// set_outline_thickness: set the thickness of a circle shape's outline
// This number cannot be negative. Using zero disables
// the outline.
// By default, the outline thickness is 0.
pub fn (c &CircleShape) set_outline_thickness(thickness f32) {
	unsafe {
		C.sfCircleShape_setOutlineThickness(&C.sfCircleShape(c), f32(thickness))
	}
}

// get_texture: get the source texture of a circle shape
// If the shape has no source texture, a NULL pointer is returned.
// The returned pointer is const, which means that you can't
// modify the texture when you retrieve it with this function.
pub fn (c &CircleShape) get_texture() !&Texture {
	unsafe {
		result := &Texture(C.sfCircleShape_getTexture(&C.sfCircleShape(c)))
		if voidptr(result) == C.NULL {
			return error('get_texture failed')
		}
		return result
	}
}

// get_texture_rect: get the sub-rectangle of the texture displayed by a circle shape
pub fn (c &CircleShape) get_texture_rect() IntRect {
	unsafe {
		return IntRect(C.sfCircleShape_getTextureRect(&C.sfCircleShape(c)))
	}
}

// get_fill_color: get the fill color of a circle shape
pub fn (c &CircleShape) get_fill_color() Color {
	unsafe {
		return Color(C.sfCircleShape_getFillColor(&C.sfCircleShape(c)))
	}
}

// get_outline_color: get the outline color of a circle shape
pub fn (c &CircleShape) get_outline_color() Color {
	unsafe {
		return Color(C.sfCircleShape_getOutlineColor(&C.sfCircleShape(c)))
	}
}

// get_outline_thickness: get the outline thickness of a circle shape
pub fn (c &CircleShape) get_outline_thickness() f32 {
	unsafe {
		return f32(C.sfCircleShape_getOutlineThickness(&C.sfCircleShape(c)))
	}
}

// get_point_count: get the total number of points of a circle shape
pub fn (c &CircleShape) get_point_count() u64 {
	unsafe {
		return u64(C.sfCircleShape_getPointCount(&C.sfCircleShape(c)))
	}
}

// get_point: get a point of a circle shape
// The result is undefined if index is out of the valid range.
pub fn (c &CircleShape) get_point(index u64) system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfCircleShape_getPoint(&C.sfCircleShape(c), usize(index)))
	}
}

// set_radius: set the radius of a circle
pub fn (c &CircleShape) set_radius(radius f32) {
	unsafe {
		C.sfCircleShape_setRadius(&C.sfCircleShape(c), f32(radius))
	}
}

// get_radius: get the radius of a circle
pub fn (c &CircleShape) get_radius() f32 {
	unsafe {
		return f32(C.sfCircleShape_getRadius(&C.sfCircleShape(c)))
	}
}

// set_point_count: set the number of points of a circle
pub fn (c &CircleShape) set_point_count(count u64) {
	unsafe {
		C.sfCircleShape_setPointCount(&C.sfCircleShape(c), usize(count))
	}
}

// get_local_bounds: get the local bounding rectangle of a circle shape
// The returned rectangle is in local coordinates, which means
// that it ignores the transformations (translation, rotation,
// scale, ...) that are applied to the entity.
// In other words, this function returns the bounds of the
// entity in the entity's coordinate system.
pub fn (c &CircleShape) get_local_bounds() FloatRect {
	unsafe {
		return FloatRect(C.sfCircleShape_getLocalBounds(&C.sfCircleShape(c)))
	}
}

// get_global_bounds: get the global bounding rectangle of a circle shape
// The returned rectangle is in global coordinates, which means
// that it takes in account the transformations (translation,
// rotation, scale, ...) that are applied to the entity.
// In other words, this function returns the bounds of the
// sprite in the global 2D world's coordinate system.
pub fn (c &CircleShape) get_global_bounds() FloatRect {
	unsafe {
		return FloatRect(C.sfCircleShape_getGlobalBounds(&C.sfCircleShape(c)))
	}
}
