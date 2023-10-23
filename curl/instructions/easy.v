module instructions

import vibe.curl.state

fn C.curl_easy_init() &C.CURL
fn C.curl_easy_cleanup(&C.CURL)
fn C.curl_easy_setopt(&C.CURL, int, voidptr) int
fn C.curl_easy_perform(&C.CURL) int
fn C.curl_easy_strerror(int) &char
fn C.curl_easy_getinfo(&C.CURL, int, voidptr) int

fn ecode(i int) state.Ecode {
	return unsafe { state.Ecode(i) }
}

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
	str_err := &char(C.curl_easy_strerror(int(err_code)))
	unsafe {
		return str_err.vstring()
	}
}

pub fn easy_setopt[T](handle &C.CURL, option state.Opt, parameter T) state.Ecode {
	return ecode(C.curl_easy_setopt(handle, int(option), parameter))
}

pub fn easy_perform(handle &C.CURL) state.Ecode {
	return ecode(C.curl_easy_perform(handle))
}

pub fn easy_getinfo(handle &C.CURL, info state.Info, typ voidptr) state.Ecode {
	return ecode(C.curl_easy_getinfo(handle, int(info), typ))
}
