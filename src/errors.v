module vibe

struct HttpError {
	Error
	kind HttpErrorKind
	val  string
}

enum HttpErrorKind {
	easy_init
	slice_out_of_range
	status_line
	version
	version_segment
	max_redirs_reached
}

fn (err HttpError) msg() string {
	return match err.kind {
		.easy_init { 'Failed initiating curl' }
		.slice_out_of_range { 'Failed finding slice in range: `${err.val}`' }
		.status_line { 'Failed processing HTTP response - Invalid header status line: `${err.val}`' }
		.version { 'Failed processing HTTP version: `${err.val}`' }
		.version_segment { 'Failed processing HTTP version segment: `${err.val}`' }
		.max_redirs_reached { 'Maximum redirects reached' }
	}
}
