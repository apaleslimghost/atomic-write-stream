# atomic-write-stream

ever tried `fs.createReadStream('a.txt').pipe(fs.createWriteStream('a.txt'))` and ended up with an empty file? yeah, don't do that. use `atomic-write-stream`.

## `npm install atomic-write-stream`

works by redirecting your writes to a unique temporary file then `rename`ing it to the target

## cheers

inspired by [atomic-write](https://github.com/nightfly19/atomic-write) except streaming because what is this 2011?

MIT licence, &copy; MMXIV mb
