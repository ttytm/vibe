module vibe

import v.vmod

const manifest = vmod.decode($embed_file('../v.mod').to_string()) or { panic(err) }

// get sends a GET request to the specified `url` and returns the response.
pub fn get(url string) !Response {
	return Request{}.get_(url)!
}

// get send a GET request to the specified `url` and returns the response.
pub fn (req Request) get(url string) !Response {
	return req.get_(url)!
}

// get_slice sends a GET request to the specified `url` and returns a slice of the response content.
// Allocation of the received response as a vstring is postponed until the `start` byte position is reached.
// The content is returned as soon as the slice reaches its `max_size` (offset from `start`)
// - `max_size` can be `none` to return the remainder from the start.
pub fn get_slice(url string, start usize, size ?usize) !Response {
	return Request{}.get_slice_(url, start, size)!
}

// get_slice sends a GET request to the specified `url` and returns a slice of the response content.
// Allocation of the received response as a vstring is postponed until the `start` byte position is reached.
// The content is returned as soon as the slice reaches its `max_size` (offset from `start`)
// - `max_size` can be `none` to return the remainder from the start.
pub fn (req Request) get_slice(url string, start usize, size ?usize) !Response {
	return req.get_slice_(url, start, size)!
}

// head sends a HEAD request to the specified `url` and returns the response.
pub fn head(url string) !Response {
	return Request{}.head_(url)!
}

// head sends a HEAD request to the specified `url` and returns the response.
pub fn (req Request) head(url string) !Response {
	return req.head_(url)!
}

// download_file downloads a document from the specified `url` and saves it to the specified `file_path`.
pub fn download_file(url string, file_path string) !Response {
	return Request{}.download_file_(url, file_path)!
}

// download_file downloads a document from the specified `url` and saves it to the specified `file_path`.
pub fn (req Request) download_file(url string, file_path string) !Response {
	return req.download_file_(url, file_path)!
}

// download_file_with_progress downloads a document from the specified `url` and saves it to the specified `file_path`.
// `download` must implement a `progress(pos u64, size u64)`, and a `finish()` method.
pub fn download_file_with_progress(url string, file_path string, mut download Download) !Response {
	return Request{}.download_file_with_progress_(url, file_path, mut download)!
}

// download_file_with_progress downloads a document from the specified `url` and saves it to the specified `file_path`.
// `download` must implement a `progress(pos u64, size u64)`, and a `finish()` method.
pub fn (req Request) download_file_with_progress(url string, file_path string, mut download Download) !Response {
	return req.download_file_with_progress_(url, file_path, mut download)!
}

// post sends a POST request to the specified `url` and returns the response.
pub fn post(url string, data string) !Response {
	return Request{}.post_(url, data)!
}

// post sends a POST request to the specified `url` and returns the response.
pub fn (req Request) post(url string, data string) !Response {
	return req.post_(url, data)!
}

// msg returns the message associated with the status code.
pub fn (status Status) msg() string {
	return status.msg_()
}

// custom_init initializes libcurl with a custom flag.
pub fn custom_init(flag CustomInitFlag) {
	custom_init_(flag)
}

// cleanup releases resources that were acquired initializing the underlying libcurl module.
pub fn cleanup() {
	cleanup_()
}
