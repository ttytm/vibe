// vtest retry: 9
module vibe

fn test_get_slice() {
	resp := get_slice('https://raw.githubusercontent.com/vlang/v/refs/tags/0.4.8/doc/docs.md',
		135_000, 10_000)!
	assert resp.status == 200
	assert resp.body.contains("Module {
       name: 'mypackage'
       description: 'My nice package.'
       version: '0.0.1'
       license: 'MIT'
       dependencies: []
   }"), resp.body
}
