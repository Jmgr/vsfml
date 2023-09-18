module audio

import vsfml.system

#include <SFML/Audio/SoundStream.h>

[typedef]
struct C.sfSoundStreamChunk {
pub:
	samples     &i16
	sampleCount int
}

// SoundStreamChunk: defines the data to fill by the OnGetData callback
pub type SoundStreamChunk = C.sfSoundStreamChunk

fn C.sfSoundStream_create(C.sfSoundStreamGetDataCallback, C.sfSoundStreamSeekCallback, u32, u32, voidptr) &C.sfSoundStream
fn C.sfSoundStream_destroy(&C.sfSoundStream)
fn C.sfSoundStream_play(&C.sfSoundStream)
fn C.sfSoundStream_pause(&C.sfSoundStream)
fn C.sfSoundStream_stop(&C.sfSoundStream)
fn C.sfSoundStream_getStatus(&C.sfSoundStream) C.sfSoundStatus
fn C.sfSoundStream_setPitch(&C.sfSoundStream, f32)
fn C.sfSoundStream_setVolume(&C.sfSoundStream, f32)
fn C.sfSoundStream_setPosition(&C.sfSoundStream, C.sfVector3f)
fn C.sfSoundStream_setRelativeToListener(&C.sfSoundStream, int)
fn C.sfSoundStream_setMinDistance(&C.sfSoundStream, f32)
fn C.sfSoundStream_setAttenuation(&C.sfSoundStream, f32)
fn C.sfSoundStream_setPlayingOffset(&C.sfSoundStream, C.sfTime)
fn C.sfSoundStream_setLoop(&C.sfSoundStream, int)
fn C.sfSoundStream_getPitch(&C.sfSoundStream) f32
fn C.sfSoundStream_getVolume(&C.sfSoundStream) f32
fn C.sfSoundStream_getPosition(&C.sfSoundStream) C.sfVector3f
fn C.sfSoundStream_isRelativeToListener(&C.sfSoundStream) int
fn C.sfSoundStream_getMinDistance(&C.sfSoundStream) f32
fn C.sfSoundStream_getAttenuation(&C.sfSoundStream) f32
fn C.sfSoundStream_getLoop(&C.sfSoundStream) int
fn C.sfSoundStream_getPlayingOffset(&C.sfSoundStream) C.sfTime

pub type SoundStreamGetDataCallback = fn (&C.sfSoundStreamChunk, voidptr) int // Type of the callback used to get a sound stream data

pub type SoundStreamSeekCallback = fn (C.sfTime, voidptr) // Type of the callback used to seek in a sound stream

// new_sound_stream: create a new sound stream
pub fn new_sound_stream(params SoundStreamNewSoundStreamParams) !&SoundStream {
	unsafe {
		result := &SoundStream(C.sfSoundStream_create(*&C.sfSoundStreamGetDataCallback(&params.on_get_data),
			*&C.sfSoundStreamSeekCallback(&params.on_seek), u32(params.channel_count),
			u32(params.sample_rate), voidptr(params.user_data)))
		if voidptr(result) == C.NULL {
			return error('new_sound_stream failed with on_get_data=${params.on_get_data} on_seek=${params.on_seek} channel_count=${params.channel_count} sample_rate=${params.sample_rate}')
		}
		return result
	}
}

// SoundStreamNewSoundStreamParams: parameters for new_sound_stream
pub struct SoundStreamNewSoundStreamParams {
pub:
	on_get_data   SoundStreamGetDataCallback [required] // function called when the stream needs more data (can't be NULL)
	on_seek       SoundStreamSeekCallback    [required]    // function called when the stream seeks (can't be NULL)
	channel_count u32                        [required] // number of channels to use (1 = mono, 2 = stereo)
	sample_rate   u32                        [required] // sample rate of the sound (44100 = CD quality)
	user_data     voidptr // data to pass to the callback functions
}

// free: destroy a sound stream
[unsafe]
pub fn (s &SoundStream) free() {
	unsafe {
		C.sfSoundStream_destroy(&C.sfSoundStream(s))
	}
}

// play: start or resume playing a sound stream
// This function starts the stream if it was stopped, resumes
// it if it was paused, and restarts it from beginning if it
// was it already playing.
// This function uses its own thread so that it doesn't block
// the rest of the program while the music is played.
pub fn (s &SoundStream) play() {
	unsafe {
		C.sfSoundStream_play(&C.sfSoundStream(s))
	}
}

// pause: pause a sound stream
// This function pauses the stream if it was playing,
// otherwise (stream already paused or stopped) it has no effect.
pub fn (s &SoundStream) pause() {
	unsafe {
		C.sfSoundStream_pause(&C.sfSoundStream(s))
	}
}

// stop: stop playing a sound stream
// This function stops the stream if it was playing or paused,
// and does nothing if it was already stopped.
// It also resets the playing position (unlike pause).
pub fn (s &SoundStream) stop() {
	unsafe {
		C.sfSoundStream_stop(&C.sfSoundStream(s))
	}
}

// get_status: get the current status of a sound stream (stopped, paused, playing)
pub fn (s &SoundStream) get_status() SoundStatus {
	unsafe {
		return SoundStatus(C.sfSoundStream_getStatus(&C.sfSoundStream(s)))
	}
}

// set_pitch: set the pitch of a sound stream
// The pitch represents the perceived fundamental frequency
// of a sound; thus you can make a stream more acute or grave
// by changing its pitch. A side effect of changing the pitch
// is to modify the playing speed of the stream as well.
// The default value for the pitch is 1.
pub fn (s &SoundStream) set_pitch(pitch f32) {
	unsafe {
		C.sfSoundStream_setPitch(&C.sfSoundStream(s), f32(pitch))
	}
}

// set_volume: set the volume of a sound stream
// The volume is a value between 0 (mute) and 100 (full volume).
// The default value for the volume is 100.
pub fn (s &SoundStream) set_volume(volume f32) {
	unsafe {
		C.sfSoundStream_setVolume(&C.sfSoundStream(s), f32(volume))
	}
}

// set_position: set the 3D position of a sound stream in the audio scene
// Only streams with one channel (mono streams) can be
// spatialized.
// The default position of a stream is (0, 0, 0).
pub fn (s &SoundStream) set_position(position system.Vector3f) {
	unsafe {
		C.sfSoundStream_setPosition(&C.sfSoundStream(s), *&C.sfVector3f(&position))
	}
}

// set_relative_to_listener: make a sound stream's position relative to the listener or absolute
// Making a stream relative to the listener will ensure that it will always
// be played the same way regardless the position of the listener.
// This can be useful for non-spatialized streams, streams that are
// produced by the listener, or streams attached to it.
// The default value is false (position is absolute).
pub fn (s &SoundStream) set_relative_to_listener(relative bool) {
	unsafe {
		C.sfSoundStream_setRelativeToListener(&C.sfSoundStream(s), int(relative))
	}
}

// set_min_distance: set the minimum distance of a sound stream
// The "minimum distance" of a stream is the maximum
// distance at which it is heard at its maximum volume. Further
// than the minimum distance, it will start to fade out according
// to its attenuation factor. A value of 0 ("inside the head
// of the listener") is an invalid value and is forbidden.
// The default value of the minimum distance is 1.
pub fn (s &SoundStream) set_min_distance(distance f32) {
	unsafe {
		C.sfSoundStream_setMinDistance(&C.sfSoundStream(s), f32(distance))
	}
}

// set_attenuation: set the attenuation factor of a sound stream
// The attenuation is a multiplicative factor which makes
// the stream more or less loud according to its distance
// from the listener. An attenuation of 0 will produce a
// non-attenuated stream, i.e. its volume will always be the same
// whether it is heard from near or from far. On the other hand,
// an attenuation value such as 100 will make the stream fade out
// very quickly as it gets further from the listener.
// The default value of the attenuation is 1.
pub fn (s &SoundStream) set_attenuation(attenuation f32) {
	unsafe {
		C.sfSoundStream_setAttenuation(&C.sfSoundStream(s), f32(attenuation))
	}
}

// set_playing_offset: change the current playing position of a sound stream
// The playing position can be changed when the stream is
// either paused or playing.
pub fn (s &SoundStream) set_playing_offset(timeOffset system.Time) {
	unsafe {
		C.sfSoundStream_setPlayingOffset(&C.sfSoundStream(s), *&C.sfTime(&timeOffset))
	}
}

// set_loop: set whether or not a sound stream should loop after reaching the end
// If set, the stream will restart from beginning after
// reaching the end and so on, until it is stopped or
// setLoop(stream, false) is called.
// The default looping state for sound streams is false.
pub fn (s &SoundStream) set_loop(loop bool) {
	unsafe {
		C.sfSoundStream_setLoop(&C.sfSoundStream(s), int(loop))
	}
}

// get_pitch: get the pitch of a sound stream
pub fn (s &SoundStream) get_pitch() f32 {
	unsafe {
		return f32(C.sfSoundStream_getPitch(&C.sfSoundStream(s)))
	}
}

// get_volume: get the volume of a sound stream
pub fn (s &SoundStream) get_volume() f32 {
	unsafe {
		return f32(C.sfSoundStream_getVolume(&C.sfSoundStream(s)))
	}
}

// get_position: get the 3D position of a sound stream in the audio scene
pub fn (s &SoundStream) get_position() system.Vector3f {
	unsafe {
		return system.Vector3f(C.sfSoundStream_getPosition(&C.sfSoundStream(s)))
	}
}

// is_relative_to_listener: tell whether a sound stream's position is relative to the
// listener or is absolute
pub fn (s &SoundStream) is_relative_to_listener() bool {
	unsafe {
		return C.sfSoundStream_isRelativeToListener(&C.sfSoundStream(s)) != 0
	}
}

// get_min_distance: get the minimum distance of a sound stream
pub fn (s &SoundStream) get_min_distance() f32 {
	unsafe {
		return f32(C.sfSoundStream_getMinDistance(&C.sfSoundStream(s)))
	}
}

// get_attenuation: get the attenuation factor of a sound stream
pub fn (s &SoundStream) get_attenuation() f32 {
	unsafe {
		return f32(C.sfSoundStream_getAttenuation(&C.sfSoundStream(s)))
	}
}

// get_loop: tell whether or not a sound stream is in loop mode
pub fn (s &SoundStream) get_loop() bool {
	unsafe {
		return C.sfSoundStream_getLoop(&C.sfSoundStream(s)) != 0
	}
}

// get_playing_offset: get the current playing position of a sound stream
pub fn (s &SoundStream) get_playing_offset() system.Time {
	unsafe {
		return system.Time(C.sfSoundStream_getPlayingOffset(&C.sfSoundStream(s)))
	}
}
