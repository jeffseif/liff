JS = dat/liff.js

all: $(JS)

$(JS): $(JS:.js=.txt.gz)
	@zcat $< | $(JS:.js=.sh) > $@

clean:
	@rm -f $(JS)
