#
# Project  Name: None
# File / Folder: Makefile
# File Language: make
# Copyright (C): 2005 Liam Bryan
# First  Author: Liam Bryan
# First Created: 2005.10.24 21:00:33
# Last Modifier: Liam Bryan
# Last Modified: 2006.07.17 12:38:37

CC = gcc

BIN_PATH = ../bin/

all: $(BIN_PATH)hist.rb $(BIN_PATH)differ.pl $(BIN_PATH)beeper

../bin/beeper: beeper.c
	$(CC) -O3 -o beeper beeper.c
	mv beeper ../bin/

../bin/differ.pl: differ.pl
	ln -s differ.pl ../bin/differ.pl

../bin/hist.rb: hist.rb
	ln -s hist.rb ../bin/hist.rb
