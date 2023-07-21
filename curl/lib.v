/*
Source: https://github.com/tobealive/vibe
License: MIT
*/

module curl

import vibe.curl.instructions
import vibe.curl.state

pub type Opt = state.Opt

pub type Ecode = state.Ecode

pub type Mcode = state.Mcode

pub type SHEcode = state.SHEcode

pub type UEcode = state.UEcode

// pub type Hcode = state.Hcode

pub type GlobalInitFlag = state.GlobalInitFlag

pub type Info = state.Info

pub struct C.curl_slist {}

pub fn global_init(flag state.GlobalInitFlag) {
	C.curl_global_init(flag)
}

pub fn global_cleanup() {
	C.curl_global_cleanup()
}

pub fn easy_init() !&C.CURL {
	return instructions.easy_init()!
}

pub fn easy_cleanup(handle &C.CURL) {
	C.curl_easy_cleanup(handle)
}

pub fn easy_setopt[T](handle &C.CURL, option Opt, parameter T) Ecode {
	return C.curl_easy_setopt(handle, option, parameter)
}

pub fn easy_perform(handle &C.CURL) Ecode {
	return C.curl_easy_perform(handle)
}

pub fn easy_getinfo[T](handle &C.CURL, info Info, typ T) Ecode {
	return C.curl_easy_getinfo(handle, info, typ)
}

pub fn easy_strerror(err_code Ecode) string {
	return instructions.easy_strerror(err_code)
}

pub fn slist_append(list &C.curl_slist, item string) &C.curl_slist {
	return C.curl_slist_append(list, item.str)
}

pub fn slist_free_all(list &C.curl_slist) {
	C.curl_slist_free_all(list)
}
