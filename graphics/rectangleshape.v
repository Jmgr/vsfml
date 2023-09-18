module graphics

import vsfml.system

#include <SFML/Graphics/RectangleShape.h>

fn C.sfRectangleShape_create() &C.sfRectangleShape
fn C.sfRectangleShape_copy(&C.sfRectangleShape) &C.sfRectangleShape
fn C.sfRectangleShape_destroy(&C.sfRectangleShape)
fn C.sfRectangleShape_setPosition(&C.sfRectangleShape, C.sfVector2f)
fn C.sfRectangleShape_setRotation(&C.sfRectangleShape, f32)
fn C.sfRectangleShape_setScale(&C.sfRectangleShape, C.sfVector2f)
fn C.sfRectangleShape_setOrigin(&C.sfRectangleShape, C.sfVector2f)
fn C.sfRectangleShape_getPosition(&C.sfRectangleShape) C.sfVector2f
fn C.sfRectangleShape_getRotation(&C.sfRectangleShape) f32
fn C.sfRectangleShape_getScale(&C.sfRectangleShape) C.sfVector2f
fn C.sfRectangleShape_getOrigin(&C.sfRectangleShape) C.sfVector2f
fn C.sfRectangleShape_move(&C.sfRectangleShape, C.sfVector2f)
fn C.sfRectangleShape_rotate(&C.sfRectangleShape, f32)
fn C.sfRectangleShape_scale(&C.sfRectangleShape, C.sfVector2f)
fn C.sfRectangleShape_getTransform(&C.sfRectangleShape) C.sfTransform
fn C.sfRectangleShape_getInverseTransform(&C.sfRectangleShape) C.sfTransform
fn C.sfRectangleShape_setTexture(&C.sfRectangleShape, &C.sfTexture, int)
fn C.sfRectangleShape_setTextureRect(&C.sfRectangleShape, C.sfIntRect)
fn C.sfRectangleShape_setFillColor(&C.sfRectangleShape, C.sfColor)
fn C.sfRectangleShape_setOutlineColor(&C.sfRectangleShape, C.sfColor)
fn C.sfRectangleShape_setOutlineThickness(&C.sfRectangleShape, f32)
fn C.sfRectangleShape_getTexture(&C.sfRectangleShape) &C.sfTexture
fn C.sfRectangleShape_getTextureRect(&C.sfRectangleShape) C.sfIntRect
fn C.sfRectangleShape_getFillColor(&C.sfRectangleShape) C.sfColor
fn C.sfRectangleShape_getOutlineColor(&C.sfRectangleShape) C.sfColor
fn C.sfRectangleShape_getOutlineThickness(&C.sfRectangleShape) f32
fn C.sfRectangleShape_getPointCount(&C.sfRectangleShape) usize
fn C.sfRectangleShape_getPoint(&C.sfRectangleShape, usize) C.sfVector2f
fn C.sfRectangleShape_setSize(&C.sfRectangleShape, C.sfVector2f)
fn C.sfRectangleShape_getSize(&C.sfRectangleShape) C.sfVector2f
fn C.sfRectangleShape_getLocalBounds(&C.sfRectangleShape) C.sfFloatRect
fn C.sfRectangleShape_getGlobalBounds(&C.sfRectangleShape) C.sfFloatRect

// new_rectangle_shape: create a new rectangle shape
pub fn new_rectangle_shape() !&RectangleShape {
	unsafe {
		result := &RectangleShape(C.sfRectangleShape_create())
		if voidptr(result) == C.NULL {
			return error('new_rectangle_shape failed')
		}
		return result
	}
}

// copy: copy an existing rectangle shape
pub fn (r &RectangleShape) copy() !&RectangleShape {
	unsafe {
		result := &RectangleShape(C.sfRectangleShape_copy(&C.sfRectangleShape(r)))
		if voidptr(result) == C.NULL {
			return error('copy failed')
		}
		return result
	}
}

// free: destroy an existing rectangle shape
[unsafe]
pub fn (r &RectangleShape) free() {
	unsafe {
		C.sfRectangleShape_destroy(&C.sfRectangleShape(r))
	}
}

// set_position: set the position of a rectangle shape
// This function completely overwrites the previous position.
// See move to apply an offset based on the previous position instead.
// The default position of a circle Shape object is (0, 0).
pub fn (r &RectangleShape) set_position(position system.Vector2f) {
	unsafe {
		C.sfRectangleShape_setPosition(&C.sfRectangleShape(r), *&C.sfVector2f(&position))
	}
}

// set_rotation: set the orientation of a rectangle shape
// This function completely overwrites the previous rotation.
// See rotate to add an angle based on the previous rotation instead.
// The default rotation of a circle Shape object is 0.
pub fn (r &RectangleShape) set_rotation(angle f32) {
	unsafe {
		C.sfRectangleShape_setRotation(&C.sfRectangleShape(r), f32(angle))
	}
}

// set_scale: set the scale factors of a rectangle shape
// This function completely overwrites the previous scale.
// See scale to add a factor based on the previous scale instead.
// The default scale of a circle Shape object is (1, 1).
pub fn (r &RectangleShape) set_scale(scale system.Vector2f) {
	unsafe {
		C.sfRectangleShape_setScale(&C.sfRectangleShape(r), *&C.sfVector2f(&scale))
	}
}

// set_origin: set the local origin of a rectangle shape
// The origin of an object defines the center point for
// all transformations (position, scale, rotation).
// The coordinates of this point must be relative to the
// top-left corner of the object, and ignore all
// transformations (position, scale, rotation).
// The default origin of a circle Shape object is (0, 0).
pub fn (r &RectangleShape) set_origin(origin system.Vector2f) {
	unsafe {
		C.sfRectangleShape_setOrigin(&C.sfRectangleShape(r), *&C.sfVector2f(&origin))
	}
}

// get_position: get the position of a rectangle shape
pub fn (r &RectangleShape) get_position() system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfRectangleShape_getPosition(&C.sfRectangleShape(r)))
	}
}

// get_rotation: get the orientation of a rectangle shape
// The rotation is always in the range [0, 360].
pub fn (r &RectangleShape) get_rotation() f32 {
	unsafe {
		return f32(C.sfRectangleShape_getRotation(&C.sfRectangleShape(r)))
	}
}

// get_scale: get the current scale of a rectangle shape
pub fn (r &RectangleShape) get_scale() system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfRectangleShape_getScale(&C.sfRectangleShape(r)))
	}
}

// get_origin: get the local origin of a rectangle shape
pub fn (r &RectangleShape) get_origin() system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfRectangleShape_getOrigin(&C.sfRectangleShape(r)))
	}
}

// move: move a rectangle shape by a given offset
// This function adds to the current position of the object,
// unlike setPosition which overwrites it.
pub fn (r &RectangleShape) move(offset system.Vector2f) {
	unsafe {
		C.sfRectangleShape_move(&C.sfRectangleShape(r), *&C.sfVector2f(&offset))
	}
}

// rotate: rotate a rectangle shape
// This function adds to the current rotation of the object,
// unlike setRotation which overwrites it.
pub fn (r &RectangleShape) rotate(angle f32) {
	unsafe {
		C.sfRectangleShape_rotate(&C.sfRectangleShape(r), f32(angle))
	}
}

// scale: scale a rectangle shape
// This function multiplies the current scale of the object,
// unlike setScale which overwrites it.
pub fn (r &RectangleShape) scale(factors system.Vector2f) {
	unsafe {
		C.sfRectangleShape_scale(&C.sfRectangleShape(r), *&C.sfVector2f(&factors))
	}
}

// get_transform: get the combined transform of a rectangle shape
pub fn (r &RectangleShape) get_transform() Transform {
	unsafe {
		return Transform(C.sfRectangleShape_getTransform(&C.sfRectangleShape(r)))
	}
}

// get_inverse_transform: get the inverse of the combined transform of a rectangle shape
pub fn (r &RectangleShape) get_inverse_transform() Transform {
	unsafe {
		return Transform(C.sfRectangleShape_getInverseTransform(&C.sfRectangleShape(r)))
	}
}

// set_texture: change the source texture of a rectangle shape
// The texture argument refers to a texture that must
// exist as long as the shape uses it. Indeed, the shape
// doesn't store its own copy of the texture, but rather keeps
// a pointer to the one that you passed to this function.
// If the source texture is destroyed and the shape tries to
// use it, the behaviour is undefined.
pub fn (r &RectangleShape) set_texture(texture &Texture, resetRect bool) {
	unsafe {
		C.sfRectangleShape_setTexture(&C.sfRectangleShape(r), &C.sfTexture(texture), int(resetRect))
	}
}

// set_texture_rect: set the sub-rectangle of the texture that a rectangle shape will display
// The texture rect is useful when you don't want to display
// the whole texture, but rather a part of it.
// By default, the texture rect covers the entire texture.
pub fn (r &RectangleShape) set_texture_rect(rect IntRect) {
	unsafe {
		C.sfRectangleShape_setTextureRect(&C.sfRectangleShape(r), *&C.sfIntRect(&rect))
	}
}

// set_fill_color: set the fill color of a rectangle shape
// This color is modulated (multiplied) with the shape's
// texture if any. It can be used to colorize the shape,
// or change its global opacity.
// You can use Transparent to make the inside of
// the shape transparent, and have the outline alone.
// By default, the shape's fill color is opaque white.
pub fn (r &RectangleShape) set_fill_color(color Color) {
	unsafe {
		C.sfRectangleShape_setFillColor(&C.sfRectangleShape(r), *&C.sfColor(&color))
	}
}

// set_outline_color: set the outline color of a rectangle shape
// You can use Transparent to disable the outline.
// By default, the shape's outline color is opaque white.
pub fn (r &RectangleShape) set_outline_color(color Color) {
	unsafe {
		C.sfRectangleShape_setOutlineColor(&C.sfRectangleShape(r), *&C.sfColor(&color))
	}
}

// set_outline_thickness: set the thickness of a rectangle shape's outline
// This number cannot be negative. Using zero disables
// the outline.
// By default, the outline thickness is 0.
pub fn (r &RectangleShape) set_outline_thickness(thickness f32) {
	unsafe {
		C.sfRectangleShape_setOutlineThickness(&C.sfRectangleShape(r), f32(thickness))
	}
}

// get_texture: get the source texture of a rectangle shape
// If the shape has no source texture, a NULL pointer is returned.
// The returned pointer is const, which means that you can't
// modify the texture when you retrieve it with this function.
pub fn (r &RectangleShape) get_texture() !&Texture {
	unsafe {
		result := &Texture(C.sfRectangleShape_getTexture(&C.sfRectangleShape(r)))
		if voidptr(result) == C.NULL {
			return error('get_texture failed')
		}
		return result
	}
}

// get_texture_rect: get the sub-rectangle of the texture displayed by a rectangle shape
pub fn (r &RectangleShape) get_texture_rect() IntRect {
	unsafe {
		return IntRect(C.sfRectangleShape_getTextureRect(&C.sfRectangleShape(r)))
	}
}

// get_fill_color: get the fill color of a rectangle shape
pub fn (r &RectangleShape) get_fill_color() Color {
	unsafe {
		return Color(C.sfRectangleShape_getFillColor(&C.sfRectangleShape(r)))
	}
}

// get_outline_color: get the outline color of a rectangle shape
pub fn (r &RectangleShape) get_outline_color() Color {
	unsafe {
		return Color(C.sfRectangleShape_getOutlineColor(&C.sfRectangleShape(r)))
	}
}

// get_outline_thickness: get the outline thickness of a rectangle shape
pub fn (r &RectangleShape) get_outline_thickness() f32 {
	unsafe {
		return f32(C.sfRectangleShape_getOutlineThickness(&C.sfRectangleShape(r)))
	}
}

// get_point_count: get the total number of points of a rectangle shape
pub fn (r &RectangleShape) get_point_count() u64 {
	unsafe {
		return u64(C.sfRectangleShape_getPointCount(&C.sfRectangleShape(r)))
	}
}

// get_point: get a point of a rectangle shape
// The result is undefined if index is out of the valid range.
pub fn (r &RectangleShape) get_point(index u64) system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfRectangleShape_getPoint(&C.sfRectangleShape(r), usize(index)))
	}
}

// set_size: set the size of a rectangle shape
pub fn (r &RectangleShape) set_size(size system.Vector2f) {
	unsafe {
		C.sfRectangleShape_setSize(&C.sfRectangleShape(r), *&C.sfVector2f(&size))
	}
}

// get_size: get the size of a rectangle shape
pub fn (r &RectangleShape) get_size() system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfRectangleShape_getSize(&C.sfRectangleShape(r)))
	}
}

// get_local_bounds: get the local bounding rectangle of a rectangle shape
// The returned rectangle is in local coordinates, which means
// that it ignores the transformations (translation, rotation,
// scale, ...) that are applied to the entity.
// In other words, this function returns the bounds of the
// entity in the entity's coordinate system.
pub fn (r &RectangleShape) get_local_bounds() FloatRect {
	unsafe {
		return FloatRect(C.sfRectangleShape_getLocalBounds(&C.sfRectangleShape(r)))
	}
}

// get_global_bounds: get the global bounding rectangle of a rectangle shape
// The returned rectangle is in global coordinates, which means
// that it takes in account the transformations (translation,
// rotation, scale, ...) that are applied to the entity.
// In other words, this function returns the bounds of the
// sprite in the global 2D world's coordinate system.
pub fn (r &RectangleShape) get_global_bounds() FloatRect {
	unsafe {
		return FloatRect(C.sfRectangleShape_getGlobalBounds(&C.sfRectangleShape(r)))
	}
}
