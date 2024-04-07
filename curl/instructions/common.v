module instructions

import state

fn C.curl_global_init(state.GlobalInitFlag)

fn C.curl_global_cleanup()

fn C.curl_slist_append(&C.curl_slist, &char) &C.curl_slist

fn C.curl_slist_free_all(&C.curl_slist)
