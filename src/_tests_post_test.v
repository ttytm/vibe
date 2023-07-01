module vibe

import time
import x.json2 as json

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
	mut resp := req.post('https://httpbin.org/post', '{"msg":"hello from vibe"}')!
	// Allow one retry as we rely here on httpbin as a third party and may encounter slow/no response times
	if resp.status != 200 {
		resp = req.post('https://httpbin.org/post', '{"msg":"hello from vibe"}')!
	}

	assert resp.status == 200
	raw_json_resp := json.raw_decode(resp.body)!.as_map()
	headers := raw_json_resp['headers']!.as_map()
	assert headers['My-Custom-Header']!.str() == 'FooBar'
	assert headers['User-Agent']!.str() == 'YourCustomUserAgent/v0.0.1'
	json_data := raw_json_resp['json']!.as_map()
	assert json_data['msg']!.str() == 'hello from vibe'
}
