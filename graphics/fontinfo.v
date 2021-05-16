module graphics

#include <SFML/Graphics/FontInfo.h>

[typedef]
struct C.sfFontInfo {
pub:
	family &char
}

// FontInfo: holds various information about a font
pub type FontInfo = C.sfFontInfo
