module graphics

#include <SFML/Graphics/Glsl.h>

pub type GlslVec2 = C.sfVector2f
pub type GlslIvec2 = C.sfVector2i
pub type GlslVec3 = C.sfVector3f

[typedef]
struct C.sfGlslBvec2 {
pub:
	x int
	y int
}

// GlslBvec2
pub type GlslBvec2 = C.sfGlslBvec2

[typedef]
struct C.sfGlslIvec3 {
pub:
	x int
	y int
	z int
}

// GlslIvec3
pub type GlslIvec3 = C.sfGlslIvec3

[typedef]
struct C.sfGlslBvec3 {
pub:
	x int
	y int
	z int
}

// GlslBvec3
pub type GlslBvec3 = C.sfGlslBvec3

[typedef]
struct C.sfGlslVec4 {
pub:
	x f32
	y f32
	z f32
	w f32
}

// GlslVec4
pub type GlslVec4 = C.sfGlslVec4

[typedef]
struct C.sfGlslIvec4 {
pub:
	x int
	y int
	z int
	w int
}

// GlslIvec4
pub type GlslIvec4 = C.sfGlslIvec4

[typedef]
struct C.sfGlslBvec4 {
pub:
	x int
	y int
	z int
	w int
}

// GlslBvec4
pub type GlslBvec4 = C.sfGlslBvec4

[typedef]
struct C.sfGlslMat3 {
}

// GlslMat3
pub type GlslMat3 = C.sfGlslMat3

[typedef]
struct C.sfGlslMat4 {
}

// GlslMat4
pub type GlslMat4 = C.sfGlslMat4
