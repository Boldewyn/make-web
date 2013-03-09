make web
========

Makefiles for Easy Modern Web Development
-----------------------------------------

Dutch developer [Zef Hemel](http://zef.me/4235/pick-your-battles) advises
wisely:

> “go and build amazing applications. Build them with the most boring
> technology you can find. The stuff that has been in use for years and
> years.”

While it’s arguable, if `make` is “boring,” it fulfills the second statement
very good: It’s in use for nearly 35 years now.

There is a lot of buzz on the front of automated build systems. Apache Ant is
a grandfather yet, [Rake](http://rake.rubyforge.org/) tries to mimic `make` in
Ruby and [Grunt](http://gruntjs.com/) just recently jumped up to get its share
in the JS community. While all of these tools have their advantages and rights
on their own, the good old `make` is not only sufficient for most jobs, it
has also the highest chance to be available on your backend guys’ machines.

The Makefiles in this Project
-----------------------------

There are several Makefiles that all provide different functionality. For
example, if you want to validate HTML files in your project, include the
`tidy.mk` file like this in your main Makefile:

    HTML_TARGETS := $(shell find . -type f -name \*.html)

    test: test-tidy

    include make-web/tidy.mk

Then you can run

    $ make build-tidy

to get the tidy program, and

    $ make test

to see instantly the validation results.

### 0make-web.mk

This file serves as general purpose dummy. It’s main purpose is to allow you
to do

    include make-web/*

in your Makefile and to utter a warning, if you do this before any of your own
targets, thus setting the default target.

### css.mk

These are CSS related targets. Set `CSS_SRC` to a list of CSS files, and the
target `css` will grab them and minify them using
[cssmin](https://github.com/jbleuzen/node-cssmin).

### images.mk

This Makefile contains targets to optimize PNG, JPEG and GIF images.

### js.mk

Build, concatenate and minify JavaScript files with this Makefile. There is
support for [Bower](http://twitter.github.com/bower/) and
[RequireJS](http://requirejs.org/) built right in.

### php.mk

Handle PHP dependencies with [Composer](http://getcomposer.org) or test PHP
files for syntax errors. You can run PHPUnit unit tests by specifying the unit
test entry in `$(PHP_PHPUNIT_ENTRY)`.

### sass.mk

Compile Sass files to CSS. You can set the output style with `$(SASS_STYLE)`.
Add `SASS_USE_COMPASS = 1` to switch to the
[Compass framework](http://compass-style.org/).

### tidy.mk

Validate HTML files. This Makefile fetches the [HTML5-enabled
Tidy](https://github.com/w3c/tidy-html5) from Github.

### watch.mk

Watch directories for changes and automatically start other make targets, if a
file is modified.

Documentation about `make`
--------------------------

If you want to start with `make`, take a look at
[the Wikipedia article](http://en.wikipedia.org/wiki/Make_%28software%29).
From there you should jump directly to the well-written
[GNU make manual](http://www.gnu.org/software/make/manual/make.html). There
is a [WikiBook](http://en.wikibooks.org/wiki/Make) dedicated to `make`.

Copyright
---------

The Makefiles are put in the public domain. If this concept is not applicable
in your country, the license is
[CC0](http://creativecommons.org/publicdomain/zero/1.0/). Please note, that
the files may load other software, that is distributed under different
licenses. It’s your responsibility to adhere to them.

Author
------

These Makefiles were written by [Manuel Strehl](http://www.manuel-strehl.de)
