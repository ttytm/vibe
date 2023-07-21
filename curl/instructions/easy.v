module instructions

import vibe.curl.state

fn C.curl_easy_init() &C.CURL

fn C.curl_easy_cleanup(&C.CURL)

fn C.curl_easy_setopt(&C.CURL, state.Opt, voidptr) state.Ecode

fn C.curl_easy_perform(&C.CURL) state.Ecode

fn C.curl_easy_strerror(state.Ecode) &char

fn C.curl_easy_getinfo(&C.CURL, state.Info, voidptr) state.Ecode

pub fn easy_init() !&C.CURL {
	handle := C.curl_easy_init()
	unsafe {
		if handle == nil {
			error('Failed performing curl.easy_init()')
		}
	}
	return handle
}

pub fn easy_strerror(err_code state.Ecode) string {
	str_err := &char(C.curl_easy_strerror(err_code))
	unsafe {
		return str_err.vstring()
	}
}
