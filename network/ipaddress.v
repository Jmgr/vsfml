module network

import system

#include <SFML/Network/IpAddress.h>

[typedef]
struct C.sfIpAddress {
pub:
	address [16]char
}

// IpAddress: encapsulate an IPv4 network address
pub type IpAddress = C.sfIpAddress

fn C.sfIpAddress_fromString(&char) C.sfIpAddress
fn C.sfIpAddress_fromBytes(byte, byte, byte, byte) C.sfIpAddress
fn C.sfIpAddress_fromInteger(u32) C.sfIpAddress
fn C.sfIpAddress_toString(C.sfIpAddress, &char)
fn C.sfIpAddress_toInteger(C.sfIpAddress) u32
fn C.sfIpAddress_getLocalAddress() C.sfIpAddress
fn C.sfIpAddress_getPublicAddress(C.sfTime) C.sfIpAddress

// ipaddress_from_string: create an address from a string
// Here address can be either a decimal address
// (ex: "192.168.1.56") or a network name (ex: "localhost").
pub fn ipaddress_from_string(address string) IpAddress {
	unsafe {
		return IpAddress(C.sfIpAddress_fromString(address.str))
	}
}

// ipaddress_from_bytes: create an address from 4 bytes
// Calling fromBytes(a, b, c, d) is equivalent
// to calling fromString("a.b.c.d"), but safer
// as it doesn't have to parse a string to get the address
// components.
pub fn ipaddress_from_bytes(byte0 byte, byte1 byte, byte2 byte, byte3 byte) IpAddress {
	unsafe {
		return IpAddress(C.sfIpAddress_fromBytes(byte(byte0), byte(byte1), byte(byte2),
			byte(byte3)))
	}
}

// ipaddress_from_integer: construct an address from a 32-bits integer
// This function uses the internal representation of
// the address directly. It should be used for optimization
// purposes, and only if you got that representation from
// ToInteger.
pub fn ipaddress_from_integer(address u32) IpAddress {
	unsafe {
		return IpAddress(C.sfIpAddress_fromInteger(u32(address)))
	}
}

// to_string: get a string representation of an address
// The returned string is the decimal representation of the
// IP address (like "192.168.1.56"), even if it was constructed
// from a host name.
pub fn (i IpAddress) to_string(string string) {
	unsafe {
		C.sfIpAddress_toString(C.sfIpAddress(i), string.str)
	}
}

// to_integer: get an integer representation of the address
// The returned number is the internal representation of the
// address, and should be used for optimization purposes only
// (like sending the address through a socket).
// The integer produced by this function can then be converted
// back to a IpAddress with FromInteger.
pub fn (i IpAddress) to_integer() u32 {
	unsafe {
		return u32(C.sfIpAddress_toInteger(C.sfIpAddress(i)))
	}
}

// ipaddress_get_local_address: get the computer's local address
// The local address is the address of the computer from the
// LAN point of view, i.e. something like 192.168.1.56. It is
// meaningful only for communications over the local network.
// Unlike getPublicAddress, this function is fast
// and may be used safely anywhere.
pub fn ipaddress_get_local_address() IpAddress {
	unsafe {
		return IpAddress(C.sfIpAddress_getLocalAddress())
	}
}

// ipaddress_get_public_address: get the computer's public address
// The public address is the address of the computer from the
// internet point of view, i.e. something like 89.54.1.169.
// It is necessary for communications over the world wide web.
// The only way to get a public address is to ask it to a
// distant website; as a consequence, this function depends on
// both your network connection and the server, and may be
// very slow. You should use it as few as possible. Because
// this function depends on the network connection and on a distant
// server, you may use a time limit if you don't want your program
// to be possibly stuck waiting in case there is a problem; use
// 0 to deactivate this limit.
pub fn ipaddress_get_public_address(timeout system.Time) IpAddress {
	unsafe {
		return IpAddress(C.sfIpAddress_getPublicAddress(C.sfTime(timeout)))
	}
}
