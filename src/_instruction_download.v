module vibe

import os
import vibe.curl

fn (req Request) download_file_(url string, file_path string) !Response {
	h := curl.easy_init() or { return http_error(.easy_init, none) }
	header := set_header(req.headers, h)
	defer {
		curl.easy_cleanup(h)
		curl.slist_free_all(header)
	}

	mut resp := req.head__(h, url)!
	mut file := os.create(file_path)!
	defer {
		file.close()
	}
	mut fw := FileWriter{
		file: file
	}
	curl.easy_setopt(h, .header, 0)
	curl.easy_setopt(h, .writefunction, write_download)
	curl.easy_setopt(h, .writedata, &fw)
	send_request(h)!

	mut status_code := 0
	curl.easy_getinfo(h, .response_code, &status_code)
	resp.status = Status(status_code)
	resp.get_http_version()!

	return resp
}

fn (req Request) download_file_with_progress_(url string, file_path string, cb fn (Download)) !Response {
	h := curl.easy_init() or { return http_error(.easy_init, none) }
	header := set_header(req.headers, h)
	defer {
		curl.easy_cleanup(h)
		curl.slist_free_all(header)
	}

	mut resp := req.head__(h, url)!
	mut file := os.create(file_path)!
	defer {
		file.close()
	}

	mut length := u64(0)
	curl.easy_getinfo(h, .content_length_download_t, &length)
	mut fw := FileWriter{
		file: file
		cb: cb
		download: Download{
			size: length
			file_path: file_path
		}
	}

	curl.easy_setopt(h, .header, 0)
	curl.easy_setopt(h, .httpget, 1)
	curl.easy_setopt(h, .writefunction, write_download_with_progress)
	curl.easy_setopt(h, .writedata, &fw)
	send_request(h)!

	mut status_code := 0
	curl.easy_getinfo(h, .response_code, &status_code)
	resp.status = Status(status_code)
	resp.get_http_version()!

	return resp
}
