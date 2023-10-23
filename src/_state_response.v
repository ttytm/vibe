module vibe

pub struct Response {
pub mut:
	header       string
	status       Status
	http_version string
	body         string
}

struct VibeResponse {
	Response
mut:
	pos         usize
	status_code int
	slice       struct {
		start usize
		end   usize
	mut:
		finished bool
	}
}
