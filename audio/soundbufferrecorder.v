module audio

#include <SFML/Audio/SoundBufferRecorder.h>

fn C.sfSoundBufferRecorder_create() &C.sfSoundBufferRecorder
fn C.sfSoundBufferRecorder_destroy(&C.sfSoundBufferRecorder)
fn C.sfSoundBufferRecorder_start(&C.sfSoundBufferRecorder, u32) int
fn C.sfSoundBufferRecorder_stop(&C.sfSoundBufferRecorder)
fn C.sfSoundBufferRecorder_getBuffer(&C.sfSoundBufferRecorder) &C.sfSoundBuffer
fn C.sfSoundBufferRecorder_setDevice(&C.sfSoundBufferRecorder, &char) int
fn C.sfSoundBufferRecorder_getDevice(&C.sfSoundBufferRecorder) &char

// new_sound_buffer_recorder: create a new sound buffer recorder
pub fn new_sound_buffer_recorder() ?&SoundBufferRecorder {
	unsafe {
		result := &SoundBufferRecorder(C.sfSoundBufferRecorder_create())
		if voidptr(result) == C.NULL {
			return error('new_sound_buffer_recorder failed')
		}
		return result
	}
}

// free: destroy a sound buffer recorder
[unsafe]
pub fn (s &SoundBufferRecorder) free() {
	unsafe {
		C.sfSoundBufferRecorder_destroy(&C.sfSoundBufferRecorder(s))
	}
}

// start: start the capture of a sound recorder recorder
// The sampleRate parameter defines the number of audio samples
// captured per second. The higher, the better the quality
// (for example, 44100 samples/sec is CD quality).
// This function uses its own thread so that it doesn't block
// the rest of the program while the capture runs.
// Please note that only one capture can happen at the same time.
pub fn (s &SoundBufferRecorder) start(sampleRate u32) bool {
	unsafe {
		return C.sfSoundBufferRecorder_start(&C.sfSoundBufferRecorder(s), u32(sampleRate)) != 0
	}
}

// stop: stop the capture of a sound recorder
pub fn (s &SoundBufferRecorder) stop() {
	unsafe {
		C.sfSoundBufferRecorder_stop(&C.sfSoundBufferRecorder(s))
	}
}

// get_buffer: get the sound buffer containing the captured audio data
// The sound buffer is valid only after the capture has ended.
// This function provides a read-only access to the internal
// sound buffer, but it can be copied if you need to
// make any modification to it.
pub fn (s &SoundBufferRecorder) get_buffer() ?&SoundBuffer {
	unsafe {
		result := &SoundBuffer(C.sfSoundBufferRecorder_getBuffer(&C.sfSoundBufferRecorder(s)))
		if voidptr(result) == C.NULL {
			return error('get_buffer failed')
		}
		return result
	}
}

// set_device: set the audio capture device
// This function sets the audio capture device to the device
// with the given name. It can be called on the fly (i.e:
// while recording). If you do so while recording and
// opening the device fails, it stops the recording.
pub fn (s &SoundBufferRecorder) set_device(name string) bool {
	unsafe {
		return C.sfSoundBufferRecorder_setDevice(&C.sfSoundBufferRecorder(s), name.str) != 0
	}
}

// get_device: get the name of the current audio capture device
pub fn (s &SoundBufferRecorder) get_device() string {
	unsafe {
		return cstring_to_vstring(C.sfSoundBufferRecorder_getDevice(&C.sfSoundBufferRecorder(s)))
	}
}
