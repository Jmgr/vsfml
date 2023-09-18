module network

import system

#include <SFML/Network/Ftp.h>

// FtpTransferMode: enumeration of transfer modes
pub enum FtpTransferMode {
	binary // Binary mode (file is transfered as a sequence of bytes)
	ascii // Text mode using ASCII encoding
	ebcdic // Text mode using EBCDIC encoding
}

// FtpStatus: status codes possibly returned by a FTP response
pub enum FtpStatus {
	restart_marker_reply = 110 // Restart marker reply
	service_ready_soon = 120 // Service ready in N minutes
	data_connection_already_opened = 125 // Data connection already opened, transfer starting
	opening_data_connection = 150 // File status ok, about to open data connection
	ok = 200 // Command ok
	pointless_command = 202 // Command not implemented
	system_status = 211 // System status, or system help reply
	directory_status = 212 // Directory status
	file_status = 213 // File status
	help_message = 214 // Help message
	system_type = 215 // NAME system type, where NAME is an official system name from the list in the Assigned Numbers document
	service_ready = 220 // Service ready for new user
	closing_connection = 221 // Service closing control connection
	data_connection_opened = 225 // Data connection open, no transfer in progress
	closing_data_connection = 226 // Closing data connection, requested file action successful
	entering_passive_mode = 227 // Entering passive mode
	logged_in = 230 // User logged in, proceed. Logged out if appropriate
	file_action_ok = 250 // Requested file action ok
	directory_ok = 257 // PATHNAME created
	need_password = 331 // User name ok, need password
	need_account_to_log_in = 332 // Need account for login
	need_information = 350 // Requested file action pending further information
	service_unavailable = 421 // Service not available, closing control connection
	data_connection_unavailable = 425 // Can't open data connection
	transfer_aborted = 426 // Connection closed, transfer aborted
	file_action_aborted = 450 // Requested file action not taken
	local_error = 451 // Requested action aborted, local error in processing
	insufficient_storage_space = 452 // Requested action not taken; insufficient storage space in system, file unavailable
	command_unknown = 500 // Syntax error, command unrecognized
	parameters_unknown = 501 // Syntax error in parameters or arguments
	command_not_implemented = 502 // Command not implemented
	bad_command_sequence = 503 // Bad sequence of commands
	parameter_not_implemented = 504 // Command not implemented for that parameter
	not_logged_in = 530 // Not logged in
	need_account_to_store = 532 // Need account for storing files
	file_unavailable = 550 // Requested action not taken, file unavailable
	page_type_unknown = 551 // Requested action aborted, page type unknown
	not_enough_memory = 552 // Requested file action aborted, exceeded storage allocation
	filename_not_allowed = 553 // Requested action not taken, file name not allowed
	invalid_response = 1000 // Response is not a valid FTP one
	connection_failed = 1001 // Connection with server failed
	connection_closed = 1002 // Connection with server closed
	invalid_file = 1003 // Invalid file to upload / download
}

fn C.sfFtpListingResponse_destroy(&C.sfFtpListingResponse)
fn C.sfFtpListingResponse_isOk(&C.sfFtpListingResponse) int
fn C.sfFtpListingResponse_getStatus(&C.sfFtpListingResponse) C.sfFtpStatus
fn C.sfFtpListingResponse_getMessage(&C.sfFtpListingResponse) &char
fn C.sfFtpListingResponse_getCount(&C.sfFtpListingResponse) usize
fn C.sfFtpListingResponse_getName(&C.sfFtpListingResponse, usize) &char
fn C.sfFtpDirectoryResponse_destroy(&C.sfFtpDirectoryResponse)
fn C.sfFtpDirectoryResponse_isOk(&C.sfFtpDirectoryResponse) int
fn C.sfFtpDirectoryResponse_getStatus(&C.sfFtpDirectoryResponse) C.sfFtpStatus
fn C.sfFtpDirectoryResponse_getMessage(&C.sfFtpDirectoryResponse) &char
fn C.sfFtpDirectoryResponse_getDirectory(&C.sfFtpDirectoryResponse) &char
fn C.sfFtpResponse_destroy(&C.sfFtpResponse)
fn C.sfFtpResponse_isOk(&C.sfFtpResponse) int
fn C.sfFtpResponse_getStatus(&C.sfFtpResponse) C.sfFtpStatus
fn C.sfFtpResponse_getMessage(&C.sfFtpResponse) &char
fn C.sfFtp_create() &C.sfFtp
fn C.sfFtp_destroy(&C.sfFtp)
fn C.sfFtp_connect(&C.sfFtp, C.sfIpAddress, u16, C.sfTime) &C.sfFtpResponse
fn C.sfFtp_loginAnonymous(&C.sfFtp) &C.sfFtpResponse
fn C.sfFtp_login(&C.sfFtp, &char, &char) &C.sfFtpResponse
fn C.sfFtp_disconnect(&C.sfFtp) &C.sfFtpResponse
fn C.sfFtp_keepAlive(&C.sfFtp) &C.sfFtpResponse
fn C.sfFtp_getWorkingDirectory(&C.sfFtp) &C.sfFtpDirectoryResponse
fn C.sfFtp_getDirectoryListing(&C.sfFtp, &char) &C.sfFtpListingResponse
fn C.sfFtp_changeDirectory(&C.sfFtp, &char) &C.sfFtpResponse
fn C.sfFtp_parentDirectory(&C.sfFtp) &C.sfFtpResponse
fn C.sfFtp_createDirectory(&C.sfFtp, &char) &C.sfFtpResponse
fn C.sfFtp_deleteDirectory(&C.sfFtp, &char) &C.sfFtpResponse
fn C.sfFtp_renameFile(&C.sfFtp, &char, &char) &C.sfFtpResponse
fn C.sfFtp_deleteFile(&C.sfFtp, &char) &C.sfFtpResponse
fn C.sfFtp_download(&C.sfFtp, &char, &char, C.sfFtpTransferMode) &C.sfFtpResponse
fn C.sfFtp_upload(&C.sfFtp, &char, &char, C.sfFtpTransferMode, int) &C.sfFtpResponse
fn C.sfFtp_sendCommand(&C.sfFtp, &char, &char) &C.sfFtpResponse

// free: destroy a FTP listing response
[unsafe]
pub fn (f &FtpListingResponse) free() {
	unsafe {
		C.sfFtpListingResponse_destroy(&C.sfFtpListingResponse(f))
	}
}

// is_ok: check if a FTP listing response status code means a success
// This function is defined for convenience, it is
// equivalent to testing if the status code is < 400.
pub fn (f &FtpListingResponse) is_ok() bool {
	unsafe {
		return C.sfFtpListingResponse_isOk(&C.sfFtpListingResponse(f)) != 0
	}
}

// get_status: get the status code of a FTP listing response
pub fn (f &FtpListingResponse) get_status() FtpStatus {
	unsafe {
		return FtpStatus(C.sfFtpListingResponse_getStatus(&C.sfFtpListingResponse(f)))
	}
}

// get_message: get the full message contained in a FTP listing response
pub fn (f &FtpListingResponse) get_message() string {
	unsafe {
		return cstring_to_vstring(C.sfFtpListingResponse_getMessage(&C.sfFtpListingResponse(f)))
	}
}

// get_count: return the number of directory/file names contained in a FTP listing response
pub fn (f &FtpListingResponse) get_count() u64 {
	unsafe {
		return u64(C.sfFtpListingResponse_getCount(&C.sfFtpListingResponse(f)))
	}
}

// get_name: return a directory/file name contained in a FTP listing response
pub fn (f &FtpListingResponse) get_name(index u64) string {
	unsafe {
		return cstring_to_vstring(C.sfFtpListingResponse_getName(&C.sfFtpListingResponse(f),
			usize(index)))
	}
}

// free: destroy a FTP directory response
[unsafe]
pub fn (f &FtpDirectoryResponse) free() {
	unsafe {
		C.sfFtpDirectoryResponse_destroy(&C.sfFtpDirectoryResponse(f))
	}
}

// is_ok: check if a FTP directory response status code means a success
// This function is defined for convenience, it is
// equivalent to testing if the status code is < 400.
pub fn (f &FtpDirectoryResponse) is_ok() bool {
	unsafe {
		return C.sfFtpDirectoryResponse_isOk(&C.sfFtpDirectoryResponse(f)) != 0
	}
}

// get_status: get the status code of a FTP directory response
pub fn (f &FtpDirectoryResponse) get_status() FtpStatus {
	unsafe {
		return FtpStatus(C.sfFtpDirectoryResponse_getStatus(&C.sfFtpDirectoryResponse(f)))
	}
}

// get_message: get the full message contained in a FTP directory response
pub fn (f &FtpDirectoryResponse) get_message() string {
	unsafe {
		return cstring_to_vstring(C.sfFtpDirectoryResponse_getMessage(&C.sfFtpDirectoryResponse(f)))
	}
}

// get_directory: get the directory returned in a FTP directory response
pub fn (f &FtpDirectoryResponse) get_directory() string {
	unsafe {
		return cstring_to_vstring(C.sfFtpDirectoryResponse_getDirectory(&C.sfFtpDirectoryResponse(f)))
	}
}

// free: destroy a FTP response
[unsafe]
pub fn (f &FtpResponse) free() {
	unsafe {
		C.sfFtpResponse_destroy(&C.sfFtpResponse(f))
	}
}

// is_ok: check if a FTP response status code means a success
// This function is defined for convenience, it is
// equivalent to testing if the status code is < 400.
pub fn (f &FtpResponse) is_ok() bool {
	unsafe {
		return C.sfFtpResponse_isOk(&C.sfFtpResponse(f)) != 0
	}
}

// get_status: get the status code of a FTP response
pub fn (f &FtpResponse) get_status() FtpStatus {
	unsafe {
		return FtpStatus(C.sfFtpResponse_getStatus(&C.sfFtpResponse(f)))
	}
}

// get_message: get the full message contained in a FTP response
pub fn (f &FtpResponse) get_message() string {
	unsafe {
		return cstring_to_vstring(C.sfFtpResponse_getMessage(&C.sfFtpResponse(f)))
	}
}

// new_ftp: create a new Ftp object
pub fn new_ftp() !&Ftp {
	unsafe {
		result := &Ftp(C.sfFtp_create())
		if voidptr(result) == C.NULL {
			return error('new_ftp failed')
		}
		return result
	}
}

// free: destroy a Ftp object
[unsafe]
pub fn (f &Ftp) free() {
	unsafe {
		C.sfFtp_destroy(&C.sfFtp(f))
	}
}

// connect: connect to the specified FTP server
// The port should be 21, which is the standard
// port used by the FTP protocol. You shouldn't use a different
// value, unless you really know what you do.
// This function tries to connect to the server so it may take
// a while to complete, especially if the server is not
// reachable. To avoid blocking your application for too long,
// you can use a timeout. Using 0 means that the
// system timeout will be used (which is usually pretty long).
pub fn (f &Ftp) connect(params FtpConnectParams) !&FtpResponse {
	unsafe {
		result := &FtpResponse(C.sfFtp_connect(&C.sfFtp(f), *&C.sfIpAddress(&params.server),
			u16(params.port), *&C.sfTime(&params.timeout)))
		if voidptr(result) == C.NULL {
			return error('connect failed with server=$params.server port=$params.port timeout=$params.timeout')
		}
		return result
	}
}

// FtpConnectParams: parameters for connect
pub struct FtpConnectParams {
pub:
	server  IpAddress   [required] // name or address of the FTP server to connect to
	port    u16         [required] // port used for the connection
	timeout system.Time [required] // maximum time to wait
}

// login_anonymous: log in using an anonymous account
// Logging in is mandatory after connecting to the server.
// Users that are not logged in cannot perform any operation.
pub fn (f &Ftp) login_anonymous() !&FtpResponse {
	unsafe {
		result := &FtpResponse(C.sfFtp_loginAnonymous(&C.sfFtp(f)))
		if voidptr(result) == C.NULL {
			return error('login_anonymous failed')
		}
		return result
	}
}

// login: log in using a username and a password
// Logging in is mandatory after connecting to the server.
// Users that are not logged in cannot perform any operation.
pub fn (f &Ftp) login(name string, password string) !&FtpResponse {
	unsafe {
		result := &FtpResponse(C.sfFtp_login(&C.sfFtp(f), name.str, password.str))
		if voidptr(result) == C.NULL {
			return error('login failed with name=$name password=$password')
		}
		return result
	}
}

// disconnect: close the connection with the server
pub fn (f &Ftp) disconnect() !&FtpResponse {
	unsafe {
		result := &FtpResponse(C.sfFtp_disconnect(&C.sfFtp(f)))
		if voidptr(result) == C.NULL {
			return error('disconnect failed')
		}
		return result
	}
}

// keep_alive: send a null command to keep the connection alive
// This command is useful because the server may close the
// connection automatically if no command is sent.
pub fn (f &Ftp) keep_alive() !&FtpResponse {
	unsafe {
		result := &FtpResponse(C.sfFtp_keepAlive(&C.sfFtp(f)))
		if voidptr(result) == C.NULL {
			return error('keep_alive failed')
		}
		return result
	}
}

// get_working_directory: get the current working directory
// The working directory is the root path for subsequent
// operations involving directories and/or filenames.
pub fn (f &Ftp) get_working_directory() !&FtpDirectoryResponse {
	unsafe {
		result := &FtpDirectoryResponse(C.sfFtp_getWorkingDirectory(&C.sfFtp(f)))
		if voidptr(result) == C.NULL {
			return error('get_working_directory failed')
		}
		return result
	}
}

// get_directory_listing: get the contents of the given directory
// This function retrieves the sub-directories and files
// contained in the given directory. It is not recursive.
// The directory parameter is relative to the current
// working directory.
pub fn (f &Ftp) get_directory_listing(directory string) !&FtpListingResponse {
	unsafe {
		result := &FtpListingResponse(C.sfFtp_getDirectoryListing(&C.sfFtp(f), directory.str))
		if voidptr(result) == C.NULL {
			return error('get_directory_listing failed with directory=$directory')
		}
		return result
	}
}

// change_directory: change the current working directory
// The new directory must be relative to the current one.
pub fn (f &Ftp) change_directory(directory string) !&FtpResponse {
	unsafe {
		result := &FtpResponse(C.sfFtp_changeDirectory(&C.sfFtp(f), directory.str))
		if voidptr(result) == C.NULL {
			return error('change_directory failed with directory=$directory')
		}
		return result
	}
}

// parent_directory: go to the parent directory of the current one
pub fn (f &Ftp) parent_directory() !&FtpResponse {
	unsafe {
		result := &FtpResponse(C.sfFtp_parentDirectory(&C.sfFtp(f)))
		if voidptr(result) == C.NULL {
			return error('parent_directory failed')
		}
		return result
	}
}

// new_ftp_response_directory: create a new directory
// The new directory is created as a child of the current
// working directory.
pub fn new_ftp_response_directory(params FtpNewFtpResponseDirectoryParams) !&FtpResponse {
	unsafe {
		result := &FtpResponse(C.sfFtp_createDirectory(&C.sfFtp(params.ftp), params.name.str))
		if voidptr(result) == C.NULL {
			return error('new_ftp_response_directory failed with name=$params.name')
		}
		return result
	}
}

// FtpNewFtpResponseDirectoryParams: parameters for new_ftp_response_directory
pub struct FtpNewFtpResponseDirectoryParams {
pub:
	ftp  &Ftp   [required] // ftp object
	name string [required] // name of the directory to create
}

// delete_directory: remove an existing directory
// The directory to remove must be relative to the
// current working directory.
// Use this function with caution, the directory will
// be removed permanently!
pub fn (f &Ftp) delete_directory(name string) !&FtpResponse {
	unsafe {
		result := &FtpResponse(C.sfFtp_deleteDirectory(&C.sfFtp(f), name.str))
		if voidptr(result) == C.NULL {
			return error('delete_directory failed with name=$name')
		}
		return result
	}
}

// rename_file: rename an existing file
// The filenames must be relative to the current working
// directory.
pub fn (f &Ftp) rename_file(file string, newName string) !&FtpResponse {
	unsafe {
		result := &FtpResponse(C.sfFtp_renameFile(&C.sfFtp(f), file.str, newName.str))
		if voidptr(result) == C.NULL {
			return error('rename_file failed with file=$file newName=$newName')
		}
		return result
	}
}

// delete_file: remove an existing file
// The file name must be relative to the current working
// directory.
// Use this function with caution, the file will be
// removed permanently!
pub fn (f &Ftp) delete_file(name string) !&FtpResponse {
	unsafe {
		result := &FtpResponse(C.sfFtp_deleteFile(&C.sfFtp(f), name.str))
		if voidptr(result) == C.NULL {
			return error('delete_file failed with name=$name')
		}
		return result
	}
}

// download: download a file from a FTP server
// The filename of the distant file is relative to the
// current working directory of the server, and the local
// destination path is relative to the current directory
// of your application.
pub fn (f &Ftp) download(params FtpDownloadParams) !&FtpResponse {
	unsafe {
		result := &FtpResponse(C.sfFtp_download(&C.sfFtp(f), params.remote_file.str,
			params.local_path.str, *&C.sfFtpTransferMode(&params.mode)))
		if voidptr(result) == C.NULL {
			return error('download failed with remote_file=$params.remote_file local_path=$params.local_path mode=$params.mode')
		}
		return result
	}
}

// FtpDownloadParams: parameters for download
pub struct FtpDownloadParams {
pub:
	remote_file string          [required] // filename of the distant file to download
	local_path  string          [required] // where to put to file on the local computer
	mode        FtpTransferMode [required] // transfer mode
}

// upload: upload a file to a FTP server
// The name of the local file is relative to the current
// working directory of your application, and the
// remote path is relative to the current directory of the
// FTP server.
pub fn (f &Ftp) upload(params FtpUploadParams) !&FtpResponse {
	unsafe {
		result := &FtpResponse(C.sfFtp_upload(&C.sfFtp(f), params.local_file.str, params.remote_path.str,
			*&C.sfFtpTransferMode(&params.mode), int(params.append)))
		if voidptr(result) == C.NULL {
			return error('upload failed with local_file=$params.local_file remote_path=$params.remote_path mode=$params.mode append=$params.append')
		}
		return result
	}
}

// FtpUploadParams: parameters for upload
pub struct FtpUploadParams {
pub:
	local_file  string          [required] // path of the local file to upload
	remote_path string          [required] // where to put to file on the server
	mode        FtpTransferMode [required] // transfer mode
	append      bool            [required] // pass true to append to or false to overwrite the remote file if it already exists
}

// send_command: send a command to the FTP server
// While the most often used commands are provided as
// specific functions, this function can be used to send
// any FTP command to the server. If the command requires
// one or more parameters, they can be specified in
pub fn (f &Ftp) send_command(command string, parameter string) !&FtpResponse {
	unsafe {
		result := &FtpResponse(C.sfFtp_sendCommand(&C.sfFtp(f), command.str, parameter.str))
		if voidptr(result) == C.NULL {
			return error('send_command failed with command=$command parameter=$parameter')
		}
		return result
	}
}
