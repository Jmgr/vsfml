module network

#include <SFML/Network/Packet.h>

fn C.sfPacket_create() &C.sfPacket
fn C.sfPacket_copy(&C.sfPacket) &C.sfPacket
fn C.sfPacket_destroy(&C.sfPacket)
fn C.sfPacket_append(&C.sfPacket, voidptr, size_t)
fn C.sfPacket_clear(&C.sfPacket)
fn C.sfPacket_getData(&C.sfPacket) voidptr
fn C.sfPacket_getDataSize(&C.sfPacket) size_t
fn C.sfPacket_endOfPacket(&C.sfPacket) int
fn C.sfPacket_canRead(&C.sfPacket) int
fn C.sfPacket_readUint16(&C.sfPacket) u16
fn C.sfPacket_readUint32(&C.sfPacket) u32
fn C.sfPacket_writeBool(&C.sfPacket, int)
fn C.sfPacket_writeInt8(&C.sfPacket, i8)
fn C.sfPacket_writeUint8(&C.sfPacket, byte)
fn C.sfPacket_writeInt16(&C.sfPacket, i16)
fn C.sfPacket_writeUint16(&C.sfPacket, u16)
fn C.sfPacket_writeInt32(&C.sfPacket, int)
fn C.sfPacket_writeUint32(&C.sfPacket, u32)
fn C.sfPacket_writeFloat(&C.sfPacket, f32)
fn C.sfPacket_writeDouble(&C.sfPacket, f64)
fn C.sfPacket_writeString(&C.sfPacket, &char)
fn C.sfPacket_writeWideString(&C.sfPacket, &i16)

// new_packet: create a new packet
pub fn new_packet() ?&Packet {
	unsafe {
		result := &Packet(C.sfPacket_create())
		if voidptr(result) == C.NULL {
			return error('new_packet failed')
		}
		return result
	}
}

// copy: create a new packet by copying an existing one
pub fn (p &Packet) copy() ?&Packet {
	unsafe {
		result := &Packet(C.sfPacket_copy(&C.sfPacket(p)))
		if voidptr(result) == C.NULL {
			return error('copy failed')
		}
		return result
	}
}

// free: destroy a packet
[unsafe]
pub fn (p &Packet) free() {
	unsafe {
		C.sfPacket_destroy(&C.sfPacket(p))
	}
}

// append: append data to the end of a packet
pub fn (p &Packet) append(data voidptr, sizeInBytes u64) {
	unsafe {
		C.sfPacket_append(&C.sfPacket(p), voidptr(data), size_t(sizeInBytes))
	}
}

// clear
pub fn (p &Packet) clear() {
	unsafe {
		C.sfPacket_clear(&C.sfPacket(p))
	}
}

// get_data: get a pointer to the data contained in a packet
// Warning: the returned pointer may become invalid after
// you append data to the packet, therefore it should never
// be stored.
// The return pointer is NULL if the packet is empty.
pub fn (p &Packet) get_data() {
	unsafe {
		C.sfPacket_getData(&C.sfPacket(p))
	}
}

// get_data_size: get the size of the data contained in a packet
// This function returns the number of bytes pointed to by
// what getData returns.
pub fn (p &Packet) get_data_size() u64 {
	unsafe {
		return u64(C.sfPacket_getDataSize(&C.sfPacket(p)))
	}
}

// end_of_packet: tell if the reading position has reached the
// end of a packet
// This function is useful to know if there is some data
// left to be read, without actually reading it.
pub fn (p &Packet) end_of_packet() bool {
	unsafe {
		return C.sfPacket_endOfPacket(&C.sfPacket(p)) != 0
	}
}

// can_read: test the validity of a packet, for reading
// This function allows to test the packet, to check if
// a reading operation was successful.
// A packet will be in an invalid state if it has no more
// data to read.
pub fn (p &Packet) can_read() bool {
	unsafe {
		return C.sfPacket_canRead(&C.sfPacket(p)) != 0
	}
}

// readuint16
pub fn (p &Packet) readuint16() u16 {
	unsafe {
		return u16(C.sfPacket_readUint16(&C.sfPacket(p)))
	}
}

// readuint32
pub fn (p &Packet) readuint32() u32 {
	unsafe {
		return u32(C.sfPacket_readUint32(&C.sfPacket(p)))
	}
}

// write_bool: functions to insert data into a packet
pub fn (p &Packet) write_bool(param0 bool) {
	unsafe {
		C.sfPacket_writeBool(&C.sfPacket(p), int(param1))
	}
}

// writeint8
pub fn (p &Packet) writeint8(param0 i8) {
	unsafe {
		C.sfPacket_writeInt8(&C.sfPacket(p), i8(param1))
	}
}

// writeuint8
pub fn (p &Packet) writeuint8(param0 byte) {
	unsafe {
		C.sfPacket_writeUint8(&C.sfPacket(p), byte(param1))
	}
}

// writeint16
pub fn (p &Packet) writeint16(param0 i16) {
	unsafe {
		C.sfPacket_writeInt16(&C.sfPacket(p), i16(param1))
	}
}

// writeuint16
pub fn (p &Packet) writeuint16(param0 u16) {
	unsafe {
		C.sfPacket_writeUint16(&C.sfPacket(p), u16(param1))
	}
}

// writeint32
pub fn (p &Packet) writeint32(param0 int) {
	unsafe {
		C.sfPacket_writeInt32(&C.sfPacket(p), int(param1))
	}
}

// writeuint32
pub fn (p &Packet) writeuint32(param0 u32) {
	unsafe {
		C.sfPacket_writeUint32(&C.sfPacket(p), u32(param1))
	}
}

// write_float
pub fn (p &Packet) write_float(param0 f32) {
	unsafe {
		C.sfPacket_writeFloat(&C.sfPacket(p), f32(param1))
	}
}

// write_double
pub fn (p &Packet) write_double(param0 f64) {
	unsafe {
		C.sfPacket_writeDouble(&C.sfPacket(p), f64(param1))
	}
}

// write_string
pub fn (p &Packet) write_string(string string) {
	unsafe {
		C.sfPacket_writeString(&C.sfPacket(p), string.str)
	}
}

// write_wide_string
pub fn (p &Packet) write_wide_string(string &i16) {
	unsafe {
		C.sfPacket_writeWideString(&C.sfPacket(p), &i16(string))
	}
}
