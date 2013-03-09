#
# Tools to handle PHP
#

PHP_COMPOSER ?= bin/composer.phar
PHP_SRC ?=
PHP_PHPUNIT_FLAGS ?=
PHP_PHPUNIT_ENTRY ?=

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
ifdef PHP_PHPUNIT_ENTRY
	phpunit $(PHP_PHPUNIT_FLAGS) $(PHP_PHPUNIT_ENTRY)
endif

