#!/bin/sh
# Project  Name: None
# File / Folder: install.sh
# File Language: sh
# Copyright (C): 2006 Liam Bryan
# First  Author: Liam Bryan
# First Created: 2006.07.18 13:27:11
# Last Modifier: Liam Bryan
# Last Modified: 2006.07.19 13:55:03

svn checkout svn+ssh://wa.heptadecagram.net/home/svn/dot $HOME/dot
mv $HOME/.ssh $HOME/.old.ssh
mv $HOME/.subversion $HOME/.old.subversion
mv $HOME/dot/.[a-z]* $HOME/
mv $HOME/dot/* $HOME/
rmdir $HOME/dot/
if [ `expr $SHELL : bash` -eq 0 ]; then
	echo "Changing shell to `grep '/bash' /etc/shells` from $SHELL"
	chsh -s `grep '/bash' /etc/shells` && exec `grep '/bash' /etc/shells` -l
fi
