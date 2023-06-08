module curl

pub struct CurlError {
	Error
	kind     CurlErrorKind
	e_code   Ecode
	m_code   Mcode
	she_code SHEcode
	ue_code  UEcode
	h_code   Hcode
}

pub enum CurlErrorKind {
	easy
	multi
	share
	url
	header
}

fn (err CurlError) msg() string {
	return match err.kind {
		.easy { easy_strerror(err.e_code) }
		// TODO:
		else { 'Currently unspecified curl error' }
	}
}
