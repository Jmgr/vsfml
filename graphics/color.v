module graphics

#include <SFML/Graphics/Color.h>

[typedef]
struct C.sfColor {
pub:
	r byte
	g byte
	b byte
	a byte
}

// Color: utility class for manpulating RGBA colors
pub type Color = C.sfColor

fn C.sfColor_fromRGB(byte, byte, byte) C.sfColor
fn C.sfColor_fromRGBA(byte, byte, byte, byte) C.sfColor
fn C.sfColor_fromInteger(u32) C.sfColor
fn C.sfColor_toInteger(C.sfColor) u32
fn C.sfColor_add(C.sfColor, C.sfColor) C.sfColor
fn C.sfColor_subtract(C.sfColor, C.sfColor) C.sfColor
fn C.sfColor_modulate(C.sfColor, C.sfColor) C.sfColor

// color_from_rgb: construct a color from its 3 RGB components
pub fn color_from_rgb(red byte, green byte, blue byte) Color {
	unsafe {
		return Color(C.sfColor_fromRGB(byte(red), byte(green), byte(blue)))
	}
}

// color_from_rgba: construct a color from its 4 RGBA components
pub fn color_from_rgba(red byte, green byte, blue byte, alpha byte) Color {
	unsafe {
		return Color(C.sfColor_fromRGBA(byte(red), byte(green), byte(blue), byte(alpha)))
	}
}

// color_from_integer: construct the color from 32-bit unsigned integer
pub fn color_from_integer(color u32) Color {
	unsafe {
		return Color(C.sfColor_fromInteger(u32(color)))
	}
}

// to_integer: convert a color to a 32-bit unsigned integer
pub fn (c Color) to_integer() u32 {
	unsafe {
		return u32(C.sfColor_toInteger(*&C.sfColor(&c)))
	}
}

// add: add two colors
pub fn (c Color) add(color2 Color) Color {
	unsafe {
		return Color(C.sfColor_add(*&C.sfColor(&c), *&C.sfColor(&color2)))
	}
}

// subtract: subtract two colors
pub fn (c Color) subtract(color2 Color) Color {
	unsafe {
		return Color(C.sfColor_subtract(*&C.sfColor(&c), *&C.sfColor(&color2)))
	}
}

// modulate: modulate two colors
pub fn (c Color) modulate(color2 Color) Color {
	unsafe {
		return Color(C.sfColor_modulate(*&C.sfColor(&c), *&C.sfColor(&color2)))
	}
}
