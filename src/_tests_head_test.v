module vibe

fn test_head() {
	resp := head('https://github.com/vlang/v/releases/download/weekly.2023.23/v_linux.zip')!

	assert resp.status == 200
	assert resp.header.contains('filename=v_linux.zip')
	assert resp.header.contains('content-length: 15225062')
}
