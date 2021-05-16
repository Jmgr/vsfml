module system

#include <SFML/System/Sleep.h>

fn C.sfSleep(C.sfTime)

// sleep: make the current thread sleep for a given duration
// Sleep is the best way to block a program or one of its
// threads, as it doesn't consume any CPU power.
pub fn sleep(duration Time) {
	unsafe {
		C.sfSleep(C.sfTime(duration))
	}
}
