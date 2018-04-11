INPUT = dat/liff.txt.gz
OUTPUT = static/js/dict.js

all: $(OUTPUT)

.PHONY: $(OUTPUT)
$(OUTPUT):
	@zcat $(INPUT) | $(INPUT:.txt.gz=.sh) > $@

clean:
	@rm -f $(OUTPUT)
