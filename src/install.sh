#!/bin/sh

git clone --origin=github https://github.com/heptadecagram/dot.git -- $HOME/dot
mv $HOME/dot/.local/* $HOME/.local/
rmdir $HOME/dot/.local
mv $HOME/dot/.ssh $HOME/.old.ssh
mv $HOME/dot/.[a-z]* $HOME/
mv $HOME/dot/* $HOME/
rmdir $HOME/dot/
if [ `expr $SHELL : '.*bash'` -eq 0 ]; then
	echo "Changing shell to `grep '/bash' /etc/shells` from $SHELL"
	chsh -s `grep '/bash' /etc/shells` && exec `grep '/bash' /etc/shells` -l
fi
chmod 700 $HOME/.ssh
