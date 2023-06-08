module vibe

pub struct Response {
mut:
	pos   u32
	slice struct {
		start u32
		end   u32
	mut:
		finished bool
	}
pub mut:
	body         string
	header       string
	status_code  int
	status_msg   string
	http_version string
}
