module vibe

import os
import vibe.curl

fn (s Session) download_file_(url string, file_path string) !Response {
	mut resp := s.get_head(url)!

	mut file := os.create(file_path)!
	defer {
		file.close()
	}
	mut fw := FileWriter{
		file: file
	}

	curl.easy_setopt(s.curl, .header, 0)
	curl.easy_setopt(s.curl, .writefunction, write_download)
	curl.easy_setopt(s.curl, .writedata, &fw)

	res := curl.easy_perform(s.curl)
	if res != curl.Ecode.ok {
		return IError(curl.CurlError{
			e_code: res
		})
	}

	mut status_code := 0
	curl.easy_getinfo(s.curl, .response_code, &status_code)

	resp.status = Status(status_code)
	resp.get_http_version()!

	return resp
}
