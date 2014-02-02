#!/bin/sh
# Project  Name: None
# File / Folder: install.sh
# File Language: sh
# Copyright (C): 2006 Liam Bryan
# First  Author: Liam Bryan
# First Created: 2006.07.18 13:27:11
# Last Modifier: Liam Echlin
# Last Modified: 2013.02.18

git clone --origin=github https://github.com/heptadecagram/dot -- $HOME/dot
mv $HOME/.ssh $HOME/.old.ssh
mv $HOME/dot/.[a-z]* $HOME/
mv $HOME/dot/* $HOME/
rmdir $HOME/dot/
if [ `expr $SHELL : bash` -eq 0 ]; then
	echo "Changing shell to `grep '/bash' /etc/shells` from $SHELL"
	chsh -s `grep '/bash' /etc/shells` && exec `grep '/bash' /etc/shells` -l
fi
chmod 700 $HOME/.ssh
