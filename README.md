<h1 align="center"><a href="https://github.com/ttytm/vibe"><img src ="https://github.com/ttytm/ui/assets/34311583/15dcf057-8284-4f5d-8622-0d8d878fa4bb" alt="vibe logo" width="125"></a></h1>

Vibe is a request library that wraps libcurl to enable fast and reliable requests while providing a
higher-level API.

## Installation

Install via `v` cli

- From source

  ```
  v install --git https://github.com/ttytm/vibe
  ```

  ```v
  import vibe
  ```

## Usage examples

#### GET request

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

#### Download

```v
import vibe

vibe.download_file('https://github.com/vlang/v/releases/download/weekly.2023.23/v_linux.zip',
	'v_linux.zip')!
```

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
pub fn (req Request) get_slice(url string, start usize, size ?usize) !Response
```

```v
import vibe
import net.html

resp := vibe.get_slice('https://docs.vosca.dev/advanced-concepts/v-and-c.html', 65_000,
	10_000)!
selector := html.parse(resp.body).get_tags_by_class_name('language-vmod')[0]
println(selector.text())
```

#### Download with progress

```v oksyntax
// Downloads a document from the specified `url` and saves it to the specified `file_path`.
// `download` must implement a `progress(pos usize, size usize)`, and a `finish()` method.
pub fn (req Request) download_file_with_progress(url string, file_path string, download Download) !Response
```

```v
import vibe
import os

struct Download {}

fn (dl Download) progress(pos u64, size u64) {
	print('\rDownloading... ${f64(pos) / size * 100:.2f}%')
	os.flush()
}

fn (dl Download) finish() {
	println('\nDownload completed.')
}

mut dl := Download{}
vibe.download_file_with_progress('https://github.com/vlang/v/releases/download/weekly.2023.23/v_linux.zip',
	'v_linux.zip', mut dl)!
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
	headers: {
		.content_type: 'application/json; charset=utf-8'
	}
	cookie_jar: cookie_jar
}

// Login and save cookies to curl cookie file.
req.post('https://api.yourdomain.com/v1/login', '{"username":"yourname","password":"password"}')!

// Use the `cookie_file` in subsequent sessions to access endpoints that require the authentication above.
req2 := vibe.Request{
	headers: {
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
- [x] curl Proxy support
- [ ] SSL options
- [ ] Extend HTTP methods

### Considered

- Additional curl-compatible formats beyond HTTP.
- Expose response streams / io.Reader implementation

Given that the project is being worked on in spare time, please excuse potential delays in replying
due to limited time resources.
Contributions like bug 🐛 reports, ⭐ stars and 💡 suggestions are welcome alike!
