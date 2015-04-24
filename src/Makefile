
all: beeper diff_tree history_check

beeper: beeper.c
	$(CC) -O3 -o beeper beeper.c
	mv beeper $(HOME)/bin/

diff_tree: diff-dir
	ln -s $(HOME)/src/diff-dir $(HOME)/bin/diff-dir

history_check: hist.rb
	ln -s $(HOME)/src/hist.rb $(HOME)/bin/history_check.rb
