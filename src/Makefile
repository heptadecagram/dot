#
# Project  Name: None
# File / Folder: Makefile
# File Language: make
# Copyright (C): 2005 Liam Bryan
# First  Author: Liam Bryan
# First Created: 2005.10.24 21:00:33
# Last Modifier: Liam Echlin
# Last Modified: 2010.12.04

CC = gcc

all: beeper diff_tree history_check

beeper: beeper.c
	$(CC) -O3 -o beeper beeper.c
	mv beeper $(HOME)/bin/

diff_tree: diff-dir
	ln -s $(HOME)/src/diff-dir $(HOME)/bin/diff-dir

history_check: hist.rb
	ln -s $(HOME)/src/hist.rb $(HOME)/bin/history_check.rb
