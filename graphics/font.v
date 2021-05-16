module graphics

import system

#include <SFML/Graphics/Font.h>

fn C.sfFont_createFromFile(&char) &C.sfFont
fn C.sfFont_createFromMemory(voidptr, size_t) &C.sfFont
fn C.sfFont_createFromStream(&C.sfInputStream) &C.sfFont
fn C.sfFont_copy(&C.sfFont) &C.sfFont
fn C.sfFont_destroy(&C.sfFont)
fn C.sfFont_getGlyph(&C.sfFont, u32, u32, int, f32) C.sfGlyph
fn C.sfFont_getKerning(&C.sfFont, u32, u32, u32) f32
fn C.sfFont_getLineSpacing(&C.sfFont, u32) f32
fn C.sfFont_getUnderlinePosition(&C.sfFont, u32) f32
fn C.sfFont_getUnderlineThickness(&C.sfFont, u32) f32
fn C.sfFont_getTexture(&C.sfFont, u32) &C.sfTexture
fn C.sfFont_getInfo(&C.sfFont) C.sfFontInfo

// new_font_from_file: create a new font from a file
pub fn new_font_from_file(params FontNewFontFromFileParams) ?&Font {
	unsafe {
		result := &Font(C.sfFont_createFromFile(params.filename.str))
		if voidptr(result) == C.NULL {
			return error('new_font_from_file failed with filename=$params.filename')
		}
		return result
	}
}

// FontNewFontFromFileParams: parameters for new_font_from_file
pub struct FontNewFontFromFileParams {
pub:
	filename string [required] // path of the font file to load
}

// new_font_from_memory: create a new image font a file in memory
pub fn new_font_from_memory(params FontNewFontFromMemoryParams) ?&Font {
	unsafe {
		result := &Font(C.sfFont_createFromMemory(voidptr(params.data), size_t(params.size_in_bytes)))
		if voidptr(result) == C.NULL {
			return error('new_font_from_memory failed with size_in_bytes=$params.size_in_bytes')
		}
		return result
	}
}

// FontNewFontFromMemoryParams: parameters for new_font_from_memory
pub struct FontNewFontFromMemoryParams {
pub:
	data          voidptr [required] // pointer to the file data in memory
	size_in_bytes u64     [required] // size of the data to load, in bytes
}

// new_font_from_stream: create a new image font a custom stream
pub fn new_font_from_stream(params FontNewFontFromStreamParams) ?&Font {
	unsafe {
		result := &Font(C.sfFont_createFromStream(&C.sfInputStream(params.stream)))
		if voidptr(result) == C.NULL {
			return error('new_font_from_stream failed')
		}
		return result
	}
}

// FontNewFontFromStreamParams: parameters for new_font_from_stream
pub struct FontNewFontFromStreamParams {
pub:
	stream &system.InputStream [required] // source stream to read from
}

// copy: copy an existing font
pub fn (f &Font) copy() ?&Font {
	unsafe {
		result := &Font(C.sfFont_copy(&C.sfFont(f)))
		if voidptr(result) == C.NULL {
			return error('copy failed')
		}
		return result
	}
}

// free: destroy an existing font
[unsafe]
pub fn (f &Font) free() {
	unsafe {
		C.sfFont_destroy(&C.sfFont(f))
	}
}

// get_glyph: get a glyph in a font
pub fn (f &Font) get_glyph(params FontGetGlyphParams) Glyph {
	unsafe {
		return Glyph(C.sfFont_getGlyph(&C.sfFont(f), u32(params.code_point), u32(params.character_size),
			int(params.bold), f32(params.outline_thickness)))
	}
}

// FontGetGlyphParams: parameters for get_glyph
pub struct FontGetGlyphParams {
pub:
	code_point        u32  [required] // unicode code point of the character to get
	character_size    u32  [required] // character size, in pixels
	bold              bool [required] // retrieve the bold version or the regular one?
	outline_thickness f32  [required] // thickness of outline (when != 0 the glyph will not be filled)
}

// get_kerning: get the kerning value corresponding to a given pair of characters in a font
pub fn (f &Font) get_kerning(params FontGetKerningParams) f32 {
	unsafe {
		return f32(C.sfFont_getKerning(&C.sfFont(f), u32(params.first), u32(params.second),
			u32(params.character_size)))
	}
}

// FontGetKerningParams: parameters for get_kerning
pub struct FontGetKerningParams {
pub:
	first          u32 [required] // unicode code point of the first character
	second         u32 [required] // unicode code point of the second character
	character_size u32 [required] // character size, in pixels
}

// get_line_spacing: get the line spacing value
pub fn (f &Font) get_line_spacing(characterSize u32) f32 {
	unsafe {
		return f32(C.sfFont_getLineSpacing(&C.sfFont(f), u32(characterSize)))
	}
}

// get_underline_position: get the position of the underline
// Underline position is the vertical offset to apply between the
// baseline and the underline.
pub fn (f &Font) get_underline_position(characterSize u32) f32 {
	unsafe {
		return f32(C.sfFont_getUnderlinePosition(&C.sfFont(f), u32(characterSize)))
	}
}

// get_underline_thickness: get the thickness of the underline
// Underline thickness is the vertical size of the underline.
pub fn (f &Font) get_underline_thickness(characterSize u32) f32 {
	unsafe {
		return f32(C.sfFont_getUnderlineThickness(&C.sfFont(f), u32(characterSize)))
	}
}

// get_texture: get the texture containing the glyphs of a given size in a font
pub fn (f &Font) get_texture(characterSize u32) ?&Texture {
	unsafe {
		result := &Texture(C.sfFont_getTexture(&C.sfFont(f), u32(characterSize)))
		if voidptr(result) == C.NULL {
			return error('get_texture failed with characterSize=$characterSize')
		}
		return result
	}
}

// get_info: get the font information
// The returned structure will remain valid only if the font
// is still valid. If the font is invalid an invalid structure
// is returned.
pub fn (f &Font) get_info() FontInfo {
	unsafe {
		return FontInfo(C.sfFont_getInfo(&C.sfFont(f)))
	}
}
