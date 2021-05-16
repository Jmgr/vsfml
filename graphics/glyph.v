module graphics

#include <SFML/Graphics/Glyph.h>

[typedef]
struct C.sfGlyph {
pub:
	advance     f32
	bounds      C.sfFloatRect
	textureRect C.sfIntRect
}

// Glyph: describes a glyph (a visual character)
pub type Glyph = C.sfGlyph
