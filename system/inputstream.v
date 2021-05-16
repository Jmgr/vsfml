module system

#include <SFML/System/InputStream.h>

[typedef]
struct C.sfInputStream {
pub:
	read     C.sfInputStreamReadFunc
	seek     C.sfInputStreamSeekFunc
	tell     C.sfInputStreamTellFunc
	getSize  C.sfInputStreamGetSizeFunc
	userData voidptr
}

// InputStream: set of callbacks that allow users to define custom file streams
pub type InputStream = C.sfInputStream

pub type InputStreamReadFunc = fn (voidptr, i64, voidptr) i64

pub type InputStreamSeekFunc = fn (i64, voidptr) i64

pub type InputStreamTellFunc = fn (voidptr) i64

pub type InputStreamGetSizeFunc = fn (voidptr) i64
