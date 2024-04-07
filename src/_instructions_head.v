module vibe

import curl

fn (req Request) head_(url string) !Response {
	h := curl.easy_init() or { return http_error(.easy_init, none) }
	header := set_header(h, common: req.headers, custom: req.custom_headers)
	defer {
		curl.easy_cleanup(h)
		curl.slist_free_all(header)
	}

	mut resp := VibeResponse{}
	req.set_head_opts(h, url, &resp)
	send_request(h)!

	curl.easy_getinfo(h, .response_code, &resp.status_code)
	if resp.status_code / 100 == 3 {
		resp.handle_redirect(h, req.max_redirects)!
		curl.easy_getinfo(h, .response_code, &resp.status_code)
	}
	resp.get_http_version()!
	resp.status = Status(resp.status_code)

	return resp.Response
}

fn (req Request) set_head_opts(h &curl.Handle, url string, resp &VibeResponse) {
	curl.easy_setopt(h, .writefunction, write_null)
	curl.easy_setopt(h, .nobody, 1)
	req.set_common_opts(h, url, resp)
}
