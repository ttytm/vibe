module curl

pub struct CurlError {
	Error
	curl_code CurlCode
}

pub type CurlCode = Ecode | Mcode | SHEcode | UEcode //| Hcode

fn (err CurlError) msg() string {
	return match err.curl_code {
		Ecode { easy_strerror(err.curl_code) }
		// TODO:
		else { 'Currently unspecified curl error' }
	}
}

pub fn curl_error(code CurlCode) IError {
	return IError(CurlError{
		curl_code: code
	})
}
