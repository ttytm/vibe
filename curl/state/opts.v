// https://curl.se/libcurl/c/easy_setopt_options.html
@[generated]
module state

// TODO: check commented after debian 10 EOL, June 30, 2024. Compare Ubuntu LTS 22.04 with Debian 11.
enum Opt {
	abstract_unix_socket       = C.CURLOPT_ABSTRACT_UNIX_SOCKET // abstract Unix domain socket
	accepttimeout_ms           = C.CURLOPT_ACCEPTTIMEOUT_MS // timeout waiting for FTP server to connect back
	accept_encoding            = C.CURLOPT_ACCEPT_ENCODING // automatic decompression of HTTP downloads
	address_scope              = C.CURLOPT_ADDRESS_SCOPE // scope id for IPv6 addresses
	// altsvc                     = C.CURLOPT_ALTSVC // alt-svc cache file name // 7.64.1
	// altsvc_ctrl                = C.CURLOPT_ALTSVC_CTRL // control alt-svc behavior // 7.64.1
	append                     = C.CURLOPT_APPEND // append to the remote file
	autoreferer                = C.CURLOPT_AUTOREFERER // automatically update the referer header
	// aws_sigv4                  = C.CURLOPT_AWS_SIGV4 // V4 signature // 7.75.0
	buffersize                 = C.CURLOPT_BUFFERSIZE // receive buffer size
	// cainfo                     = C.CURLOPT_CAINFO // path to Certificate Authority (CA) bundle // 7.84.0
	// cainfo_blob                = C.CURLOPT_CAINFO_BLOB // Certificate Authority (CA) bundle in PEM format // 7.77.0
	capath                     = C.CURLOPT_CAPATH // directory holding CA certificates
	// ca_cache_timeout = C.CURLOPT_CA_CACHE_TIMEOUT // life-time for cached certificate stores // 7.87.0
	certinfo                   = C.CURLOPT_CERTINFO // request SSL certificate information
	chunk_bgn_function         = C.CURLOPT_CHUNK_BGN_FUNCTION // callback before a transfer with FTP wildcard match
	chunk_data                 = C.CURLOPT_CHUNK_DATA // pointer passed to the FTP chunk callbacks
	chunk_end_function         = C.CURLOPT_CHUNK_END_FUNCTION // callback after a transfer with FTP wildcard match
	closesocketdata            = C.CURLOPT_CLOSESOCKETDATA // pointer passed to the socket close callback
	closesocketfunction        = C.CURLOPT_CLOSESOCKETFUNCTION // callback to socket close replacement
	connecttimeout             = C.CURLOPT_CONNECTTIMEOUT // timeout for the connect phase
	connecttimeout_ms          = C.CURLOPT_CONNECTTIMEOUT_MS // timeout for the connect phase
	connect_only               = C.CURLOPT_CONNECT_ONLY // stop when connected to target server
	connect_to                 = C.CURLOPT_CONNECT_TO // connect to a specific host and port instead of the URL's host and port
	conv_from_network_function = C.CURLOPT_CONV_FROM_NETWORK_FUNCTION // convert data from network to host encoding
	conv_from_utf8_function    = C.CURLOPT_CONV_FROM_UTF8_FUNCTION // convert data from UTF8 to host encoding
	conv_to_network_function   = C.CURLOPT_CONV_TO_NETWORK_FUNCTION // convert data to network from host encoding
	cookie                     = C.CURLOPT_COOKIE // HTTP Cookie header
	cookiefile                 = C.CURLOPT_COOKIEFILE // file name to read cookies from
	cookiejar                  = C.CURLOPT_COOKIEJAR // file name to store cookies to
	cookielist                 = C.CURLOPT_COOKIELIST // add to or manipulate cookies held in memory
	cookiesession              = C.CURLOPT_COOKIESESSION // start a new cookie session
	copypostfields             = C.CURLOPT_COPYPOSTFIELDS // have libcurl copy data to POST
	crlf                       = C.CURLOPT_CRLF // CRLF conversion
	crlfile                    = C.CURLOPT_CRLFILE // Certificate Revocation List file
	curlu                      = C.CURLOPT_CURLU // URL in URL handle format
	customrequest              = C.CURLOPT_CUSTOMREQUEST // custom request method
	debugdata                  = C.CURLOPT_DEBUGDATA // pointer passed to the debug callback
	debugfunction              = C.CURLOPT_DEBUGFUNCTION // debug callback
	default_protocol           = C.CURLOPT_DEFAULT_PROTOCOL // default protocol to use if the URL is missing a scheme name
	dirlistonly                = C.CURLOPT_DIRLISTONLY // ask for names only in a directory listing
	disallow_username_in_url   = C.CURLOPT_DISALLOW_USERNAME_IN_URL // disallow specifying username in the URL
	dns_cache_timeout          = C.CURLOPT_DNS_CACHE_TIMEOUT // life-time for DNS cache entries
	dns_interface              = C.CURLOPT_DNS_INTERFACE // interface to speak DNS over
	dns_local_ip4              = C.CURLOPT_DNS_LOCAL_IP4 // IPv4 address to bind DNS resolves to
	dns_local_ip6              = C.CURLOPT_DNS_LOCAL_IP6 // IPv6 address to bind DNS resolves to
	dns_servers                = C.CURLOPT_DNS_SERVERS // DNS servers to use
	dns_shuffle_addresses      = C.CURLOPT_DNS_SHUFFLE_ADDRESSES // shuffle IP addresses for hostname
	dns_use_global_cache       = C.CURLOPT_DNS_USE_GLOBAL_CACHE // global DNS cache
	// doh_ssl_verifyhost         = C.CURLOPT_DOH_SSL_VERIFYHOST // verify the host name in the DoH SSL certificate // 7.76.0
	// doh_ssl_verifypeer         = C.CURLOPT_DOH_SSL_VERIFYPEER // verify the DoH SSL certificate // 7.76.0
	// doh_ssl_verifystatus       = C.CURLOPT_DOH_SSL_VERIFYSTATUS // verify the DoH SSL certificate's status // 7.76.0
	doh_url                    = C.CURLOPT_DOH_URL // provide the DNS-over-HTTPS URL
	egdsocket                  = C.CURLOPT_EGDSOCKET // EGD socket path
	errorbuffer                = C.CURLOPT_ERRORBUFFER // error buffer for error messages
	expect_100_timeout_ms      = C.CURLOPT_EXPECT_100_TIMEOUT_MS // timeout for Expect: 100-continue response
	failonerror                = C.CURLOPT_FAILONERROR // request failure on HTTP response >= 400
	filetime                   = C.CURLOPT_FILETIME // get the modification time of the remote resource
	fnmatch_data               = C.CURLOPT_FNMATCH_DATA // pointer passed to the fnmatch callback
	fnmatch_function           = C.CURLOPT_FNMATCH_FUNCTION // wildcard match callback
	followlocation             = C.CURLOPT_FOLLOWLOCATION // follow HTTP 3xx redirects
	forbid_reuse               = C.CURLOPT_FORBID_REUSE // make connection get closed at once after use
	fresh_connect              = C.CURLOPT_FRESH_CONNECT // force a new connection to be used
	ftpport                    = C.CURLOPT_FTPPORT // make FTP transfer active
	ftpsslauth                 = C.CURLOPT_FTPSSLAUTH // order in which to attempt TLS vs SSL
	ftp_account                = C.CURLOPT_FTP_ACCOUNT // account info for FTP
	ftp_alternative_to_user    = C.CURLOPT_FTP_ALTERNATIVE_TO_USER // command to use instead of USER with FTP
	ftp_create_missing_dirs    = C.CURLOPT_FTP_CREATE_MISSING_DIRS // create missing directories for FTP and SFTP
	ftp_filemethod             = C.CURLOPT_FTP_FILEMETHOD // select directory traversing method for FTP
	ftp_skip_pasv_ip           = C.CURLOPT_FTP_SKIP_PASV_IP // ignore the IP address in the PASV response
	ftp_ssl_ccc                = C.CURLOPT_FTP_SSL_CCC // switch off SSL again with FTP after auth
	ftp_use_eprt               = C.CURLOPT_FTP_USE_EPRT // use EPRT for FTP
	ftp_use_epsv               = C.CURLOPT_FTP_USE_EPSV // use EPSV for FTP
	ftp_use_pret               = C.CURLOPT_FTP_USE_PRET // use PRET for FTP
	gssapi_delegation          = C.CURLOPT_GSSAPI_DELEGATION // allowed GSS-API delegation
	happy_eyeballs_timeout_ms  = C.CURLOPT_HAPPY_EYEBALLS_TIMEOUT_MS // head start for IPv6 for happy eyeballs
	haproxyprotocol            = C.CURLOPT_HAPROXYPROTOCOL // send HAProxy PROXY protocol v1 header
	header                     = C.CURLOPT_HEADER // pass headers to the data stream
	headerdata                 = C.CURLOPT_HEADERDATA // pointer to pass to header callback
	headerfunction             = C.CURLOPT_HEADERFUNCTION // callback that receives header data
	headeropt                  = C.CURLOPT_HEADEROPT // send HTTP headers to both proxy and host or separately
	// hsts                       = C.CURLOPT_HSTS // HSTS cache file name // 7.74.0
	// hstsreaddata               = C.CURLOPT_HSTSREADDATA // pointer passed to the HSTS read callback // 7.74.0
	// hstsreadfunction           = C.CURLOPT_HSTSREADFUNCTION // read callback for HSTS hosts // 7.74.0
	// hstswritedata              = C.CURLOPT_HSTSWRITEDATA // pointer passed to the HSTS write callback // 7.74.0
	// hstswritefunction          = C.CURLOPT_HSTSWRITEFUNCTION // write callback for HSTS hosts // 7.74.0
	// hsts_ctrl                  = C.CURLOPT_HSTS_CTRL // control HSTS behavior // 7.74.0
	http09_allowed             = C.CURLOPT_HTTP09_ALLOWED // allow HTTP/0.9 response
	http200aliases             = C.CURLOPT_HTTP200ALIASES // alternative matches for HTTP 200 OK
	httpauth                   = C.CURLOPT_HTTPAUTH // HTTP server authentication methods to try
	httpget                    = C.CURLOPT_HTTPGET // ask for an HTTP GET request
	httpheader                 = C.CURLOPT_HTTPHEADER // set of HTTP headers
	httppost                   = C.CURLOPT_HTTPPOST // multipart formpost content
	httpproxytunnel            = C.CURLOPT_HTTPPROXYTUNNEL // tunnel through HTTP proxy
	http_content_decoding      = C.CURLOPT_HTTP_CONTENT_DECODING // HTTP content decoding control
	http_transfer_decoding     = C.CURLOPT_HTTP_TRANSFER_DECODING // HTTP transfer decoding control
	http_version               = C.CURLOPT_HTTP_VERSION // HTTP protocol version to use
	ignore_content_length      = C.CURLOPT_IGNORE_CONTENT_LENGTH // ignore content length
	infilesize                 = C.CURLOPT_INFILESIZE // size of the input file to send off
	infilesize_large           = C.CURLOPT_INFILESIZE_LARGE // size of the input file to send off
	interface                  = C.CURLOPT_INTERFACE // source interface for outgoing traffic
	interleavedata             = C.CURLOPT_INTERLEAVEDATA // pointer passed to RTSP interleave callback
	interleavefunction         = C.CURLOPT_INTERLEAVEFUNCTION // callback for RTSP interleaved data
	ioctldata                  = C.CURLOPT_IOCTLDATA // pointer passed to I/O callback
	ioctlfunction              = C.CURLOPT_IOCTLFUNCTION // callback for I/O operations
	ipresolve                  = C.CURLOPT_IPRESOLVE // IP protocol version to use
	issuercert                 = C.CURLOPT_ISSUERCERT // issuer SSL certificate filename
	// issuercert_blob            = C.CURLOPT_ISSUERCERT_BLOB // issuer SSL certificate from memory blob // 7.71.0
	keep_sending_on_error      = C.CURLOPT_KEEP_SENDING_ON_ERROR // keep sending on early HTTP response >= 300
	keypasswd                  = C.CURLOPT_KEYPASSWD // passphrase to private key
	krblevel                   = C.CURLOPT_KRBLEVEL // FTP kerberos security level
	localport                  = C.CURLOPT_LOCALPORT // local port number to use for socket
	localportrange             = C.CURLOPT_LOCALPORTRANGE // number of additional local ports to try
	login_options              = C.CURLOPT_LOGIN_OPTIONS // login options
	low_speed_limit            = C.CURLOPT_LOW_SPEED_LIMIT // low speed limit in bytes per second
	low_speed_time             = C.CURLOPT_LOW_SPEED_TIME // low speed limit time period
	mail_auth                  = C.CURLOPT_MAIL_AUTH // SMTP authentication address
	mail_from                  = C.CURLOPT_MAIL_FROM // SMTP sender address
	mail_rcpt                  = C.CURLOPT_MAIL_RCPT // list of SMTP mail recipients
	// mail_rcpt_alllowfails      = C.CURLOPT_MAIL_RCPT_ALLLOWFAILS // allow RCPT TO command to fail for some recipients // 8.2.0
	// maxage_conn                = C.CURLOPT_MAXAGE_CONN // max idle time allowed for reusing a connection // 7.65.0
	// maxconnects                = C.CURLOPT_MAXCONNECTS // maximum connection cache size // 7.7.0
	maxfilesize                = C.CURLOPT_MAXFILESIZE // maximum file size allowed to download
	maxfilesize_large          = C.CURLOPT_MAXFILESIZE_LARGE // maximum file size allowed to download
	// maxlifetime_conn           = C.CURLOPT_MAXLIFETIME_CONN // max lifetime (since creation) allowed for reusing a connection // 7.80.0
	maxredirs                  = C.CURLOPT_MAXREDIRS // maximum number of redirects allowed
	max_recv_speed_large       = C.CURLOPT_MAX_RECV_SPEED_LARGE // rate limit data download speed
	max_send_speed_large       = C.CURLOPT_MAX_SEND_SPEED_LARGE // rate limit data upload speed
	mimepost                   = C.CURLOPT_MIMEPOST // send data from mime structure
	// mime_options               = C.CURLOPT_MIME_OPTIONS // set MIME option flags // 7.81.0
	netrc                      = C.CURLOPT_NETRC // enable use of .netrc
	netrc_file                 = C.CURLOPT_NETRC_FILE // file name to read .netrc info from
	new_directory_perms        = C.CURLOPT_NEW_DIRECTORY_PERMS // permissions for remotely created directories
	new_file_perms             = C.CURLOPT_NEW_FILE_PERMS // permissions for remotely created files
	nobody                     = C.CURLOPT_NOBODY // do the download request without getting the body
	noprogress                 = C.CURLOPT_NOPROGRESS // switch off the progress meter
	noproxy                    = C.CURLOPT_NOPROXY // disable proxy use for specific hosts
	nosignal                   = C.CURLOPT_NOSIGNAL // skip all signal handling
	opensocketdata             = C.CURLOPT_OPENSOCKETDATA // pointer passed to open socket callback
	opensocketfunction         = C.CURLOPT_OPENSOCKETFUNCTION // callback for opening socket
	password                   = C.CURLOPT_PASSWORD // password to use in authentication
	path_as_is                 = C.CURLOPT_PATH_AS_IS // do not handle dot dot sequences
	pinnedpublickey            = C.CURLOPT_PINNEDPUBLICKEY // pinned public key
	pipewait                   = C.CURLOPT_PIPEWAIT // wait for pipelining/multiplexing
	port                       = C.CURLOPT_PORT // remote port number to connect to
	post                       = C.CURLOPT_POST // make an HTTP POST
	postfields                 = C.CURLOPT_POSTFIELDS // data to POST to server
	postfieldsize              = C.CURLOPT_POSTFIELDSIZE // size of POST data pointed to
	postfieldsize_large        = C.CURLOPT_POSTFIELDSIZE_LARGE // size of POST data pointed to
	postquote                  = C.CURLOPT_POSTQUOTE // (S)FTP commands to run after the transfer
	postredir                  = C.CURLOPT_POSTREDIR // how to act on an HTTP POST redirect
	prequote                   = C.CURLOPT_PREQUOTE // commands to run before an FTP transfer
	// prereqdata                 = C.CURLOPT_PREREQDATA // pointer passed to the pre-request callback // 7.80.0
	// prereqfunction             = C.CURLOPT_PREREQFUNCTION // user callback called when a connection has been // 7.80.0
	pre_proxy                  = C.CURLOPT_PRE_PROXY // pre-proxy host to use
	private                    = C.CURLOPT_PRIVATE // store a private pointer
	progressdata               = C.CURLOPT_PROGRESSDATA // pointer passed to the progress callback
	progressfunction           = C.CURLOPT_PROGRESSFUNCTION // progress meter callback
	protocols                  = C.CURLOPT_PROTOCOLS // allowed protocols
	// protocols_str = C.CURLOPT_PROTOCOLS_STR // allowed protocols // 7.85.0
	proxy                      = C.CURLOPT_PROXY // proxy to use
	proxyauth                  = C.CURLOPT_PROXYAUTH // HTTP proxy authentication methods
	proxyheader                = C.CURLOPT_PROXYHEADER // set of HTTP headers to pass to proxy
	proxypassword              = C.CURLOPT_PROXYPASSWORD // password to use with proxy authentication
	proxyport                  = C.CURLOPT_PROXYPORT // port number the proxy listens on
	proxytype                  = C.CURLOPT_PROXYTYPE // proxy protocol type
	proxyusername              = C.CURLOPT_PROXYUSERNAME // user name to use for proxy authentication
	proxyuserpwd               = C.CURLOPT_PROXYUSERPWD // user name and password to use for proxy authentication
	proxy_cainfo               = C.CURLOPT_PROXY_CAINFO // path to proxy Certificate Authority (CA) bundle
	// proxy_cainfo_blob          = C.CURLOPT_PROXY_CAINFO_BLOB // proxy Certificate Authority (CA) bundle in PEM format // 7.77.0
	proxy_capath               = C.CURLOPT_PROXY_CAPATH // directory holding HTTPS proxy CA certificates
	proxy_crlfile              = C.CURLOPT_PROXY_CRLFILE // HTTPS proxy Certificate Revocation List file
	// proxy_issuercert           = C.CURLOPT_PROXY_ISSUERCERT // proxy issuer SSL certificate filename // 7.71.0
	// proxy_issuercert_blob      = C.CURLOPT_PROXY_ISSUERCERT_BLOB // proxy issuer SSL certificate from memory blob // 7.71.0
	proxy_keypasswd            = C.CURLOPT_PROXY_KEYPASSWD // passphrase for the proxy private key
	proxy_pinnedpublickey      = C.CURLOPT_PROXY_PINNEDPUBLICKEY // pinned public key for https proxy
	proxy_service_name         = C.CURLOPT_PROXY_SERVICE_NAME // proxy authentication service name
	proxy_sslcert              = C.CURLOPT_PROXY_SSLCERT // HTTPS proxy client certificate
	proxy_sslcerttype          = C.CURLOPT_PROXY_SSLCERTTYPE // type of the proxy client SSL certificate
	// proxy_sslcert_blob         = C.CURLOPT_PROXY_SSLCERT_BLOB // SSL proxy client certificate from memory blob // 7.71.0
	proxy_sslkey               = C.CURLOPT_PROXY_SSLKEY // private key file for HTTPS proxy client cert
	proxy_sslkeytype           = C.CURLOPT_PROXY_SSLKEYTYPE // type of the proxy private key file
	// proxy_sslkey_blob          = C.CURLOPT_PROXY_SSLKEY_BLOB // private key for proxy cert from memory blob // 7.71.0
	proxy_sslversion           = C.CURLOPT_PROXY_SSLVERSION // preferred HTTPS proxy TLS version
	proxy_ssl_cipher_list      = C.CURLOPT_PROXY_SSL_CIPHER_LIST // ciphers to use for HTTPS proxy
	proxy_ssl_options          = C.CURLOPT_PROXY_SSL_OPTIONS // HTTPS proxy SSL behavior options
	proxy_ssl_verifyhost       = C.CURLOPT_PROXY_SSL_VERIFYHOST // verify the proxy certificate's name against host
	proxy_ssl_verifypeer       = C.CURLOPT_PROXY_SSL_VERIFYPEER // verify the proxy's SSL certificate
	proxy_tls13_ciphers        = C.CURLOPT_PROXY_TLS13_CIPHERS // ciphers suites for proxy TLS 1.3
	proxy_tlsauth_password     = C.CURLOPT_PROXY_TLSAUTH_PASSWORD // password to use for proxy TLS authentication
	proxy_tlsauth_type         = C.CURLOPT_PROXY_TLSAUTH_TYPE // HTTPS proxy TLS authentication methods
	proxy_tlsauth_username     = C.CURLOPT_PROXY_TLSAUTH_USERNAME // user name to use for proxy TLS authentication
	proxy_transfer_mode        = C.CURLOPT_PROXY_TRANSFER_MODE // append FTP transfer mode to URL for proxy
	put                        = C.CURLOPT_PUT // make an HTTP PUT request
	// quick_exit = C.CURLOPT_QUICK_EXIT // allow to exit quickly // 7.87.0
	quote                      = C.CURLOPT_QUOTE // (S)FTP commands to run before transfer
	random_file                = C.CURLOPT_RANDOM_FILE // file to read random data from
	range                      = C.CURLOPT_RANGE // byte range to request
	readdata                   = C.CURLOPT_READDATA // pointer passed to the read callback
	readfunction               = C.CURLOPT_READFUNCTION // read callback for data uploads
	redir_protocols            = C.CURLOPT_REDIR_PROTOCOLS // protocols allowed to redirect to
	// redir_protocols_str = C.CURLOPT_REDIR_PROTOCOLS_STR // protocols allowed to redirect to // 7.85.0
	referer                    = C.CURLOPT_REFERER // the HTTP referer header
	request_target             = C.CURLOPT_REQUEST_TARGET // alternative target for this request
	resolve                    = C.CURLOPT_RESOLVE // provide custom host name to IP address resolves
	resolver_start_data        = C.CURLOPT_RESOLVER_START_DATA // pointer passed to the resolver start callback
	resolver_start_function    = C.CURLOPT_RESOLVER_START_FUNCTION // callback called before a new name resolve is started
	resume_from                = C.CURLOPT_RESUME_FROM // offset to resume transfer from
	resume_from_large          = C.CURLOPT_RESUME_FROM_LARGE // offset to resume transfer from
	rtsp_client_cseq           = C.CURLOPT_RTSP_CLIENT_CSEQ // RTSP client CSEQ number
	rtsp_request               = C.CURLOPT_RTSP_REQUEST // RTSP request
	rtsp_server_cseq           = C.CURLOPT_RTSP_SERVER_CSEQ // RTSP server CSEQ number
	rtsp_session_id            = C.CURLOPT_RTSP_SESSION_ID // RTSP session ID
	rtsp_stream_uri            = C.CURLOPT_RTSP_STREAM_URI // RTSP stream URI
	rtsp_transport             = C.CURLOPT_RTSP_TRANSPORT // RTSP Transport: header
	// sasl_authzid               = C.CURLOPT_SASL_AUTHZID // authorization identity (identity to act as) // 7.66.0
	sasl_ir                    = C.CURLOPT_SASL_IR // send initial response in first packet
	seekdata                   = C.CURLOPT_SEEKDATA // pointer passed to the seek callback
	seekfunction               = C.CURLOPT_SEEKFUNCTION // user callback for seeking in input stream
	server_response_timeout    = C.CURLOPT_SERVER_RESPONSE_TIMEOUT // time allowed to wait for server response
	service_name               = C.CURLOPT_SERVICE_NAME // authentication service name
	share                      = C.CURLOPT_SHARE // share handle to use
	sockoptdata                = C.CURLOPT_SOCKOPTDATA // pointer to pass to sockopt callback
	sockoptfunction            = C.CURLOPT_SOCKOPTFUNCTION // callback for setting socket options
	socks5_auth                = C.CURLOPT_SOCKS5_AUTH // methods for SOCKS5 proxy authentication
	socks5_gssapi_nec          = C.CURLOPT_SOCKS5_GSSAPI_NEC // SOCKS proxy GSSAPI negotiation protection
	socks5_gssapi_service      = C.CURLOPT_SOCKS5_GSSAPI_SERVICE // SOCKS5 proxy authentication service name
	ssh_auth_types             = C.CURLOPT_SSH_AUTH_TYPES // auth types for SFTP and SCP
	ssh_compression            = C.CURLOPT_SSH_COMPRESSION // enable SSH compression
	// ssh_hostkeydata = C.CURLOPT_SSH_HOSTKEYDATA // pointer to pass to the SSH host key callback // 7.84.0
	// ssh_hostkeyfunction = C.CURLOPT_SSH_HOSTKEYFUNCTION // callback to check host key // 7.84.0
	ssh_host_public_key_md5    = C.CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 // MD5 checksum of SSH server public key
	// ssh_host_public_key_sha256 = C.CURLOPT_SSH_HOST_PUBLIC_KEY_SHA256 // SHA256 hash of SSH server public key // 7.80.0
	ssh_keydata                = C.CURLOPT_SSH_KEYDATA // pointer passed to the SSH key callback
	ssh_keyfunction            = C.CURLOPT_SSH_KEYFUNCTION // callback for known host matching logic
	ssh_knownhosts             = C.CURLOPT_SSH_KNOWNHOSTS // file name holding the SSH known hosts
	ssh_private_keyfile        = C.CURLOPT_SSH_PRIVATE_KEYFILE // private key file for SSH auth
	ssh_public_keyfile         = C.CURLOPT_SSH_PUBLIC_KEYFILE // public key file for SSH auth
	sslcert                    = C.CURLOPT_SSLCERT // SSL client certificate
	sslcerttype                = C.CURLOPT_SSLCERTTYPE // type of client SSL certificate
	// sslcert_blob               = C.CURLOPT_SSLCERT_BLOB // SSL client certificate from memory blob // 7.71.0
	sslengine                  = C.CURLOPT_SSLENGINE // SSL engine identifier
	sslengine_default          = C.CURLOPT_SSLENGINE_DEFAULT // make SSL engine default
	sslkey                     = C.CURLOPT_SSLKEY // private key file for TLS and SSL client cert
	sslkeytype                 = C.CURLOPT_SSLKEYTYPE // type of the private key file
	// sslkey_blob                = C.CURLOPT_SSLKEY_BLOB // private key for client cert from memory blob // 7.71.0
	sslversion                 = C.CURLOPT_SSLVERSION // preferred TLS/SSL version
	ssl_cipher_list            = C.CURLOPT_SSL_CIPHER_LIST // ciphers to use for TLS
	ssl_ctx_data               = C.CURLOPT_SSL_CTX_DATA // pointer passed to SSL context callback
	ssl_ctx_function           = C.CURLOPT_SSL_CTX_FUNCTION // SSL context callback for OpenSSL, wolfSSL or mbedTLS
	// ssl_ec_curves              = C.CURLOPT_SSL_EC_CURVES // key exchange curves // 7.73.0
	ssl_enable_alpn            = C.CURLOPT_SSL_ENABLE_ALPN // Application Layer Protocol Negotiation
	ssl_enable_npn             = C.CURLOPT_SSL_ENABLE_NPN // use NPN
	ssl_falsestart             = C.CURLOPT_SSL_FALSESTART // TLS false start
	ssl_options                = C.CURLOPT_SSL_OPTIONS // SSL behavior options
	ssl_sessionid_cache        = C.CURLOPT_SSL_SESSIONID_CACHE // use the SSL session-ID cache
	ssl_verifyhost             = C.CURLOPT_SSL_VERIFYHOST // verify the certificate's name against host
	ssl_verifypeer             = C.CURLOPT_SSL_VERIFYPEER // verify the peer's SSL certificate
	ssl_verifystatus           = C.CURLOPT_SSL_VERIFYSTATUS // verify the certificate's status
	stderr                     = C.CURLOPT_STDERR // redirect stderr to another stream
	stream_depends             = C.CURLOPT_STREAM_DEPENDS // stream this transfer depends on
	stream_depends_e           = C.CURLOPT_STREAM_DEPENDS_E // stream this transfer depends on exclusively
	stream_weight              = C.CURLOPT_STREAM_WEIGHT // numerical stream weight
	suppress_connect_headers   = C.CURLOPT_SUPPRESS_CONNECT_HEADERS // suppress proxy CONNECT response headers from user callbacks
	tcp_fastopen               = C.CURLOPT_TCP_FASTOPEN // TCP Fast Open
	tcp_keepalive              = C.CURLOPT_TCP_KEEPALIVE // TCP keep-alive probing
	tcp_keepidle               = C.CURLOPT_TCP_KEEPIDLE // TCP keep-alive idle time wait
	tcp_keepintvl              = C.CURLOPT_TCP_KEEPINTVL // TCP keep-alive interval
	tcp_nodelay                = C.CURLOPT_TCP_NODELAY // the TCP_NODELAY option
	telnetoptions              = C.CURLOPT_TELNETOPTIONS // set of telnet options
	tftp_blksize               = C.CURLOPT_TFTP_BLKSIZE // TFTP block size
	tftp_no_options            = C.CURLOPT_TFTP_NO_OPTIONS // send no TFTP options requests
	timecondition              = C.CURLOPT_TIMECONDITION // select condition for a time request
	timeout                    = C.CURLOPT_TIMEOUT // maximum time the transfer is allowed to complete
	timeout_ms                 = C.CURLOPT_TIMEOUT_MS // maximum time the transfer is allowed to complete
	timevalue                  = C.CURLOPT_TIMEVALUE // time value for conditional
	timevalue_large            = C.CURLOPT_TIMEVALUE_LARGE // time value for conditional
	tls13_ciphers              = C.CURLOPT_TLS13_CIPHERS // ciphers suites to use for TLS 1.3
	tlsauth_password           = C.CURLOPT_TLSAUTH_PASSWORD // password to use for TLS authentication
	tlsauth_type               = C.CURLOPT_TLSAUTH_TYPE // TLS authentication methods
	tlsauth_username           = C.CURLOPT_TLSAUTH_USERNAME // user name to use for TLS authentication
	trailerdata                = C.CURLOPT_TRAILERDATA // pointer passed to trailing headers callback
	trailerfunction            = C.CURLOPT_TRAILERFUNCTION // callback for sending trailing headers
	transfertext               = C.CURLOPT_TRANSFERTEXT // request a text based transfer for FTP
	transfer_encoding          = C.CURLOPT_TRANSFER_ENCODING // ask for HTTP Transfer Encoding
	unix_socket_path           = C.CURLOPT_UNIX_SOCKET_PATH // Unix domain socket
	unrestricted_auth          = C.CURLOPT_UNRESTRICTED_AUTH // send credentials to other hosts too
	upkeep_interval_ms         = C.CURLOPT_UPKEEP_INTERVAL_MS // connection upkeep interval
	upload                     = C.CURLOPT_UPLOAD // data upload
	upload_buffersize          = C.CURLOPT_UPLOAD_BUFFERSIZE // upload buffer size
	url                        = C.CURLOPT_URL // URL for this transfer
	useragent                  = C.CURLOPT_USERAGENT // HTTP user-agent header
	username                   = C.CURLOPT_USERNAME // user name to use in authentication
	userpwd                    = C.CURLOPT_USERPWD // user name and password to use in authentication
	use_ssl                    = C.CURLOPT_USE_SSL // request using SSL / TLS for the transfer
	verbose                    = C.CURLOPT_VERBOSE // verbose mode
	wildcardmatch              = C.CURLOPT_WILDCARDMATCH // directory wildcard transfers
	writedata                  = C.CURLOPT_WRITEDATA // pointer passed to the write callback
	writefunction              = C.CURLOPT_WRITEFUNCTION // callback for writing received data
	// ws_options = C.CURLOPT_WS_OPTIONS // WebSocket behavior options // 7.8.6.0
	xferinfodata               = C.CURLOPT_XFERINFODATA // pointer passed to the progress callback
	xferinfofunction           = C.CURLOPT_XFERINFOFUNCTION // progress meter callback
	xoauth2_bearer             = C.CURLOPT_XOAUTH2_BEARER // OAuth 2.0 access token
}
