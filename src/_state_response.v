module vibe

import os

pub struct Response {
mut:
	pos   usize
	slice struct {
		start usize
		end   usize
	mut:
		finished bool
	}
pub mut:
	header       string
	status       Status
	http_version string
	body         string
}

struct FileWriter {
mut:
	file     os.File
	pos      u64
}

struct ProgressWriter {
	FileWriter
mut:
	size      u64
	download Download
}

interface Download {
	progress(u64, u64)
	completed()
}
