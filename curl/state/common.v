module state

pub enum GlobalInitFlag {
	all = C.CURL_GLOBAL_ALL
	ssl = C.CURL_GLOBAL_SSL
	win32 = C.CURL_GLOBAL_WIN32
	nothing = C.CURL_GLOBAL_NOTHING
	default = C.CURL_GLOBAL_DEFAULT
}
