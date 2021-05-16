module graphics

#include <SFML/Graphics/Vertex.h>

[typedef]
struct C.sfVertex {
pub:
	position  C.sfVector2f
	color     C.sfColor
	texCoords C.sfVector2f
}

// Vertex: define a point with color and texture coordinates
pub type Vertex = C.sfVertex
