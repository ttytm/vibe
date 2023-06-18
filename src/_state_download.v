module vibe

import os

struct FileWriter {
mut:
	file     os.File
	pos      u64
}

struct ProgressWriter {
	FileWriter
mut:
	size      u64
	download Download
}

interface Download {
	progress(u64, u64)
	completed()
}
