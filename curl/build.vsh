#!/usr/bin/env -S v

import cli
import os
import time
import net.http

const parent_dir = '${@VMODROOT}/curl'
const dl_base_url = 'https://curl.se/download/'
const curl_version = $if linux { 'curl-8.7.1' } $else { 'curl-8.11.0' }
const dl_file = '${curl_version}.tar.gz'
const dl_dir = join_path(parent_dir, curl_version)
const dst_dir = join_path(parent_dir, 'libcurl')

fn download(silent bool) {
	println('(1/4) Downloading...')
	s := chan bool{cap: 1}
	if !silent {
		spawn spinner(s)
	}
	http.download_file('${dl_base_url}/${dl_file}', '${parent_dir}/${dl_file}') or { panic(err) }
	s <- true
	// A short sleep appears to help ensure the spinner is cleared before the next print.
	time.sleep(100 * time.millisecond)
}

fn prep(silent bool) ! {
	println('(2/4) Extracting...')
	chdir(parent_dir)!
	mut s := chan bool{cap: 1}
	if !silent {
		spawn spinner(s)
	}
	execute('tar xf ' + dl_file)
	s <- true

	time.sleep(100 * time.millisecond)

	println('(3/4) Configuring...')
	chdir(dl_dir)!
	s = chan bool{cap: 1}
	if !silent {
		spawn spinner(s)
	}
	// execute('./configure --with-openssl --disable-shared')
	execute('./configure --with-openssl')
	s <- true

	time.sleep(100 * time.millisecond)

	// TODO: windows build?
	println('(4/4) Building...')
	s = chan bool{cap: 1}
	if !silent {
		spawn spinner(s)
	}
	execute('make -j4')

	mkdir(dst_dir)!
	mv(join_path(dl_dir, 'lib'), join_path(dst_dir, 'lib'))!
	mv(join_path(dl_dir, 'include'), join_path(dst_dir, 'include'))!
	// Remove unnecessary files, only keep the `lib` and `include` directories.
	rmdir_all(dl_dir)!
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
			name: 'silent'
		},
	]
	execute:       fn (cmd cli.Command) ! {
		// Remove old library files
		rmdir_all(dst_dir) or {}

		// Mainly for CI usage, preventing printing a vast amount of new lines and sleep delay by spinner.
		silent := cmd.flags.get_bool('silent')!

		download(silent)

		prep(silent)!

		// Remove downloaded archive.
		rm(join_path(parent_dir, dl_file)) or {}

		println('\rFinished!')
	}
}
cmd.parse(os.args)
