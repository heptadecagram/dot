#!/bin/sh
# Project  Name: dot
# File / Folder: ~/.bash_profile
# File Language: sh
# Copyright (C): 2004 Liam Bryan
# First  Author: Liam Bryan
# First Created: 2004.08.11
# Last Modifier: Liam Bryan
# Last Modified: 2006.03.27 10:51:43

export TZ='America/New_York'

alias ls='ls -FG'
alias grep='grep --color'

alias home='ssh home'
alias work="ruby -r net/http -e'Net::HTTP.start(\"files.richard-group.com\",80){|http|http.get(\"/open/barley\")}';ssh work"

# Vim alias with sudo built-ins
function o {
	for file in $*; do
		if [ ! -w "$file" -a ! -O "$file" ]; then
			if [ -x "sudoedit" ]; then
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

alias n='ls'
alias nn='ls -lA'
alias s='svn'
alias a='cd'
alias oo='vimdiff'

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
