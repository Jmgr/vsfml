module network

#include <SFML/Network/UdpSocket.h>

fn C.sfUdpSocket_create() &C.sfUdpSocket
fn C.sfUdpSocket_destroy(&C.sfUdpSocket)
fn C.sfUdpSocket_setBlocking(&C.sfUdpSocket, int)
fn C.sfUdpSocket_isBlocking(&C.sfUdpSocket) int
fn C.sfUdpSocket_bind(&C.sfUdpSocket, u16, C.sfIpAddress) C.sfSocketStatus
fn C.sfUdpSocket_unbind(&C.sfUdpSocket)
fn C.sfUdpSocket_send(&C.sfUdpSocket, voidptr, usize, C.sfIpAddress, u16) C.sfSocketStatus
fn C.sfUdpSocket_receive(&C.sfUdpSocket, voidptr, usize, &usize, &C.sfIpAddress, &u16) C.sfSocketStatus
fn C.sfUdpSocket_sendPacket(&C.sfUdpSocket, &C.sfPacket, C.sfIpAddress, u16) C.sfSocketStatus
fn C.sfUdpSocket_receivePacket(&C.sfUdpSocket, &C.sfPacket, &C.sfIpAddress, &u16) C.sfSocketStatus

// new_udp_socket: create a new UDP socket
pub fn new_udp_socket() !&UdpSocket {
	unsafe {
		result := &UdpSocket(C.sfUdpSocket_create())
		if voidptr(result) == C.NULL {
			return error('new_udp_socket failed')
		}
		return result
	}
}

// free: destroy a UDP socket
[unsafe]
pub fn (u &UdpSocket) free() {
	unsafe {
		C.sfUdpSocket_destroy(&C.sfUdpSocket(u))
	}
}

// set_blocking: set the blocking state of a UDP listener
// In blocking mode, calls will not return until they have
// completed their task. For example, a call to
// receive in blocking mode won't return until
// new data was actually received.
// In non-blocking mode, calls will always return immediately,
// using the return code to signal whether there was data
// available or not.
// By default, all sockets are blocking.
pub fn (u &UdpSocket) set_blocking(blocking bool) {
	unsafe {
		C.sfUdpSocket_setBlocking(&C.sfUdpSocket(u), int(blocking))
	}
}

// is_blocking: tell whether a UDP socket is in blocking or non-blocking mode
pub fn (u &UdpSocket) is_blocking() bool {
	unsafe {
		return C.sfUdpSocket_isBlocking(&C.sfUdpSocket(u)) != 0
	}
}

// bind: bind a UDP socket to a specific port
// Binding the socket to a port is necessary for being
// able to receive data on that port.
// You can use the special value 0 to tell the
// system to automatically pick an available port, and then
// call getLocalPort to retrieve the chosen port.
// If there is no specific address to listen to, pass Any
pub fn (u &UdpSocket) bind(port u16, address IpAddress) SocketStatus {
	unsafe {
		return SocketStatus(C.sfUdpSocket_bind(&C.sfUdpSocket(u), u16(port), *&C.sfIpAddress(&address)))
	}
}

// unbind: unbind a UDP socket from the local port to which it is bound
// The port that the socket was previously using is immediately
// available after this function is called. If the
// socket is not bound to a port, this function has no effect.
pub fn (u &UdpSocket) unbind() {
	unsafe {
		C.sfUdpSocket_unbind(&C.sfUdpSocket(u))
	}
}

// send: send raw data to a remote peer with a UDP socket
// Make sure that size is not greater than
// maxDatagramSize(), otherwise this function will
// fail and no data will be sent.
pub fn (u &UdpSocket) send(params UdpSocketSendParams) SocketStatus {
	unsafe {
		return SocketStatus(C.sfUdpSocket_send(&C.sfUdpSocket(u), voidptr(params.data),
			usize(params.size), *&C.sfIpAddress(&params.remote_address), u16(params.remote_port)))
	}
}

// UdpSocketSendParams: parameters for send
pub struct UdpSocketSendParams {
pub:
	data           voidptr   [required] // pointer to the sequence of bytes to send
	size           u64       [required] // number of bytes to send
	remote_address IpAddress [required] // address of the receiver
	remote_port    u16       [required] // port of the receiver to send the data to
}

// receive: receive raw data from a remote peer with a UDP socket
// In blocking mode, this function will wait until some
// bytes are actually received.
// Be careful to use a buffer which is large enough for
// the data that you intend to receive, if it is too small
// then an error will be returned and *all* the data will
// be lost.
pub fn (u &UdpSocket) receive(params UdpSocketReceiveParams) SocketStatus {
	unsafe {
		return SocketStatus(C.sfUdpSocket_receive(&C.sfUdpSocket(u), voidptr(params.data),
			usize(params.size), &usize(params.received), &C.sfIpAddress(params.remote_address),
			&u16(params.remote_port)))
	}
}

// UdpSocketReceiveParams: parameters for receive
pub struct UdpSocketReceiveParams {
pub:
	data           voidptr    [required] // pointer to the array to fill with the received bytes
	size           u64        [required] // maximum number of bytes that can be received
	received       &u64       [required] // this variable is filled with the actual number of bytes received
	remote_address &IpAddress [required] // address of the peer that sent the data
	remote_port    &u16       [required] // port of the peer that sent the data
}

// send_packet: send a formatted packet of data to a remote peer with a UDP socket
// Make sure that the packet size is not greater than
// maxDatagramSize(), otherwise this function will
// fail and no data will be sent.
pub fn (u &UdpSocket) send_packet(params UdpSocketSendPacketParams) SocketStatus {
	unsafe {
		return SocketStatus(C.sfUdpSocket_sendPacket(&C.sfUdpSocket(u), &C.sfPacket(params.packet),
			*&C.sfIpAddress(&params.remote_address), u16(params.remote_port)))
	}
}

// UdpSocketSendPacketParams: parameters for send_packet
pub struct UdpSocketSendPacketParams {
pub:
	packet         &Packet   [required] // packet to send
	remote_address IpAddress [required] // address of the receiver
	remote_port    u16       [required] // port of the receiver to send the data to
}

// receive_packet: receive a formatted packet of data from a remote peer with a UDP socket
// In blocking mode, this function will wait until the whole packet
// has been received.
pub fn (u &UdpSocket) receive_packet(params UdpSocketReceivePacketParams) SocketStatus {
	unsafe {
		return SocketStatus(C.sfUdpSocket_receivePacket(&C.sfUdpSocket(u), &C.sfPacket(params.packet),
			&C.sfIpAddress(params.remote_address), &u16(params.remote_port)))
	}
}

// UdpSocketReceivePacketParams: parameters for receive_packet
pub struct UdpSocketReceivePacketParams {
pub:
	packet         &Packet    [required] // address of the peer that sent the data
	remote_address &IpAddress [required] // port of the peer that sent the data
	remote_port    &u16       [required]
}
