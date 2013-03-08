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

### css.mk

### images.mk

### js.mk

### php.mk

### sass.mk

### tidy.mk

### tpl.mk

### watch.mk

Documentation about `make`
--------------------------

If you want to start with `make`, take a look at
[the Wikipedia article](http://en.wikipedia.org/wiki/Make_%28software%29).
From there you should jump directly to the well-written
[GNU make manual](http://www.gnu.org/software/make/manual/make.html). There
is a [WikiBook](http://en.wikibooks.org/wiki/Make) dedicated to `make`.
