#
# Watch directories for changes
#

WATCH_DIRS ?=
WATCH_INIT ?=
WATCH_TARGETS ?=

.PHONY: watch

watch:
ifdef WATCH_INIT
	@echo "* initial build...";
	@make -s $(WATCH_TARGETS)
endif
	@while true; do \
		inotifywait -q -q -e close_write -r $(WATCH_DIRS);\
		echo "* change detected. Re-building...";\
		make -s $(WATCH_TARGETS);\
	done
