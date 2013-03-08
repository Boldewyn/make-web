#
# Tools to handle PHP
#

PHP_COMPOSER ?= bin/composer.phar
PHP_SRC ?=

.PHONY: build-php deps-php test-php

build-php:
	curl -sS https://getcomposer.org/composer.phar >$(PHP_COMPOSER)

deps-php: composer.json
	php $(PHP_COMPOSER) install

test-php: $(PHP_SRC)
	! (for PHP in $(PHP_SRC); do \
		php --syntax-check $$PHP; \
	done ) | \
		grep -v '^No syntax errors detected in '

