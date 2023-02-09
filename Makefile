# SPDX-License-Identifier: CC0-1.0
# SPDX-FileCopyrightText: 2023 The Foundation for Public Code <eric@publiccode.net>

SHELL=/bin/bash

JEKYLL=vendor/bundle/ruby/3.0.0/gems/jekyll-3.9.3/exe/jekyll

.PHONY: default
default: check

$(JEKYLL):
	bundle install
	@echo SUCCESS $@

_site/index.html: $(JEKYLL)
	bundle exec jekyll build
	ls -l $@

jekyll.pid: _site/index.html
	make shutdown
	bundle exec jekyll serve & echo $$! > jekyll.pid
	ls -l $@
	echo "jekyll running as PID: $$(cat jekyll.pid)"

.PHONY: serve
serve: jekyll.pid

.PHONY: check
check: serve
	while ! curl "http://localhost:4000" >/dev/null 2>&1 ; do \
		echo "waiting"; sleep 1; done
	curl "http://127.0.0.1:4000" | grep "This is a Test"
	make shutdown
	@echo SUCCESS $@

.PHONY: shutdown
shutdown:
	# if we have a pid file, then
		# if the process is running, then
			# stop it
		# if the process is not running, then
			# remove the pid file
	-( if [ -f jekyll.pid ]; then \
		export JEKYLL_PID=$$(cat jekyll.pid); \
		echo "jekyll.pid: $$JEKYLL_PID"; \
		if kill -0 "$$JEKYLL_PID" 2>/dev/null; then \
			kill -9 "$$JEKYLL_PID"; \
			sleep 1; \
		fi; \
		if ! kill -0 "$$JEKYLL_PID" 2>/dev/null; then \
			rm jekyll.pid; \
		fi; \
	   fi )

.PHONY: clean
clean: shutdown
	rm -rfv _site

.PHONY: distclean
distclean: clean
	git clean -dffx
	git submodule foreach --recursive git clean -dffx
