PYTHON = $(shell which python3)
VENV = venv/

HOST = 0.0.0.0
LIFF_DICT = static/js/dict.js
LIFF_TXT = dat/liff.txt.gz
PORT = 5000
WSGI = wsgi.py

all: wsgi

.PHONY: wsgi
wsgi: $(VENV) $(LIFF_DICT) $(WSGI)
	@echo "Hosted @ http://$(shell hostname -I | xargs):$(PORT)/"
	@FLASK_ENV=development FLASK_RUN_HOST=$(HOST) FLASK_RUN_PORT=$(PORT) $</bin/flask run

.PHONY: $(LIFF_DICT)
$(LIFF_DICT):
	@md5sum $@
	@zcat $(LIFF_TXT) | $(LIFF_TXT:.txt.gz=.sh) > $@
	@md5sum $@

$(VENV): requirements.txt
	@virtualenv \
		--no-site-packages \
		--python=$(PYTHON) \
		$@
	@$@/bin/pip install \
		--requirement $<
	@$@/bin/pip install \
		--upgrade pip
	@touch $@

clean:
	@rm -rf $(VENV)
	@find . -name '*.pyc' -delete
	@find . -name '__pycache__' -type d -delete
