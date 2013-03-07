#
# Compile Sass stypesheets to CSS
#

SASS_DIR ?= src/sass
SASS_SRC ?= $(shell find $(SASS_DIR) -name '[^_]*.scss')
SASS_STYLE ?= nested
SASS_USE_COMPASS ?=
SASS_CSS_DIR ?= static/css
SASS_CSS_TARGETS ?= $(patsubst $(SASS_DIR)/%.scss,$(SASS_CSS_DIR)/%.css,$(SASS_SRC))

.PHONY: sass clean-sass test-sass

sass: $(SASS_CSS_TARGETS)

$(SASS_CSS_TARGETS): $(SASS_CSS_DIR)/%.css : $(SASS_DIR)/%.scss
ifdef SASS_USE_COMPASS
	compass compile --force \
		--sass-dir "$(SASS_DIR)" --css-dir "$(SASS_CSS_DIR)" \
		--output-style "$(SASS_STYLE)" \
		"$<"
else
	sass --update --style $(SASS_STYLE) --force "$<:$@"
endif

clean-sass:
ifdef SASS_USE_COMPASS
	compass clean
else
	-rm $(SASS_CSS_TARGETS)
endif

test-sass: $(SASS_SRC)
ifdef SASS_USE_COMPASS
	sass --check $$(compass imports) $^
else
	sass --check $^
endif
