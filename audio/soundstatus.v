module audio

#include <SFML/Audio/SoundStatus.h>

// SoundStatus: enumeration of statuses for sounds and musics
pub enum SoundStatus {
	stopped // Sound / music is not playing
	paused // Sound / music is paused
	playing // Sound / music is playing
}
