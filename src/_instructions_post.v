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

	resp.set_status_line()!
	resp.body = resp.body[resp.header.len..]

	return resp
}
