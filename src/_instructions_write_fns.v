module vibe

fn write_resp(data &char, size usize, nmemb usize, mut resp Response) usize {
	n := size * nmemb
	resp.pos += n
	unsafe {
		resp.body += data.vstring()
	}
	return n
}

fn write_resp_header(data &char, size usize, nmemb usize, mut resp Response) usize {
	n := size * nmemb
	resp.pos += n
	unsafe {
		resp.header += data.vstring()
	}
	return n
}

fn write_resp_slice(data &char, size usize, nmemb usize, mut resp Response) usize {
	n := size * nmemb
	resp.pos += n

	if resp.pos > resp.slice.start {
		unsafe {
			resp.body += data.vstring()
		}
		if resp.slice.end != resp.slice.start && resp.pos > resp.slice.end {
			resp.slice.finished = true
			return 0
		}
	}

	return n
}
