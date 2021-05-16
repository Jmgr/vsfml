module network

#include <SFML/Network/TcpListener.h>

fn C.sfTcpListener_create() &C.sfTcpListener
fn C.sfTcpListener_destroy(&C.sfTcpListener)
fn C.sfTcpListener_setBlocking(&C.sfTcpListener, int)
fn C.sfTcpListener_isBlocking(&C.sfTcpListener) int
fn C.sfTcpListener_listen(&C.sfTcpListener, u16, C.sfIpAddress) C.sfSocketStatus
fn C.sfTcpListener_accept(&C.sfTcpListener, &&C.sfTcpSocket) C.sfSocketStatus

// new_tcp_listener: create a new TCP listener
pub fn new_tcp_listener() ?&TcpListener {
	unsafe {
		result := &TcpListener(C.sfTcpListener_create())
		if voidptr(result) == C.NULL {
			return error('new_tcp_listener failed')
		}
		return result
	}
}

// free: destroy a TCP listener
[unsafe]
pub fn (t &TcpListener) free() {
	unsafe {
		C.sfTcpListener_destroy(&C.sfTcpListener(t))
	}
}

// set_blocking: set the blocking state of a TCP listener
// In blocking mode, calls will not return until they have
// completed their task. For example, a call to
// accept in blocking mode won't return until
// a new connection was actually received.
// In non-blocking mode, calls will always return immediately,
// using the return code to signal whether there was data
// available or not.
// By default, all sockets are blocking.
pub fn (t &TcpListener) set_blocking(blocking bool) {
	unsafe {
		C.sfTcpListener_setBlocking(&C.sfTcpListener(t), int(blocking))
	}
}

// is_blocking: tell whether a TCP listener is in blocking or non-blocking mode
pub fn (t &TcpListener) is_blocking() bool {
	unsafe {
		return C.sfTcpListener_isBlocking(&C.sfTcpListener(t)) != 0
	}
}

// listen: start listening for connections
// This functions makes the socket listen to the specified
// port, waiting for new connections.
// If the socket was previously listening to another port,
// it will be stopped first and bound to the new port.
// If there is no specific address to listen to, pass Any
pub fn (t &TcpListener) listen(port u16, address IpAddress) SocketStatus {
	unsafe {
		return SocketStatus(C.sfTcpListener_listen(&C.sfTcpListener(t), u16(port), C.sfIpAddress(address)))
	}
}

// accept: accept a new connection
// If the socket is in blocking mode, this function will
// not return until a connection is actually received.
// The connected argument points to a valid TcpSocket pointer
// in case of success (the function returns SocketDone), it points
// to a NULL pointer otherwise.
pub fn (t &TcpListener) accept(connected &&TcpSocket) SocketStatus {
	unsafe {
		return SocketStatus(C.sfTcpListener_accept(&C.sfTcpListener(t), &&C.sfTcpSocket(connected)))
	}
}
