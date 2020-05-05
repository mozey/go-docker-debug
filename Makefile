# Copied from
# https://gist.github.com/lantins/e83477d8bccab83f078d

# binary name to kill/restart
PROG_APP = dev.out

dependencies:
	@command -v fswatch --version >/dev/null 2>&1 || \
	{ printf >&2 "Install fswatch, e.g. brew install fswatch\n"; exit 1; }

# default targets to run when only running `make`
default: dependencies test

# ..............................................................................
# TODO Tests should run in the container
clean:
	go clean

# Tests are cached,
# to re-run all tests clear it first
test:
	go clean -testcache
	@make test.cache

test.cache: dependencies
	gotest ./...

# app...........................................................................
# (Re)start docker container,
# create a tmux session on the container,
# then rebuild app and run it with debugging in tmux
app.restart:
	/usr/bin/env bash -c "scripts/docker/restart.sh"

# Reload stops app processing running in tmux on the container,
# then rebuild app and run it with debugging
app.reload:
	/usr/bin/env bash -c "scripts/docker/reload.sh"

# Watch .go files for changes.
# fswatch includes everything unless an exclusion filter says otherwise
# https://stackoverflow.com/a/37237681/639133
app: dependencies
	@make app.restart
	@fswatch -or --exclude ".*" \
	--include "^.*go$$" ./ | \
	xargs -n1 -I{} make app.reload || echo $?
