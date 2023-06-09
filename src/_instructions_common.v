module vibe

import vibe.curl

fn init_session_(opts SessionOpts) !Session {
	curl.global_init(.default)

	// Curl handle
	h := curl.easy_init() or { return IError(HttpError{
		kind: .session_init
	}) }

	header_list := if opts.headers.len > 0 {
		set_header(opts.headers, h)
	} else {
		set_default_header(h)
	}

	s := Session{
		SessionOpts: opts
		curl: h
		header_list: header_list
	}

	s.set_opts()

	return s
}

fn (s &Session) set_opts() {
	if s.cookie_session {
		curl.easy_setopt(s.curl, .cookiesession, 1)
	}
	if s.cookie_jar != '' {
		curl.easy_setopt(s.curl, .cookiejar, s.cookie_jar)
	}
	if s.cookie_file != '' {
		curl.easy_setopt(s.curl, .cookiefile, s.cookie_file)
	}
	if s.timeout > 0 {
		curl.easy_setopt(s.curl, .timeout_ms, s.timeout.milliseconds())
	}
	if s.max_redirects > 0 {
		curl.easy_setopt(s.curl, .maxredirs, s.max_redirects)
	}
	curl.easy_setopt(s.curl, .header, 1)
	curl.easy_setopt(s.curl, .headerfunction, write_resp_header)
	curl.easy_setopt(s.curl, .writefunction, write_resp)

	$if curl_verbose ? {
		curl.easy_setopt(s.curl, .verbose, 1)
	}
}

fn (s &Session) close_() {
	curl.slist_free_all(s.header_list)
	curl.easy_cleanup(s.curl)
	curl.global_cleanup()
}

fn (s &Session) set_request_opts(method Method, resp &Response, url string) {
	match method {
		.get {
			curl.easy_setopt(s.curl, .httpget, 1)
			if resp.slice.start != 0 {
				curl.easy_setopt(s.curl, .writefunction, write_resp_slice)
			} else {
				curl.easy_setopt(s.curl, .writefunction, write_resp)
			}
		}
		.post {
			curl.easy_setopt(s.curl, .post, 1)
		}
	}
	curl.easy_setopt(s.curl, .url, url)
	curl.easy_setopt(s.curl, .writedata, resp)
	curl.easy_setopt(s.curl, .headerdata, resp)
}
