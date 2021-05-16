module system

#include <SFML/System/Time.h>

[typedef]
struct C.sfTime {
pub:
	microseconds i64
}

// Time: represents a time value
pub type Time = C.sfTime

fn C.sfTime_asSeconds(C.sfTime) f32
fn C.sfTime_asMilliseconds(C.sfTime) int
fn C.sfTime_asMicroseconds(C.sfTime) i64
fn C.sfSeconds(f32) C.sfTime
fn C.sfMilliseconds(int) C.sfTime
fn C.sfMicroseconds(i64) C.sfTime

// as_seconds: return a time value as a number of seconds
pub fn (t Time) as_seconds() f32 {
	unsafe {
		return f32(C.sfTime_asSeconds(C.sfTime(t)))
	}
}

// as_milliseconds: return a time value as a number of milliseconds
pub fn (t Time) as_milliseconds() int {
	unsafe {
		return int(C.sfTime_asMilliseconds(C.sfTime(t)))
	}
}

// as_microseconds: return a time value as a number of microseconds
pub fn (t Time) as_microseconds() i64 {
	unsafe {
		return i64(C.sfTime_asMicroseconds(C.sfTime(t)))
	}
}

// seconds: construct a time value from a number of seconds
pub fn seconds(amount f32) Time {
	unsafe {
		return Time(C.sfSeconds(f32(amount)))
	}
}

// milliseconds: construct a time value from a number of milliseconds
pub fn milliseconds(amount int) Time {
	unsafe {
		return Time(C.sfMilliseconds(int(amount)))
	}
}

// microseconds: construct a time value from a number of microseconds
pub fn microseconds(amount i64) Time {
	unsafe {
		return Time(C.sfMicroseconds(i64(amount)))
	}
}
