module vibe

import vibe.curl.state
import time

pub struct Request {
pub mut:
	headers        map[HttpHeader]string
	custom_headers map[string]string
	cookie_jar     string
	cookie_file    string
	proxy          ProxySettings
	timeout        time.Duration
	max_redirects  u16 = 10
}

pub struct ProxySettings {
pub mut:
	address  string
	port     u16
	user     string
	password string
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
	head
}

// vfmt off
pub type CustomInitFlag = state.GlobalInitFlag
// vfmt on
