#
# Handle HTML related things
#

HTML_TARGETS ?=
HTML_COMPRESSOR_BIN ?= jar/htmlcompressor.jar
HTML_COMPRESSORFLAGS ?= --remove-intertag-spaces --remove-quotes \
--remove-style-attr --remove-link-attr --remove-script-attr --remove-form-attr \
--remove-input-attr --simple-bool-attr --remove-js-protocol \
--remove-surrounding-spaces min
HTML_COMPRESSOR ?= java -jar $(HTML_COMPRESSOR_BIN)
HTML_COMPRESSOR_EXT ?=
HTML_COMPRESSOR_VERSION ?= 1.5.3

.PHONY: html build-html clean-html test-html

# minify HTML files, optionally extend the filename with HTML_COMPRESSOR_EXT
html: $(HTML_TARGETS) test-html
ifdef HTML_COMPRESSOR_BIN
	$(HTML_COMPRESSOR) $(HTML_COMPRESSORFLAGS) \
		-o $(patsubst %.html,%$(HTML_COMPRESSOR_EXT).html,$@) $@
endif

# build the compressor executable
build-html: $(HTML_COMPRESSOR_BIN)

ifdef HTML_COMPRESSOR_BIN
$(HTML_COMPRESSOR_BIN):
	curl -sS http://htmlcompressor.googlecode.com/files/htmlcompressor-$(HTML_COMPRESSOR_VERSION).jar > $@
endif

# remove HTML compressor
clean-html:
	rm -f $(HTML_COMPRESSOR_BIN)

# test HTML files, if Tidy was loaded
test-html: $(HTML_TARGETS)
ifdef TIDY
	$(MAKE) test-tidy
endif

#END
