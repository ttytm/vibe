module vibe

import vibe.curl

fn (req Request) head_(url string) !Response {
	h := curl.easy_init() or { return IError(HttpError{
		kind: .easy_init
	}) }
	header := set_header(req.headers, h)
	defer {
		curl.easy_cleanup(h)
		curl.slist_free_all(header)
	}

	mut resp := Response{}
	curl.easy_setopt(h, .nobody, 1)
	curl.easy_setopt(h, .header, 0)
	req.set_common_opts(h, url, &resp)
	send_request(h)!

	mut status_code := 0
	curl.easy_getinfo(h, .response_code, &status_code)
	if status_code / 100 == 3 {
		resp.handle_redirect(h, req.max_redirects)!
		curl.easy_getinfo(h, .response_code, &status_code)
	}

	resp.get_http_version()!
	resp.status = Status(status_code)

	return resp
}
