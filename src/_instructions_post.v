module vibe

import vibe.curl

fn (s Session) post_(url string, data string) !Response {
	mut resp := Response{}

	s.set_request_opts(.post, &resp, url)
	curl.easy_setopt(s.curl, .postfields, data)

	res := curl.easy_perform(s.curl)
	if res != curl.Ecode.ok {
		return IError(curl.CurlError{
			e_code: res
		})
	}

	mut status_code := 0
	curl.easy_getinfo(s.curl, .response_code, &status_code)
	if status_code / 100 == 3 {
		s.handle_redirect(mut resp)!
		curl.easy_getinfo(s.curl, .response_code, &status_code)
	}

	resp.get_http_version()!
	resp.status = Status(status_code)
	resp.body = resp.body[resp.header.len..]

	return resp
}
