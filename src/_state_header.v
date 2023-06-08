module vibe

type HeaderList = C.curl_slist

// https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers
[generated]
pub enum HttpHeader {
	accept
	accept_ch
	accept_charset
	accept_encoding
	accept_language
	accept_patch
	accept_post
	accept_ranges
	access_control_allow_credentials
	access_control_allow_headers
	access_control_allow_methods
	access_control_allow_origin
	access_control_expose_headers
	access_control_max_age
	access_control_request_headers
	access_control_request_method
	age
	allow
	alt_svc
	authorization
	cache_control
	clear_site_data
	connection
	content_disposition
	content_encoding
	content_language
	content_length
	content_location
	content_range
	content_security_policy
	content_security_policy_report_only
	content_type
	cookie
	critical_ch // Experimental
	cross_origin_embedder_policy
	cross_origin_opener_policy
	cross_origin_resource_policy
	date
	device_memory // Experimental
	digest
	downlink // Experimental
	early_data // Experimental
	ect // Experimental
	etag
	expect
	expect_ct
	expires
	forwarded
	from
	host
	if_match
	if_modified_since
	if_none_match
	if_range
	if_unmodified_since
	keep_alive
	last_modified
	link
	location
	max_forwards
	nel // Experimental
	origin
	permissions_policy
	proxy_authenticate
	proxy_authorization
	range
	referer
	referrer_policy
	retry_after
	rtt // Experimental
	save_data // Experimental
	sec_ch_prefers_reduced_motion // Experimental
	sec_ch_ua // Experimental
	sec_ch_ua_arch // Experimental
	sec_ch_ua_bitness // Experimental
	sec_ch_ua_full_version_list // Experimental
	sec_ch_ua_mobile // Experimental
	sec_ch_ua_model // Experimental
	sec_ch_ua_platform // Experimental
	sec_ch_ua_platform_version // Experimental
	sec_fetch_dest
	sec_fetch_mode
	sec_fetch_site
	sec_fetch_user
	sec_gpc // Experimental
	sec_websocket_accept
	server
	server_timing
	service_worker_navigation_preload
	set_cookie
	sourcemap
	strict_transport_security
	te
	timing_allow_origin
	trailer
	transfer_encoding
	upgrade
	upgrade_insecure_requests
	user_agent
	vary
	via
	want_digest
	www_authenticate
	x_content_type_options
	x_dns_prefetch_control // Non-standard
	x_forwarded_for // Non-standard
	x_forwarded_host // Non-standard
	x_forwarded_proto // Non-standard
	x_frame_options
	x_xss_protection // Non-standard
}
