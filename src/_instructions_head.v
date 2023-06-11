module vibe

import vibe.curl

fn (s Session) head_(url string) !Response {
	mut resp := Response{}

	s.set_request_opts(.head, &resp, url)
	header_res := curl.easy_perform(s.curl)
	if header_res != curl.Ecode.ok {
		return IError(curl.CurlError{
			e_code: header_res
		})
	}

	mut status_code := 0
	curl.easy_getinfo(s.curl, .response_code, &status_code)
	if status_code / 100 == 3 {
		s.handle_redirect(mut resp)!
	}

	resp.get_http_version()!
	resp.status = Status(status_code)

	return resp
}

// Head requests often fail due to beeing unauthicated.
// Performing a get request that omits the body to get information about the head can be a workaround.
// For now this function is for internal usage, e.g. in conjunction with downloading.
fn (s Session) get_head(url string) !Response {
	mut resp := Response{}

	s.set_request_opts(.get, &resp, url)
	curl.easy_setopt(s.curl, .writefunction, write_null)
	curl.easy_setopt(s.curl, .writedata, unsafe { nil })
	header_res := curl.easy_perform(s.curl)
	if header_res != curl.Ecode.ok {
		return IError(curl.CurlError{
			e_code: header_res
		})
	}

	mut status_code := 0
	curl.easy_getinfo(s.curl, .response_code, &status_code)
	if status_code / 100 == 3 {
		s.handle_redirect(mut resp)!
	}

	return resp
}
