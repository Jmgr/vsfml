module window

#include <SFML/Window/JoystickIdentification.h>

[typedef]
struct C.sfJoystickIdentification {
pub:
	name      &char
	vendorId  int
	productId int
}

// JoystickIdentification: holds a joystick's identification
pub type JoystickIdentification = C.sfJoystickIdentification
