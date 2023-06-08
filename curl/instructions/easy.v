module instructions

import vibe.curl.state

#flag -lcurl
#include <curl/curl.h>

fn C.curl_easy_init() &C.CURL

fn C.curl_easy_cleanup(&C.CURL)

fn C.curl_easy_setopt(&C.CURL, state.Opt, voidptr) state.Ecode

fn C.curl_easy_perform(&C.CURL) state.Ecode

fn C.curl_easy_strerror(state.Ecode) &char

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
	unsafe {
		return C.curl_easy_strerror(err_code).vstring()
	}
}
