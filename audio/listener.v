module audio

import system

#include <SFML/Audio/Listener.h>

fn C.sfListener_setGlobalVolume(f32)
fn C.sfListener_getGlobalVolume() f32
fn C.sfListener_setPosition(C.sfVector3f)
fn C.sfListener_getPosition() C.sfVector3f
fn C.sfListener_setDirection(C.sfVector3f)
fn C.sfListener_getDirection() C.sfVector3f
fn C.sfListener_setUpVector(C.sfVector3f)
fn C.sfListener_getUpVector() C.sfVector3f

// listener_set_global_volume: change the global volume of all the sounds and musics
// The volume is a number between 0 and 100; it is combined with
// the individual volume of each sound / music.
// The default value for the volume is 100 (maximum).
pub fn listener_set_global_volume(volume f32) {
	unsafe {
		C.sfListener_setGlobalVolume(f32(volume))
	}
}

// listener_get_global_volume: get the current value of the global volume
pub fn listener_get_global_volume() f32 {
	unsafe {
		return f32(C.sfListener_getGlobalVolume())
	}
}

// listener_set_position: set the position of the listener in the scene
// The default listener's position is (0, 0, 0).
pub fn listener_set_position(position system.Vector3f) {
	unsafe {
		C.sfListener_setPosition(C.sfVector3f(position))
	}
}

// listener_get_position: get the current position of the listener in the scene
pub fn listener_get_position() system.Vector3f {
	unsafe {
		return system.Vector3f(C.sfListener_getPosition())
	}
}

// listener_set_direction: set the orientation of the forward vector in the scene
// The direction (also called "at vector") is the vector
// pointing forward from the listener's perspective. Together
// with the up vector, it defines the 3D orientation of the
// listener in the scene. The direction vector doesn't
// have to be normalized.
// The default listener's direction is (0, 0, -1).
pub fn listener_set_direction(direction system.Vector3f) {
	unsafe {
		C.sfListener_setDirection(C.sfVector3f(direction))
	}
}

// listener_get_direction: get the current forward vector of the listener in the scene
pub fn listener_get_direction() system.Vector3f {
	unsafe {
		return system.Vector3f(C.sfListener_getDirection())
	}
}

// listener_set_up_vector: set the upward vector of the listener in the scene
// The up vector is the vector that points upward from the
// listener's perspective. Together with the direction, it
// defines the 3D orientation of the listener in the scene.
// The up vector doesn't have to be normalized.
// The default listener's up vector is (0, 1, 0). It is usually
// not necessary to change it, especially in 2D scenarios.
pub fn listener_set_up_vector(upVector system.Vector3f) {
	unsafe {
		C.sfListener_setUpVector(C.sfVector3f(upVector))
	}
}

// listener_get_up_vector: get the current upward vector of the listener in the scene
pub fn listener_get_up_vector() system.Vector3f {
	unsafe {
		return system.Vector3f(C.sfListener_getUpVector())
	}
}
