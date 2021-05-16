module graphics

import system

#include <SFML/Graphics/ConvexShape.h>

fn C.sfConvexShape_create() &C.sfConvexShape
fn C.sfConvexShape_copy(&C.sfConvexShape) &C.sfConvexShape
fn C.sfConvexShape_destroy(&C.sfConvexShape)
fn C.sfConvexShape_setPosition(&C.sfConvexShape, C.sfVector2f)
fn C.sfConvexShape_setRotation(&C.sfConvexShape, f32)
fn C.sfConvexShape_setScale(&C.sfConvexShape, C.sfVector2f)
fn C.sfConvexShape_setOrigin(&C.sfConvexShape, C.sfVector2f)
fn C.sfConvexShape_getPosition(&C.sfConvexShape) C.sfVector2f
fn C.sfConvexShape_getRotation(&C.sfConvexShape) f32
fn C.sfConvexShape_getScale(&C.sfConvexShape) C.sfVector2f
fn C.sfConvexShape_getOrigin(&C.sfConvexShape) C.sfVector2f
fn C.sfConvexShape_move(&C.sfConvexShape, C.sfVector2f)
fn C.sfConvexShape_rotate(&C.sfConvexShape, f32)
fn C.sfConvexShape_scale(&C.sfConvexShape, C.sfVector2f)
fn C.sfConvexShape_getTransform(&C.sfConvexShape) C.sfTransform
fn C.sfConvexShape_getInverseTransform(&C.sfConvexShape) C.sfTransform
fn C.sfConvexShape_setTexture(&C.sfConvexShape, &C.sfTexture, int)
fn C.sfConvexShape_setTextureRect(&C.sfConvexShape, C.sfIntRect)
fn C.sfConvexShape_setFillColor(&C.sfConvexShape, C.sfColor)
fn C.sfConvexShape_setOutlineColor(&C.sfConvexShape, C.sfColor)
fn C.sfConvexShape_setOutlineThickness(&C.sfConvexShape, f32)
fn C.sfConvexShape_getTexture(&C.sfConvexShape) &C.sfTexture
fn C.sfConvexShape_getTextureRect(&C.sfConvexShape) C.sfIntRect
fn C.sfConvexShape_getFillColor(&C.sfConvexShape) C.sfColor
fn C.sfConvexShape_getOutlineColor(&C.sfConvexShape) C.sfColor
fn C.sfConvexShape_getOutlineThickness(&C.sfConvexShape) f32
fn C.sfConvexShape_getPointCount(&C.sfConvexShape) size_t
fn C.sfConvexShape_getPoint(&C.sfConvexShape, size_t) C.sfVector2f
fn C.sfConvexShape_setPointCount(&C.sfConvexShape, size_t)
fn C.sfConvexShape_setPoint(&C.sfConvexShape, size_t, C.sfVector2f)
fn C.sfConvexShape_getLocalBounds(&C.sfConvexShape) C.sfFloatRect
fn C.sfConvexShape_getGlobalBounds(&C.sfConvexShape) C.sfFloatRect

// new_convex_shape: create a new convex shape
pub fn new_convex_shape() ?&ConvexShape {
	unsafe {
		result := &ConvexShape(C.sfConvexShape_create())
		if voidptr(result) == C.NULL {
			return error('new_convex_shape failed')
		}
		return result
	}
}

// copy: copy an existing convex shape
pub fn (c &ConvexShape) copy() ?&ConvexShape {
	unsafe {
		result := &ConvexShape(C.sfConvexShape_copy(&C.sfConvexShape(c)))
		if voidptr(result) == C.NULL {
			return error('copy failed')
		}
		return result
	}
}

// free: destroy an existing convex Shape
[unsafe]
pub fn (c &ConvexShape) free() {
	unsafe {
		C.sfConvexShape_destroy(&C.sfConvexShape(c))
	}
}

// set_position: set the position of a convex shape
// This function completely overwrites the previous position.
// See move to apply an offset based on the previous position instead.
// The default position of a circle Shape object is (0, 0).
pub fn (c &ConvexShape) set_position(position system.Vector2f) {
	unsafe {
		C.sfConvexShape_setPosition(&C.sfConvexShape(c), C.sfVector2f(position))
	}
}

// set_rotation: set the orientation of a convex shape
// This function completely overwrites the previous rotation.
// See rotate to add an angle based on the previous rotation instead.
// The default rotation of a circle Shape object is 0.
pub fn (c &ConvexShape) set_rotation(angle f32) {
	unsafe {
		C.sfConvexShape_setRotation(&C.sfConvexShape(c), f32(angle))
	}
}

// set_scale: set the scale factors of a convex shape
// This function completely overwrites the previous scale.
// See scale to add a factor based on the previous scale instead.
// The default scale of a circle Shape object is (1, 1).
pub fn (c &ConvexShape) set_scale(scale system.Vector2f) {
	unsafe {
		C.sfConvexShape_setScale(&C.sfConvexShape(c), C.sfVector2f(scale))
	}
}

// set_origin: set the local origin of a convex shape
// The origin of an object defines the center point for
// all transformations (position, scale, rotation).
// The coordinates of this point must be relative to the
// top-left corner of the object, and ignore all
// transformations (position, scale, rotation).
// The default origin of a circle Shape object is (0, 0).
pub fn (c &ConvexShape) set_origin(origin system.Vector2f) {
	unsafe {
		C.sfConvexShape_setOrigin(&C.sfConvexShape(c), C.sfVector2f(origin))
	}
}

// get_position: get the position of a convex shape
pub fn (c &ConvexShape) get_position() system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfConvexShape_getPosition(&C.sfConvexShape(c)))
	}
}

// get_rotation: get the orientation of a convex shape
// The rotation is always in the range [0, 360].
pub fn (c &ConvexShape) get_rotation() f32 {
	unsafe {
		return f32(C.sfConvexShape_getRotation(&C.sfConvexShape(c)))
	}
}

// get_scale: get the current scale of a convex shape
pub fn (c &ConvexShape) get_scale() system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfConvexShape_getScale(&C.sfConvexShape(c)))
	}
}

// get_origin: get the local origin of a convex shape
pub fn (c &ConvexShape) get_origin() system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfConvexShape_getOrigin(&C.sfConvexShape(c)))
	}
}

// move: move a convex shape by a given offset
// This function adds to the current position of the object,
// unlike setPosition which overwrites it.
pub fn (c &ConvexShape) move(offset system.Vector2f) {
	unsafe {
		C.sfConvexShape_move(&C.sfConvexShape(c), C.sfVector2f(offset))
	}
}

// rotate: rotate a convex shape
// This function adds to the current rotation of the object,
// unlike setRotation which overwrites it.
pub fn (c &ConvexShape) rotate(angle f32) {
	unsafe {
		C.sfConvexShape_rotate(&C.sfConvexShape(c), f32(angle))
	}
}

// scale: scale a convex shape
// This function multiplies the current scale of the object,
// unlike setScale which overwrites it.
pub fn (c &ConvexShape) scale(factors system.Vector2f) {
	unsafe {
		C.sfConvexShape_scale(&C.sfConvexShape(c), C.sfVector2f(factors))
	}
}

// get_transform: get the combined transform of a convex shape
pub fn (c &ConvexShape) get_transform() Transform {
	unsafe {
		return Transform(C.sfConvexShape_getTransform(&C.sfConvexShape(c)))
	}
}

// get_inverse_transform: get the inverse of the combined transform of a convex shape
pub fn (c &ConvexShape) get_inverse_transform() Transform {
	unsafe {
		return Transform(C.sfConvexShape_getInverseTransform(&C.sfConvexShape(c)))
	}
}

// set_texture: change the source texture of a convex shape
// The texture argument refers to a texture that must
// exist as long as the shape uses it. Indeed, the shape
// doesn't store its own copy of the texture, but rather keeps
// a pointer to the one that you passed to this function.
// If the source texture is destroyed and the shape tries to
// use it, the behaviour is undefined.
pub fn (c &ConvexShape) set_texture(texture &Texture, resetRect bool) {
	unsafe {
		C.sfConvexShape_setTexture(&C.sfConvexShape(c), &C.sfTexture(texture), int(resetRect))
	}
}

// set_texture_rect: set the sub-rectangle of the texture that a convex shape will display
// The texture rect is useful when you don't want to display
// the whole texture, but rather a part of it.
// By default, the texture rect covers the entire texture.
pub fn (c &ConvexShape) set_texture_rect(rect IntRect) {
	unsafe {
		C.sfConvexShape_setTextureRect(&C.sfConvexShape(c), C.sfIntRect(rect))
	}
}

// set_fill_color: set the fill color of a convex shape
// This color is modulated (multiplied) with the shape's
// texture if any. It can be used to colorize the shape,
// or change its global opacity.
// You can use Transparent to make the inside of
// the shape transparent, and have the outline alone.
// By default, the shape's fill color is opaque white.
pub fn (c &ConvexShape) set_fill_color(color Color) {
	unsafe {
		C.sfConvexShape_setFillColor(&C.sfConvexShape(c), C.sfColor(color))
	}
}

// set_outline_color: set the outline color of a convex shape
// You can use Transparent to disable the outline.
// By default, the shape's outline color is opaque white.
pub fn (c &ConvexShape) set_outline_color(color Color) {
	unsafe {
		C.sfConvexShape_setOutlineColor(&C.sfConvexShape(c), C.sfColor(color))
	}
}

// set_outline_thickness: set the thickness of a convex shape's outline
// This number cannot be negative. Using zero disables
// the outline.
// By default, the outline thickness is 0.
pub fn (c &ConvexShape) set_outline_thickness(thickness f32) {
	unsafe {
		C.sfConvexShape_setOutlineThickness(&C.sfConvexShape(c), f32(thickness))
	}
}

// get_texture: get the source texture of a convex shape
// If the shape has no source texture, a NULL pointer is returned.
// The returned pointer is const, which means that you can't
// modify the texture when you retrieve it with this function.
pub fn (c &ConvexShape) get_texture() ?&Texture {
	unsafe {
		result := &Texture(C.sfConvexShape_getTexture(&C.sfConvexShape(c)))
		if voidptr(result) == C.NULL {
			return error('get_texture failed')
		}
		return result
	}
}

// get_texture_rect: get the sub-rectangle of the texture displayed by a convex shape
pub fn (c &ConvexShape) get_texture_rect() IntRect {
	unsafe {
		return IntRect(C.sfConvexShape_getTextureRect(&C.sfConvexShape(c)))
	}
}

// get_fill_color: get the fill color of a convex shape
pub fn (c &ConvexShape) get_fill_color() Color {
	unsafe {
		return Color(C.sfConvexShape_getFillColor(&C.sfConvexShape(c)))
	}
}

// get_outline_color: get the outline color of a convex shape
pub fn (c &ConvexShape) get_outline_color() Color {
	unsafe {
		return Color(C.sfConvexShape_getOutlineColor(&C.sfConvexShape(c)))
	}
}

// get_outline_thickness: get the outline thickness of a convex shape
pub fn (c &ConvexShape) get_outline_thickness() f32 {
	unsafe {
		return f32(C.sfConvexShape_getOutlineThickness(&C.sfConvexShape(c)))
	}
}

// get_point_count: get the total number of points of a convex shape
pub fn (c &ConvexShape) get_point_count() u64 {
	unsafe {
		return u64(C.sfConvexShape_getPointCount(&C.sfConvexShape(c)))
	}
}

// get_point: get a point of a convex shape
// The result is undefined if index is out of the valid range.
pub fn (c &ConvexShape) get_point(index u64) system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfConvexShape_getPoint(&C.sfConvexShape(c), size_t(index)))
	}
}

// set_point_count: set the number of points of a convex shap
pub fn (c &ConvexShape) set_point_count(count u64) {
	unsafe {
		C.sfConvexShape_setPointCount(&C.sfConvexShape(c), size_t(count))
	}
}

// set_point: set the position of a point in a convex shape
// Don't forget that the polygon must remain convex, and
// the points need to stay ordered!
// setPointCount must be called first in order to set the total
// number of points. The result is undefined if index is out
// of the valid range.
pub fn (c &ConvexShape) set_point(index u64, point system.Vector2f) {
	unsafe {
		C.sfConvexShape_setPoint(&C.sfConvexShape(c), size_t(index), C.sfVector2f(point))
	}
}

// get_local_bounds: get the local bounding rectangle of a convex shape
// The returned rectangle is in local coordinates, which means
// that it ignores the transformations (translation, rotation,
// scale, ...) that are applied to the entity.
// In other words, this function returns the bounds of the
// entity in the entity's coordinate system.
pub fn (c &ConvexShape) get_local_bounds() FloatRect {
	unsafe {
		return FloatRect(C.sfConvexShape_getLocalBounds(&C.sfConvexShape(c)))
	}
}

// get_global_bounds: get the global bounding rectangle of a convex shape
// The returned rectangle is in global coordinates, which means
// that it takes in account the transformations (translation,
// rotation, scale, ...) that are applied to the entity.
// In other words, this function returns the bounds of the
// sprite in the global 2D world's coordinate system.
pub fn (c &ConvexShape) get_global_bounds() FloatRect {
	unsafe {
		return FloatRect(C.sfConvexShape_getGlobalBounds(&C.sfConvexShape(c)))
	}
}
