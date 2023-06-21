module vibe

import net.html

fn test_get_slice() {
	resp := get_slice('https://docs.vosca.dev/advanced-concepts/v-and-c.html', 65_000,
		10_000)!
	selector := html.parse(resp.body).get_tags_by_class_name('language-vmod')[0]

	assert resp.status == 200
	assert selector.text().trim(' \n') == "Module {
    name: 'mymodule',
    description: 'My nice module wraps a simple C library.',
    version: '0.0.1'
    dependencies: []
}"
}
