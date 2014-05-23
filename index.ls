require! {mktemp, fs}

atomic-write-stream = (file, options)->
	out = new process.EventEmitter

	buf = []
	ended = false

	out.write = (chunk, encoding, callback)->
		buf.push [chunk, encoding, callback]
		false
	out.end = ->
		out.write ... if arguments.length
		ended := true

	mktemp.create-file ".#{file}-XXXXXXX.tmp" (err, tmp)->
		if err
			out.emit \error that
		else
			w = fs.create-write-stream tmp, options

			out.write = w~write
			out.end = w~end

			w.on \finish ->
				err <- fs.rename tmp, file
				if err
					out.emit \error that
				else
					out.end!

			w.on \drain -> out.emit \drain

			if buf.length
				for [chunk, encoding, callback] in buf
					w.write chunk, encoding, callback

				buf := []
				out.emit \drain

			if ended
				w.end!

	return out

module.exports = atomic-write-stream
