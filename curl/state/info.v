// https://curl.se/libcurl/c/easy_getinfo_options.html
@[generated]
module state

// TODO: check commented after debian 10 EOL, June 30, 2024. Compare Ubuntu LTS 22.04 with Debian 11.
pub enum Info {
	activesocket              = C.CURLINFO_ACTIVESOCKET // get the active socket
	appconnect_time           = C.CURLINFO_APPCONNECT_TIME // get the time until the SSL/SSH handshake is completed
	appconnect_time_t         = C.CURLINFO_APPCONNECT_TIME_T // time until the SSL/SSH handshake completed
	// cainfo = C.CURLINFO_CAINFO // get the default built-in CA certificate path // 7.84.0
	// capath = C.CURLINFO_CAPATH // get the default built-in CA path string // 7.84.0
	certinfo                  = C.CURLINFO_CERTINFO // get the TLS certificate chain
	condition_unmet           = C.CURLINFO_CONDITION_UNMET // get info on unmet time conditional or 304 HTTP response.
	connect_time              = C.CURLINFO_CONNECT_TIME // get the time until connect
	connect_time_t            = C.CURLINFO_CONNECT_TIME_T // get the time until connect
	content_length_download   = C.CURLINFO_CONTENT_LENGTH_DOWNLOAD // get content-length of download
	content_length_download_t = C.CURLINFO_CONTENT_LENGTH_DOWNLOAD_T // get content-length of download
	content_length_upload     = C.CURLINFO_CONTENT_LENGTH_UPLOAD // get the specified size of the upload
	content_length_upload_t   = C.CURLINFO_CONTENT_LENGTH_UPLOAD_T // get the specified size of the upload
	content_type              = C.CURLINFO_CONTENT_TYPE // get Content-Type
	cookielist                = C.CURLINFO_COOKIELIST // get all known cookies
	// effective_method          = C.CURLINFO_EFFECTIVE_METHOD // get the last used HTTP method // 7.72.0
	effective_url             = C.CURLINFO_EFFECTIVE_URL // get the last used URL
	filetime                  = C.CURLINFO_FILETIME // get the remote time of the retrieved document
	filetime_t                = C.CURLINFO_FILETIME_T // get the remote time of the retrieved document
	ftp_entry_path            = C.CURLINFO_FTP_ENTRY_PATH // get entry path in FTP server
	header_size               = C.CURLINFO_HEADER_SIZE // get size of retrieved headers
	httpauth_avail            = C.CURLINFO_HTTPAUTH_AVAIL // get available HTTP authentication methods
	http_connectcode          = C.CURLINFO_HTTP_CONNECTCODE // get the CONNECT response code
	http_version              = C.CURLINFO_HTTP_VERSION // get the http version used in the connection
	lastsocket                = C.CURLINFO_LASTSOCKET // get the last socket used
	local_ip                  = C.CURLINFO_LOCAL_IP // get local IP address of last connection
	local_port                = C.CURLINFO_LOCAL_PORT // get the latest local port number
	namelookup_time           = C.CURLINFO_NAMELOOKUP_TIME // get the name lookup time
	namelookup_time_t         = C.CURLINFO_NAMELOOKUP_TIME_T // get the name lookup time in microseconds
	num_connects              = C.CURLINFO_NUM_CONNECTS // get number of created connections
	os_errno                  = C.CURLINFO_OS_ERRNO // get errno number from last connect failure
	pretransfer_time          = C.CURLINFO_PRETRANSFER_TIME // get the time until the file transfer start
	pretransfer_time_t        = C.CURLINFO_PRETRANSFER_TIME_T // get the time until the file transfer start
	primary_ip                = C.CURLINFO_PRIMARY_IP // get IP address of last connection
	primary_port              = C.CURLINFO_PRIMARY_PORT // get the latest destination port number
	private                   = C.CURLINFO_PRIVATE // get the private pointer
	protocol                  = C.CURLINFO_PROTOCOL // get the protocol used in the connection
	proxyauth_avail           = C.CURLINFO_PROXYAUTH_AVAIL // get available HTTP proxy authentication methods
	// proxy_error               = C.CURLINFO_PROXY_ERROR // get the detailed (SOCKS) proxy error // 7.74.0
	proxy_ssl_verifyresult    = C.CURLINFO_PROXY_SSL_VERIFYRESULT // get the result of the proxy certificate verification
	redirect_count            = C.CURLINFO_REDIRECT_COUNT // get the number of redirects
	redirect_time             = C.CURLINFO_REDIRECT_TIME // get the time for all redirection steps
	redirect_time_t           = C.CURLINFO_REDIRECT_TIME_T // get the time for all redirection steps
	redirect_url              = C.CURLINFO_REDIRECT_URL // get the URL a redirect would go to
	// referer                   = C.CURLINFO_REFERER // get the referrer header // 7.76.0
	request_size              = C.CURLINFO_REQUEST_SIZE // get size of sent request
	response_code             = C.CURLINFO_RESPONSE_CODE // get the last response code
	// retry_after               = C.CURLINFO_RETRY_AFTER // returns the Retry-After retry delay // 7.66.0
	rtsp_client_cseq          = C.CURLINFO_RTSP_CLIENT_CSEQ // get the next RTSP client CSeq
	rtsp_cseq_recv            = C.CURLINFO_RTSP_CSEQ_RECV // get the recently received CSeq
	rtsp_server_cseq          = C.CURLINFO_RTSP_SERVER_CSEQ // get the next RTSP server CSeq
	rtsp_session_id           = C.CURLINFO_RTSP_SESSION_ID // get RTSP session ID
	scheme                    = C.CURLINFO_SCHEME // get the URL scheme (sometimes called protocol) used in the connection
	size_download             = C.CURLINFO_SIZE_DOWNLOAD // get the number of downloaded bytes
	size_download_t           = C.CURLINFO_SIZE_DOWNLOAD_T // get the number of downloaded bytes
	size_upload               = C.CURLINFO_SIZE_UPLOAD // get the number of uploaded bytes
	size_upload_t             = C.CURLINFO_SIZE_UPLOAD_T // get the number of uploaded bytes
	speed_download            = C.CURLINFO_SPEED_DOWNLOAD // get download speed
	speed_download_t          = C.CURLINFO_SPEED_DOWNLOAD_T // get download speed
	speed_upload              = C.CURLINFO_SPEED_UPLOAD // get upload speed
	speed_upload_t            = C.CURLINFO_SPEED_UPLOAD_T // get upload speed
	ssl_engines               = C.CURLINFO_SSL_ENGINES // get an slist of OpenSSL crypto-engines
	ssl_verifyresult          = C.CURLINFO_SSL_VERIFYRESULT // get the result of the certificate verification
	starttransfer_time        = C.CURLINFO_STARTTRANSFER_TIME // get the time until the first byte is received
	starttransfer_time_t      = C.CURLINFO_STARTTRANSFER_TIME_T // get the time until the first byte is received
	tls_session               = C.CURLINFO_TLS_SESSION // get TLS session info
	tls_ssl_ptr               = C.CURLINFO_TLS_SSL_PTR //
	total_time                = C.CURLINFO_TOTAL_TIME // get total time of previous transfer
	total_time_t              = C.CURLINFO_TOTAL_TIME_T // get total time of previous transfer in microseconds
}
