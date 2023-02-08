# SPDX-License-Identifier: CC0-1.0
# SPDX-FileCopyrightText: 2023 The Foundation for Public Code <eric@publiccode.net>

SHELL=/bin/bash

JEKYLL=vendor/bundle/ruby/3.0.0/gems/jekyll-3.9.3/exe/jekyll

.PHONY: serve
default: check

$(JEKYLL):
	bundle install

_site/index.html: $(JEKYLL)
	bundle exec jekyll build

.PHONY: serve
jekyll.pid: _site/index.html
	bundle exec jekyll serve & echo $$! > jekyll.pid
	echo jekyll running as PID: $$(cat jekyll.pid)

.PHONY:
serve: jekyll.pid

check: serve
	while ! curl "http://localhost:4000" >/dev/null 2>&1 ; do \
		echo "waiting"; sleep 1; done
	curl "http://127.0.0.1:4000" | grep "This is a Test"
	make shutdown

shutdown:
	-( if [ -f jekyll.pid ]; then kill -9 $$(cat jekyll.pid); fi )

.PHONY:
clean: shutdown
	git clean -dffx
	git submodule foreach --recursive git clean -dffx
