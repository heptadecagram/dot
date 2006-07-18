#
# Project  Name: None
# File / Folder: Makefile
# File Language: make
# Copyright (C): 2005 Liam Bryan
# First  Author: Liam Bryan
# First Created: 2005.10.24 21:00:33
# Last Modifier: Liam Bryan
# Last Modified: 2006.07.18 13:25:28

CC = gcc

BIN_PATH = ../bin/

all: beeper diff_tree.pl history_check.rb

beeper: beeper.c
	$(CC) -O3 -o beeper beeper.c
	mv beeper $(HOME)/bin/

diff_tree.pl: differ.pl
	ln -s $(HOME)/src/differ.pl $(HOME)/bin/diff_tree.pl

history_check.rb: hist.rb
	ln -s $(HOME)/src/hist.rb $(HOME)/bin/history_check.rb
