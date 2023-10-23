#!/usr/bin/env -S v

import cli
import os
import time
import net.http

const (
	parent_dir  = '${@VMODROOT}/curl'
	dl_base_url = 'https://curl.se/download/'
	dl_file     = 'curl-8.4.0.tar.gz'
	dl_dir      = join_path(parent_dir, 'curl-8.4.0')
	dst_dir     = join_path(parent_dir, 'libcurl')
)

fn spinner(ch chan bool) {
	runes := [`-`, `\\`, `|`, `/`]
	mut pos := 0
	for {
		mut finished := false
		ch.try_pop(mut finished)
		if finished {
			print('\r')
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

// == Download & Build Library ================================================

fn download(silent bool) {
	println('Download...')
	s := chan bool{cap: 1}
	if !silent {
		spawn spinner(s)
	}
	http.download_file('${dl_base_url}/${dl_file}', '${parent_dir}/${dl_file}') or { panic(err) }
	s <- true
}

fn prep(silent bool) ! {
	println('Extract...')
	chdir(parent_dir)!
	mut s := chan bool{cap: 1}
	if !silent {
		spawn spinner(s)
	}
	execute('tar xf ' + dl_file)
	s <- true

	time.sleep(100 * time.millisecond)

	println('Configure...')
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
	println('Build...')
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

fn run(cmd cli.Command) ! {
	// Remove old library files
	rmdir_all(dst_dir) or {}

	// Mainly for CI usage, preventing printing a vast amount of new lines and sleep delay by spinner.
	silent := cmd.flags.get_bool('silent')!

	download(silent)

	// Short sleep helps to ensure the spinner was cleared before the next print.
	time.sleep(100 * time.millisecond)

	prep(silent)!

	// Remove downloaded archive.
	rm(join_path(parent_dir, dl_file)) or {}

	println('\rSuccess!')
}

// == Commands ================================================================

mut cmd := cli.Command{
	name: 'build.vsh'
	posix_mode: true
	required_args: 0
	pre_execute: fn (cmd cli.Command) ! {
		if cmd.args.len > cmd.required_args {
			eprintln('Unknown commands ${cmd.args}.\n')
			cmd.execute_help()
			exit(0)
		}
	}
	flags: [
		cli.Flag{
			flag: .bool
			name: 'silent'
		},
	]
	execute: run
}
cmd.parse(os.args)
