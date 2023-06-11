// NOTE: if vibe is in `~/.vmodules/` cd out of the project directory to execute the script.
import net.html
import vibe

const (
	request   = vibe.Request{}
	separator = '\n-----------------------------------------------------------------------\n'
)

fn gen_opts() string {
	body := request.get('https://curl.se/libcurl/c/easy_setopt_options.html') or {
		panic('Error requesting options source: ${err}')
	}.body
	mut rows := html.parse(body).get_tag('table')[0].get_tags('tr')
	if rows.len == 0 {
		panic('Failed finding option selector tags.')
	}

	mut opts := 'enum Opt {'
	for r in rows {
		// [0]: CURLOPT_<NAME>, [1]: Description
		tds := r.get_tags('td')
		opt := tds[0].text()
		opts += '\t${opt.replace('CURLOPT_', '').to_lower()} = C.${opt} // ${tds[1].text()}\n'
	}
	opts += '}'

	return '// https://curl.se/libcurl/c/easy_setopt_options.html
[generated]
module state
${opts}'
}

fn gen_codes() string {
	body := request.get('https://curl.se/libcurl/c/libcurl-errors.html') or {
		panic('Error requesting errors source: ${err}')
	}.body
	mut doc := html.parse(body)

	// Currently, scraped paragraphs won't contain span children - the selectors containing the CURLcode.
	// This makes it harder to add their following paragraphs(description).
	// For simplicity reasons descriptions are omitted for now and code tags are targeted directly.
	// paragraphs := doc.get_tag_by_attribute_value('class', 'contents')[0].get_tags('p')

	spans := doc.get_tags_by_class_name('nroffip')
	if spans.len == 0 {
		panic('Failed finding errors selector tags.')
	}

	mut e := 'enum Ecode {\n'
	mut m := 'enum Mcode {\n'
	mut sh := 'enum SHEcode {\n'
	mut ue := 'enum UEcode {\n'
	mut h := 'enum Hcode {\n'
	for i := 0; i <= spans.len - 1; i++ {
		code := spans[i] or { continue }.text().before(' ')
		match true {
			code.contains('CURLE') { e += '\t${code.replace('CURLE_', '').to_lower()} = C.${code}\n' }
			code.contains('CURLM') { m += '\t${code.replace('CURLM_', '').to_lower()} = C.${code}\n' }
			code.contains('CURLSHE') { sh += '\t${code.replace('CURLSHE_', '').to_lower()} = C.${code}\n' }
			code.contains('CURLUE') { ue += '\t${code.replace('CURLUE_', '').to_lower()} = C.${code}\n' }
			code.contains('CURLH') { h += '\t${code.replace('CURLSH_', '').to_lower()} = C.${code}\n' }
			else { continue }
		}
	}

	e += '\twritefunc_error = C.CURL_WRITEFUNC_ERROR\n'
	e += '}'
	obsolete := 'obsolete* = C.CURLE_OBSOLETE*'
	e = e.replace(obsolete, '// ${obsolete}')
	m += '}'
	sh += '}'
	ue += '}'
	h += '}'

	return '// https://curl.se/libcurl/c/libcurl-errors.html
[generated]
module state
${e}\n
${m}\n
${sh}\n
${ue}\n
${h}'
}

fn gen_info() string {
	body := request.get('https://curl.se/libcurl/c/easy_getinfo_options.html') or {
		panic('Error requesting info options source: ${err}')
	}.body
	mut rows := html.parse(body).get_tag('table')[0].get_tags('tr')
	if rows.len == 0 {
		panic('Failed finding info options selector tags.')
	}

	mut info := 'enum Info {\n'
	for r in rows {
		// [0]: CURLOPT_<NAME>, [1]: Description
		tds := r.get_tags('td')
		opt := tds[0].text()
		info += '\t${opt.replace('CURLINFO_', '').to_lower()} = C.${opt} // ${tds[1].text()}\n'
	}
	info += '}'

	return '// https://curl.se/libcurl/c/easy_getinfo_options.html
[generated]
module state
${info}'
}

println(gen_opts())
println(separator)
println(gen_codes())
println(separator)
println(gen_info())
