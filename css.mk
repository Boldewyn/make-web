#
# minify and validate CSS files
#

CSS_MINIFIER ?= cssmin
CSS_MINIFIER_NPM ?= cssmin
CSS_DIR ?= static/css
CSS_SRC ?= $(shell find $(CSS_DIR) -type f -name '*.css' -not -name '*.min.css')
CSS_TARGETS ?= $(patsubst %.css,%.min.css,$(CSS_SRC))

.PHONY: css build-css clean-css test-css

css: $(CSS_TARGETS)

$(CSS_TARGETS): %.min.css : %.css
	<"$<" $(CSS_MINIFIER) >"$@"

build-css:
	npm install $(CSS_MINIFIER_NPM)

clean-css:
	-rm $(CSS_TARGETS)
	-rm -fr node_modules/$(CSS_MINIFIER_NPM)
	-rmdir node_modules

test-css: $(CSS_SRC)
	# I cannot bring the W3C CSS validator to run locally
