// vtest retry: 9
module vibe

fn test_get_slice() {
	resp := get_slice('https://raw.githubusercontent.com/vlang/v/master/doc/docs.md', 185_000,
		10_000)!
	assert resp.status == 200
	assert resp.body.contains("Module {
\tname: 'mymodule',
\tdescription: 'My nice module wraps a simple C library.',
\tversion: '0.0.1'
\tdependencies: []
}"), resp.body
}
