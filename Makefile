JSDUCK = /usr/local/bin/jsduck
.PHONY: clean docs all

all: clean docs

docs:
	mkdir build
	$(JSDUCK) --config jsduck_conf.json
	cp css/*.css build/resources/css
	cp images/* build/resources/images
	cp favicon.ico build/favicon.ico

clean:
	rm -rf build || true



