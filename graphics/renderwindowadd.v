module graphics

import vsfml.window

fn C.pollEventRenderWindow(&RenderWindow, &int, &voidptr) int

// poll_event: get the event on top of event queue of a render window, if any, and pop it
pub fn (r &RenderWindow) poll_event() ?window.Event {
	evt_type := int(0)
	evt := unsafe { nil }
	if C.pollEventRenderWindow(r, &evt_type, &evt) == 0 {
		return none
	}
	return window.process_event(unsafe { window.EventTypeEnum(evt_type) }, evt)
}
