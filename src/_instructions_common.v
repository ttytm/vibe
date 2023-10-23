module vibe

import vibe.curl

// Automatically call curl_global_init when using `vibe`.
fn init() {
	curl.global_init(.default)
}

fn custom_init_(flag CustomInitFlag) {
	curl.global_cleanup()
	curl.global_init(flag)
}

fn cleanup_() {
	curl.global_cleanup()
}

fn (req Request) set_common_opts(h &curl.Handle, url string, resp &VibeResponse) {
	if req.cookie_jar != '' {
		curl.easy_setopt(h, .cookiejar, req.cookie_jar)
	}
	if req.cookie_file != '' {
		curl.easy_setopt(h, .cookiefile, req.cookie_file)
	}
	if req.timeout > 0 {
		curl.easy_setopt(h, .timeout_ms, req.timeout.milliseconds())
	}
	curl.easy_setopt(h, .url, url)
	curl.easy_setopt(h, .header, 1)
	curl.easy_setopt(h, .headerdata, resp)
	curl.easy_setopt(h, .headerfunction, write_resp_header)
	req.set_proxy(h)
}

fn (req Request) set_proxy(h &curl.Handle) {
	if req.proxy.address == '' {
		return
	}
	curl.easy_setopt(h, .proxy, req.proxy.address.str)
	if req.proxy.port != 0 {
		curl.easy_setopt(h, .proxyport, req.proxy.port)
	}
	if req.proxy.user != '' {
		mut userpwd := req.proxy.user
		if req.proxy.password != '' {
			userpwd += ':' + req.proxy.password
		}
		curl.easy_setopt(h, .proxyuserpwd, userpwd.replace(' ', '').str)
	}
}

fn send_request(handle &curl.Handle) ! {
	res := curl.easy_perform(handle)
	if res != curl.Ecode.ok {
		return curl.curl_error(res)
	}
}

fn (mut resp VibeResponse) handle_redirect(h &curl.Handle, max_redirects u16) ! {
	mut redir_url := ''.str

	for _ in 0 .. max_redirects {
		resp = VibeResponse{}
		curl.easy_getinfo(h, .redirect_url, &redir_url)
		curl.easy_setopt(h, .url, redir_url)
		send_request(h)!
		curl.easy_getinfo(h, .response_code, &resp.status_code)
		if resp.status_code / 100 != 3 {
			return
		}
	}

	return http_error(.max_redirs_reached, none)
}
