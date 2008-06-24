#
# Project  Name: None
# File / Folder: Makefile
# File Language: make
# Copyright (C): 2005 Liam Bryan
# First  Author: Liam Bryan
# First Created: 2005.10.24 21:00:33
# Last Modifier: Liam Echlin
# Last Modified: 2008.05.20

CC = gcc

all: beeper diff_tree history_check

beeper: beeper.c
	$(CC) -O3 -o beeper beeper.c
	mv beeper $(HOME)/bin/

diff_tree: differ.pl
	ln -s $(HOME)/src/differ.pl $(HOME)/bin/diff_tree.pl

history_check: hist.rb
	ln -s $(HOME)/src/hist.rb $(HOME)/bin/history_check.rb
