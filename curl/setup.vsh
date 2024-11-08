#!/usr/bin/env -S v

import cli
import os
import time
import net.http

const parent_dir = '${@VMODROOT}/curl'
const dl_base_url = 'https://github.com/stunnel/static-curl/releases/download/8.10.1'
const dl_file = $if linux {
	'curl-linux-x86_64-dev-8.10.1.tar.xz'
} $else {
	'curl-macos-arm64-dev-8.10.1.tar.xz'
}
const dst_dir = join_path(parent_dir, 'libcurl')

// == Download & Build Library ================================================

fn download(silent bool) ! {
	println('Download...')
	s := chan bool{cap: 1}
	if !silent {
		spawn spinner(s)
	}
	http.download_file('${dl_base_url}/${dl_file}', '${parent_dir}/${dl_file}')!
	s <- true
	// A short sleep appears to help ensure that the spinner has been cleared before the next print.
	time.sleep(100 * time.millisecond)
}

fn extract(silent bool) ! {
	// Remove old library files
	rmdir_all(dst_dir) or {}
	mkdir(dst_dir)!

	println('Extract...')
	chdir(parent_dir)!
	mut s := chan bool{cap: 1}
	if !silent {
		spawn spinner(s)
	}
	execute_opt('tar xf ${dl_file} --strip-components=1 -C ${dst_dir}')!
	s <- true
	time.sleep(100 * time.millisecond)
}

fn spinner(ch chan bool) {
	runes := [`-`, `\\`, `|`, `/`]
	mut pos := 0
	for {
		mut finished := false
		ch.try_pop(mut finished)
		if finished {
			print('\r')
			flush()
			return
		}
		if pos == runes.len - 1 {
			pos = 0
		} else {
			pos += 1
		}
		print('\r${runes[pos]}')
		flush()
		time.sleep(100 * time.millisecond)
	}
}

// == Commands ================================================================

mut cmd := cli.Command{
	name:          'build.vsh'
	posix_mode:    true
	required_args: 0
	pre_execute:   fn (cmd cli.Command) ! {
		if cmd.args.len > cmd.required_args {
			eprintln('Unknown commands ${cmd.args}.\n')
			cmd.execute_help()
			exit(0)
		}
	}
	flags:         [
		cli.Flag{
			flag: .bool
			name: 'silent' // Mainly for CI usage, preventing printing a vast amount of new lines by spinner.
		},
	]
	execute:       fn (cmd cli.Command) ! {
		silent := cmd.flags.get_bool('silent')!
		download(silent)!
		extract(silent)!

		// Remove downloaded archive.
		rm(join_path(parent_dir, dl_file)) or {}

		println('\rSuccess!')
	}
}
cmd.parse(os.args)
