module vibe

import os

fn test_download() {
	download_path := '/tmp/v_linux.zip'
	resp := download_file('https://github.com/vlang/v/releases/download/weekly.2023.23/v_linux.zip',
		download_path)!

	assert resp.header.contains('content-length: 15225062')
	assert os.file_size(download_path) == 15225062
	os.rm(download_path)!
}
