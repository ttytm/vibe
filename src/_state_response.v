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
	status       Status
	http_version string
}
