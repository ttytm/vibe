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

fn setup_windows(silent bool) ! {
	dl_url := 'https://curl.se/windows/dl-8.11.0_1/curl-8.11.0_1-win64-mingw.zip'
	dl_archive := dl_url.all_after_last('/')
	extracted_dir := '${curl_mod_dir}/curl-8.11.0_1-win64-mingw'

	{
		println('(1/2) Downloading...')
		s := chan bool{cap: 1}
		if !silent {
			spawn spinner(s)
		}
		http.download_file(dl_url, '${curl_mod_dir}/${dl_archive}')!
		s <- true
	}
	time.sleep(100 * time.millisecond)

	{
		println('(2/2) Extracting...')
		s := chan bool{cap: 1}
		if !silent {
			spawn spinner(s)
		}
		mkdir(dst_dir)!
		execute_opt('powershell -command Expand-Archive -LiteralPath ${curl_mod_dir}/${dl_archive} -DestinationPath ${curl_mod_dir}')!
		mv('${extracted_dir}/include', '${dst_dir}/include')!
		mv('${extracted_dir}/bin/', '${dst_dir}/bin/')!
		rmdir_all(extracted_dir) or {}
		s <- true
	}
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
		$if windows {
			setup_windows(silent)!
			defer {
				// For now, don't automatically update the PATH, as it's easily corrupted and might cause annoyances on a user's machine.
				println('\nOn Windows, libcurl requires access to a compatible curl.exe.')
				println('A reliable way is to use the curl.exe that is shipped with every libcurl version.')
				println("Add '${curl_mod_dir.replace('/', os.path_separator)}\\libcurl\\bin' to your PATH to make it accessible.")
			}
		} $else {
			setup(silent)!
		}
		println('\rFinished!')
	}
}
cmd.parse(os.args)
