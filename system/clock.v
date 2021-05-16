module system

#include <SFML/System/Clock.h>

fn C.sfClock_create() &C.sfClock
fn C.sfClock_copy(&C.sfClock) &C.sfClock
fn C.sfClock_destroy(&C.sfClock)
fn C.sfClock_getElapsedTime(&C.sfClock) C.sfTime
fn C.sfClock_restart(&C.sfClock) C.sfTime

// new_clock: create a new clock and start it
pub fn new_clock() ?&Clock {
	unsafe {
		result := &Clock(C.sfClock_create())
		if voidptr(result) == C.NULL {
			return error('new_clock failed')
		}
		return result
	}
}

// copy: create a new clock by copying an existing one
pub fn (c &Clock) copy() ?&Clock {
	unsafe {
		result := &Clock(C.sfClock_copy(&C.sfClock(c)))
		if voidptr(result) == C.NULL {
			return error('copy failed')
		}
		return result
	}
}

// free: destroy a clock
[unsafe]
pub fn (c &Clock) free() {
	unsafe {
		C.sfClock_destroy(&C.sfClock(c))
	}
}

// get_elapsed_time: get the time elapsed in a clock
// This function returns the time elapsed since the last call
// to restart (or the construction of the object if
// restart has not been called).
pub fn (c &Clock) get_elapsed_time() Time {
	unsafe {
		return Time(C.sfClock_getElapsedTime(&C.sfClock(c)))
	}
}

// restart: restart a clock
// This function puts the time counter back to zero.
// It also returns the time elapsed since the clock was started.
pub fn (c &Clock) restart() Time {
	unsafe {
		return Time(C.sfClock_restart(&C.sfClock(c)))
	}
}
