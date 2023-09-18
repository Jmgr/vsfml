module graphics

import vsfml.system

#include <SFML/Graphics/Sprite.h>

fn C.sfSprite_create() &C.sfSprite
fn C.sfSprite_copy(&C.sfSprite) &C.sfSprite
fn C.sfSprite_destroy(&C.sfSprite)
fn C.sfSprite_setPosition(&C.sfSprite, C.sfVector2f)
fn C.sfSprite_setRotation(&C.sfSprite, f32)
fn C.sfSprite_setScale(&C.sfSprite, C.sfVector2f)
fn C.sfSprite_setOrigin(&C.sfSprite, C.sfVector2f)
fn C.sfSprite_getPosition(&C.sfSprite) C.sfVector2f
fn C.sfSprite_getRotation(&C.sfSprite) f32
fn C.sfSprite_getScale(&C.sfSprite) C.sfVector2f
fn C.sfSprite_getOrigin(&C.sfSprite) C.sfVector2f
fn C.sfSprite_move(&C.sfSprite, C.sfVector2f)
fn C.sfSprite_rotate(&C.sfSprite, f32)
fn C.sfSprite_scale(&C.sfSprite, C.sfVector2f)
fn C.sfSprite_getTransform(&C.sfSprite) C.sfTransform
fn C.sfSprite_getInverseTransform(&C.sfSprite) C.sfTransform
fn C.sfSprite_setTexture(&C.sfSprite, &C.sfTexture, int)
fn C.sfSprite_setTextureRect(&C.sfSprite, C.sfIntRect)
fn C.sfSprite_setColor(&C.sfSprite, C.sfColor)
fn C.sfSprite_getTexture(&C.sfSprite) &C.sfTexture
fn C.sfSprite_getTextureRect(&C.sfSprite) C.sfIntRect
fn C.sfSprite_getColor(&C.sfSprite) C.sfColor
fn C.sfSprite_getLocalBounds(&C.sfSprite) C.sfFloatRect
fn C.sfSprite_getGlobalBounds(&C.sfSprite) C.sfFloatRect

// new_sprite: create a new sprite
pub fn new_sprite() !&Sprite {
	unsafe {
		result := &Sprite(C.sfSprite_create())
		if voidptr(result) == C.NULL {
			return error('new_sprite failed')
		}
		return result
	}
}

// copy: copy an existing sprite
pub fn (s &Sprite) copy() !&Sprite {
	unsafe {
		result := &Sprite(C.sfSprite_copy(&C.sfSprite(s)))
		if voidptr(result) == C.NULL {
			return error('copy failed')
		}
		return result
	}
}

// free: destroy an existing sprite
[unsafe]
pub fn (s &Sprite) free() {
	unsafe {
		C.sfSprite_destroy(&C.sfSprite(s))
	}
}

// set_position: set the position of a sprite
// This function completely overwrites the previous position.
// See move to apply an offset based on the previous position instead.
// The default position of a sprite Sprite object is (0, 0).
pub fn (s &Sprite) set_position(position system.Vector2f) {
	unsafe {
		C.sfSprite_setPosition(&C.sfSprite(s), *&C.sfVector2f(&position))
	}
}

// set_rotation: set the orientation of a sprite
// This function completely overwrites the previous rotation.
// See rotate to add an angle based on the previous rotation instead.
// The default rotation of a sprite Sprite object is 0.
pub fn (s &Sprite) set_rotation(angle f32) {
	unsafe {
		C.sfSprite_setRotation(&C.sfSprite(s), f32(angle))
	}
}

// set_scale: set the scale factors of a sprite
// This function completely overwrites the previous scale.
// See scale to add a factor based on the previous scale instead.
// The default scale of a sprite Sprite object is (1, 1).
pub fn (s &Sprite) set_scale(scale system.Vector2f) {
	unsafe {
		C.sfSprite_setScale(&C.sfSprite(s), *&C.sfVector2f(&scale))
	}
}

// set_origin: set the local origin of a sprite
// The origin of an object defines the center point for
// all transformations (position, scale, rotation).
// The coordinates of this point must be relative to the
// top-left corner of the object, and ignore all
// transformations (position, scale, rotation).
// The default origin of a sprite Sprite object is (0, 0).
pub fn (s &Sprite) set_origin(origin system.Vector2f) {
	unsafe {
		C.sfSprite_setOrigin(&C.sfSprite(s), *&C.sfVector2f(&origin))
	}
}

// get_position: get the position of a sprite
pub fn (s &Sprite) get_position() system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfSprite_getPosition(&C.sfSprite(s)))
	}
}

// get_rotation: get the orientation of a sprite
// The rotation is always in the range [0, 360].
pub fn (s &Sprite) get_rotation() f32 {
	unsafe {
		return f32(C.sfSprite_getRotation(&C.sfSprite(s)))
	}
}

// get_scale: get the current scale of a sprite
pub fn (s &Sprite) get_scale() system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfSprite_getScale(&C.sfSprite(s)))
	}
}

// get_origin: get the local origin of a sprite
pub fn (s &Sprite) get_origin() system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfSprite_getOrigin(&C.sfSprite(s)))
	}
}

// move: move a sprite by a given offset
// This function adds to the current position of the object,
// unlike setPosition which overwrites it.
pub fn (s &Sprite) move(offset system.Vector2f) {
	unsafe {
		C.sfSprite_move(&C.sfSprite(s), *&C.sfVector2f(&offset))
	}
}

// rotate: rotate a sprite
// This function adds to the current rotation of the object,
// unlike setRotation which overwrites it.
pub fn (s &Sprite) rotate(angle f32) {
	unsafe {
		C.sfSprite_rotate(&C.sfSprite(s), f32(angle))
	}
}

// scale: scale a sprite
// This function multiplies the current scale of the object,
// unlike setScale which overwrites it.
pub fn (s &Sprite) scale(factors system.Vector2f) {
	unsafe {
		C.sfSprite_scale(&C.sfSprite(s), *&C.sfVector2f(&factors))
	}
}

// get_transform: get the combined transform of a sprite
pub fn (s &Sprite) get_transform() Transform {
	unsafe {
		return Transform(C.sfSprite_getTransform(&C.sfSprite(s)))
	}
}

// get_inverse_transform: get the inverse of the combined transform of a sprite
pub fn (s &Sprite) get_inverse_transform() Transform {
	unsafe {
		return Transform(C.sfSprite_getInverseTransform(&C.sfSprite(s)))
	}
}

// set_texture: change the source texture of a sprite
// The texture argument refers to a texture that must
// exist as long as the sprite uses it. Indeed, the sprite
// doesn't store its own copy of the texture, but rather keeps
// a pointer to the one that you passed to this function.
// If the source texture is destroyed and the sprite tries to
// use it, the behaviour is undefined.
// If resetRect is true, the TextureRect property of
// the sprite is automatically adjusted to the size of the new
// texture. If it is false, the texture rect is left unchanged.
pub fn (s &Sprite) set_texture(texture &Texture, resetRect bool) {
	unsafe {
		C.sfSprite_setTexture(&C.sfSprite(s), &C.sfTexture(texture), int(resetRect))
	}
}

// set_texture_rect: set the sub-rectangle of the texture that a sprite will display
// The texture rect is useful when you don't want to display
// the whole texture, but rather a part of it.
// By default, the texture rect covers the entire texture.
pub fn (s &Sprite) set_texture_rect(rectangle IntRect) {
	unsafe {
		C.sfSprite_setTextureRect(&C.sfSprite(s), *&C.sfIntRect(&rectangle))
	}
}

// set_color: set the global color of a sprite
// This color is modulated (multiplied) with the sprite's
// texture. It can be used to colorize the sprite, or change
// its global opacity.
// By default, the sprite's color is opaque white.
pub fn (s &Sprite) set_color(color Color) {
	unsafe {
		C.sfSprite_setColor(&C.sfSprite(s), *&C.sfColor(&color))
	}
}

// get_texture: get the source texture of a sprite
// If the sprite has no source texture, a NULL pointer is returned.
// The returned pointer is const, which means that you can't
// modify the texture when you retrieve it with this function.
pub fn (s &Sprite) get_texture() !&Texture {
	unsafe {
		result := &Texture(C.sfSprite_getTexture(&C.sfSprite(s)))
		if voidptr(result) == C.NULL {
			return error('get_texture failed')
		}
		return result
	}
}

// get_texture_rect: get the sub-rectangle of the texture displayed by a sprite
pub fn (s &Sprite) get_texture_rect() IntRect {
	unsafe {
		return IntRect(C.sfSprite_getTextureRect(&C.sfSprite(s)))
	}
}

// get_color: get the global color of a sprite
pub fn (s &Sprite) get_color() Color {
	unsafe {
		return Color(C.sfSprite_getColor(&C.sfSprite(s)))
	}
}

// get_local_bounds: get the local bounding rectangle of a sprite
// The returned rectangle is in local coordinates, which means
// that it ignores the transformations (translation, rotation,
// scale, ...) that are applied to the entity.
// In other words, this function returns the bounds of the
// entity in the entity's coordinate system.
pub fn (s &Sprite) get_local_bounds() FloatRect {
	unsafe {
		return FloatRect(C.sfSprite_getLocalBounds(&C.sfSprite(s)))
	}
}

// get_global_bounds: get the global bounding rectangle of a sprite
// The returned rectangle is in global coordinates, which means
// that it takes in account the transformations (translation,
// rotation, scale, ...) that are applied to the entity.
// In other words, this function returns the bounds of the
// sprite in the global 2D world's coordinate system.
pub fn (s &Sprite) get_global_bounds() FloatRect {
	unsafe {
		return FloatRect(C.sfSprite_getGlobalBounds(&C.sfSprite(s)))
	}
}
