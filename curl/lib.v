/*
Source: https://github.com/ttytm/vibe
License: MIT
*/

module curl

import instructions
import state

#flag -I@VMODROOT/curl/libcurl/include
#flag @VMODROOT/curl/libcurl/lib/.libs/libcurl.so
#include "curl/curl.h"

pub type Handle = C.CURL

pub type LinkedList = C.curl_slist

pub type Opt = state.Opt

pub type Ecode = state.Ecode

pub type Mcode = state.Mcode

pub type SHEcode = state.SHEcode

pub type UEcode = state.UEcode

// pub type Hcode = state.Hcode

pub type GlobalInitFlag = state.GlobalInitFlag

pub type Info = state.Info

pub fn global_init(flag state.GlobalInitFlag) {
	C.curl_global_init(flag)
}

pub fn global_cleanup() {
	C.curl_global_cleanup()
}

pub fn easy_init() !&Handle {
	return instructions.easy_init()!
}

pub fn easy_cleanup(handle &Handle) {
	C.curl_easy_cleanup(handle)
}

pub fn easy_setopt[T](handle &Handle, option Opt, parameter T) Ecode {
	return instructions.easy_setopt(handle, option, parameter)
}

pub fn easy_perform(handle &Handle) Ecode {
	return instructions.easy_perform(handle)
}

pub fn easy_getinfo(handle &Handle, info Info, typ voidptr) Ecode {
	return instructions.easy_getinfo(handle, info, typ)
}

pub fn easy_strerror(err_code Ecode) string {
	return instructions.easy_strerror(err_code)
}

pub fn slist_append(list &LinkedList, item string) &LinkedList {
	return C.curl_slist_append(list, &char(item.str))
}

pub fn slist_free_all(list &LinkedList) {
	C.curl_slist_free_all(list)
}
