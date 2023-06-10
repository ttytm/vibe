module vibe

import vibe.curl

fn (s Session) get_(url string) !Response {
	mut resp := Response{}

	s.set_request_opts(.get, &resp, url)

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

fn (s Session) get_slice_(url string, start usize, max_size_ ?usize) !Response {
	max_size := max_size_ or { 0 }
	mut resp := Response{
		slice: struct {
			start: start
			end: start + max_size
		}
	}

	s.set_request_opts(.get, &resp, url)

	res := curl.easy_perform(s.curl)
	if res != curl.Ecode.ok && !resp.slice.finished {
		return IError(curl.CurlError{
			e_code: res
		})
	}
	if resp.body.len == 0 {
		return IError(HttpError{
			kind: .slice_out_of_range
			val: '${start}..${resp.slice.end}'
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

	if start < resp.header.len {
		resp.body = resp.body[resp.header.len - int(start)..]
	}
	if resp.body.len > max_size {
		resp.body = resp.body[..max_size]
	}

	return resp
}
