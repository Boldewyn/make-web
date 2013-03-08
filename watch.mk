#
# Watch directories for changes
#
# You should not do this, when you also use something like
# compass watch or Python's watchdog in parallel.
#

WATCH_DIRS ?=
WATCH_INIT ?=
WATCH_TARGETS ?=
WATCH_COMMAND ?= inotifywait
WATCH_PARAMS ?= -q -q -e close_write -r $(WATCH_DIRS)

.PHONY: watch

watch:
ifdef WATCH_INIT
	@echo "* initial build...";
	@$(MAKE) -s $(WATCH_TARGETS)
endif
	@while true; do \
		$(WATCH_COMMAND) $(WATCH_PARAMS);\
		echo "* change detected. Re-building...";\
		$(MAKE) -s $(WATCH_TARGETS);\
	done
