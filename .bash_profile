# XDG Base Directory Specification
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share
export XDG_STATE_HOME=~/.local/state

export TZ='America/New_York'
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less -X'


shopt -s histappend
export HISTCONTROL=ignoredups

HISTFILE="$XDG_STATE_HOME/bash/history"
mkdir -p "${HISTFILE%/*}"

export PATH="$PATH:~/bin:/Libary/TeX/texbin"

# go
if [ -x "`which go 2>/dev/null`" ]; then
	export GOPATH="~/src/go"
	export PATH="$PATH:$GOPATH/bin"
fi
# rbenv
if [ -d "$HOME/.rbenv" ]; then
	export PATH="$HOME/.rbenv/bin:$PATH"
fi
if [ -x "`which irb 2>/dev/null`" ]; then
	export IRBRC="$XDG_CONFIG_HOME/irb/irbrc"
fi

# cargo
if [ -d "$HOME/.cargo" ]; then
	export PATH="$HOME/.cargo/bin:$PATH"
fi
# pyenv

# jenv
if [ -d "$HOME/.jenv" ]; then
	export PATH="$HOME/.jenv/bin:$PATH"
fi
# pyenv
if [ -d "$HOME/.pyenv" ]; then
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init --path)"
fi

if [ -d "$XDG_CONFIG_HOME/nvm" ]; then
	export NVM_DIR="$HOME/.config/nvm"
fi

if [ -x "`which irssi 2>/dev/null`" ]; then
	alias irssi="irssi --config='$XDG_CONFIG_HOME/irssi/config' --home='$XDG_DATA_HOME/irssi'"
fi

export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"


if [ "$BASH" ]; then
	. ~/.bashrc
fi

if [ -a "$HOME/.local/bash_profile" ]; then
	. ~/.local/bash_profile
fi
