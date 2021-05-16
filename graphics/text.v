module graphics

import system

#include <SFML/Graphics/Text.h>

// TextStyle: text styles
pub enum TextStyle {
	regular = 0 // Regular characters, no style
	bold = 1 // Bold characters
	italic = 2 // Italic characters
	underlined = 4 // Underlined characters
	strike_through = 8 // Strike through characters
}

fn C.sfText_create() &C.sfText
fn C.sfText_copy(&C.sfText) &C.sfText
fn C.sfText_destroy(&C.sfText)
fn C.sfText_setPosition(&C.sfText, C.sfVector2f)
fn C.sfText_setRotation(&C.sfText, f32)
fn C.sfText_setScale(&C.sfText, C.sfVector2f)
fn C.sfText_setOrigin(&C.sfText, C.sfVector2f)
fn C.sfText_getPosition(&C.sfText) C.sfVector2f
fn C.sfText_getRotation(&C.sfText) f32
fn C.sfText_getScale(&C.sfText) C.sfVector2f
fn C.sfText_getOrigin(&C.sfText) C.sfVector2f
fn C.sfText_move(&C.sfText, C.sfVector2f)
fn C.sfText_rotate(&C.sfText, f32)
fn C.sfText_scale(&C.sfText, C.sfVector2f)
fn C.sfText_getTransform(&C.sfText) C.sfTransform
fn C.sfText_getInverseTransform(&C.sfText) C.sfTransform
fn C.sfText_setString(&C.sfText, &char)
fn C.sfText_setUnicodeString(&C.sfText, &u32)
fn C.sfText_setFont(&C.sfText, &C.sfFont)
fn C.sfText_setCharacterSize(&C.sfText, u32)
fn C.sfText_setLineSpacing(&C.sfText, f32)
fn C.sfText_setLetterSpacing(&C.sfText, f32)
fn C.sfText_setStyle(&C.sfText, u32)
fn C.sfText_setColor(&C.sfText, C.sfColor)
fn C.sfText_setFillColor(&C.sfText, C.sfColor)
fn C.sfText_setOutlineColor(&C.sfText, C.sfColor)
fn C.sfText_setOutlineThickness(&C.sfText, f32)
fn C.sfText_getString(&C.sfText) &char
fn C.sfText_getUnicodeString(&C.sfText) &u32
fn C.sfText_getFont(&C.sfText) &C.sfFont
fn C.sfText_getLetterSpacing(&C.sfText) f32
fn C.sfText_getLineSpacing(&C.sfText) f32
fn C.sfText_getStyle(&C.sfText) u32
fn C.sfText_getColor(&C.sfText) C.sfColor
fn C.sfText_getFillColor(&C.sfText) C.sfColor
fn C.sfText_getOutlineColor(&C.sfText) C.sfColor
fn C.sfText_getOutlineThickness(&C.sfText) f32
fn C.sfText_findCharacterPos(&C.sfText, size_t) C.sfVector2f
fn C.sfText_getLocalBounds(&C.sfText) C.sfFloatRect
fn C.sfText_getGlobalBounds(&C.sfText) C.sfFloatRect

// new_text: create a new text
pub fn new_text() ?&Text {
	unsafe {
		result := &Text(C.sfText_create())
		if voidptr(result) == C.NULL {
			return error('new_text failed')
		}
		return result
	}
}

// copy: copy an existing text
pub fn (t &Text) copy() ?&Text {
	unsafe {
		result := &Text(C.sfText_copy(&C.sfText(t)))
		if voidptr(result) == C.NULL {
			return error('copy failed')
		}
		return result
	}
}

// free: destroy an existing text
[unsafe]
pub fn (t &Text) free() {
	unsafe {
		C.sfText_destroy(&C.sfText(t))
	}
}

// set_position: set the position of a text
// This function completely overwrites the previous position.
// See move to apply an offset based on the previous position instead.
// The default position of a text Text object is (0, 0).
pub fn (t &Text) set_position(position system.Vector2f) {
	unsafe {
		C.sfText_setPosition(&C.sfText(t), C.sfVector2f(position))
	}
}

// set_rotation: set the orientation of a text
// This function completely overwrites the previous rotation.
// See rotate to add an angle based on the previous rotation instead.
// The default rotation of a text Text object is 0.
pub fn (t &Text) set_rotation(angle f32) {
	unsafe {
		C.sfText_setRotation(&C.sfText(t), f32(angle))
	}
}

// set_scale: set the scale factors of a text
// This function completely overwrites the previous scale.
// See scale to add a factor based on the previous scale instead.
// The default scale of a text Text object is (1, 1).
pub fn (t &Text) set_scale(scale system.Vector2f) {
	unsafe {
		C.sfText_setScale(&C.sfText(t), C.sfVector2f(scale))
	}
}

// set_origin: set the local origin of a text
// The origin of an object defines the center point for
// all transformations (position, scale, rotation).
// The coordinates of this point must be relative to the
// top-left corner of the object, and ignore all
// transformations (position, scale, rotation).
// The default origin of a text object is (0, 0).
pub fn (t &Text) set_origin(origin system.Vector2f) {
	unsafe {
		C.sfText_setOrigin(&C.sfText(t), C.sfVector2f(origin))
	}
}

// get_position: get the position of a text
pub fn (t &Text) get_position() system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfText_getPosition(&C.sfText(t)))
	}
}

// get_rotation: get the orientation of a text
// The rotation is always in the range [0, 360].
pub fn (t &Text) get_rotation() f32 {
	unsafe {
		return f32(C.sfText_getRotation(&C.sfText(t)))
	}
}

// get_scale: get the current scale of a text
pub fn (t &Text) get_scale() system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfText_getScale(&C.sfText(t)))
	}
}

// get_origin: get the local origin of a text
pub fn (t &Text) get_origin() system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfText_getOrigin(&C.sfText(t)))
	}
}

// move: move a text by a given offset
// This function adds to the current position of the object,
// unlike setPosition which overwrites it.
pub fn (t &Text) move(offset system.Vector2f) {
	unsafe {
		C.sfText_move(&C.sfText(t), C.sfVector2f(offset))
	}
}

// rotate: rotate a text
// This function adds to the current rotation of the object,
// unlike setRotation which overwrites it.
pub fn (t &Text) rotate(angle f32) {
	unsafe {
		C.sfText_rotate(&C.sfText(t), f32(angle))
	}
}

// scale: scale a text
// This function multiplies the current scale of the object,
// unlike setScale which overwrites it.
pub fn (t &Text) scale(factors system.Vector2f) {
	unsafe {
		C.sfText_scale(&C.sfText(t), C.sfVector2f(factors))
	}
}

// get_transform: get the combined transform of a text
pub fn (t &Text) get_transform() Transform {
	unsafe {
		return Transform(C.sfText_getTransform(&C.sfText(t)))
	}
}

// get_inverse_transform: get the inverse of the combined transform of a text
pub fn (t &Text) get_inverse_transform() Transform {
	unsafe {
		return Transform(C.sfText_getInverseTransform(&C.sfText(t)))
	}
}

// set_string: set the string of a text (from an ANSI string)
// A text's string is empty by default.
pub fn (t &Text) set_string(string string) {
	unsafe {
		C.sfText_setString(&C.sfText(t), string.str)
	}
}

// set_unicode_string: set the string of a text (from a unicode string)
pub fn (t &Text) set_unicode_string(string &u32) {
	unsafe {
		C.sfText_setUnicodeString(&C.sfText(t), &u32(string))
	}
}

// set_font: set the font of a text
// The font argument refers to a texture that must
// exist as long as the text uses it. Indeed, the text
// doesn't store its own copy of the font, but rather keeps
// a pointer to the one that you passed to this function.
// If the font is destroyed and the text tries to
// use it, the behaviour is undefined.
pub fn (t &Text) set_font(font &Font) {
	unsafe {
		C.sfText_setFont(&C.sfText(t), &C.sfFont(font))
	}
}

// set_character_size: set the character size of a text
// The default size is 30.
pub fn (t &Text) set_character_size(size u32) {
	unsafe {
		C.sfText_setCharacterSize(&C.sfText(t), u32(size))
	}
}

// set_line_spacing: set the line spacing factor
// The default spacing between lines is defined by the font.
// This method enables you to set a factor for the spacing
// between lines. By default the line spacing factor is 1.
pub fn (t &Text) set_line_spacing(spacingFactor f32) {
	unsafe {
		C.sfText_setLineSpacing(&C.sfText(t), f32(spacingFactor))
	}
}

// set_letter_spacing: set the letter spacing factor
// The default spacing between letters is defined by the font.
// This factor doesn't directly apply to the existing
// spacing between each character, it rather adds a fixed
// space between them which is calculated from the font
// metrics and the character size.
// Note that factors below 1 (including negative numbers) bring
// characters closer to each other.
// By default the letter spacing factor is 1.
pub fn (t &Text) set_letter_spacing(spacingFactor f32) {
	unsafe {
		C.sfText_setLetterSpacing(&C.sfText(t), f32(spacingFactor))
	}
}

// set_style: set the style of a text
// You can pass a combination of one or more styles, for
// example TextBold | TextItalic.
// The default style is TextRegular.
pub fn (t &Text) set_style(style u32) {
	unsafe {
		C.sfText_setStyle(&C.sfText(t), u32(style))
	}
}

// set_color: set the fill color of a text
// By default, the text's fill color is opaque white.
// Setting the fill color to a transparent color with an outline
// will cause the outline to be displayed in the fill area of the text.
pub fn (t &Text) set_color(color Color) {
	unsafe {
		C.sfText_setColor(&C.sfText(t), C.sfColor(color))
	}
}

// set_fill_color: set the fill color of a text
// By default, the text's fill color is opaque white.
// Setting the fill color to a transparent color with an outline
// will cause the outline to be displayed in the fill area of the text.
pub fn (t &Text) set_fill_color(color Color) {
	unsafe {
		C.sfText_setFillColor(&C.sfText(t), C.sfColor(color))
	}
}

// set_outline_color: set the outline color of the text
// By default, the text's outline color is opaque black.
pub fn (t &Text) set_outline_color(color Color) {
	unsafe {
		C.sfText_setOutlineColor(&C.sfText(t), C.sfColor(color))
	}
}

// set_outline_thickness: set the thickness of the text's outline
// By default, the outline thickness is 0.
// Be aware that using a negative value for the outline
// thickness will cause distorted rendering.
pub fn (t &Text) set_outline_thickness(thickness f32) {
	unsafe {
		C.sfText_setOutlineThickness(&C.sfText(t), f32(thickness))
	}
}

// get_string: get the string of a text (returns an ANSI string)
pub fn (t &Text) get_string() string {
	unsafe {
		return cstring_to_vstring(C.sfText_getString(&C.sfText(t)))
	}
}

// get_unicode_string: get the string of a text (returns a unicode string)
pub fn (t &Text) get_unicode_string() ?&u32 {
	unsafe {
		result := &u32(C.sfText_getUnicodeString(&C.sfText(t)))
		if voidptr(result) == C.NULL {
			return error('get_unicode_string failed')
		}
		return result
	}
}

// get_font: get the font used by a text
// If the text has no font attached, a NULL pointer is returned.
// The returned pointer is const, which means that you can't
// modify the font when you retrieve it with this function.
pub fn (t &Text) get_font() ?&Font {
	unsafe {
		result := &Font(C.sfText_getFont(&C.sfText(t)))
		if voidptr(result) == C.NULL {
			return error('get_font failed')
		}
		return result
	}
}

// get_letter_spacing: get the size of the letter spacing factor
pub fn (t &Text) get_letter_spacing() f32 {
	unsafe {
		return f32(C.sfText_getLetterSpacing(&C.sfText(t)))
	}
}

// get_line_spacing: get the size of the line spacing factor
pub fn (t &Text) get_line_spacing() f32 {
	unsafe {
		return f32(C.sfText_getLineSpacing(&C.sfText(t)))
	}
}

// get_style: get the style of a text
pub fn (t &Text) get_style() u32 {
	unsafe {
		return u32(C.sfText_getStyle(&C.sfText(t)))
	}
}

// get_color: get the fill color of a text
pub fn (t &Text) get_color() Color {
	unsafe {
		return Color(C.sfText_getColor(&C.sfText(t)))
	}
}

// get_fill_color: get the fill color of a text
pub fn (t &Text) get_fill_color() Color {
	unsafe {
		return Color(C.sfText_getFillColor(&C.sfText(t)))
	}
}

// get_outline_color: get the outline color of a text
pub fn (t &Text) get_outline_color() Color {
	unsafe {
		return Color(C.sfText_getOutlineColor(&C.sfText(t)))
	}
}

// get_outline_thickness: get the outline thickness of a text
pub fn (t &Text) get_outline_thickness() f32 {
	unsafe {
		return f32(C.sfText_getOutlineThickness(&C.sfText(t)))
	}
}

// find_character_pos: return the position of the index-th character in a text
// This function computes the visual position of a character
// from its index in the string. The returned position is
// in global coordinates (translation, rotation, scale and
// origin are applied).
// If index is out of range, the position of the end of
// the string is returned.
pub fn (t &Text) find_character_pos(index u64) system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfText_findCharacterPos(&C.sfText(t), size_t(index)))
	}
}

// get_local_bounds: get the local bounding rectangle of a text
// The returned rectangle is in local coordinates, which means
// that it ignores the transformations (translation, rotation,
// scale, ...) that are applied to the entity.
// In other words, this function returns the bounds of the
// entity in the entity's coordinate system.
pub fn (t &Text) get_local_bounds() FloatRect {
	unsafe {
		return FloatRect(C.sfText_getLocalBounds(&C.sfText(t)))
	}
}

// get_global_bounds: get the global bounding rectangle of a text
// The returned rectangle is in global coordinates, which means
// that it takes in account the transformations (translation,
// rotation, scale, ...) that are applied to the entity.
// In other words, this function returns the bounds of the
// text in the global 2D world's coordinate system.
pub fn (t &Text) get_global_bounds() FloatRect {
	unsafe {
		return FloatRect(C.sfText_getGlobalBounds(&C.sfText(t)))
	}
}
