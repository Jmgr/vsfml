module graphics

import vsfml.system

#include <SFML/Graphics/Shape.h>

fn C.sfShape_create(C.sfShapeGetPointCountCallback, C.sfShapeGetPointCallback, voidptr) &C.sfShape
fn C.sfShape_destroy(&C.sfShape)
fn C.sfShape_setPosition(&C.sfShape, C.sfVector2f)
fn C.sfShape_setRotation(&C.sfShape, f32)
fn C.sfShape_setScale(&C.sfShape, C.sfVector2f)
fn C.sfShape_setOrigin(&C.sfShape, C.sfVector2f)
fn C.sfShape_getPosition(&C.sfShape) C.sfVector2f
fn C.sfShape_getRotation(&C.sfShape) f32
fn C.sfShape_getScale(&C.sfShape) C.sfVector2f
fn C.sfShape_getOrigin(&C.sfShape) C.sfVector2f
fn C.sfShape_move(&C.sfShape, C.sfVector2f)
fn C.sfShape_rotate(&C.sfShape, f32)
fn C.sfShape_scale(&C.sfShape, C.sfVector2f)
fn C.sfShape_getTransform(&C.sfShape) C.sfTransform
fn C.sfShape_getInverseTransform(&C.sfShape) C.sfTransform
fn C.sfShape_setTexture(&C.sfShape, &C.sfTexture, int)
fn C.sfShape_setTextureRect(&C.sfShape, C.sfIntRect)
fn C.sfShape_setFillColor(&C.sfShape, C.sfColor)
fn C.sfShape_setOutlineColor(&C.sfShape, C.sfColor)
fn C.sfShape_setOutlineThickness(&C.sfShape, f32)
fn C.sfShape_getTexture(&C.sfShape) &C.sfTexture
fn C.sfShape_getTextureRect(&C.sfShape) C.sfIntRect
fn C.sfShape_getFillColor(&C.sfShape) C.sfColor
fn C.sfShape_getOutlineColor(&C.sfShape) C.sfColor
fn C.sfShape_getOutlineThickness(&C.sfShape) f32
fn C.sfShape_getPointCount(&C.sfShape) usize
fn C.sfShape_getPoint(&C.sfShape, usize) C.sfVector2f
fn C.sfShape_getLocalBounds(&C.sfShape) C.sfFloatRect
fn C.sfShape_getGlobalBounds(&C.sfShape) C.sfFloatRect
fn C.sfShape_update(&C.sfShape)

pub type ShapeGetPointCountCallback = fn (voidptr) usize // Type of the callback used to get the number of points in a shape

pub type ShapeGetPointCallback = fn (usize, voidptr) C.sfVector2f // Type of the callback used to get a point of a shape

// new_shape: create a new shape
pub fn new_shape(params ShapeNewShapeParams) !&Shape {
	unsafe {
		result := &Shape(C.sfShape_create(*&C.sfShapeGetPointCountCallback(&params.get_point_count),
			*&C.sfShapeGetPointCallback(&params.get_point), voidptr(params.user_data)))
		if voidptr(result) == C.NULL {
			return error('new_shape failed with get_point_count=${params.get_point_count} get_point=${params.get_point}')
		}
		return result
	}
}

// ShapeNewShapeParams: parameters for new_shape
pub struct ShapeNewShapeParams {
pub:
	get_point_count ShapeGetPointCountCallback [required] // callback that provides the point count of the shape
	get_point       ShapeGetPointCallback      [required]      // callback that provides the points of the shape
	user_data       voidptr // data to pass to the callback functions
}

// free: destroy an existing shape
[unsafe]
pub fn (s &Shape) free() {
	unsafe {
		C.sfShape_destroy(&C.sfShape(s))
	}
}

// set_position: set the position of a shape
// This function completely overwrites the previous position.
// See move to apply an offset based on the previous position instead.
// The default position of a circle Shape object is (0, 0).
pub fn (s &Shape) set_position(position system.Vector2f) {
	unsafe {
		C.sfShape_setPosition(&C.sfShape(s), *&C.sfVector2f(&position))
	}
}

// set_rotation: set the orientation of a shape
// This function completely overwrites the previous rotation.
// See rotate to add an angle based on the previous rotation instead.
// The default rotation of a circle Shape object is 0.
pub fn (s &Shape) set_rotation(angle f32) {
	unsafe {
		C.sfShape_setRotation(&C.sfShape(s), f32(angle))
	}
}

// set_scale: set the scale factors of a shape
// This function completely overwrites the previous scale.
// See scale to add a factor based on the previous scale instead.
// The default scale of a circle Shape object is (1, 1).
pub fn (s &Shape) set_scale(scale system.Vector2f) {
	unsafe {
		C.sfShape_setScale(&C.sfShape(s), *&C.sfVector2f(&scale))
	}
}

// set_origin: set the local origin of a shape
// The origin of an object defines the center point for
// all transformations (position, scale, rotation).
// The coordinates of this point must be relative to the
// top-left corner of the object, and ignore all
// transformations (position, scale, rotation).
// The default origin of a circle Shape object is (0, 0).
pub fn (s &Shape) set_origin(origin system.Vector2f) {
	unsafe {
		C.sfShape_setOrigin(&C.sfShape(s), *&C.sfVector2f(&origin))
	}
}

// get_position: get the position of a shape
pub fn (s &Shape) get_position() system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfShape_getPosition(&C.sfShape(s)))
	}
}

// get_rotation: get the orientation of a shape
// The rotation is always in the range [0, 360].
pub fn (s &Shape) get_rotation() f32 {
	unsafe {
		return f32(C.sfShape_getRotation(&C.sfShape(s)))
	}
}

// get_scale: get the current scale of a shape
pub fn (s &Shape) get_scale() system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfShape_getScale(&C.sfShape(s)))
	}
}

// get_origin: get the local origin of a shape
pub fn (s &Shape) get_origin() system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfShape_getOrigin(&C.sfShape(s)))
	}
}

// move: move a shape by a given offset
// This function adds to the current position of the object,
// unlike setPosition which overwrites it.
pub fn (s &Shape) move(offset system.Vector2f) {
	unsafe {
		C.sfShape_move(&C.sfShape(s), *&C.sfVector2f(&offset))
	}
}

// rotate: rotate a shape
// This function adds to the current rotation of the object,
// unlike setRotation which overwrites it.
pub fn (s &Shape) rotate(angle f32) {
	unsafe {
		C.sfShape_rotate(&C.sfShape(s), f32(angle))
	}
}

// scale: scale a shape
// This function multiplies the current scale of the object,
// unlike setScale which overwrites it.
pub fn (s &Shape) scale(factors system.Vector2f) {
	unsafe {
		C.sfShape_scale(&C.sfShape(s), *&C.sfVector2f(&factors))
	}
}

// get_transform: get the combined transform of a shape
pub fn (s &Shape) get_transform() Transform {
	unsafe {
		return Transform(C.sfShape_getTransform(&C.sfShape(s)))
	}
}

// get_inverse_transform: get the inverse of the combined transform of a shape
pub fn (s &Shape) get_inverse_transform() Transform {
	unsafe {
		return Transform(C.sfShape_getInverseTransform(&C.sfShape(s)))
	}
}

// set_texture: change the source texture of a shape
// The texture argument refers to a texture that must
// exist as long as the shape uses it. Indeed, the shape
// doesn't store its own copy of the texture, but rather keeps
// a pointer to the one that you passed to this function.
// If the source texture is destroyed and the shape tries to
// use it, the behaviour is undefined.
pub fn (s &Shape) set_texture(texture &Texture, resetRect bool) {
	unsafe {
		C.sfShape_setTexture(&C.sfShape(s), &C.sfTexture(texture), int(resetRect))
	}
}

// set_texture_rect: set the sub-rectangle of the texture that a shape will display
// The texture rect is useful when you don't want to display
// the whole texture, but rather a part of it.
// By default, the texture rect covers the entire texture.
pub fn (s &Shape) set_texture_rect(rect IntRect) {
	unsafe {
		C.sfShape_setTextureRect(&C.sfShape(s), *&C.sfIntRect(&rect))
	}
}

// set_fill_color: set the fill color of a shape
// This color is modulated (multiplied) with the shape's
// texture if any. It can be used to colorize the shape,
// or change its global opacity.
// You can use Transparent to make the inside of
// the shape transparent, and have the outline alone.
// By default, the shape's fill color is opaque white.
pub fn (s &Shape) set_fill_color(color Color) {
	unsafe {
		C.sfShape_setFillColor(&C.sfShape(s), *&C.sfColor(&color))
	}
}

// set_outline_color: set the outline color of a shape
// You can use Transparent to disable the outline.
// By default, the shape's outline color is opaque white.
pub fn (s &Shape) set_outline_color(color Color) {
	unsafe {
		C.sfShape_setOutlineColor(&C.sfShape(s), *&C.sfColor(&color))
	}
}

// set_outline_thickness: set the thickness of a shape's outline
// This number cannot be negative. Using zero disables
// the outline.
// By default, the outline thickness is 0.
pub fn (s &Shape) set_outline_thickness(thickness f32) {
	unsafe {
		C.sfShape_setOutlineThickness(&C.sfShape(s), f32(thickness))
	}
}

// get_texture: get the source texture of a shape
// If the shape has no source texture, a NULL pointer is returned.
// The returned pointer is const, which means that you can't
// modify the texture when you retrieve it with this function.
pub fn (s &Shape) get_texture() !&Texture {
	unsafe {
		result := &Texture(C.sfShape_getTexture(&C.sfShape(s)))
		if voidptr(result) == C.NULL {
			return error('get_texture failed')
		}
		return result
	}
}

// get_texture_rect: get the sub-rectangle of the texture displayed by a shape
pub fn (s &Shape) get_texture_rect() IntRect {
	unsafe {
		return IntRect(C.sfShape_getTextureRect(&C.sfShape(s)))
	}
}

// get_fill_color: get the fill color of a shape
pub fn (s &Shape) get_fill_color() Color {
	unsafe {
		return Color(C.sfShape_getFillColor(&C.sfShape(s)))
	}
}

// get_outline_color: get the outline color of a shape
pub fn (s &Shape) get_outline_color() Color {
	unsafe {
		return Color(C.sfShape_getOutlineColor(&C.sfShape(s)))
	}
}

// get_outline_thickness: get the outline thickness of a shape
pub fn (s &Shape) get_outline_thickness() f32 {
	unsafe {
		return f32(C.sfShape_getOutlineThickness(&C.sfShape(s)))
	}
}

// get_point_count: get the total number of points of a shape
pub fn (s &Shape) get_point_count() u64 {
	unsafe {
		return u64(C.sfShape_getPointCount(&C.sfShape(s)))
	}
}

// get_point: get a point of a shape
// The result is undefined if index is out of the valid range.
pub fn (s &Shape) get_point(index u64) system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfShape_getPoint(&C.sfShape(s), usize(index)))
	}
}

// get_local_bounds: get the local bounding rectangle of a shape
// The returned rectangle is in local coordinates, which means
// that it ignores the transformations (translation, rotation,
// scale, ...) that are applied to the entity.
// In other words, this function returns the bounds of the
// entity in the entity's coordinate system.
pub fn (s &Shape) get_local_bounds() FloatRect {
	unsafe {
		return FloatRect(C.sfShape_getLocalBounds(&C.sfShape(s)))
	}
}

// get_global_bounds: get the global bounding rectangle of a shape
// The returned rectangle is in global coordinates, which means
// that it takes in account the transformations (translation,
// rotation, scale, ...) that are applied to the entity.
// In other words, this function returns the bounds of the
// sprite in the global 2D world's coordinate system.
pub fn (s &Shape) get_global_bounds() FloatRect {
	unsafe {
		return FloatRect(C.sfShape_getGlobalBounds(&C.sfShape(s)))
	}
}

// update: recompute the internal geometry of a shape
// This function must be called by specialized shape objects
// everytime their points change (ie. the result of either
// the getPointCount or getPoint callbacks is different).
pub fn (s &Shape) update() {
	unsafe {
		C.sfShape_update(&C.sfShape(s))
	}
}
