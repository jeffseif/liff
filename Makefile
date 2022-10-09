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
VENV_DIR = venv

$(VENV_DIR):
	@$(PYTHON) -m venv $@
	@$@/bin/pip install --quiet --upgrade pip
	@$@/bin/pip install --quiet flask

LOCKFILE = .already.running.lock
HOST = 0.0.0.0
PORT ?= 5000
WSGI = wsgi.py

.PHONY: wsgi
wsgi: $(VENV_DIR) $(LIFF_DICT) $(WSGI)
	@FLASK_RUN_HOST=$(HOST) FLASK_RUN_PORT=$(PORT) flock -n $(LOCKFILE) $</bin/flask run

.PHONY: clean
clean:
	@git clean -fdfx
