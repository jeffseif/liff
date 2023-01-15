.DELETE_ON_ERROR:
.DEFAULT_GOAL := wsgi

LIFF_DICT = static/js/dict.js
LIFF_TXT = dat/liff.txt.gz

.PHONY: $(LIFF_DICT)
$(LIFF_DICT): $(LIFF_TXT)
	@md5sum $@
	@zcat $(LIFF_TXT) | $(LIFF_TXT:.txt.gz=.sh) > $@
	@md5sum $@

PYTHON = $(shell which python3)
SHELL = /bin/bash

LOCKFILE = .already.running.lock
PORT ?= 5000

.PHONY: wsgi
wsgi: $(LIFF_DICT)
	flock -n $(LOCKFILE) $(PYTHON) -m http.server $(PORT)

.PHONY: clean
clean:
	@git clean -fdfx
