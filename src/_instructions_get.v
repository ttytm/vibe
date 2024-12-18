module vibe

import curl

fn (req Request) get_(url string) !Response {
	// Curl handle
	h := curl.easy_init() or { return http_error(.easy_init, none) }
	header := set_header(h, req.headers, req.custom_headers)
	defer {
		curl.easy_cleanup(h)
		curl.slist_free_all(header)
	}

	mut resp := VibeResponse{}
	req.set_get_opts(h, url, &resp)
	curl.easy_setopt(h, .writefunction, write_resp)
	send_request(h)!

	curl.easy_getinfo(h, .response_code, &resp.status_code)
	if resp.status_code / 100 == 3 {
		resp.handle_redirect(h, req.max_redirects)!
		curl.easy_getinfo(h, .response_code, &resp.status_code)
	}

	resp.get_http_version()!
	resp.status = Status(resp.status_code)
	resp.body = resp.body[resp.header.len..]

	return resp.Response
}

fn (req Request) get_slice_(url string, start usize, max_size_ ?usize) !Response {
	h := curl.easy_init() or { return http_error(.easy_init, none) }
	header := set_header(h, req.headers, req.custom_headers)
	defer {
		curl.easy_cleanup(h)
		curl.slist_free_all(header)
	}

	max_size := max_size_ or { 0 }
	mut resp := VibeResponse{
		slice: struct {
			start: start
			end:   start + max_size
		}
	}
	req.set_get_opts(h, url, &resp)
	curl.easy_setopt(h, .writefunction, write_resp_slice)
	res := curl.easy_perform(h)
	if res != curl.Ecode.ok && !resp.slice.finished {
		return curl.curl_error(res)
	}

	curl.easy_getinfo(h, .response_code, &resp.status_code)
	if resp.status_code / 100 == 3 {
		resp.handle_redirect(h, req.max_redirects)!
		curl.easy_getinfo(h, .response_code, &resp.status_code)
	}

	slice_end := if max_size != 0 { int(max_size) } else { resp.body.len }
	if resp.body == '' {
		return http_error(.slice_out_of_range, '${start}..${slice_end}')
	}

	resp.get_http_version()!
	resp.status = Status(resp.status_code)
	if start < usize(resp.header.len) {
		resp.body = resp.body[resp.header.len - int(start)..]
	}
	if slice_end < resp.body.len {
		// If the last response chunk was longer than the max_size, truncate it.
		resp.body = resp.body[..slice_end]
	}

	return resp.Response
}

fn (req Request) set_get_opts(h &curl.Handle, url string, resp &VibeResponse) {
	curl.easy_setopt(h, .httpget, 1)
	curl.easy_setopt(h, .writedata, resp)
	req.set_common_opts(h, url, resp)
}
