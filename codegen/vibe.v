// NOTE: if vibe is in `~/.vmodules/` cd out of the project directory to execute the script.
import net.html
import vibe

const (
	request   = vibe.Request{}
	separator = '\n-----------------------------------------------------------------------\n'
)

fn gen_headers() string {
	body := request.get_slice('https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers',
		25_000, 35_000) or { panic('Error requesting headers source: ${err}') }.body
	mut lists := html.parse(body).get_tag('details')
	if lists.len == 0 {
		panic('Failed finding headers selector tags `<details>`.')
	}
	mut list_idx := -1
	for i, l in lists {
		summary := l.get_tag('summary') or { continue }
		if summary.text() == 'HTTP headers' {
			list_idx = i
			break
		}
	}
	if list_idx == -1 {
		panic('Failed finding headers selector tag `<summary>.')
	}

	items := lists[list_idx].get_tags('li')
	if items.len == 0 {
		panic('Failed finding headers selector tags `<li>.')
	}

	mut headers := 'enum HttpHeader {\n'
	mut header_str_method := 'pub fn (header HttpHeader) str() string {
\t return match header {\n'

	outer: for i in items {
		additional_info := i.get_tags('span')
		mut comment := ''
		for j in additional_info {
			text := j.text()
			match text {
				'Deprecated' { continue outer }
				'Non-standard', 'Experimental' { comment = text }
				else {}
			}
		}
		header_field := i.get_tag('code') or { continue }.text()
		enum_field := header_field.replace('-', '_').to_lower()
		headers += '\t${enum_field}' + if comment != '' { ' // ${comment}' } else { '' } + '\n'
		header_str_method += "\t\t.${enum_field} { '${header_field}' }\n"
	}
	headers += '}'
	header_str_method += '\t}\n}'

	return '// https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers
[generated]
module state
${headers}
${separator}
// https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers
[generated]
${header_str_method}'
}

fn gen_status() string {
	body := request.get('https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml') or {
		panic('Error requesting headers source: ${err}')
	}.body
	mut rows := html.parse(body).get_tag('table')[0].get_tags('tr')
	if rows.len == 0 {
		panic('Failed finding status selector tags `<table>`.')
	}

	mut status_msg_fn := 'fn (status_code Status) msg_() string {
\t return match status_code {\n'

	for r in rows {
		tds := r.get_tags('td')
		if tds.len < 2 {
			continue
		}
		// [0]: Code, [1]: Description
		status_msg_fn += "\t\t${tds[0].text().replace('-', '...')} { '${tds[1].text()}' }\n"
	}
	status_msg_fn += "\t\telse { 'Unknown' }\n"
	status_msg_fn += '\t}\n}'

	return '// https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml
[generated]
${status_msg_fn}'
}

// For now, a manual approach yanking the generated code from stdout will suffice.
println(gen_headers())
println(separator)
println(gen_status())
