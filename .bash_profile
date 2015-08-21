
export TZ='America/New_York'
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less -X'

shopt -s histappend

# go
if [ -x "`which go`" ]; then
	export GOPATH="~/src/go"
fi
# rbenv
if [ -d "$HOME/.rbenv" ]; then
	export PATH="$HOME/.rbenv/bin:$PATH"
fi
# jenv
if [ -d "$HOME/.jenv" ]; then
	export PATH="$HOME/.jenv/bin:$PATH"
fi
# pyenv
if [ -d "$HOME/.pyenv" ]; then
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
fi

if [ "$BASH" ]; then
	. ~/.bashrc
fi

if [ -a "$HOME/.local/bash_profile" ]; then
	. ~/.local/bash_profile
fi
if [ -a "$HOME/.local/`hostname`" ]; then
	. ~/.local/`hostname`
fi
