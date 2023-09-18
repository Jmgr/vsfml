module system

#include <SFML/System/Vector3.h>

[typedef]
pub struct C.sfVector3f {
pub:
	x f32
	y f32
	z f32
}

// Vector3f: 3-component vector of floats
pub type Vector3f = C.sfVector3f
