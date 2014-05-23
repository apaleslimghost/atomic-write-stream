all: index.js

%.js: %.ls
	node_modules/.bin/lsc -c $< > $@
