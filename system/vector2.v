module system

#include <SFML/System/Vector2.h>

[typedef]
struct C.sfVector2i {
pub:
	x int
	y int
}

// Vector2i: 2-component vector of integers
pub type Vector2i = C.sfVector2i

[typedef]
struct C.sfVector2u {
pub:
	x int
	y int
}

// Vector2u: 2-component vector of unsigned integers
pub type Vector2u = C.sfVector2u

[typedef]
struct C.sfVector2f {
pub:
	x f32
	y f32
}

// Vector2f: 2-component vector of floats
pub type Vector2f = C.sfVector2f
