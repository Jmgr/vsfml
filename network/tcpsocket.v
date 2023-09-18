module network

import system

#include <SFML/Network/TcpSocket.h>

fn C.sfTcpSocket_create() &C.sfTcpSocket
fn C.sfTcpSocket_destroy(&C.sfTcpSocket)
fn C.sfTcpSocket_setBlocking(&C.sfTcpSocket, int)
fn C.sfTcpSocket_isBlocking(&C.sfTcpSocket) int
fn C.sfTcpSocket_getRemoteAddress(&C.sfTcpSocket) C.sfIpAddress
fn C.sfTcpSocket_connect(&C.sfTcpSocket, C.sfIpAddress, u16, C.sfTime) C.sfSocketStatus
fn C.sfTcpSocket_disconnect(&C.sfTcpSocket)
fn C.sfTcpSocket_send(&C.sfTcpSocket, voidptr, usize) C.sfSocketStatus
fn C.sfTcpSocket_sendPartial(&C.sfTcpSocket, voidptr, usize, &usize) C.sfSocketStatus
fn C.sfTcpSocket_receive(&C.sfTcpSocket, voidptr, usize, &usize) C.sfSocketStatus
fn C.sfTcpSocket_sendPacket(&C.sfTcpSocket, &C.sfPacket) C.sfSocketStatus
fn C.sfTcpSocket_receivePacket(&C.sfTcpSocket, &C.sfPacket) C.sfSocketStatus

// new_tcp_socket: create a new TCP socket
pub fn new_tcp_socket() !&TcpSocket {
	unsafe {
		result := &TcpSocket(C.sfTcpSocket_create())
		if voidptr(result) == C.NULL {
			return error('new_tcp_socket failed')
		}
		return result
	}
}

// free: destroy a TCP socket
[unsafe]
pub fn (t &TcpSocket) free() {
	unsafe {
		C.sfTcpSocket_destroy(&C.sfTcpSocket(t))
	}
}

// set_blocking: set the blocking state of a TCP listener
// In blocking mode, calls will not return until they have
// completed their task. For example, a call to
// receive in blocking mode won't return until
// new data was actually received.
// In non-blocking mode, calls will always return immediately,
// using the return code to signal whether there was data
// available or not.
// By default, all sockets are blocking.
pub fn (t &TcpSocket) set_blocking(blocking bool) {
	unsafe {
		C.sfTcpSocket_setBlocking(&C.sfTcpSocket(t), int(blocking))
	}
}

// is_blocking: tell whether a TCP socket is in blocking or non-blocking mode
pub fn (t &TcpSocket) is_blocking() bool {
	unsafe {
		return C.sfTcpSocket_isBlocking(&C.sfTcpSocket(t)) != 0
	}
}

// get_remote_address: get the address of the connected peer of a TCP socket
// It the socket is not connected, this function returns
// None.
pub fn (t &TcpSocket) get_remote_address() IpAddress {
	unsafe {
		return IpAddress(C.sfTcpSocket_getRemoteAddress(&C.sfTcpSocket(t)))
	}
}

// connect: connect a TCP socket to a remote peer
// In blocking mode, this function may take a while, especially
// if the remote peer is not reachable. The last parameter allows
// you to stop trying to connect after a given timeout.
// If the socket was previously connected, it is first disconnected.
pub fn (t &TcpSocket) connect(params TcpSocketConnectParams) SocketStatus {
	unsafe {
		return SocketStatus(C.sfTcpSocket_connect(&C.sfTcpSocket(t), *&C.sfIpAddress(&params.remote_address),
			u16(params.remote_port), *&C.sfTime(&params.timeout)))
	}
}

// TcpSocketConnectParams: parameters for connect
pub struct TcpSocketConnectParams {
pub:
	remote_address IpAddress   [required] // address of the remote peer
	remote_port    u16         [required] // port of the remote peer
	timeout        system.Time [required] // maximum time to wait
}

// disconnect: disconnect a TCP socket from its remote peer
// This function gracefully closes the connection. If the
// socket is not connected, this function has no effect.
pub fn (t &TcpSocket) disconnect() {
	unsafe {
		C.sfTcpSocket_disconnect(&C.sfTcpSocket(t))
	}
}

// send: send raw data to the remote peer of a TCP socket
// To be able to handle partial sends over non-blocking
// sockets, use the sendPartial(sfTcpSocket*, const void*, std::usize, usize*)
// overload instead.
// This function will fail if the socket is not connected.
pub fn (t &TcpSocket) send(data voidptr, size u64) SocketStatus {
	unsafe {
		return SocketStatus(C.sfTcpSocket_send(&C.sfTcpSocket(t), data, usize(size)))
	}
}

// send_partial: send raw data to the remote peer
// This function will fail if the socket is not connected.
pub fn (t &TcpSocket) send_partial(params TcpSocketSendPartialParams) SocketStatus {
	unsafe {
		return SocketStatus(C.sfTcpSocket_sendPartial(&C.sfTcpSocket(t), params.data,
			usize(params.size), &usize(params.sent)))
	}
}

// TcpSocketSendPartialParams: parameters for send_partial
pub struct TcpSocketSendPartialParams {
pub:
	data voidptr [required] // pointer to the sequence of bytes to send
	size u64     [required] // number of bytes to send
	sent &u64    [required] // the number of bytes sent will be written here
}

// receive: receive raw data from the remote peer of a TCP socket
// In blocking mode, this function will wait until some
// bytes are actually received.
// This function will fail if the socket is not connected.
pub fn (t &TcpSocket) receive(params TcpSocketReceiveParams) SocketStatus {
	unsafe {
		return SocketStatus(C.sfTcpSocket_receive(&C.sfTcpSocket(t), params.data,
			usize(params.size), &usize(params.received)))
	}
}

// TcpSocketReceiveParams: parameters for receive
pub struct TcpSocketReceiveParams {
pub:
	data     voidptr [required] // pointer to the array to fill with the received bytes
	size     u64     [required] // maximum number of bytes that can be received
	received &u64    [required] // this variable is filled with the actual number of bytes received
}

// send_packet: send a formatted packet of data to the remote peer of a TCP socket
// In non-blocking mode, if this function returns SocketPartial,
// you must retry sending the same unmodified packet before sending
// anything else in order to guarantee the packet arrives at the remote
// peer uncorrupted.
// This function will fail if the socket is not connected.
pub fn (t &TcpSocket) send_packet(packet &Packet) SocketStatus {
	unsafe {
		return SocketStatus(C.sfTcpSocket_sendPacket(&C.sfTcpSocket(t), &C.sfPacket(packet)))
	}
}

// receive_packet: receive a formatted packet of data from the remote peer
// In blocking mode, this function will wait until the whole packet
// has been received.
// This function will fail if the socket is not connected.
pub fn (t &TcpSocket) receive_packet(packet &Packet) SocketStatus {
	unsafe {
		return SocketStatus(C.sfTcpSocket_receivePacket(&C.sfTcpSocket(t), &C.sfPacket(packet)))
	}
}
