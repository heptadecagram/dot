setopt SHARE_HISTORY
setopt APPEND_HISTORY

if [ `uname` = "Linux" ]; then
	alias ls='ls -F --color'
else
	alias ls='ls -FG'
fi

alias grep='grep --color'

alias n='ls'
alias nn='ls -lA'
alias N='ls -la'
alias oo='vimdiff'

alias home='ssh home'

alias maketexclean="find . -name '*aux' -delete -or -name '*log' -delete -or -name '*pdf' -delete -or -name '*toc' -delete -or -name '*out' -delete"

HISTFILE="$XDG_STATE_HOME/zsh/history"

function precmd() {
	echo
}

PROMPT='%F{yellow}%D{%H:%M}%f %(?..[%F{red}%?%f])%(!.%F{red}%m%f.%m):%~/'$'\n'"%# "
# Other prompt command additions will append onto the precmd_functions array

# The following lines were written by compinstall
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' squeeze-slashes true
zstyle :compinstall filename "$ZDOTDIR/.zshrc"

autoload -Uz compinit
compinit
# The previous lines were written by compinstall

# Handle large zsh helpers based on what is available.
if [ -d $ZDOTDIR/plugins ]; then
	for file in $ZDOTDIR/plugins/*; do
		if [ -x "`which ${file#*plugins/} 2>/dev/null`" ]; then
			source $file
		fi
	done
fi

# Vim alias with sudo built-ins
function o () {
	for file in "$@"; do
		if [ ! -e "$file" -a ! -w "`dirname "$file"`" ] || [ -e "$file" -a ! -w "$file" -a ! -O "$file" ]; then
			if [ -x "`which sudoedit`" ]; then
				sudoedit "$@"
				return
			else
				sudo ${VISUAL:-$EDITOR} "$@"
				return
			fi
		fi
	done

	${VISUAL:-$EDITOR} "$@"
}

# cd alias with directory substitution and directory-for-file shortcut
function a() {
	if [ -z "$1" ]; then
		builtin cd
	else
		local try=''
		if [ -n "$2" ]; then
			try="${PWD/$1/$2}"
		else
			try="$1"
		fi

		if [ -f "$try" ]; then
			builtin cd "`dirname $try`"
		else
			builtin cd "$try"
		fi
	fi
}

# Version Control diff editor
function _vc-diff() {
	local vc=$1
	shift

	# Might want to consider using 'select' to choose which files to edit in which order
	for file in "$@"; do
		if [ ! -e "$file" ]; then
			echo "File not found: $file"
		else
			TEMP=/tmp/tmp.$$.`basename $file`
			$vc "$file" | patch -sRo "$TEMP" "$file"
			vimdiff -c 'set diffopt=filler,iwhite' -c 'wincmd l' -c 'set readonly' -c 'set nomodifiable' -c 'wincmd h' -c '0' -c 'normal ]c' "$TEMP" "$file"
			#meld "$TEMP" "$file"
			#echo "meld  $TEMP $file"
			rm -f "$TEMP"
		fi
	done
}

function fix-everything() {
	local i=1
	local s='/-\|'
	echo -n ' '
	while true; do
		echo -en "\b${s:$((i++))%${#s}:1}"
	done
}
