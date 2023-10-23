module vibe

import vibe.curl

fn (req Request) post_(url string, data string) !Response {
	h := curl.easy_init() or { return http_error(.easy_init, none) }
	header := set_header(h, common: req.headers, custom: req.custom_headers)
	defer {
		curl.easy_cleanup(h)
		curl.slist_free_all(header)
	}

	mut resp := VibeResponse{}
	curl.easy_setopt(h, .post, 1)
	curl.easy_setopt(h, .postfields, data)
	curl.easy_setopt(h, .header, 1)
	curl.easy_setopt(h, .writedata, &resp)
	curl.easy_setopt(h, .writefunction, write_resp)
	req.set_common_opts(h, url, resp)
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
