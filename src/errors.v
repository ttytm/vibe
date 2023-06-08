module vibe

struct HttpError {
	Error
	kind HttpErrorKind
	val  string
}

enum HttpErrorKind {
	session_init
	slice_out_of_range
	status_line
	version
	version_segment
	status_code
}

fn (err HttpError) msg() string {
	return match err.kind {
		.session_init { 'Failed initiating session.' }
		.slice_out_of_range { 'Failed finding slice in range: `${err.val}`' }
		.status_line { 'Failed processing HTTP response - Invalid header status line: `${err.val}`' }
		.version { 'Failed processing HTTP version: `${err.val}`' }
		.version_segment { 'Failed processing HTTP version segment: `${err.val}`' }
		.status_code { 'Failed processing status code: `${err.val}`' }
	}
}
