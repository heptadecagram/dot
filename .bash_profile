#!/bin/sh
# Project  Name: dot
# File / Folder: ~/.bash_profile
# File Language: sh
# Copyright (C): 2004 Liam Bryan
# First  Author: Liam Bryan
# First Created: 2004.08.11
# Last Modifier: Liam Bryan
# Last Modified: 2006.07.18 14:41:20

export TZ='America/New_York'
export COPYRIGHT='Liam Bryan'

alias ls='ls -FG'
alias grep='grep --color'

alias home='ssh home'
alias work="perl -MSocket -e'socket(SOCK,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));connect(SOCK,sockaddr_in(80,inet_aton(\"files.richard-group.com\")))or die\$!;syswrite(SOCK,\"GET /open/barley HTTP/1.0\\n\\n\",27);'&& ssh work"

# Vim alias with sudo built-ins
function o {
	for file in "$@"; do
		if [ -a "$file" -a ! -w "$file" -a ! -O "$file" ]; then
			if [ -x "`which sudoedit`" ]; then
				sudoedit "$@"
				return
			else
				sudo vim "$@"
				return
			fi
		fi
	done

	vim "$@"
}

# cd alias with directory substitution and directory-for-file shortcut
function a {
	if [ -z "$1" ]; then
		builtin cd
	else
		if [ -n "$2" ]; then
			TRY="${PWD/$1/$2}"
		else
			TRY="$1"
		fi

		if [ -f "${TRY}" ]; then
			builtin cd "$(dirname ${TRY})"
		else
			builtin cd "${TRY}"
		fi
	fi
}

alias n='ls'
alias nn='ls -lA'
alias s='svn'
alias oo='vimdiff'

function sd {
	if [ $# != 1 ]; then
		echo "Usage: sd <file>"
		return 2
	elif [ ! -e "$1" ]; then
		echo "File not found: $1"
		return 2
	elif [ `expr "$(svn status $1)" : "M"` -eq 0 ]; then
		echo "No difference in working copy of $1"
		return 1
	else
		TEMP=/tmp/tmp.$$.`basename $1`
		cat "$1" > "$TEMP"
		svn diff "$1" | patch -R "$TEMP" >/dev/null
		vimdiff -c "wincmd l" -c "set nomodifiable" -c "wincmd h" -c "0" -c "normal ]c" "$1" "$TEMP"
		rm -f "$TEMP"
	fi
}

alias perl="perl -I${HOME}/src"
alias ri='ri -Tf ansi'

PS1='\h:\w/ '

export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/X11R6/bin:$HOME/bin

if [ -a "${HOME}/.bash_local" ]
then
	source ~/.bash_local
fi
