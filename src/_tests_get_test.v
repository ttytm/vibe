// vtest retry: 9
module vibe

fn test_get() {
	resp := get('https://hacker-news.firebaseio.com/v0/item/1.json')!

	assert resp.status == 200
	assert resp.status.msg() == 'OK'
	assert resp.body.contains('time')
	assert resp.body.contains('title')
	assert resp.body.contains('url')
}
