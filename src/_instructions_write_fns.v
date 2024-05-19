module vibe

fn write_resp(data &char, size usize, nmemb usize, mut resp VibeResponse) usize {
	n := size * nmemb
	resp.pos += n
	resp.body += unsafe { data.vstring_with_len(int(n)) }
	return n
}

fn write_resp_header(data &char, size usize, nmemb usize, mut resp VibeResponse) usize {
	n := size * nmemb
	resp.pos += n
	resp.header += unsafe { data.vstring_with_len(int(n)) }
	return n
}

fn write_resp_slice(data &char, size usize, nmemb usize, mut resp VibeResponse) usize {
	n := size * nmemb
	resp.pos += n
	if resp.pos > resp.slice.start {
		resp.body += unsafe { data.vstring_with_len(int(n)) }
		if resp.slice.end != resp.slice.start && resp.pos > resp.slice.end {
			resp.slice.finished = true
			return 0
		}
	}
	return n
}

fn write_download(data &char, size usize, nmemb usize, mut fw FileWriter) usize {
	n := size * nmemb
	if fw.file.is_opened {
		fw.pos += u64(unsafe { fw.file.write_ptr_at(data, int(n), fw.pos) })
	}
	return n
}

fn write_download_with_progress(data &char, size u64, nmemb u64, mut w ProgressWriter) u64 {
	n := size * nmemb
	if w.file.is_opened {
		w.pos += u64(unsafe { w.file.write_ptr_at(data, int(n), w.pos) })
		w.download.progress(w.pos, w.size)
	}
	return n
}

fn write_null(data &char, size usize, nmemb usize) usize {
	return size * nmemb
}
