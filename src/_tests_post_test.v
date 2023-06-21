module vibe

import time

fn test_post() {
	req := Request{
		headers: {
			.user_agent:   'YourCustomUserAgent/v0.0.1'
			.content_type: 'application/json; charset=utf-8'
		}
		timeout: time.second * 10
	}
	mut resp := req.post('https://httpbin.org/post', '{"msg":"hello from vibe"}')!
	// Allow one retry as we rely here on httpbin as a third party and may encounter slow/no response times
	if resp.status != 200 {
		resp = req.post('https://httpbin.org/post', '{"msg":"hello from vibe"}')!
	}

	assert resp.status == 200
	assert resp.body.contains('"User-Agent": "YourCustomUserAgent/v0.0.1"')
	assert resp.body.contains('"msg": "hello from vibe"')
}
