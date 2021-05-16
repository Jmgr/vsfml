module audio

import system

#include <SFML/Audio/SoundBuffer.h>

fn C.sfSoundBuffer_createFromFile(&char) &C.sfSoundBuffer
fn C.sfSoundBuffer_createFromMemory(voidptr, size_t) &C.sfSoundBuffer
fn C.sfSoundBuffer_createFromStream(&C.sfInputStream) &C.sfSoundBuffer
fn C.sfSoundBuffer_createFromSamples(&i16, u64, u32, u32) &C.sfSoundBuffer
fn C.sfSoundBuffer_copy(&C.sfSoundBuffer) &C.sfSoundBuffer
fn C.sfSoundBuffer_destroy(&C.sfSoundBuffer)
fn C.sfSoundBuffer_saveToFile(&C.sfSoundBuffer, &char) int
fn C.sfSoundBuffer_getSamples(&C.sfSoundBuffer) &i16
fn C.sfSoundBuffer_getSampleCount(&C.sfSoundBuffer) u64
fn C.sfSoundBuffer_getDuration(&C.sfSoundBuffer) C.sfTime

// new_sound_buffer_from_file: create a new sound buffer and load it from a file
// Here is a complete list of all the supported audio formats:
// ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam,
// w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
pub fn new_sound_buffer_from_file(params SoundBufferNewSoundBufferFromFileParams) ?&SoundBuffer {
	unsafe {
		result := &SoundBuffer(C.sfSoundBuffer_createFromFile(params.filename.str))
		if voidptr(result) == C.NULL {
			return error('new_sound_buffer_from_file failed with filename=$params.filename')
		}
		return result
	}
}

// SoundBufferNewSoundBufferFromFileParams: parameters for new_sound_buffer_from_file
pub struct SoundBufferNewSoundBufferFromFileParams {
pub:
	filename string [required] // path of the sound file to load
}

// new_sound_buffer_from_memory: create a new sound buffer and load it from a file in memory
// Here is a complete list of all the supported audio formats:
// ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam,
// w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
pub fn new_sound_buffer_from_memory(params SoundBufferNewSoundBufferFromMemoryParams) ?&SoundBuffer {
	unsafe {
		result := &SoundBuffer(C.sfSoundBuffer_createFromMemory(voidptr(params.data),
			size_t(params.size_in_bytes)))
		if voidptr(result) == C.NULL {
			return error('new_sound_buffer_from_memory failed with size_in_bytes=$params.size_in_bytes')
		}
		return result
	}
}

// SoundBufferNewSoundBufferFromMemoryParams: parameters for new_sound_buffer_from_memory
pub struct SoundBufferNewSoundBufferFromMemoryParams {
pub:
	data          voidptr [required] // pointer to the file data in memory
	size_in_bytes u64     [required] // size of the data to load, in bytes
}

// new_sound_buffer_from_stream: create a new sound buffer and load it from a custom stream
// Here is a complete list of all the supported audio formats:
// ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam,
// w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
pub fn new_sound_buffer_from_stream(params SoundBufferNewSoundBufferFromStreamParams) ?&SoundBuffer {
	unsafe {
		result := &SoundBuffer(C.sfSoundBuffer_createFromStream(&C.sfInputStream(params.stream)))
		if voidptr(result) == C.NULL {
			return error('new_sound_buffer_from_stream failed')
		}
		return result
	}
}

// SoundBufferNewSoundBufferFromStreamParams: parameters for new_sound_buffer_from_stream
pub struct SoundBufferNewSoundBufferFromStreamParams {
pub:
	stream &system.InputStream [required] // source stream to read from
}

// new_sound_buffer_from_samples: create a new sound buffer and load it from an array of samples in memory
// The assumed format of the audio samples is 16 bits signed integer
// (sfInt16).
pub fn new_sound_buffer_from_samples(params SoundBufferNewSoundBufferFromSamplesParams) ?&SoundBuffer {
	unsafe {
		result := &SoundBuffer(C.sfSoundBuffer_createFromSamples(&i16(params.samples),
			u64(params.sample_count), u32(params.channel_count), u32(params.sample_rate)))
		if voidptr(result) == C.NULL {
			return error('new_sound_buffer_from_samples failed with sample_count=$params.sample_count channel_count=$params.channel_count sample_rate=$params.sample_rate')
		}
		return result
	}
}

// SoundBufferNewSoundBufferFromSamplesParams: parameters for new_sound_buffer_from_samples
pub struct SoundBufferNewSoundBufferFromSamplesParams {
pub:
	samples       &i16 [required] // pointer to the array of samples in memory
	sample_count  u64  [required] // number of samples in the array
	channel_count u32  [required] // number of channels (1 = mono, 2 = stereo, ...)
	sample_rate   u32  [required] // sample rate (number of samples to play per second)
}

// copy: create a new sound buffer by copying an existing one
pub fn (s &SoundBuffer) copy() ?&SoundBuffer {
	unsafe {
		result := &SoundBuffer(C.sfSoundBuffer_copy(&C.sfSoundBuffer(s)))
		if voidptr(result) == C.NULL {
			return error('copy failed')
		}
		return result
	}
}

// free: destroy a sound buffer
[unsafe]
pub fn (s &SoundBuffer) free() {
	unsafe {
		C.sfSoundBuffer_destroy(&C.sfSoundBuffer(s))
	}
}

// save_to_file: save a sound buffer to an audio file
// Here is a complete list of all the supported audio formats:
// ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam,
// w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
pub fn (s &SoundBuffer) save_to_file(filename string) bool {
	unsafe {
		return C.sfSoundBuffer_saveToFile(&C.sfSoundBuffer(s), filename.str) != 0
	}
}

// get_samples: get the array of audio samples stored in a sound buffer
// The format of the returned samples is 16 bits signed integer
// (sfInt16). The total number of samples in this array
// is given by the getSampleCount function.
pub fn (s &SoundBuffer) get_samples() ?&i16 {
	unsafe {
		result := &i16(C.sfSoundBuffer_getSamples(&C.sfSoundBuffer(s)))
		if voidptr(result) == C.NULL {
			return error('get_samples failed')
		}
		return result
	}
}

// get_sample_count: get the number of samples stored in a sound buffer
// The array of samples can be accessed with the
// getSamples function.
pub fn (s &SoundBuffer) get_sample_count() u64 {
	unsafe {
		return u64(C.sfSoundBuffer_getSampleCount(&C.sfSoundBuffer(s)))
	}
}

// get_duration: get the total duration of a sound buffer
pub fn (s &SoundBuffer) get_duration() system.Time {
	unsafe {
		return system.Time(C.sfSoundBuffer_getDuration(&C.sfSoundBuffer(s)))
	}
}
