module audio

import vsfml.system

#include <SFML/Audio/Music.h>

[typedef]
struct C.sfTimeSpan {
pub:
	offset C.sfTime
	length C.sfTime
}

// TimeSpan: structure defining a time range
pub type TimeSpan = C.sfTimeSpan

fn C.sfMusic_createFromFile(&char) &C.sfMusic
fn C.sfMusic_createFromMemory(voidptr, usize) &C.sfMusic
fn C.sfMusic_createFromStream(&C.sfInputStream) &C.sfMusic
fn C.sfMusic_destroy(&C.sfMusic)
fn C.sfMusic_setLoop(&C.sfMusic, int)
fn C.sfMusic_getLoop(&C.sfMusic) int
fn C.sfMusic_getDuration(&C.sfMusic) C.sfTime
fn C.sfMusic_getLoopPoints(&C.sfMusic) C.sfTimeSpan
fn C.sfMusic_setLoopPoints(&C.sfMusic, C.sfTimeSpan)
fn C.sfMusic_play(&C.sfMusic)
fn C.sfMusic_pause(&C.sfMusic)
fn C.sfMusic_stop(&C.sfMusic)
fn C.sfMusic_getStatus(&C.sfMusic) C.sfSoundStatus
fn C.sfMusic_getPlayingOffset(&C.sfMusic) C.sfTime
fn C.sfMusic_setPitch(&C.sfMusic, f32)
fn C.sfMusic_setVolume(&C.sfMusic, f32)
fn C.sfMusic_setPosition(&C.sfMusic, C.sfVector3f)
fn C.sfMusic_setRelativeToListener(&C.sfMusic, int)
fn C.sfMusic_setMinDistance(&C.sfMusic, f32)
fn C.sfMusic_setAttenuation(&C.sfMusic, f32)
fn C.sfMusic_setPlayingOffset(&C.sfMusic, C.sfTime)
fn C.sfMusic_getPitch(&C.sfMusic) f32
fn C.sfMusic_getVolume(&C.sfMusic) f32
fn C.sfMusic_getPosition(&C.sfMusic) C.sfVector3f
fn C.sfMusic_isRelativeToListener(&C.sfMusic) int
fn C.sfMusic_getMinDistance(&C.sfMusic) f32
fn C.sfMusic_getAttenuation(&C.sfMusic) f32

// new_music_from_file: create a new music and load it from a file
// This function doesn't start playing the music (call
// play to do so).
// Here is a complete list of all the supported audio formats:
// ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam,
// w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
pub fn new_music_from_file(params MusicNewMusicFromFileParams) !&Music {
	unsafe {
		result := &Music(C.sfMusic_createFromFile(params.filename.str))
		if voidptr(result) == C.NULL {
			return error('new_music_from_file failed with filename=${params.filename}')
		}
		return result
	}
}

// MusicNewMusicFromFileParams: parameters for new_music_from_file
pub struct MusicNewMusicFromFileParams {
pub:
	filename string [required] // path of the music file to open
}

// new_music_from_memory: create a new music and load it from a file in memory
// This function doesn't start playing the music (call
// play to do so).
// Here is a complete list of all the supported audio formats:
// ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam,
// w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
pub fn new_music_from_memory(params MusicNewMusicFromMemoryParams) !&Music {
	unsafe {
		result := &Music(C.sfMusic_createFromMemory(voidptr(params.data), usize(params.size_in_bytes)))
		if voidptr(result) == C.NULL {
			return error('new_music_from_memory failed with size_in_bytes=${params.size_in_bytes}')
		}
		return result
	}
}

// MusicNewMusicFromMemoryParams: parameters for new_music_from_memory
pub struct MusicNewMusicFromMemoryParams {
pub:
	data          voidptr [required] // pointer to the file data in memory
	size_in_bytes u64     [required]     // size of the data to load, in bytes
}

// new_music_from_stream: create a new music and load it from a custom stream
// This function doesn't start playing the music (call
// play to do so).
// Here is a complete list of all the supported audio formats:
// ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam,
// w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
pub fn new_music_from_stream(params MusicNewMusicFromStreamParams) !&Music {
	unsafe {
		result := &Music(C.sfMusic_createFromStream(&C.sfInputStream(params.stream)))
		if voidptr(result) == C.NULL {
			return error('new_music_from_stream failed')
		}
		return result
	}
}

// MusicNewMusicFromStreamParams: parameters for new_music_from_stream
pub struct MusicNewMusicFromStreamParams {
pub:
	stream &system.InputStream [required] // source stream to read from
}

// free: destroy a music
[unsafe]
pub fn (m &Music) free() {
	unsafe {
		C.sfMusic_destroy(&C.sfMusic(m))
	}
}

// set_loop: set whether or not a music should loop after reaching the end
// If set, the music will restart from beginning after
// reaching the end and so on, until it is stopped or
// setLoop(music, false) is called.
// The default looping state for musics is false.
pub fn (m &Music) set_loop(loop bool) {
	unsafe {
		C.sfMusic_setLoop(&C.sfMusic(m), int(loop))
	}
}

// get_loop: tell whether or not a music is in loop mode
pub fn (m &Music) get_loop() bool {
	unsafe {
		return C.sfMusic_getLoop(&C.sfMusic(m)) != 0
	}
}

// get_duration: get the total duration of a music
pub fn (m &Music) get_duration() system.Time {
	unsafe {
		return system.Time(C.sfMusic_getDuration(&C.sfMusic(m)))
	}
}

// get_loop_points: get the positions of the of the sound's looping sequence
pub fn (m &Music) get_loop_points() TimeSpan {
	unsafe {
		return TimeSpan(C.sfMusic_getLoopPoints(&C.sfMusic(m)))
	}
}

// set_loop_points: sets the beginning and end of the sound's looping sequence using sf::Time
// Loop points allow one to specify a pair of positions such that, when the music
// is enabled for looping, it will seamlessly seek to the beginning whenever it
// encounters the end. Valid ranges for timePoints.offset and timePoints.length are
// [0, Dur) and (0, Dur-offset] respectively, where Dur is the value returned by getDuration().
// Note that the EOF "loop point" from the end to the beginning of the stream is still honored,
// in case the caller seeks to a point after the end of the loop range. This function can be
// safely called at any point after a stream is opened, and will be applied to a playing sound
// without affecting the current playing offset.
pub fn (m &Music) set_loop_points(timePoints TimeSpan) {
	unsafe {
		C.sfMusic_setLoopPoints(&C.sfMusic(m), *&C.sfTimeSpan(&timePoints))
	}
}

// play: start or resume playing a music
// This function starts the music if it was stopped, resumes
// it if it was paused, and restarts it from beginning if it
// was it already playing.
// This function uses its own thread so that it doesn't block
// the rest of the program while the music is played.
pub fn (m &Music) play() {
	unsafe {
		C.sfMusic_play(&C.sfMusic(m))
	}
}

// pause: pause a music
// This function pauses the music if it was playing,
// otherwise (music already paused or stopped) it has no effect.
pub fn (m &Music) pause() {
	unsafe {
		C.sfMusic_pause(&C.sfMusic(m))
	}
}

// stop: stop playing a music
// This function stops the music if it was playing or paused,
// and does nothing if it was already stopped.
// It also resets the playing position (unlike pause).
pub fn (m &Music) stop() {
	unsafe {
		C.sfMusic_stop(&C.sfMusic(m))
	}
}

// get_status: get the current status of a music (stopped, paused, playing)
pub fn (m &Music) get_status() SoundStatus {
	unsafe {
		return SoundStatus(C.sfMusic_getStatus(&C.sfMusic(m)))
	}
}

// get_playing_offset: get the current playing position of a music
pub fn (m &Music) get_playing_offset() system.Time {
	unsafe {
		return system.Time(C.sfMusic_getPlayingOffset(&C.sfMusic(m)))
	}
}

// set_pitch: set the pitch of a music
// The pitch represents the perceived fundamental frequency
// of a sound; thus you can make a music more acute or grave
// by changing its pitch. A side effect of changing the pitch
// is to modify the playing speed of the music as well.
// The default value for the pitch is 1.
pub fn (m &Music) set_pitch(pitch f32) {
	unsafe {
		C.sfMusic_setPitch(&C.sfMusic(m), f32(pitch))
	}
}

// set_volume: set the volume of a music
// The volume is a value between 0 (mute) and 100 (full volume).
// The default value for the volume is 100.
pub fn (m &Music) set_volume(volume f32) {
	unsafe {
		C.sfMusic_setVolume(&C.sfMusic(m), f32(volume))
	}
}

// set_position: set the 3D position of a music in the audio scene
// Only musics with one channel (mono musics) can be
// spatialized.
// The default position of a music is (0, 0, 0).
pub fn (m &Music) set_position(position system.Vector3f) {
	unsafe {
		C.sfMusic_setPosition(&C.sfMusic(m), *&C.sfVector3f(&position))
	}
}

// set_relative_to_listener: make a musics's position relative to the listener or absolute
// Making a music relative to the listener will ensure that it will always
// be played the same way regardless the position of the listener.
// This can be useful for non-spatialized musics, musics that are
// produced by the listener, or musics attached to it.
// The default value is false (position is absolute).
pub fn (m &Music) set_relative_to_listener(relative bool) {
	unsafe {
		C.sfMusic_setRelativeToListener(&C.sfMusic(m), int(relative))
	}
}

// set_min_distance: set the minimum distance of a music
// The "minimum distance" of a music is the maximum
// distance at which it is heard at its maximum volume. Further
// than the minimum distance, it will start to fade out according
// to its attenuation factor. A value of 0 ("inside the head
// of the listener") is an invalid value and is forbidden.
// The default value of the minimum distance is 1.
pub fn (m &Music) set_min_distance(distance f32) {
	unsafe {
		C.sfMusic_setMinDistance(&C.sfMusic(m), f32(distance))
	}
}

// set_attenuation: set the attenuation factor of a music
// The attenuation is a multiplicative factor which makes
// the music more or less loud according to its distance
// from the listener. An attenuation of 0 will produce a
// non-attenuated music, i.e. its volume will always be the same
// whether it is heard from near or from far. On the other hand,
// an attenuation value such as 100 will make the music fade out
// very quickly as it gets further from the listener.
// The default value of the attenuation is 1.
pub fn (m &Music) set_attenuation(attenuation f32) {
	unsafe {
		C.sfMusic_setAttenuation(&C.sfMusic(m), f32(attenuation))
	}
}

// set_playing_offset: change the current playing position of a music
// The playing position can be changed when the music is
// either paused or playing.
pub fn (m &Music) set_playing_offset(timeOffset system.Time) {
	unsafe {
		C.sfMusic_setPlayingOffset(&C.sfMusic(m), *&C.sfTime(&timeOffset))
	}
}

// get_pitch: get the pitch of a music
pub fn (m &Music) get_pitch() f32 {
	unsafe {
		return f32(C.sfMusic_getPitch(&C.sfMusic(m)))
	}
}

// get_volume: get the volume of a music
pub fn (m &Music) get_volume() f32 {
	unsafe {
		return f32(C.sfMusic_getVolume(&C.sfMusic(m)))
	}
}

// get_position: get the 3D position of a music in the audio scene
pub fn (m &Music) get_position() system.Vector3f {
	unsafe {
		return system.Vector3f(C.sfMusic_getPosition(&C.sfMusic(m)))
	}
}

// is_relative_to_listener: tell whether a music's position is relative to the
// listener or is absolute
pub fn (m &Music) is_relative_to_listener() bool {
	unsafe {
		return C.sfMusic_isRelativeToListener(&C.sfMusic(m)) != 0
	}
}

// get_min_distance: get the minimum distance of a music
pub fn (m &Music) get_min_distance() f32 {
	unsafe {
		return f32(C.sfMusic_getMinDistance(&C.sfMusic(m)))
	}
}

// get_attenuation: get the attenuation factor of a music
pub fn (m &Music) get_attenuation() f32 {
	unsafe {
		return f32(C.sfMusic_getAttenuation(&C.sfMusic(m)))
	}
}
