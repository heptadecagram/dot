#!/bin/sh
# Project  Name: dot
# File / Folder: ~/.bash_profile
# File Language: sh
# Copyright (C): 2004 Liam Bryan
# First  Author: Liam Bryan
# First Created: 2004.08.11
# Last Modifier: Liam Bryan
# Last Modified: 2006.06.06 12:38:28

export TZ='America/New_York'
export COPYRIGHT='Liam Bryan'

alias ls='ls -FG'
alias grep='grep --color'

alias home='ssh home'
alias work="ruby -r net/http -e'Net::HTTP.start(\"files.richard-group.com\",80){|http|http.get(\"/open/barley\")}';ssh work"

# Vim alias with sudo built-ins
function o {
	for file in $*; do
		if [ -a "$file" -a ! -w "$file" -a ! -O "$file" ]; then
			if [ -x "`which sudoedit`" ]; then
				sudoedit $*
				return
			else
				sudo vim $*
				return
			fi
		fi
	done

	vim $*
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
