#
# Tools to handle PHP
#

PHP_SRC ?=

.PHONY: test-php

test-php: $(PHP_SRC)
	! (for PHP in $(PHP_SRC); do \
		php --syntax-check $$PHP; \
	done ) | \
		grep -v '^No syntax errors detected in '

