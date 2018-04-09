
JSON = dat/liff.json

all: $(JSON)

$(JSON): $(JSON:.json=.txt.gz)
	zcat $< | $(JSON:.json=.sh) > $@

clean:
	@rm -f $(JSON)
