module vibe

import vibe.curl

fn set_header(handle &curl.Handle, headers HttpHeaders) &curl.LinkedList {
	mut list := &curl.LinkedList(unsafe { nil })

	// Set default header and return if no headers were specified
	if headers.common.len == 0 && headers.custom.len == 0 {
		curl.easy_setopt(handle, .useragent, '${manifest.name}/${manifest.version}')
		return list
	}

	mut has_user_agent := false
	for k, v in headers.common {
		if k == .user_agent {
			has_user_agent = true
		}
		list = curl.slist_append(list, '${k.str()}: ${v}')
	}
	for k, v in headers.custom {
		list = curl.slist_append(list, '${k}: ${v}')
	}

	curl.easy_setopt(handle, .httpheader, list)

	// Set default user agent if none was specified
	if !has_user_agent {
		curl.easy_setopt(handle, .useragent, '${manifest.name}/${manifest.version}')
	}

	return list
}

// https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers
@[generated]
pub fn (header HttpHeader) str() string {
	return match header {
		.accept { 'Accept' }
		.accept_ch { 'Accept-CH' }
		.accept_charset { 'Accept-Charset' }
		.accept_encoding { 'Accept-Encoding' }
		.accept_language { 'Accept-Language' }
		.accept_patch { 'Accept-Patch' }
		.accept_post { 'Accept-Post' }
		.accept_ranges { 'Accept-Ranges' }
		.access_control_allow_credentials { 'Access-Control-Allow-Credentials' }
		.access_control_allow_headers { 'Access-Control-Allow-Headers' }
		.access_control_allow_methods { 'Access-Control-Allow-Methods' }
		.access_control_allow_origin { 'Access-Control-Allow-Origin' }
		.access_control_expose_headers { 'Access-Control-Expose-Headers' }
		.access_control_max_age { 'Access-Control-Max-Age' }
		.access_control_request_headers { 'Access-Control-Request-Headers' }
		.access_control_request_method { 'Access-Control-Request-Method' }
		.age { 'Age' }
		.allow { 'Allow' }
		.alt_svc { 'Alt-Svc' }
		.authorization { 'Authorization' }
		.cache_control { 'Cache-Control' }
		.clear_site_data { 'Clear-Site-Data' }
		.connection { 'Connection' }
		.content_disposition { 'Content-Disposition' }
		.content_encoding { 'Content-Encoding' }
		.content_language { 'Content-Language' }
		.content_length { 'Content-Length' }
		.content_location { 'Content-Location' }
		.content_range { 'Content-Range' }
		.content_security_policy { 'Content-Security-Policy' }
		.content_security_policy_report_only { 'Content-Security-Policy-Report-Only' }
		.content_type { 'Content-Type' }
		.cookie { 'Cookie' }
		.critical_ch { 'Critical-CH' }
		.cross_origin_embedder_policy { 'Cross-Origin-Embedder-Policy' }
		.cross_origin_opener_policy { 'Cross-Origin-Opener-Policy' }
		.cross_origin_resource_policy { 'Cross-Origin-Resource-Policy' }
		.date { 'Date' }
		.device_memory { 'Device-Memory' }
		.digest { 'Digest' }
		.downlink { 'Downlink' }
		.early_data { 'Early-Data' }
		.ect { 'ECT' }
		.etag { 'ETag' }
		.expect { 'Expect' }
		.expect_ct { 'Expect-CT' }
		.expires { 'Expires' }
		.forwarded { 'Forwarded' }
		.from { 'From' }
		.host { 'Host' }
		.if_match { 'If-Match' }
		.if_modified_since { 'If-Modified-Since' }
		.if_none_match { 'If-None-Match' }
		.if_range { 'If-Range' }
		.if_unmodified_since { 'If-Unmodified-Since' }
		.keep_alive { 'Keep-Alive' }
		.last_modified { 'Last-Modified' }
		.link { 'Link' }
		.location { 'Location' }
		.max_forwards { 'Max-Forwards' }
		.nel { 'NEL' }
		.origin { 'Origin' }
		.permissions_policy { 'Permissions-Policy' }
		.proxy_authenticate { 'Proxy-Authenticate' }
		.proxy_authorization { 'Proxy-Authorization' }
		.range { 'Range' }
		.referer { 'Referer' }
		.referrer_policy { 'Referrer-Policy' }
		.retry_after { 'Retry-After' }
		.rtt { 'RTT' }
		.save_data { 'Save-Data' }
		.sec_ch_prefers_reduced_motion { 'Sec-CH-Prefers-Reduced-Motion' }
		.sec_ch_ua { 'Sec-CH-UA' }
		.sec_ch_ua_arch { 'Sec-CH-UA-Arch' }
		.sec_ch_ua_bitness { 'Sec-CH-UA-Bitness' }
		.sec_ch_ua_full_version_list { 'Sec-CH-UA-Full-Version-List' }
		.sec_ch_ua_mobile { 'Sec-CH-UA-Mobile' }
		.sec_ch_ua_model { 'Sec-CH-UA-Model' }
		.sec_ch_ua_platform { 'Sec-CH-UA-Platform' }
		.sec_ch_ua_platform_version { 'Sec-CH-UA-Platform-Version' }
		.sec_fetch_dest { 'Sec-Fetch-Dest' }
		.sec_fetch_mode { 'Sec-Fetch-Mode' }
		.sec_fetch_site { 'Sec-Fetch-Site' }
		.sec_fetch_user { 'Sec-Fetch-User' }
		.sec_gpc { 'Sec-GPC' }
		.sec_websocket_accept { 'Sec-WebSocket-Accept' }
		.server { 'Server' }
		.server_timing { 'Server-Timing' }
		.service_worker_navigation_preload { 'Service-Worker-Navigation-Preload' }
		.set_cookie { 'Set-Cookie' }
		.sourcemap { 'SourceMap' }
		.strict_transport_security { 'Strict-Transport-Security' }
		.te { 'TE' }
		.timing_allow_origin { 'Timing-Allow-Origin' }
		.trailer { 'Trailer' }
		.transfer_encoding { 'Transfer-Encoding' }
		.upgrade { 'Upgrade' }
		.upgrade_insecure_requests { 'Upgrade-Insecure-Requests' }
		.user_agent { 'User-Agent' }
		.vary { 'Vary' }
		.via { 'Via' }
		.want_digest { 'Want-Digest' }
		.www_authenticate { 'WWW-Authenticate' }
		.x_content_type_options { 'X-Content-Type-Options' }
		.x_dns_prefetch_control { 'X-DNS-Prefetch-Control' }
		.x_forwarded_for { 'X-Forwarded-For' }
		.x_forwarded_host { 'X-Forwarded-Host' }
		.x_forwarded_proto { 'X-Forwarded-Proto' }
		.x_frame_options { 'X-Frame-Options' }
		.x_xss_protection { 'X-XSS-Protection' }
	}
}
