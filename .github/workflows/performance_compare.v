import net.http
import sync.pool
import time
import vibe
import cli
import os

pub struct GetResult {
	error_kind ?GetError
}

enum GetError {
	request_err
	status_err
}

fn std_request(mut pp pool.PoolProcessor, idx int, wid int) &GetResult {
	url := pp.get_item[string](idx)

	start := time.new_stopwatch()
	defer { println('  ${url}: ${start.elapsed()}') }

	mut req := http.Request{
		url:    'https://${url}'
		method: .get
	}
	req.add_header(.user_agent, 'net-vibe-perf-test/0.0.1')

	resp := req.do() or {
		eprintln('    Failed to get: "${url}": ${err}')
		return &GetResult{.request_err}
	}
	if resp.status_code != 200 {
		eprintln('    Failed to get success response: "${resp.status}"')
		return &GetResult{.status_err}
	}

	// println('    Response content length: ${resp.body.len}')

	return &GetResult{}
}

fn vibe_request(mut pp pool.PoolProcessor, idx int, wid int) &GetResult {
	url := pp.get_item[string](idx)

	start := time.new_stopwatch()
	defer { println('  ${url}: ${start.elapsed()}') }

	mut req := vibe.Request{
		headers: {
			.user_agent: 'net-vibe-perf-test/0.0.1'
		}
	}

	resp := req.get('https://${url}') or {
		eprintln('    Failed to get: "${url}": ${err}')
		return &GetResult{.request_err}
	}
	if resp.status != 200 {
		eprintln('    Failed to get success response: "${resp.status}"')
		return &GetResult{.status_err}
	}
	// println('    Response content length: ${resp.body.len}')

	return &GetResult{}
}

fn prep_urls(single_host bool, request_num int) ![]string {
	return if single_host {
		base := 'google.com/search?q='
		[]string{len: request_num, init: base + index.str()}
	} else {
		urls := 'https://gist.githubusercontent.com/ttytm/b2c6e348dac6b3f0ffa150639ad94211/raw/0823f71f18d5567d231dabbafe4ad22d006f0e61/100-popular-urls.txt'
		resp := http.get(urls)!
		resp.body.split_into_lines()[..request_num]
	}
}

fn main() {
	mut app := cli.Command{
		name:       'net-vibe-perf-test'
		posix_mode: true
		execute:    run
		flags:      [
			cli.Flag{
				name:          'request-num'
				flag:          .int
				abbrev:        'r'
				default_value: ['100'] // Currently the maximium number is capped by the number of prepared urls.
			},
			cli.Flag{
				name:   'single-host'
				flag:   .bool
				abbrev: 's'
			},
			cli.Flag{
				name: 'use-vibe'
				flag: .bool
			},
		]
	}
	app.parse(os.args)
}

fn run(cmd cli.Command) ! {
	single_host := cmd.flags.get_bool('single-host')!
	use_vibe := cmd.flags.get_bool('use-vibe')!
	request_num := cmd.flags.get_int('request-num')!

	mut urls := prep_urls(single_host, if request_num < 100 { request_num } else { 100 })!

	start := time.new_stopwatch()

	mut pp := pool.new_pool_processor(
		callback: if use_vibe { vibe_request } else { std_request }
	)
	pp.work_on_items(urls)

	results := pp.get_results[GetResult]()
	mut request_errs, mut status_errs := 0, 0
	for v in results {
		err_kind := v.error_kind or { continue }
		if err_kind == GetError.request_err {
			request_errs++
		} else {
			status_errs++
		}
	}

	mod := if use_vibe { 'vibe' } else { 'net.http' }
	host_details := if single_host { ', single host' } else { '' }
	res := '
┌–––––––––––––––––––––––––––––––––––––––––––––––––––––––––┐
 Results for "${mod}"${host_details}
 –––––––––––––––––––––––––––––––––––––––––––––––––––––––––
 Requests: ${results.len}, Request errors: ${request_errs}, Status errors: ${status_errs}
 Total time: ${start.elapsed()}
└–––––––––––––––––––––––––––––––––––––––––––––––––––––––––┘
'
	println(res)
	if os.getenv('GITHUB_JOB') != '' {
		os.system('echo ``` >> \$GITHUB_STEP_SUMMARY')
		for l in res.split_into_lines() {
			os.system("echo '${l}' >> \$GITHUB_STEP_SUMMARY")
		}
		os.system("echo '```' >> \$GITHUB_STEP_SUMMARY")
	}
}
