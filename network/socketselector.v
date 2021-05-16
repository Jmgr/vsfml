module network

import system

#include <SFML/Network/SocketSelector.h>

fn C.sfSocketSelector_create() &C.sfSocketSelector
fn C.sfSocketSelector_copy(&C.sfSocketSelector) &C.sfSocketSelector
fn C.sfSocketSelector_destroy(&C.sfSocketSelector)
fn C.sfSocketSelector_addTcpListener(&C.sfSocketSelector, &C.sfTcpListener)
fn C.sfSocketSelector_addTcpSocket(&C.sfSocketSelector, &C.sfTcpSocket)
fn C.sfSocketSelector_addUdpSocket(&C.sfSocketSelector, &C.sfUdpSocket)
fn C.sfSocketSelector_removeTcpListener(&C.sfSocketSelector, &C.sfTcpListener)
fn C.sfSocketSelector_removeTcpSocket(&C.sfSocketSelector, &C.sfTcpSocket)
fn C.sfSocketSelector_removeUdpSocket(&C.sfSocketSelector, &C.sfUdpSocket)
fn C.sfSocketSelector_clear(&C.sfSocketSelector)
fn C.sfSocketSelector_wait(&C.sfSocketSelector, C.sfTime) int
fn C.sfSocketSelector_isTcpListenerReady(&C.sfSocketSelector, &C.sfTcpListener) int
fn C.sfSocketSelector_isTcpSocketReady(&C.sfSocketSelector, &C.sfTcpSocket) int
fn C.sfSocketSelector_isUdpSocketReady(&C.sfSocketSelector, &C.sfUdpSocket) int

// new_socket_selector: create a new selector
pub fn new_socket_selector() ?&SocketSelector {
	unsafe {
		result := &SocketSelector(C.sfSocketSelector_create())
		if voidptr(result) == C.NULL {
			return error('new_socket_selector failed')
		}
		return result
	}
}

// copy: create a new socket selector by copying an existing one
pub fn (s &SocketSelector) copy() ?&SocketSelector {
	unsafe {
		result := &SocketSelector(C.sfSocketSelector_copy(&C.sfSocketSelector(s)))
		if voidptr(result) == C.NULL {
			return error('copy failed')
		}
		return result
	}
}

// free: destroy a socket selector
[unsafe]
pub fn (s &SocketSelector) free() {
	unsafe {
		C.sfSocketSelector_destroy(&C.sfSocketSelector(s))
	}
}

// add_tcp_listener: add a new socket to a socket selector
// This function keeps a weak pointer to the socket,
// so you have to make sure that the socket is not destroyed
// while it is stored in the selector.
pub fn (s &SocketSelector) add_tcp_listener(socket &TcpListener) {
	unsafe {
		C.sfSocketSelector_addTcpListener(&C.sfSocketSelector(s), &C.sfTcpListener(socket))
	}
}

// add_tcp_socket
pub fn (s &SocketSelector) add_tcp_socket(socket &TcpSocket) {
	unsafe {
		C.sfSocketSelector_addTcpSocket(&C.sfSocketSelector(s), &C.sfTcpSocket(socket))
	}
}

// add_udp_socket
pub fn (s &SocketSelector) add_udp_socket(socket &UdpSocket) {
	unsafe {
		C.sfSocketSelector_addUdpSocket(&C.sfSocketSelector(s), &C.sfUdpSocket(socket))
	}
}

// remove_tcp_listener: remove a socket from a socket selector
// This function doesn't destroy the socket, it simply
// removes the pointer that the selector has to it.
pub fn (s &SocketSelector) remove_tcp_listener(socket &TcpListener) {
	unsafe {
		C.sfSocketSelector_removeTcpListener(&C.sfSocketSelector(s), &C.sfTcpListener(socket))
	}
}

// remove_tcp_socket
pub fn (s &SocketSelector) remove_tcp_socket(socket &TcpSocket) {
	unsafe {
		C.sfSocketSelector_removeTcpSocket(&C.sfSocketSelector(s), &C.sfTcpSocket(socket))
	}
}

// remove_udp_socket
pub fn (s &SocketSelector) remove_udp_socket(socket &UdpSocket) {
	unsafe {
		C.sfSocketSelector_removeUdpSocket(&C.sfSocketSelector(s), &C.sfUdpSocket(socket))
	}
}

// clear: remove all the sockets stored in a selector
// This function doesn't destroy any instance, it simply
// removes all the pointers that the selector has to
// external sockets.
pub fn (s &SocketSelector) clear() {
	unsafe {
		C.sfSocketSelector_clear(&C.sfSocketSelector(s))
	}
}

// wait: wait until one or more sockets are ready to receive
// This function returns as soon as at least one socket has
// some data available to be received. To know which sockets are
// ready, use the isXxxReady functions.
// If you use a timeout and no socket is ready before the timeout
// is over, the function returns false.
pub fn (s &SocketSelector) wait(timeout system.Time) bool {
	unsafe {
		return C.sfSocketSelector_wait(&C.sfSocketSelector(s), C.sfTime(timeout)) != 0
	}
}

// is_tcp_listener_ready: test a socket to know if it is ready to receive data
// This function must be used after a call to
// wait, to know which sockets are ready to
// receive data. If a socket is ready, a call to Receive will
// never block because we know that there is data available to read.
// Note that if this function returns true for a TcpListener,
// this means that it is ready to accept a new connection.
pub fn (s &SocketSelector) is_tcp_listener_ready(socket &TcpListener) bool {
	unsafe {
		return C.sfSocketSelector_isTcpListenerReady(&C.sfSocketSelector(s), &C.sfTcpListener(socket)) != 0
	}
}

// is_tcp_socket_ready
pub fn (s &SocketSelector) is_tcp_socket_ready(socket &TcpSocket) bool {
	unsafe {
		return C.sfSocketSelector_isTcpSocketReady(&C.sfSocketSelector(s), &C.sfTcpSocket(socket)) != 0
	}
}

// is_udp_socket_ready
pub fn (s &SocketSelector) is_udp_socket_ready(socket &UdpSocket) bool {
	unsafe {
		return C.sfSocketSelector_isUdpSocketReady(&C.sfSocketSelector(s), &C.sfUdpSocket(socket)) != 0
	}
}
