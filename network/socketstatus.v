module network

#include <SFML/Network/SocketStatus.h>

// SocketStatus: define the status that can be returned by the socket functions
pub enum SocketStatus {
	done // The socket has sent / received the data
	not_ready // The socket is not ready to send / receive data yet
	partial // The socket sent a part of the data
	disconnected // The TCP socket has been disconnected
	error // An unexpected error happened
}
