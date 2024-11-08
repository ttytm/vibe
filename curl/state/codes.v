// https://curl.se/libcurl/c/libcurl-errors.html
@[generated]
module state

// TODO: check commented after debian 10 EOL, June 30, 2024. Compare Ubuntu LTS 22.04 with Debian 11.
pub enum Ecode {
	ok                     = C.CURLE_OK
	unsupported_protocol   = C.CURLE_UNSUPPORTED_PROTOCOL
	failed_init            = C.CURLE_FAILED_INIT
	url_malformat          = C.CURLE_URL_MALFORMAT
	not_built_in           = C.CURLE_NOT_BUILT_IN
	couldnt_resolve_proxy  = C.CURLE_COULDNT_RESOLVE_PROXY
	couldnt_resolve_host   = C.CURLE_COULDNT_RESOLVE_HOST
	couldnt_connect        = C.CURLE_COULDNT_CONNECT
	weird_server_reply     = C.CURLE_WEIRD_SERVER_REPLY
	remote_access_denied   = C.CURLE_REMOTE_ACCESS_DENIED
	ftp_accept_failed      = C.CURLE_FTP_ACCEPT_FAILED
	ftp_weird_pass_reply   = C.CURLE_FTP_WEIRD_PASS_REPLY
	ftp_accept_timeout     = C.CURLE_FTP_ACCEPT_TIMEOUT
	ftp_weird_pasv_reply   = C.CURLE_FTP_WEIRD_PASV_REPLY
	ftp_weird_227_format   = C.CURLE_FTP_WEIRD_227_FORMAT
	ftp_cant_get_host      = C.CURLE_FTP_CANT_GET_HOST
	http2                  = C.CURLE_HTTP2
	ftp_couldnt_set_type   = C.CURLE_FTP_COULDNT_SET_TYPE
	partial_file           = C.CURLE_PARTIAL_FILE
	ftp_couldnt_retr_file  = C.CURLE_FTP_COULDNT_RETR_FILE
	quote_error            = C.CURLE_QUOTE_ERROR
	http_returned_error    = C.CURLE_HTTP_RETURNED_ERROR
	write_error            = C.CURLE_WRITE_ERROR
	upload_failed          = C.CURLE_UPLOAD_FAILED
	read_error             = C.CURLE_READ_ERROR
	out_of_memory          = C.CURLE_OUT_OF_MEMORY
	operation_timedout     = C.CURLE_OPERATION_TIMEDOUT
	ftp_port_failed        = C.CURLE_FTP_PORT_FAILED
	ftp_couldnt_use_rest   = C.CURLE_FTP_COULDNT_USE_REST
	range_error            = C.CURLE_RANGE_ERROR
	http_post_error        = C.CURLE_HTTP_POST_ERROR
	ssl_connect_error      = C.CURLE_SSL_CONNECT_ERROR
	bad_download_resume    = C.CURLE_BAD_DOWNLOAD_RESUME
	file_couldnt_read_file = C.CURLE_FILE_COULDNT_READ_FILE
	ldap_cannot_bind       = C.CURLE_LDAP_CANNOT_BIND
	ldap_search_failed     = C.CURLE_LDAP_SEARCH_FAILED
	function_not_found     = C.CURLE_FUNCTION_NOT_FOUND
	aborted_by_callback    = C.CURLE_ABORTED_BY_CALLBACK
	bad_function_argument  = C.CURLE_BAD_FUNCTION_ARGUMENT
	interface_failed       = C.CURLE_INTERFACE_FAILED
	too_many_redirects     = C.CURLE_TOO_MANY_REDIRECTS
	unknown_option         = C.CURLE_UNKNOWN_OPTION
	// setopt_option_syntax     = C.CURLE_SETOPT_OPTION_SYNTAX // 7.78.0
	got_nothing              = C.CURLE_GOT_NOTHING
	ssl_engine_notfound      = C.CURLE_SSL_ENGINE_NOTFOUND
	ssl_engine_setfailed     = C.CURLE_SSL_ENGINE_SETFAILED
	send_error               = C.CURLE_SEND_ERROR
	recv_error               = C.CURLE_RECV_ERROR
	ssl_certproblem          = C.CURLE_SSL_CERTPROBLEM
	ssl_cipher               = C.CURLE_SSL_CIPHER
	peer_failed_verification = C.CURLE_PEER_FAILED_VERIFICATION
	bad_content_encoding     = C.CURLE_BAD_CONTENT_ENCODING
	filesize_exceeded        = C.CURLE_FILESIZE_EXCEEDED
	use_ssl_failed           = C.CURLE_USE_SSL_FAILED
	send_fail_rewind         = C.CURLE_SEND_FAIL_REWIND
	ssl_engine_initfailed    = C.CURLE_SSL_ENGINE_INITFAILED
	login_denied             = C.CURLE_LOGIN_DENIED
	tftp_notfound            = C.CURLE_TFTP_NOTFOUND
	tftp_perm                = C.CURLE_TFTP_PERM
	remote_disk_full         = C.CURLE_REMOTE_DISK_FULL
	tftp_illegal             = C.CURLE_TFTP_ILLEGAL
	tftp_unknownid           = C.CURLE_TFTP_UNKNOWNID
	remote_file_exists       = C.CURLE_REMOTE_FILE_EXISTS
	tftp_nosuchuser          = C.CURLE_TFTP_NOSUCHUSER
	ssl_cacert_badfile       = C.CURLE_SSL_CACERT_BADFILE
	remote_file_not_found    = C.CURLE_REMOTE_FILE_NOT_FOUND
	ssh                      = C.CURLE_SSH
	ssl_shutdown_failed      = C.CURLE_SSL_SHUTDOWN_FAILED
	again                    = C.CURLE_AGAIN
	ssl_crl_badfile          = C.CURLE_SSL_CRL_BADFILE
	ssl_issuer_error         = C.CURLE_SSL_ISSUER_ERROR
	ftp_pret_failed          = C.CURLE_FTP_PRET_FAILED
	rtsp_cseq_error          = C.CURLE_RTSP_CSEQ_ERROR
	rtsp_session_error       = C.CURLE_RTSP_SESSION_ERROR
	ftp_bad_file_list        = C.CURLE_FTP_BAD_FILE_LIST
	chunk_failed             = C.CURLE_CHUNK_FAILED
	no_connection_available  = C.CURLE_NO_CONNECTION_AVAILABLE
	ssl_pinnedpubkeynotmatch = C.CURLE_SSL_PINNEDPUBKEYNOTMATCH
	ssl_invalidcertstatus    = C.CURLE_SSL_INVALIDCERTSTATUS
	http2_stream             = C.CURLE_HTTP2_STREAM
	recursive_api_call       = C.CURLE_RECURSIVE_API_CALL
	// auth_error               = C.CURLE_AUTH_ERROR // 7.66.0
	// http3                    = C.CURLE_HTTP3 // 7.68.0
	// quic_connect_error       = C.CURLE_QUIC_CONNECT_ERROR // 7.69.0
	// proxy                    = C.CURLE_PROXY // 7.73.0
	// ssl_clientcert           = C.CURLE_SSL_CLIENTCERT // 7.77.0
	// unrecoverable_poll       = C.CURLE_UNRECOVERABLE_POLL // 7.84.0
	// writefunc_error          = C.CURL_WRITEFUNC_ERROR // 7.87.0
}

enum Mcode {
	call_multi_perform = C.CURLM_CALL_MULTI_PERFORM
	call_multi_socket  = C.CURLM_CALL_MULTI_SOCKET
	ok                 = C.CURLM_OK
	bad_handle         = C.CURLM_BAD_HANDLE
	bad_easy_handle    = C.CURLM_BAD_EASY_HANDLE
	out_of_memory      = C.CURLM_OUT_OF_MEMORY
	internal_error     = C.CURLM_INTERNAL_ERROR
	bad_socket         = C.CURLM_BAD_SOCKET
	unknown_option     = C.CURLM_UNKNOWN_OPTION
	added_already      = C.CURLM_ADDED_ALREADY
	recursive_api_call = C.CURLM_RECURSIVE_API_CALL
	// wakeup_failure        = C.CURLM_WAKEUP_FAILURE // 7.68.0
	// bad_function_argument = C.CURLM_BAD_FUNCTION_ARGUMENT // 7.69.0
	// aborted_by_callback   = C.CURLM_ABORTED_BY_CALLBACK // 7.81.0
	// unrecoverable_poll    = C.CURLM_UNRECOVERABLE_POLL // 7.84.0
}

pub enum SHEcode {
	ok           = C.CURLSHE_OK
	bad_option   = C.CURLSHE_BAD_OPTION
	in_use       = C.CURLSHE_IN_USE
	invalid      = C.CURLSHE_INVALID
	nomem        = C.CURLSHE_NOMEM
	not_built_in = C.CURLSHE_NOT_BUILT_IN
}

enum UEcode {
	bad_handle         = C.CURLUE_BAD_HANDLE
	bad_partpointer    = C.CURLUE_BAD_PARTPOINTER
	malformed_input    = C.CURLUE_MALFORMED_INPUT
	bad_port_number    = C.CURLUE_BAD_PORT_NUMBER
	unsupported_scheme = C.CURLUE_UNSUPPORTED_SCHEME
	urldecode          = C.CURLUE_URLDECODE
	out_of_memory      = C.CURLUE_OUT_OF_MEMORY
	user_not_allowed   = C.CURLUE_USER_NOT_ALLOWED
	unknown_part       = C.CURLUE_UNKNOWN_PART
	no_scheme          = C.CURLUE_NO_SCHEME
	no_user            = C.CURLUE_NO_USER
	no_password        = C.CURLUE_NO_PASSWORD
	no_options         = C.CURLUE_NO_OPTIONS
	no_host            = C.CURLUE_NO_HOST
	no_port            = C.CURLUE_NO_PORT
	no_query           = C.CURLUE_NO_QUERY
	no_fragment        = C.CURLUE_NO_FRAGMENT
	// no_zoneid          = C.CURLUE_NO_ZONEID // 7.81.0
	// bad_file_url       = C.CURLUE_BAD_FILE_URL // 7.81.0
	// bad_fragment       = C.CURLUE_BAD_FRAGMENT // 7.81.0
	// bad_hostname       = C.CURLUE_BAD_HOSTNAME // 7.81.0
	// bad_ipv6           = C.CURLUE_BAD_IPV6 // 7.81.0
	// bad_login          = C.CURLUE_BAD_LOGIN // 7.81.0
	// bad_password       = C.CURLUE_BAD_PASSWORD // 7.81.0
	// bad_path           = C.CURLUE_BAD_PATH // 7.81.0
	// bad_query          = C.CURLUE_BAD_QUERY // 7.81.0
	// bad_scheme         = C.CURLUE_BAD_SCHEME // 7.81.0
	// bad_slashes        = C.CURLUE_BAD_SLASHES // 7.81.0
	// bad_user           = C.CURLUE_BAD_USER // 7.81.0
}

/*
enum Hcode {
	curlhe_badindex = C.CURLHE_BADINDEX // 7.83.0
	curlhe_missing = C.CURLHE_MISSING // 7.83.0
	curlhe_noheaders = C.CURLHE_NOHEADERS // 7.83.0
	curlhe_norequest = C.CURLHE_NOREQUEST // 7.83.0
	curlhe_out_of_memory = C.CURLHE_OUT_OF_MEMORY // 7.83.0
	curlhe_bad_argument = C.CURLHE_BAD_ARGUMENT // 7.83.0
	curlhe_not_built_in = C.CURLHE_NOT_BUILT_IN // 7.83.0
}*/
