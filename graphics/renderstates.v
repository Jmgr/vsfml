module graphics

#include <SFML/Graphics/RenderStates.h>

[typedef]
struct C.sfRenderStates {
pub:
	blendMode C.sfBlendMode
	transform C.sfTransform
	texture   &C.sfTexture
	shader    &C.sfShader
}

// RenderStates: define the states used for drawing to a RenderTarget
pub type RenderStates = C.sfRenderStates
