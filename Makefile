JS = dat/liff.js

all: $(JS)

.PHONY: $(JS)
$(JS):
	@zcat $(JS:.js=.txt.gz) | $(JS:.js=.sh) > $@

clean:
	@rm -f $(JS)
