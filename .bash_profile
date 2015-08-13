
export TZ='America/New_York'
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less -X'

shopt -s histappend

if [ "$BASH" ]; then
	. ~/.bashrc
fi

if [ -a "$HOME/.local/bash_profile" ]; then
	. ~/.local/bash_profile
fi
if [ -a "$HOME/.local/`hostname`" ]; then
	. ~/.local/`hostname`
fi
