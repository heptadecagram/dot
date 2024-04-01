# XDG Base Directory Specification
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share

export TZ='America/New_York'
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less -X'

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
fi

if [ -d "$XDG_CONFIG_HOME/nvm" ]; then
	export NVM_DIR="$XDG_CONFIG_HOME/nvm"
fi

export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
