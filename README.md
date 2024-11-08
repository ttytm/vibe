<div align="center">

# [![logo](https://github.com/ttytm/vibe/assets/34311583/b894de5f-cdcd-4002-82ee-29d2c9b4eccd)](https://github.com/ttytm/vibe)

</div>

Vibe is a request library that wraps libcurl to enable fast and reliable requests while providing a
higher-level API.

## Installation

**Development- / Build Dependencies**

- libcurl - E.g., on Debian-based Linux distros, this might be `libcurl4-openssl-dev` or
  `libcurl4-gnutls-dev`.

**Vibe as V module**

- Install via V's cli

  ```sh
  # Into `<vmodules_dir>/vibe`
  v install https://github.com/ttytm/vibe
  # OR as vpm module under a namespace `<vmodules_dir>/ttytm/vibe`
  v install ttytm.vibe
  ```

## Usage examples

#### GET request

> **NOTE**
> For installations as VPM module use
>
> ```v
> import ttytm.vibe
> ```

```v
import vibe

// Default request
resp := vibe.get('https://hacker-news.firebaseio.com/v0/item/1.json')!
println(resp.body)

// Custom request
request := vibe.Request{
	headers: {
		.user_agent: 'YourCustomUserAgent/v0.0.1'
	}
}
resp2 := request.get('https://hacker-news.firebaseio.com/v0/item/1.json')!
println(resp2.body)
```

[`get_test`](https://github.com/ttytm/vibe/blob/main/src/_tests_get_test.v)

#### POST request

```v
import vibe
import time

req := vibe.Request{
	headers: {
		.user_agent:   'YourCustomUserAgent/v0.0.1'
		.content_type: 'application/json; charset=utf-8'
	}
	timeout: time.second * 10
}

resp := req.post('https://httpbin.org/post', '{"msg":"hello from vibe"}')!
println(resp)
```

[`post_test`](https://github.com/ttytm/vibe/blob/main/src/_tests_post_test.v)

#### Download

```v
import vibe

vibe.download_file('https://github.com/vlang/v/releases/download/weekly.2023.23/v_linux.zip',
	'v_linux.zip')!
```

[`download_file_test`](https://github.com/ttytm/vibe/blob/main/src/_tests_download_file_test.v)

<details><summary><b>More examples</b></summary>

<br>

#### GET Slice request

If optimizing speed is of concern when querying pages with large response bodies, and you know you
only need a portion of them, you can perform a `get_slice` request.

```v oksyntax
// Sends a GET request to the specified `url` and returns a slice of the response content.
// Allocation of the received response as a vstring is postponed until the `start` byte position is reached.
// The content is returned as soon as the slice reaches its `max_size` (offset from `start`)
// - `max_size` can be `none` to return the remainder from the start.
pub fn (req Request) get_slice(url string, start usize, max_size ?usize) !Response
```

```v
import vibe
import net.html

resp := vibe.get_slice('https://docs.vosca.dev/advanced-concepts/v-and-c.html', 65_000,
	10_000)!
selector := html.parse(resp.body).get_tags_by_class_name('language-vmod')[0]
println(selector.text())
```

[`get_slice_test`](https://github.com/ttytm/vibe/blob/main/src/_tests_get_slice_test.v)

#### Download with progress

```v oksyntax
// Downloads a document from the specified `url` and saves it to the specified `file_path`.
// `download` must implement a `progress(pos usize, size usize)`, and a `finish()` method.
pub fn (req Request) download_file_with_progress(url string, file_path string, download Download) !Response
```

```v
import vibe
import os

// User-defined struct that implements the `Download` interface.
struct MyStruct {
	foo string
	bar string
}

fn (dl MyStruct) progress(pos u64, size u64) {
	print('\rDownloading... ${f64(pos) / size * 100:.2f}%')
	os.flush()
}

fn (dl MyStruct) finish() {
	println('\nDownload completed.')
}

mut download := MyStruct{}
vibe.download_file_with_progress('https://github.com/vlang/v/releases/download/weekly.2023.23/v_linux.zip',
	'v_linux.zip', mut download)!
```

#### Persistent Cookie

Share cookies between requests / sessions with a curl cookie jar file.

<em>The demo below does not provide real authentication data, for a "full" use-case scenario,
change the payload data and requested URLs to actual addresses that require authentication.</em>

```v
import vibe
import os

cookie_jar := './demo_cookie'

req := vibe.Request{
	headers:    {
		.content_type: 'application/json; charset=utf-8'
	}
	cookie_jar: cookie_jar
}

// Login and save cookies to curl cookie file.
req.post('https://api.yourdomain.com/v1/login', '{"username":"yourname","password":"password"}')!

// Use the `cookie_file` in subsequent sessions to access endpoints that require the authentication above.
req2 := vibe.Request{
	headers:     {
		.content_type: 'application/json; charset=utf-8'
	}
	cookie_file: cookie_jar
}

resp := req2.get('https://api.yourdomain.com/v1/protected_page')!
// ... use resp

// Remove the cookie file or keep it for later usage.
os.rm(cookie_jar)!
```

</details>

## Further information and upcoming features

Vibe is in early development. Additional features will be added based on personal projects and
sensible community needs.

### Planned

- [x] Download with progress
- [x] Custom headers
- [x] Proxy support
- [ ] SSL options
- [ ] Extend HTTP methods

### Considered

- Additional curl-compatible formats beyond HTTP.
- Expose response streams / io.Reader implementation
- Support multiple curl versions / allow to opt into newer versions.

Given that the project is being worked on in spare time, please excuse potential delays in replying
due to limited time resources.
Contributions like bug 🐛 reports, ⭐ stars and 💡 suggestions are welcome alike!
