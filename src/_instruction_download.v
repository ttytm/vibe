module vibe

import os
import vibe.curl

fn (req Request) download_file_(url string, file_path string) !Response {
	h := curl.easy_init() or { return http_error(.easy_init, none) }
	header := set_header(h, common: req.headers, custom: req.custom_headers)
	defer {
		curl.easy_cleanup(h)
		curl.slist_free_all(header)
	}

	mut resp := req.head__(h, url)!
	mut file := os.create(file_path)!
	defer {
		file.close()
	}
	mut w := FileWriter{
		file: file
	}
	set_download_opts(h, w)
	send_request(h)!

	mut status_code := 0
	curl.easy_getinfo(h, .response_code, &status_code)
	resp.status = Status(status_code)
	resp.get_http_version()!

	return resp
}

fn (req Request) download_file_with_progress_(url string, file_path string, mut dl Download) !Response {
	h := curl.easy_init() or { return http_error(.easy_init, none) }
	header := set_header(h, common: req.headers, custom: req.custom_headers)
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
	mut w := ProgressWriter{
		file: file
		size: length
		download: dl
	}
	set_download_opts(h, w)
	send_request(h)!
	dl.finish()

	mut status_code := 0
	curl.easy_getinfo(h, .response_code, &status_code)
	resp.status = Status(status_code)
	resp.get_http_version()!

	return resp
}

fn set_download_opts(h &C.CURL, w DownloadWriter) {
	curl.easy_setopt(h, .header, 0)
	curl.easy_setopt(h, .headerfunction, write_null)
	curl.easy_setopt(h, .httpget, 1)
	curl.easy_setopt(h, .writedata, &w)
	match w {
		FileWriter { curl.easy_setopt(h, .writefunction, write_download) }
		ProgressWriter { curl.easy_setopt(h, .writefunction, write_download_with_progress) }
	}
}
