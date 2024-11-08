#!/usr/bin/env -S v

import cli
import os
import regex

const site_path = join_path(@VMODROOT, 'docs', 'site')

// Remove redundant readme section from module page.
fn rm_readme_section(html string) string {
	mut r := regex.regex_opt(r'<section id="readme_vibe".*</section>') or { panic(err) }
	sec_start, sec_end := r.find(html)
	return '${html[..sec_start]}</section>${html[sec_end..]}'
		.replace('<li class="open"><a href="#readme_vibe">README</a></li>', '')
}

fn run(cmd cli.Command) ! {
	// Cleanup old docs.
	rmdir_all(os.join_path(@VMODROOT, '_docs')) or {}
	rmdir_all(site_path) or {}
	// Build docs.
	mut p := os.new_process(@VEXE)
	p.set_args(['doc', '-readme', '-m', '-f', 'html', './src'])
	p.set_work_folder(@VMODROOT)
	p.wait()
	mv(os.join_path(@VMODROOT, 'src', '_docs'), site_path)!
	module_html_path := join_path(site_path, 'vibe.html')
	// Prepare html.
	mut module_html := read_file(module_html_path)!
	module_html = rm_readme_section(module_html)
	write_file(module_html_path, module_html)!
}

mut cmd := cli.Command{
	name:    'build.vsh'
	execute: run
}
cmd.parse(os.args)
