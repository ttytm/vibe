module vibe

import time
import x.json2 as json

fn try_request(request Request, attempt int, max_attempts int) !Response {
	return if resp := request.post('https://httpbin.org/post', '{"msg":"hello from vibe"}') {
		resp
	} else {
		if attempt < max_attempts {
			return try_request(request, attempt + 1, max_attempts)
		}
		err
	}
}

fn test_post() {
	req := Request{
		headers: {
			.user_agent:   'YourCustomUserAgent/v0.0.1'
			.content_type: 'application/json; charset=utf-8'
		}
		custom_headers: {
			'My-Custom-Header': 'FooBar'
		}
		timeout: time.second * 10
	}
	// Allow for retries as the current test relies on httpbin as a third party
	// and may encounter slow/no response times.
	resp := try_request(req, 0, 10)!

	assert resp.status == 200
	raw_json_resp := json.raw_decode(resp.body)!.as_map()
	headers := raw_json_resp['headers']!.as_map()
	assert headers['My-Custom-Header']!.str() == 'FooBar'
	assert headers['User-Agent']!.str() == 'YourCustomUserAgent/v0.0.1'
	json_data := raw_json_resp['json']!.as_map()
	assert json_data['msg']!.str() == 'hello from vibe'
}
