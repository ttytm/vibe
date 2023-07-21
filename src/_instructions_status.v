module vibe

import strconv

fn (mut resp VibeResponse) get_http_version() ! {
	status_line := resp.header.before('\r\n')

	// Example: [0]: http/1.1 [1]: 200 [2]: OK
	vals := status_line.split_nth(' ', 3)
	if vals.len != 3 {
		return http_error(.version, status_line)
	}

	version := vals[0][5..]
	if version.len != 1 && (version != '2' || version != '3') {
		maj_min_ver := version.split_nth('.', 3)
		if maj_min_ver.len != 2 {
			return http_error(.version, maj_min_ver.str())
		}
		for ver in maj_min_ver {
			strconv.atoi(ver) or { return http_error(.version, ver) }
		}
	}

	resp.http_version = version
}

// https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml
[generated]
fn (status_code Status) msg_() string {
	return match status_code {
		100 { 'Continue' }
		101 { 'Switching Protocols' }
		102 { 'Processing' }
		103 { 'Early Hints' }
		104...199 { 'Unassigned' }
		200 { 'OK' }
		201 { 'Created' }
		202 { 'Accepted' }
		203 { 'Non-Authoritative Information' }
		204 { 'No Content' }
		205 { 'Reset Content' }
		206 { 'Partial Content' }
		207 { 'Multi-Status' }
		208 { 'Already Reported' }
		209...225 { 'Unassigned' }
		226 { 'IM Used' }
		227...299 { 'Unassigned' }
		300 { 'Multiple Choices' }
		301 { 'Moved Permanently' }
		302 { 'Found' }
		303 { 'See Other' }
		304 { 'Not Modified' }
		305 { 'Use Proxy' }
		306 { '(Unused)' }
		307 { 'Temporary Redirect' }
		308 { 'Permanent Redirect' }
		309...399 { 'Unassigned' }
		400 { 'Bad Request' }
		401 { 'Unauthorized' }
		402 { 'Payment Required' }
		403 { 'Forbidden' }
		404 { 'Not Found' }
		405 { 'Method Not Allowed' }
		406 { 'Not Acceptable' }
		407 { 'Proxy Authentication Required' }
		408 { 'Request Timeout' }
		409 { 'Conflict' }
		410 { 'Gone' }
		411 { 'Length Required' }
		412 { 'Precondition Failed' }
		413 { 'Content Too Large' }
		414 { 'URI Too Long' }
		415 { 'Unsupported Media Type' }
		416 { 'Range Not Satisfiable' }
		417 { 'Expectation Failed' }
		418 { '(Unused)' }
		419...420 { 'Unassigned' }
		421 { 'Misdirected Request' }
		422 { 'Unprocessable Content' }
		423 { 'Locked' }
		424 { 'Failed Dependency' }
		425 { 'Too Early' }
		426 { 'Upgrade Required' }
		427 { 'Unassigned' }
		428 { 'Precondition Required' }
		429 { 'Too Many Requests' }
		430 { 'Unassigned' }
		431 { 'Request Header Fields Too Large' }
		432...450 { 'Unassigned' }
		451 { 'Unavailable For Legal Reasons' }
		452...499 { 'Unassigned' }
		500 { 'Internal Server Error' }
		501 { 'Not Implemented' }
		502 { 'Bad Gateway' }
		503 { 'Service Unavailable' }
		504 { 'Gateway Timeout' }
		505 { 'HTTP Version Not Supported' }
		506 { 'Variant Also Negotiates' }
		507 { 'Insufficient Storage' }
		508 { 'Loop Detected' }
		509 { 'Unassigned' }
		510 { 'Not Extended (OBSOLETED)' }
		511 { 'Network Authentication Required' }
		512...599 { 'Unassigned' }
		else { 'Unknown' }
	}
}
