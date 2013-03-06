TIDY_DIR := lib/tidy
TIDY := $(TIDY_DIR)/bin/tidy
TIDY_FLAGS := -e -q --drop-empty-elements no

.PHONY: build-tidy clean-tidy test-tidy

# build the tidy executable
build-tidy: $(TIDY)

$(TIDY):
	git clone https://github.com/w3c/tidy-html5.git $(TIDY_DIR) && \
		make -C $(TIDY_DIR)/build/gmake

# remove tidy again
clean-tidy:
	rm -fr $(TIDY_DIR)

# test a bundle of HTML files with tidy
test-tidy: build-tidy $(HTML_TARGETS)
ifdef TIDY
	$(info * test markup)
	@for html in $(HTML_TARGETS); do \
		echo "  > $$html"; \
		$(TIDY) $(TIDY_FLAGS) $$html; \
	done
endif

#END
