module vibe

import v.vmod

const manifest = vmod.decode($embed_file('../v.mod').to_string()) or { panic(err) }

// Initializes a new session to send and receive responses.
pub fn init_session(opts SessionOpts) !Session {
	return init_session_(opts)!
}

// Releases resources that the session acquired with the underlying libcurl module.
pub fn (session Session) close() {
	session.close_()
}

// Sends a GET request to the specified `url` and returns the response.
pub fn (session Session) get(url string) !Response {
	return session.get_(url)!
}

// Sends a GET request to the specified `url` and returns a slice of the response content.
// Allocation of the received response as a vstring is postponed until the `start` byte position is reached.
// The content is returned as soon as the slice reaches its `max_size` (offset from `start`)
// - `max_size` can be `none` to return the remainder from the start.
pub fn (session Session) get_slice(url string, start u32, size ?u32) !Response {
	return session.get_slice_(url, start, size)!
}

// Sends a POST request to the specified `url` and returns the response.
pub fn (session Session) post(url string, data string) !Response {
	return session.post_(url, data)!
}

// Returns the message associated with the status code.
pub fn (status Status) msg() string {
	return status.msg_()
}
