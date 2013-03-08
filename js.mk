#
# Compact and minify JS, optionally with RequireJS
#

JS_MINIFIER ?= node_modules/uglify-js/bin/uglifyjs
JS_MINIFIER_NPM ?= uglify-js
JS_LINTER ?= node_modules/jshint/bin/hint
JS_LINTER_NPM ?= jshint
JS_LINTER_FLAGS ?=
JS_PACKAGE_FILE ?= components.json
JS_PACKAGE_MANAGER ?= bower
JS_SRC_DIR ?= src/js
JS_SRC ?= $(wildcard $(JS_DIR)/*.js)
JS_TARGET_DIR ?= static/js
JS_TARGETS ?= $(patsubst $(JS_SRC_DIR)/%.js,$(JS_TARGET_DIR)/%.js,$(SASS_SRC))
JS_USE_REQUIRE ?=
JS_REQUIRE_FLAGS ?=

.PHONY: js build-js deps-js clean-js test-js

js: $(JS_TARGETS)

$(JS_TARGETS): $(JS_TARGET_DIR)/%.js : $(JS_SRC_DIR)/%.js
ifdef JS_USE_REQUIRE
ifeq ($(notdir $(JS_REQUIRE_FLAGS)), build.js)
	node_modules/requirejs/bin/r.js -o $(JS_REQUIRE_FLAGS) \
		baseUrl=. name="$(basename $(notdir $<))" out="$@"
else
	node_modules/requirejs/bin/r.js -o $(JS_REQUIRE_FLAGS)
endif
else
	<$< $(JS_MINIFIER) >$@
endif

build-js:
	npm install "$(JS_LINTER_NPM)"
ifdef JS_USE_REQUIRE
	npm install requirejs
else
	npm install "$(JS_MINIFIER_NPM)"
endif

deps-js: $(JS_PACKAGE_FILE)
	$(JS_PACKAGE_MANAGER) install

clean-js:
	-rm $(JS_TARGETS)
	-rm -fr node_modules/requirejs node_modules/$(JS_LINTER_NPM) node_modules/$(JS_MINIFIER_NPM)
	-rmdir node_modules

test-js: $(JS_SRC)
	$(JS_LINTER) $(JS_LINTER_FLAGS) $^

