module window

#include <SFML/Window/Context.h>

fn C.sfContext_create() &C.sfContext
fn C.sfContext_destroy(&C.sfContext)
fn C.sfContext_setActive(&C.sfContext, int) int
fn C.sfContext_getSettings(&C.sfContext) C.sfContextSettings
fn C.sfContext_getActiveContextId() u64

// new_context: create a new context
// This function activates the new context.
pub fn new_context() ?&Context {
	unsafe {
		result := &Context(C.sfContext_create())
		if voidptr(result) == C.NULL {
			return error('new_context failed')
		}
		return result
	}
}

// free: destroy a context
[unsafe]
pub fn (c &Context) free() {
	unsafe {
		C.sfContext_destroy(&C.sfContext(c))
	}
}

// set_active: activate or deactivate explicitely a context
pub fn (c &Context) set_active(active bool) bool {
	unsafe {
		return C.sfContext_setActive(&C.sfContext(c), int(active)) != 0
	}
}

// get_settings: get the settings of the context.
// Note that these settings may be different than the ones passed to the
// constructor; they are indeed adjusted if the original settings are not
// directly supported by the system.
pub fn (c &Context) get_settings() ContextSettings {
	unsafe {
		return ContextSettings(C.sfContext_getSettings(&C.sfContext(c)))
	}
}

// context_get_active_context_id: get the currently active context's ID
// The context ID is used to identify contexts when
// managing unshareable OpenGL resources.
pub fn context_get_active_context_id() u64 {
	unsafe {
		return u64(C.sfContext_getActiveContextId())
	}
}
