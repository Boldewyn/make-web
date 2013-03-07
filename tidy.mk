#
# Get and build an HTML5 enabled tidy build
#
# This can be used to validate HTML files on build. Include
# the `test-tidy` target and set the variable HTML_TARGETS
# to list the HTML files to be tested.
#

TIDY_DIR ?= lib/tidy
TIDY ?= $(TIDY_DIR)/bin/tidy
TIDY_FLAGS ?= -e -q --drop-empty-elements no
HTML_TARGETS ?=

.PHONY: build-tidy clean-tidy test-tidy

# build the tidy executable
build-tidy: $(TIDY)

ifdef TIDY
$(TIDY):
	$(info * build the tidy executable $(TIDY))
	@if [ -d "$(TIDY_DIR)" ]; then \
		git --git-dir="$(TIDY_DIR)/.git" --work-tree="$(TIDY_DIR)" pull; \
	else \
		git clone https://github.com/w3c/tidy-html5.git "$(TIDY_DIR)"; \
	fi
	@make -C "$(TIDY_DIR)/build/gmake"
endif

# remove tidy again
clean-tidy:
	$(info * remove tidy)
	@rm -fr "$(TIDY_DIR)"

# test a bundle of HTML files with tidy
test-tidy: build-tidy $(HTML_TARGETS)
	$(info * test markup)
	@for html in $(HTML_TARGETS); do \
		echo "  > $$html"; \
		"$(TIDY)" $(TIDY_FLAGS) $$html; \
	done

#END
