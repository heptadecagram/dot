#!/bin/sh
# Project  Name: dot
# File / Folder: ~/.bash_profile
# File Language: sh
# Copyright (C): 2004 Liam Bryan
# First  Author: Liam Bryan
# First Created: 2004.08.11
# Last Modifier: Liam Bryan
# Last Modified: 2006.03.24 20:05:18

export TZ='America/New_York'

alias ls='ls -FG'
alias grep='grep --color'

alias home='ssh home'
alias work="ruby -r net/http -e'Net::HTTP.start(\"files.richard-group.com\",80){|http|http.get(\"/open/barley\")}';ssh work"

alias n='ls'
alias nn='ls -lA'
alias o='vim'
alias s='svn'
alias a='cd'
alias oo='vimdiff'
alias so='sudoedit'

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
