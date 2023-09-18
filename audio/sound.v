module audio

import vsfml.system

#include <SFML/Audio/Sound.h>

fn C.sfSound_create() &C.sfSound
fn C.sfSound_copy(&C.sfSound) &C.sfSound
fn C.sfSound_destroy(&C.sfSound)
fn C.sfSound_play(&C.sfSound)
fn C.sfSound_pause(&C.sfSound)
fn C.sfSound_stop(&C.sfSound)
fn C.sfSound_setBuffer(&C.sfSound, &C.sfSoundBuffer)
fn C.sfSound_getBuffer(&C.sfSound) &C.sfSoundBuffer
fn C.sfSound_setLoop(&C.sfSound, int)
fn C.sfSound_getLoop(&C.sfSound) int
fn C.sfSound_getStatus(&C.sfSound) C.sfSoundStatus
fn C.sfSound_setPitch(&C.sfSound, f32)
fn C.sfSound_setVolume(&C.sfSound, f32)
fn C.sfSound_setPosition(&C.sfSound, C.sfVector3f)
fn C.sfSound_setRelativeToListener(&C.sfSound, int)
fn C.sfSound_setMinDistance(&C.sfSound, f32)
fn C.sfSound_setAttenuation(&C.sfSound, f32)
fn C.sfSound_setPlayingOffset(&C.sfSound, C.sfTime)
fn C.sfSound_getPitch(&C.sfSound) f32
fn C.sfSound_getVolume(&C.sfSound) f32
fn C.sfSound_getPosition(&C.sfSound) C.sfVector3f
fn C.sfSound_isRelativeToListener(&C.sfSound) int
fn C.sfSound_getMinDistance(&C.sfSound) f32
fn C.sfSound_getAttenuation(&C.sfSound) f32
fn C.sfSound_getPlayingOffset(&C.sfSound) C.sfTime

// new_sound: create a new sound
pub fn new_sound() !&Sound {
	unsafe {
		result := &Sound(C.sfSound_create())
		if voidptr(result) == C.NULL {
			return error('new_sound failed')
		}
		return result
	}
}

// copy: create a new sound by copying an existing one
pub fn (s &Sound) copy() !&Sound {
	unsafe {
		result := &Sound(C.sfSound_copy(&C.sfSound(s)))
		if voidptr(result) == C.NULL {
			return error('copy failed')
		}
		return result
	}
}

// free: destroy a sound
[unsafe]
pub fn (s &Sound) free() {
	unsafe {
		C.sfSound_destroy(&C.sfSound(s))
	}
}

// play: start or resume playing a sound
// This function starts the sound if it was stopped, resumes
// it if it was paused, and restarts it from beginning if it
// was it already playing.
// This function uses its own thread so that it doesn't block
// the rest of the program while the sound is played.
pub fn (s &Sound) play() {
	unsafe {
		C.sfSound_play(&C.sfSound(s))
	}
}

// pause: pause a sound
// This function pauses the sound if it was playing,
// otherwise (sound already paused or stopped) it has no effect.
pub fn (s &Sound) pause() {
	unsafe {
		C.sfSound_pause(&C.sfSound(s))
	}
}

// stop: stop playing a sound
// This function stops the sound if it was playing or paused,
// and does nothing if it was already stopped.
// It also resets the playing position (unlike pause).
pub fn (s &Sound) stop() {
	unsafe {
		C.sfSound_stop(&C.sfSound(s))
	}
}

// set_buffer: set the source buffer containing the audio data to play
// It is important to note that the sound buffer is not copied,
// thus the SoundBuffer object must remain alive as long
// as it is attached to the sound.
pub fn (s &Sound) set_buffer(buffer &SoundBuffer) {
	unsafe {
		C.sfSound_setBuffer(&C.sfSound(s), &C.sfSoundBuffer(buffer))
	}
}

// get_buffer: get the audio buffer attached to a sound
pub fn (s &Sound) get_buffer() !&SoundBuffer {
	unsafe {
		result := &SoundBuffer(C.sfSound_getBuffer(&C.sfSound(s)))
		if voidptr(result) == C.NULL {
			return error('get_buffer failed')
		}
		return result
	}
}

// set_loop: set whether or not a sound should loop after reaching the end
// If set, the sound will restart from beginning after
// reaching the end and so on, until it is stopped or
// setLoop(sound, false) is called.
// The default looping state for sounds is false.
pub fn (s &Sound) set_loop(loop bool) {
	unsafe {
		C.sfSound_setLoop(&C.sfSound(s), int(loop))
	}
}

// get_loop: tell whether or not a sound is in loop mode
pub fn (s &Sound) get_loop() bool {
	unsafe {
		return C.sfSound_getLoop(&C.sfSound(s)) != 0
	}
}

// get_status: get the current status of a sound (stopped, paused, playing)
pub fn (s &Sound) get_status() SoundStatus {
	unsafe {
		return SoundStatus(C.sfSound_getStatus(&C.sfSound(s)))
	}
}

// set_pitch: set the pitch of a sound
// The pitch represents the perceived fundamental frequency
// of a sound; thus you can make a sound more acute or grave
// by changing its pitch. A side effect of changing the pitch
// is to modify the playing speed of the sound as well.
// The default value for the pitch is 1.
pub fn (s &Sound) set_pitch(pitch f32) {
	unsafe {
		C.sfSound_setPitch(&C.sfSound(s), f32(pitch))
	}
}

// set_volume: set the volume of a sound
// The volume is a value between 0 (mute) and 100 (full volume).
// The default value for the volume is 100.
pub fn (s &Sound) set_volume(volume f32) {
	unsafe {
		C.sfSound_setVolume(&C.sfSound(s), f32(volume))
	}
}

// set_position: set the 3D position of a sound in the audio scene
// Only sounds with one channel (mono sounds) can be
// spatialized.
// The default position of a sound is (0, 0, 0).
pub fn (s &Sound) set_position(position system.Vector3f) {
	unsafe {
		C.sfSound_setPosition(&C.sfSound(s), *&C.sfVector3f(&position))
	}
}

// set_relative_to_listener: make the sound's position relative to the listener or absolute
// Making a sound relative to the listener will ensure that it will always
// be played the same way regardless the position of the listener.
// This can be useful for non-spatialized sounds, sounds that are
// produced by the listener, or sounds attached to it.
// The default value is false (position is absolute).
pub fn (s &Sound) set_relative_to_listener(relative bool) {
	unsafe {
		C.sfSound_setRelativeToListener(&C.sfSound(s), int(relative))
	}
}

// set_min_distance: set the minimum distance of a sound
// The "minimum distance" of a sound is the maximum
// distance at which it is heard at its maximum volume. Further
// than the minimum distance, it will start to fade out according
// to its attenuation factor. A value of 0 ("inside the head
// of the listener") is an invalid value and is forbidden.
// The default value of the minimum distance is 1.
pub fn (s &Sound) set_min_distance(distance f32) {
	unsafe {
		C.sfSound_setMinDistance(&C.sfSound(s), f32(distance))
	}
}

// set_attenuation: set the attenuation factor of a sound
// The attenuation is a multiplicative factor which makes
// the sound more or less loud according to its distance
// from the listener. An attenuation of 0 will produce a
// non-attenuated sound, i.e. its volume will always be the same
// whether it is heard from near or from far. On the other hand,
// an attenuation value such as 100 will make the sound fade out
// very quickly as it gets further from the listener.
// The default value of the attenuation is 1.
pub fn (s &Sound) set_attenuation(attenuation f32) {
	unsafe {
		C.sfSound_setAttenuation(&C.sfSound(s), f32(attenuation))
	}
}

// set_playing_offset: change the current playing position of a sound
// The playing position can be changed when the sound is
// either paused or playing.
pub fn (s &Sound) set_playing_offset(timeOffset system.Time) {
	unsafe {
		C.sfSound_setPlayingOffset(&C.sfSound(s), *&C.sfTime(&timeOffset))
	}
}

// get_pitch: get the pitch of a sound
pub fn (s &Sound) get_pitch() f32 {
	unsafe {
		return f32(C.sfSound_getPitch(&C.sfSound(s)))
	}
}

// get_volume: get the volume of a sound
pub fn (s &Sound) get_volume() f32 {
	unsafe {
		return f32(C.sfSound_getVolume(&C.sfSound(s)))
	}
}

// get_position: get the 3D position of a sound in the audio scene
pub fn (s &Sound) get_position() system.Vector3f {
	unsafe {
		return system.Vector3f(C.sfSound_getPosition(&C.sfSound(s)))
	}
}

// is_relative_to_listener: tell whether a sound's position is relative to the
// listener or is absolute
pub fn (s &Sound) is_relative_to_listener() bool {
	unsafe {
		return C.sfSound_isRelativeToListener(&C.sfSound(s)) != 0
	}
}

// get_min_distance: get the minimum distance of a sound
pub fn (s &Sound) get_min_distance() f32 {
	unsafe {
		return f32(C.sfSound_getMinDistance(&C.sfSound(s)))
	}
}

// get_attenuation: get the attenuation factor of a sound
pub fn (s &Sound) get_attenuation() f32 {
	unsafe {
		return f32(C.sfSound_getAttenuation(&C.sfSound(s)))
	}
}

// get_playing_offset: get the current playing position of a sound
pub fn (s &Sound) get_playing_offset() system.Time {
	unsafe {
		return system.Time(C.sfSound_getPlayingOffset(&C.sfSound(s)))
	}
}
