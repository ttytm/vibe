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

	// Follows redirects, updates the url to the redirected target and sets header data.
	mut resp := req.get_head(h, url)!
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

// HEAD requests often fail due to being unauthenticated.
// Performing a get request that omits the body to get information about the head can be a workaround.
// For now this function is for internal usage, e.g. in conjunction with downloading.
fn (req Request) get_head(h &C.CURL, url string) !Response {
	mut resp := Response{}
	req.set_get_opts(h, url, &resp)
	curl.easy_setopt(h, .writefunction, write_null)
	curl.easy_setopt(h, .writedata, unsafe { nil })
	send_request(h)!

	mut status_code := 0
	curl.easy_getinfo(h, .response_code, &status_code)
	if status_code / 100 == 3 {
		resp.handle_redirect(h, req.max_redirects)!
	}

	return resp
}
