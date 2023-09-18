module audio

import vsfml.system

#include <SFML/Audio/SoundRecorder.h>

fn C.sfSoundRecorder_create(C.sfSoundRecorderStartCallback, C.sfSoundRecorderProcessCallback, C.sfSoundRecorderStopCallback, voidptr) &C.sfSoundRecorder
fn C.sfSoundRecorder_destroy(&C.sfSoundRecorder)
fn C.sfSoundRecorder_start(&C.sfSoundRecorder, u32) int
fn C.sfSoundRecorder_stop(&C.sfSoundRecorder)
fn C.sfSoundRecorder_isAvailable() int
fn C.sfSoundRecorder_setProcessingInterval(&C.sfSoundRecorder, C.sfTime)
fn C.sfSoundRecorder_getDefaultDevice() &char
fn C.sfSoundRecorder_setDevice(&C.sfSoundRecorder, &char) int
fn C.sfSoundRecorder_getDevice(&C.sfSoundRecorder) &char
fn C.sfSoundRecorder_setChannelCount(&C.sfSoundRecorder, u32)

pub type SoundRecorderStartCallback = fn (voidptr) int // Type of the callback used when starting a capture

pub type SoundRecorderProcessCallback = fn (&i16, usize, voidptr) int // Type of the callback used to process audio data

pub type SoundRecorderStopCallback = fn (voidptr) // Type of the callback used when stopping a capture

// new_sound_recorder: construct a new sound recorder from callback functions
pub fn new_sound_recorder(params SoundRecorderNewSoundRecorderParams) !&SoundRecorder {
	unsafe {
		result := &SoundRecorder(C.sfSoundRecorder_create(*&C.sfSoundRecorderStartCallback(&params.on_start),
			*&C.sfSoundRecorderProcessCallback(&params.on_process), *&C.sfSoundRecorderStopCallback(&params.on_stop),
			voidptr(params.user_data)))
		if voidptr(result) == C.NULL {
			return error('new_sound_recorder failed with on_start=${params.on_start} on_process=${params.on_process} on_stop=${params.on_stop}')
		}
		return result
	}
}

// SoundRecorderNewSoundRecorderParams: parameters for new_sound_recorder
pub struct SoundRecorderNewSoundRecorderParams {
pub:
	on_start   SoundRecorderStartCallback = unsafe { nil } // callback function which will be called when a new capture starts (can be NULL)
	on_process SoundRecorderProcessCallback [required] // callback function which will be called each time there's audio data to process
	on_stop    SoundRecorderStopCallback = unsafe { nil } // callback function which will be called when the current capture stops (can be NULL)
	user_data  voidptr = unsafe { nil } // data to pass to the callback function (can be NULL)
}

// free: destroy a sound recorder
[unsafe]
pub fn (s &SoundRecorder) free() {
	unsafe {
		C.sfSoundRecorder_destroy(&C.sfSoundRecorder(s))
	}
}

// start: start the capture of a sound recorder
// The sampleRate parameter defines the number of audio samples
// captured per second. The higher, the better the quality
// (for example, 44100 samples/sec is CD quality).
// This function uses its own thread so that it doesn't block
// the rest of the program while the capture runs.
// Please note that only one capture can happen at the same time.
pub fn (s &SoundRecorder) start(sampleRate u32) bool {
	unsafe {
		return C.sfSoundRecorder_start(&C.sfSoundRecorder(s), u32(sampleRate)) != 0
	}
}

// stop: stop the capture of a sound recorder
pub fn (s &SoundRecorder) stop() {
	unsafe {
		C.sfSoundRecorder_stop(&C.sfSoundRecorder(s))
	}
}

// soundrecorder_is_available: check if the system supports audio capture
// This function should always be called before using
// the audio capture features. If it returns false, then
// any attempt to use SoundRecorder will fail.
pub fn soundrecorder_is_available() bool {
	unsafe {
		return C.sfSoundRecorder_isAvailable() != 0
	}
}

// set_processing_interval: set the processing interval
// The processing interval controls the period
// between calls to the onProcessSamples function. You may
// want to use a small interval if you want to process the
// recorded data in real time, for example.
// Note: this is only a hint, the actual period may vary.
// So don't rely on this parameter to implement precise timing.
// The default processing interval is 100 ms.
pub fn (s &SoundRecorder) set_processing_interval(interval system.Time) {
	unsafe {
		C.sfSoundRecorder_setProcessingInterval(&C.sfSoundRecorder(s), *&C.sfTime(&interval))
	}
}

// soundrecorder_get_default_device: get the name of the default audio capture device
// This function returns the name of the default audio
// capture device. If none is available, NULL is returned.
pub fn soundrecorder_get_default_device() string {
	unsafe {
		return cstring_to_vstring(C.sfSoundRecorder_getDefaultDevice())
	}
}

// set_device: set the audio capture device
// This function sets the audio capture device to the device
// with the given name. It can be called on the fly (i.e:
// while recording). If you do so while recording and
// opening the device fails, it stops the recording.
pub fn (s &SoundRecorder) set_device(name string) bool {
	unsafe {
		return C.sfSoundRecorder_setDevice(&C.sfSoundRecorder(s), name.str) != 0
	}
}

// get_device: get the name of the current audio capture device
pub fn (s &SoundRecorder) get_device() string {
	unsafe {
		return cstring_to_vstring(C.sfSoundRecorder_getDevice(&C.sfSoundRecorder(s)))
	}
}

// set_channel_count: set the channel count of the audio capture device
// This method allows you to specify the number of channels
// used for recording. Currently only 16-bit mono and
// 16-bit stereo are supported.
pub fn (s &SoundRecorder) set_channel_count(channelCount u32) {
	unsafe {
		C.sfSoundRecorder_setChannelCount(&C.sfSoundRecorder(s), u32(channelCount))
	}
}
