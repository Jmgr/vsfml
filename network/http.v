module network

import system

#include <SFML/Network/Http.h>

// HttpMethod: enumerate the available HTTP methods for a request
pub enum HttpMethod {
	get // Request in get mode, standard method to retrieve a page
	post // Request in post mode, usually to send data to a page
	head // Request a page's header only
	put // Request in put mode, useful for a REST API
	delete // Request in delete mode, useful for a REST API
}

// HttpStatus: enumerate all the valid status codes for a response
pub enum HttpStatus {
	ok = 200 // Most common code returned when operation was successful
	created = 201 // The resource has successfully been created
	accepted = 202 // The request has been accepted, but will be processed later by the server
	no_content = 204 // Sent when the server didn't send any data in return
	reset_content = 205 // The server informs the client that it should clear the view (form) that caused the request to be sent
	partial_content = 206 // The server has sent a part of the resource, as a response to a partial GET request
	multiple_choices = 300 // The requested page can be accessed from several locations
	moved_permanently = 301 // The requested page has permanently moved to a new location
	moved_temporarily = 302 // The requested page has temporarily moved to a new location
	not_modified = 304 // For conditional requests, means the requested page hasn't changed and doesn't need to be refreshed
	bad_request = 400 // The server couldn't understand the request (syntax error)
	unauthorized = 401 // The requested page needs an authentication to be accessed
	forbidden = 403 // The requested page cannot be accessed at all, even with authentication
	not_found = 404 // The requested page doesn't exist
	range_not_satisfiable = 407 // The server can't satisfy the partial GET request (with a "Range" header field)
	internal_server_error = 500 // The server encountered an unexpected error
	not_implemented = 501 // The server doesn't implement a requested feature
	bad_gateway = 502 // The gateway server has received an error from the source server
	service_not_available = 503 // The server is temporarily unavailable (overloaded, in maintenance, ...)
	gateway_timeout = 504 // The gateway server couldn't receive a response from the source server
	version_not_supported = 505 // The server doesn't support the requested HTTP version
	invalid_response = 1000 // Response is not a valid HTTP one
	connection_failed = 1001 // Connection with server failed
}

fn C.sfHttpRequest_create() &C.sfHttpRequest
fn C.sfHttpRequest_destroy(&C.sfHttpRequest)
fn C.sfHttpRequest_setField(&C.sfHttpRequest, &char, &char)
fn C.sfHttpRequest_setMethod(&C.sfHttpRequest, C.sfHttpMethod)
fn C.sfHttpRequest_setUri(&C.sfHttpRequest, &char)
fn C.sfHttpRequest_setHttpVersion(&C.sfHttpRequest, u32, u32)
fn C.sfHttpRequest_setBody(&C.sfHttpRequest, &char)
fn C.sfHttpResponse_destroy(&C.sfHttpResponse)
fn C.sfHttpResponse_getField(&C.sfHttpResponse, &char) &char
fn C.sfHttpResponse_getStatus(&C.sfHttpResponse) C.sfHttpStatus
fn C.sfHttpResponse_getBody(&C.sfHttpResponse) &char
fn C.sfHttp_create() &C.sfHttp
fn C.sfHttp_destroy(&C.sfHttp)
fn C.sfHttp_setHost(&C.sfHttp, &char, u16)
fn C.sfHttp_sendRequest(&C.sfHttp, &C.sfHttpRequest, C.sfTime) &C.sfHttpResponse

// new_http_request: create a new HTTP request
pub fn new_http_request() !&HttpRequest {
	unsafe {
		result := &HttpRequest(C.sfHttpRequest_create())
		if voidptr(result) == C.NULL {
			return error('new_http_request failed')
		}
		return result
	}
}

// free: destroy a HTTP request
[unsafe]
pub fn (h &HttpRequest) free() {
	unsafe {
		C.sfHttpRequest_destroy(&C.sfHttpRequest(h))
	}
}

// set_field: set the value of a header field of a HTTP request
// The field is created if it doesn't exist. The name of
// the field is case insensitive.
// By default, a request doesn't contain any field (but the
// mandatory fields are added later by the HTTP client when
// sending the request).
pub fn (h &HttpRequest) set_field(field string, value string) {
	unsafe {
		C.sfHttpRequest_setField(&C.sfHttpRequest(h), field.str, value.str)
	}
}

// set_method: set a HTTP request method
// See the HttpMethod enumeration for a complete list of all
// the availale methods.
// The method is HttpGet by default.
pub fn (h &HttpRequest) set_method(method HttpMethod) {
	unsafe {
		C.sfHttpRequest_setMethod(&C.sfHttpRequest(h), *&C.sfHttpMethod(&method))
	}
}

// set_uri: set a HTTP request URI
// The URI is the resource (usually a web page or a file)
// that you want to get or post.
// The URI is "/" (the root page) by default.
pub fn (h &HttpRequest) set_uri(uri string) {
	unsafe {
		C.sfHttpRequest_setUri(&C.sfHttpRequest(h), uri.str)
	}
}

// set_http_version: set the HTTP version of a HTTP request
// The HTTP version is 1.0 by default.
pub fn (h &HttpRequest) set_http_version(major u32, minor u32) {
	unsafe {
		C.sfHttpRequest_setHttpVersion(&C.sfHttpRequest(h), u32(major), u32(minor))
	}
}

// set_body: set the body of a HTTP request
// The body of a request is optional and only makes sense
// for POST requests. It is ignored for all other methods.
// The body is empty by default.
pub fn (h &HttpRequest) set_body(body string) {
	unsafe {
		C.sfHttpRequest_setBody(&C.sfHttpRequest(h), body.str)
	}
}

// free: destroy a HTTP response
[unsafe]
pub fn (h &HttpResponse) free() {
	unsafe {
		C.sfHttpResponse_destroy(&C.sfHttpResponse(h))
	}
}

// get_field: get the value of a field of a HTTP response
// If the field field is not found in the response header,
// the empty string is returned. This function uses
// case-insensitive comparisons.
pub fn (h &HttpResponse) get_field(field string) string {
	unsafe {
		return cstring_to_vstring(C.sfHttpResponse_getField(&C.sfHttpResponse(h), field.str))
	}
}

// get_status: get the status code of a HTTP reponse
// The status code should be the first thing to be checked
// after receiving a response, it defines whether it is a
// success, a failure or anything else (see the HttpStatus
// enumeration).
pub fn (h &HttpResponse) get_status() HttpStatus {
	unsafe {
		return HttpStatus(C.sfHttpResponse_getStatus(&C.sfHttpResponse(h)))
	}
}

// get_body: get the body of a HTTP response
// The body of a response may contain:
pub fn (h &HttpResponse) get_body() string {
	unsafe {
		return cstring_to_vstring(C.sfHttpResponse_getBody(&C.sfHttpResponse(h)))
	}
}

// new_http: create a new Http object
pub fn new_http() !&Http {
	unsafe {
		result := &Http(C.sfHttp_create())
		if voidptr(result) == C.NULL {
			return error('new_http failed')
		}
		return result
	}
}

// free: destroy a Http object
[unsafe]
pub fn (h &Http) free() {
	unsafe {
		C.sfHttp_destroy(&C.sfHttp(h))
	}
}

// set_host: set the target host of a HTTP object
// This function just stores the host address and port, it
// doesn't actually connect to it until you send a request.
// If the port is 0, it means that the HTTP client will use
// the right port according to the protocol used
// (80 for HTTP, 443 for HTTPS). You should
// leave it like this unless you really need a port other
// than the standard one, or use an unknown protocol.
pub fn (h &Http) set_host(host string, port u16) {
	unsafe {
		C.sfHttp_setHost(&C.sfHttp(h), host.str, u16(port))
	}
}

// send_request: send a HTTP request and return the server's response.
// You must have a valid host before sending a request (see setHost).
// Any missing mandatory header field in the request will be added
// with an appropriate value.
// Warning: this function waits for the server's response and may
// not return instantly; use a thread if you don't want to block your
// application, or use a timeout to limit the time to wait. A value
// of 0 means that the client will use the system defaut timeout
// (which is usually pretty long).
pub fn (h &Http) send_request(request &HttpRequest, timeout system.Time) !&HttpResponse {
	unsafe {
		result := &HttpResponse(C.sfHttp_sendRequest(&C.sfHttp(h), &C.sfHttpRequest(request),
			*&C.sfTime(&timeout)))
		if voidptr(result) == C.NULL {
			return error('send_request failed with timeout=$timeout')
		}
		return result
	}
}
