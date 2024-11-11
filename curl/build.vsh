#!/usr/bin/env -S v

import cli
import os
import time
import net.http

const curl_mod_dir = '${@VMODROOT}/curl'
const dst_dir = join_path(curl_mod_dir, 'libcurl')

fn setup(silent bool) ! {
	curl_version := $if linux { 'curl-8.7.1' } $else { 'curl-8.11.0' }
	extracted_dir := join_path(curl_mod_dir, curl_version)
	dl_url := 'https://curl.se/download/${curl_version}.tar.gz'
	dl_archive := dl_url.all_after_last('/')

	{
		println('(1/4) Downloading...')
		s := chan bool{cap: 1}
		if !silent {
			spawn spinner(s)
		}
		http.download_file('${dl_url}', '${curl_mod_dir}/${dl_archive}')!
		s <- true
		defer { rm(join_path(curl_mod_dir, dl_archive)) or {} }
	}
	// A short sleep appears to help ensure the spinner is cleared before the next print.
	time.sleep(100 * time.millisecond)

	{
		println('(2/4) Extracting...')
		chdir(curl_mod_dir)!
		s := chan bool{cap: 1}
		if !silent {
			spawn spinner(s)
		}
		execute('tar xf ' + dl_archive)
		s <- true
	}
	time.sleep(100 * time.millisecond)

	{
		println('(3/4) Configuring...')
		chdir(extracted_dir)!
		s := chan bool{cap: 1}
		if !silent {
			spawn spinner(s)
		}
		execute('./configure --with-openssl --disable-static')
		s <- true
	}
	time.sleep(100 * time.millisecond)

	{
		println('(4/4) Building...')
		s := chan bool{cap: 1}
		if !silent {
			spawn spinner(s)
		}
		execute('make -j4')
		s <- true
	}
	//

	{
		mkdir(dst_dir)!
		mv('${extracted_dir}/include', '${dst_dir}/include')!
		$if linux {
			mv('${extracted_dir}/lib/.libs/libcurl.so.4.8.0', '${dst_dir}/libcurl.so')!
		}
		rmdir_all(extracted_dir) or {}
	}
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
			name: 'silent' // Mainly for CI usage, preventing printing a vast amount of new lines by spinner.
			flag: .bool
		},
	]
	execute:       fn (cmd cli.Command) ! {
		// TODO: build in temp then remove old and move new from temp.
		rmdir_all(dst_dir) or {} // Remove old library files.
		silent := cmd.flags.get_bool('silent')!
		setup(silent)!
		println('\rFinished!')
	}
}
cmd.parse(os.args)
