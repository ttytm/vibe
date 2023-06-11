module vibe

import vibe.curl

fn init_session_(opts SessionOpts) !Session {
	curl.global_init(.default)

	// Curl handle
	h := curl.easy_init() or { return IError(HttpError{
		kind: .session_init
	}) }

	s := Session{
		SessionOpts: opts
		curl: h
		header_list: set_header(opts.headers, h)
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

	curl.easy_setopt(s.curl, .headerfunction, write_resp_header)

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
	// Individual
	match method {
		.get {
			if resp.slice.start > 0 {
				curl.easy_setopt(s.curl, .writefunction, write_resp_slice)
			}
		}
		.post {
			curl.easy_setopt(s.curl, .post, 1)
		}
		.head {
			curl.easy_setopt(s.curl, .header, 0)
			curl.easy_setopt(s.curl, .nobody, 1)
		}
	}

	// Partially shared
	if method in [.get, .head] {
		curl.easy_setopt(s.curl, .httpget, 1)
	}
	if method != .head {
		curl.easy_setopt(s.curl, .nobody, 0)
		curl.easy_setopt(s.curl, .header, 1)
		curl.easy_setopt(s.curl, .writefunction, write_resp)
		curl.easy_setopt(s.curl, .writedata, resp)
	}

	// Shared
	curl.easy_setopt(s.curl, .url, url)
	curl.easy_setopt(s.curl, .headerdata, resp)
}

fn (s Session) handle_redirect(mut resp Response) ! {
	mut status_code := 0
	mut redir_url := ''.str

	for _ in 0 .. s.max_redirects {
		resp = Response{}
		curl.easy_getinfo(s.curl, .redirect_url, &redir_url)
		curl.easy_setopt(s.curl, .url, redir_url)
		res := curl.easy_perform(s.curl)
		if res != curl.Ecode.ok {
			return IError(curl.CurlError{
				e_code: res
			})
		}
		curl.easy_getinfo(s.curl, .response_code, &status_code)
		if status_code / 100 != 3 {
			return
		}
	}

	return IError(HttpError{
		kind: .max_redirs_reached
	})
}
