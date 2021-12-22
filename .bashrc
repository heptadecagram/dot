
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

alias perl="perl -I${HOME}/src"
alias ri='ri -Tf ansi'

alias maketexclean="find . -name '*aux' -delete -or -name '*log' -delete -or -name '*pdf' -delete -or -name '*toc' -delete -or -name '*out' -delete"

CODE_RED=$'\[\033[0;31m\]'
CODE_GREEN=$'\[\033[0;32m\]'
CODE_YELL=$'\[\033[0;33m\]'
CODE_BLUE=$'\[\033[0;34m\]'
CODE_NORM=$'\[\033[m\]'
PS1='\h:\w/\n'

prompt_command () {
	if [ $? -ne 0 ]; then
		PS1="[$CODE_RED\$?$CODE_NORM]"
	else
		PS1=''
	fi
	if [ $UID -eq 0 ]; then
		PS1="$PS1$CODE_RED\h$CODE_NORM"
	else
		PS1="$PS1\h"
	fi
	PS1="\n$CODE_YELL\A$CODE_NORM $PS1:\w/\\n> "
}
PROMPT_COMMAND="prompt_command"

[[ $PS1  && -f /usr/share/bash-completion/bash_completion ]] && \
	. /usr/share/bash-completion/bash_completion

# Handle large bash helpers based on what is available.
if [ -d $HOME/.bash ]; then
	for file in $HOME/.bash/*; do
		if [ -x "`which ${file#*.bash/} 2>/dev/null`" ]; then
			source $file
		fi
	done
fi


# Vim alias with sudo built-ins
o () {
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
a () {
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
complete -A directory a cd rmdir

# Version Control diff editor
_vc-diff () {
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



# perlbrew
if [ -e ~/perl5/perlbrew/etc/bashrc ]; then
	. ~/perl5/perlbrew/etc/bashrc
fi

fix_everything () {
	i=1
	s='/-\|'
	echo -n ' '
	while true; do
		echo -en "\b${s:i++%${#s}:1}"
	done
}
