module vibe

import vibe.curl

fn (req Request) head_(url string) !Response {
	h := curl.easy_init() or { return http_error(.easy_init, none) }
	header := set_header(req.headers, h)
	defer {
		curl.easy_cleanup(h)
		curl.slist_free_all(header)
	}

	mut resp := req.head__(h, url)!

	mut status_code := 0
	curl.easy_getinfo(h, .response_code, &status_code)
	resp.get_http_version()!
	resp.status = Status(status_code)

	return resp
}

// Follows redirects, sets the handle's URL opt to the latest URL of the redirected destination and sets header data.
// Abstracted to also allow internal usage. E.g. before downloading to retrieve the head before an actual request.
fn (req Request) head__(h &C.CURL, url string) !Response {
	mut resp := Response{}
	curl.easy_setopt(h, .nobody, 1)
	curl.easy_setopt(h, .header, 0)
	req.set_common_opts(h, url, &resp)
	send_request(h)!

	mut status_code := 0
	curl.easy_getinfo(h, .response_code, &status_code)
	if status_code / 100 == 3 {
		resp.handle_redirect(h, req.max_redirects)!
	}

	return resp
}
