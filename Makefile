PYTHON = $(which python3)
VENV = venv/

HOST = host.py
LIFF_TXT = dat/liff.txt.gz
LIFF_DICT = static/js/dict.js
PORT = 5000

all: $(LIFF_DICT) host

.PHONY: $(LIFF_DICT)
$(LIFF_DICT):
	@zcat $(LIFF_TXT) | $(LIFF_TXT:.txt.gz=.sh) > $@

.PHONY: host
host: $(VENV) $(HOST)
	@echo "Hosted @ http://$(shell hostname -I | xargs):$(PORT)/"
	@FLASK_APP=$(HOST) $</bin/flask \
		run \
			--host '0.0.0.0' \
			--port $(PORT) \
			--reload

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
