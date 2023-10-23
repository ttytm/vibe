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

	mut resp := req.follow_download_head(h, url)!
	mut file := os.create(file_path)!
	defer {
		file.close()
	}
	mut fw := FileWriter{
		file: file
	}
	req.set_download_opts(h)
	curl.easy_setopt(h, .writefunction, write_download)
	curl.easy_setopt(h, .writedata, &fw)
	send_request(h)!

	curl.easy_getinfo(h, .response_code, &resp.status_code)
	resp.status = Status(resp.status_code)
	resp.get_http_version()!

	return resp.Response
}

fn (req Request) download_file_with_progress_(url string, file_path string, mut dl Download) !Response {
	h := curl.easy_init() or { return http_error(.easy_init, none) }
	header := set_header(h, common: req.headers, custom: req.custom_headers)
	defer {
		curl.easy_cleanup(h)
		curl.slist_free_all(header)
	}

	mut resp := req.follow_download_head(h, url)!
	mut file := os.create(file_path)!
	defer {
		file.close()
	}

	mut length := u64(0)
	curl.easy_getinfo(h, .content_length_download_t, &length)
	mut fw := ProgressWriter{
		file: file
		size: length
		download: dl
	}
	req.set_download_opts(h)
	curl.easy_setopt(h, .writefunction, write_download_with_progress)
	curl.easy_setopt(h, .writedata, &fw)
	send_request(h)!
	dl.finish()

	curl.easy_getinfo(h, .response_code, &resp.status_code)
	resp.status = Status(resp.status_code)
	resp.get_http_version()!

	return resp.Response
}

fn (req Request) set_download_opts(h &curl.Handle) {
	curl.easy_setopt(h, .header, 0)
	curl.easy_setopt(h, .headerfunction, write_null)
	curl.easy_setopt(h, .httpget, 1)
}

// Follows redirects, sets the handle's URL opt to the latest URL of the redirected destination and sets header data.
// Used to retrieve the head before sending the actual download request.
fn (req Request) follow_download_head(h &curl.Handle, url string) !VibeResponse {
	mut resp := VibeResponse{}
	req.set_head_opts(h, url, &resp)
	send_request(h)!

	curl.easy_getinfo(h, .response_code, &resp.status_code)
	if resp.status_code / 100 == 3 {
		resp.handle_redirect(h, req.max_redirects)!
		curl.easy_getinfo(h, .response_code, &resp.status_code)
	}

	return resp
}
