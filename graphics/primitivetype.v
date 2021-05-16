module graphics

#include <SFML/Graphics/PrimitiveType.h>

// PrimitiveType: types of primitives that a sf::VertexArray can render
// Points and lines have no area, therefore their thickness
// will always be 1 pixel, regardless the current transform
// and view.
pub enum PrimitiveType {
	points // List of individual points
	lines // List of individual lines
	line_strip // List of connected lines, a point uses the previous point to form a line
	triangles // List of individual triangles
	triangle_strip // List of connected triangles, a point uses the two previous points to form a triangle
	triangle_fan // List of connected triangles, a point uses the common center and the previous point to form a triangle
	quads // List of individual quads
}
