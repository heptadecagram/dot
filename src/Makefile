# Sanity
CPPFLAGS+=-Wall -Wextra -Wpedantic
# On types
CPPFLAGS+=-Wwrite-strings -Wfloat-equal -Wconversion
# On assumptions
CPPFLAGS+=-Waggregate-return -Winline -Wstack-usage=256

# For embedded platforms
# CPPFLAGS+=-Wdouble-promotion

CFLAGS+=-std=c11
CXXFLAGS+=-std=c++14

.PHONY: all install

all: beeper diff-dir hist

install: all
	@mkdir -p ~/bin
	mv beeper $(HOME)/bin/
	ln -s $(HOME)/src/diff-dir $(HOME)/bin/diff-dir
	ln -s $(HOME)/src/hist $(HOME)/bin/history_check
