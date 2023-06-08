module vibe

import time

pub struct Session {
	SessionOpts
	curl &C.CURL
}

pub struct SessionOpts {
pub mut:
	headers        map[HttpHeader]string
	custom_headers map[string]string // TODO:
	cookie_session bool = true
	cookie_jar     string
	cookie_file    string
	timeout        time.Duration
	max_redirects  u16
}

// TODO:
pub enum SSLLevel {
	@none
	try
	control
	all
}

enum Method {
	get
	post
}
