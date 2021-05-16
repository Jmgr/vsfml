module window

enum EventTypeEnum {
	evt_closed
	evt_resized
	evt_lost_focus
	evt_gained_focus
	evt_text_entered
	evt_key_pressed
	evt_key_released
	evt_mouse_wheel_moved
	evt_mouse_wheel_scrolled
	evt_mouse_button_pressed
	evt_mouse_button_released
	evt_mouse_moved
	evt_mouse_entered
	evt_mouse_left
	evt_joystick_button_pressed
	evt_joystick_button_released
	evt_joystick_moved
	evt_joystick_connected
	evt_joystick_disconnected
	evt_touch_began
	evt_touch_moved
	evt_touch_ended
	evt_sensor_changed
}

// process_event: internal event processing function
pub fn process_event(evtType EventTypeEnum, evt &voidptr) ?Event {
	unsafe {
		match evtType {
			.evt_closed { return CloseEvent{} }
			.evt_resized { return *&SizeEvent(evt) }
			.evt_lost_focus { return LostFocusEvent{} }
			.evt_gained_focus { return GainedFocusEvent{} }
			.evt_text_entered { return *&TextEnteredEvent(evt) }
			.evt_key_pressed { return *&KeyPressedEvent(evt) }
			.evt_key_released { return *&KeyReleasedEvent(evt) }
			.evt_mouse_wheel_moved { return none } // deprecated
			.evt_mouse_wheel_scrolled { return *&MouseWheelScrollEvent(evt) }
			.evt_mouse_button_pressed { return *&MouseButtonPressedEvent(evt) }
			.evt_mouse_button_released { return *&MouseButtonReleasedEvent(evt) }
			.evt_mouse_moved { return *&MouseMovedEvent(evt) }
			.evt_mouse_entered { return MouseEnteredEvent{} }
			.evt_mouse_left { return MouseLeftEvent{} }
			.evt_joystick_button_pressed { return *&JoystickButtonPressedEvent(evt) }
			.evt_joystick_button_released { return *&JoystickButtonReleasedEvent(evt) }
			.evt_joystick_moved { return *&JoystickMovedEvent(evt) }
			.evt_joystick_connected { return *&JoystickConnectedEvent(evt) }
			.evt_joystick_disconnected { return *&JoystickDisconnectedEvent(evt) }
			.evt_touch_began { return *&TouchBeganEvent(evt) }
			.evt_touch_moved { return *&TouchMovedEvent(evt) }
			.evt_touch_ended { return *&TouchEndedEvent(evt) }
			.evt_sensor_changed { return *&SensorChangedEvent(evt) }
		}
	}
	return none
}

// poll_event: pop the event on top of event queue, if any, and return it
// Note that more than one event may be present in the event queue,
// thus you should always call this function in a loop
// to make sure that you process every pending event.
pub fn (w &Window) poll_event() ?Event {
	evt_type := int(0)
	evt := voidptr(0)
	if C.pollEventWindow(w, &evt_type, &evt) == 0 {
		return none
	}
	return process_event(EventTypeEnum(evt_type), evt)
}

struct EventType {
	event_type u32
}

// CloseEvent parameters
pub struct CloseEvent {
	EventType
}

// SizeEvent parameters
pub struct SizeEvent {
	EventType
pub:
	width  u32
	height u32
}

// LostFocusEvent parameters
pub struct LostFocusEvent {
	EventType
}

// GainedFocusEvent parameters
pub struct GainedFocusEvent {
	EventType
}

// TextEnteredEvent parameters
pub struct TextEnteredEvent {
	EventType
pub:
	unicode u32
}

struct KeyEvent {
	EventType
pub:
	code    KeyCode
	alt     bool
	control bool
	shift   bool
	system  bool
}

// KeyPressedEvent parameters
pub type KeyPressedEvent = KeyEvent

// KeyReleasedEvent parameters
pub type KeyReleasedEvent = KeyEvent

// MouseWheelScrollEvent parameters
pub struct MouseWheelScrollEvent {
	EventType
pub:
	wheel MouseWheel
	delta f32
	x     int
	y     int
}

struct MouseButtonEvent {
	EventType
pub:
	button MouseButton
	x      int
	y      int
}

// MouseButtonPressedEvent parameters
pub type MouseButtonPressedEvent = MouseButtonEvent

// MouseButtonReleasedEvent parameters
pub type MouseButtonReleasedEvent = MouseButtonEvent

// MouseMovedEvent parameters
pub struct MouseMovedEvent {
	EventType
pub:
	x int
	y int
}

// MouseEnteredEvent parameters
pub struct MouseEnteredEvent {
	EventType
}

// MouseLeftEvent parameters
pub struct MouseLeftEvent {
	EventType
}

struct JoystickButtonEvent {
	EventType
pub:
	joystick_id u32
	button      u32
}

// JoystickButtonPressedEvent parameters
pub type JoystickButtonPressedEvent = JoystickButtonEvent

// JoystickButtonReleasedEvent parameters
pub type JoystickButtonReleasedEvent = JoystickButtonEvent

// JoystickMovedEvent parameters
pub struct JoystickMovedEvent {
	EventType
pub:
	joystick_id u32
	axis        JoystickAxis
	position    f32
}

struct JoystickConnectEvent {
	EventType
pub:
	joystick_id u32
}

// JoystickConnectedEvent parameters
pub type JoystickConnectedEvent = JoystickConnectEvent

// JoystickDisconnectedEvent parameters
pub type JoystickDisconnectedEvent = JoystickConnectEvent

struct TouchEvent {
	EventType
pub:
	finger u32
	x      int
	y      int
}

// TouchBeganEvent parameters
pub type TouchBeganEvent = TouchEvent

// TouchMovedEvent parameters
pub type TouchMovedEvent = TouchEvent

// TouchEndedEvent parameters
pub type TouchEndedEvent = TouchEvent

// SensorChangedEvent parameters
pub struct SensorChangedEvent {
	EventType
pub:
	sensor_type SensorType
	x           f32
	y           f32
	z           f32
}

// Event defines a system event and its parameters
pub type Event = CloseEvent | GainedFocusEvent | JoystickButtonPressedEvent | JoystickButtonReleasedEvent |
	JoystickConnectedEvent | JoystickDisconnectedEvent | JoystickMovedEvent | KeyPressedEvent |
	KeyReleasedEvent | LostFocusEvent | MouseButtonPressedEvent | MouseButtonReleasedEvent |
	MouseEnteredEvent | MouseLeftEvent | MouseMovedEvent | MouseWheelScrollEvent | SensorChangedEvent |
	SizeEvent | TextEnteredEvent | TouchBeganEvent | TouchEndedEvent | TouchMovedEvent
