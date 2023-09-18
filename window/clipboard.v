module window

#include <SFML/Window/Clipboard.h>

fn C.sfClipboard_getString() &char
fn C.sfClipboard_getUnicodeString() &u32
fn C.sfClipboard_setString(&char)
fn C.sfClipboard_setUnicodeString(&u32)

// clipboard_get_string: get the content of the clipboard as string data (returns an ANSI string)
// This function returns the content of the clipboard
// as a string. If the clipboard does not contain string
// it returns an empty string.
pub fn clipboard_get_string() string {
	unsafe {
		return cstring_to_vstring(C.sfClipboard_getString())
	}
}

// clipboard_get_unicode_string: get the content of the clipboard as string data (returns a Unicode string)
// This function returns the content of the clipboard
// as a string. If the clipboard does not contain string
// it returns an empty string.
pub fn clipboard_get_unicode_string() !&u32 {
	unsafe {
		result := &u32(C.sfClipboard_getUnicodeString())
		if voidptr(result) == C.NULL {
			return error('get_unicode_string failed')
		}
		return result
	}
}

// clipboard_set_string: set the content of the clipboard as ANSI string data
// This function sets the content of the clipboard as an
// ANSI string.
pub fn clipboard_set_string(text string) {
	unsafe {
		C.sfClipboard_setString(text.str)
	}
}

// clipboard_set_unicode_string: set the content of the clipboard as Unicode string data
// This function sets the content of the clipboard as a
// Unicode string.
pub fn clipboard_set_unicode_string(text &u32) {
	unsafe {
		C.sfClipboard_setUnicodeString(&u32(text))
	}
}
