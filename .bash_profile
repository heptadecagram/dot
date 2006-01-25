#!/bin/sh
# Project  Name: dot
# File / Folder: ~/.bash_profile
# File Language: sh
# Copyright (C): 2004 Liam Bryan
# First  Author: Liam Bryan
# First Created: 2004.08.11
# Last Modifier: Liam Bryan
# Last Modified: 2006.01.25 07:18:21

export TZ='America/New_York'

alias ls='ls -FG'
alias home='ssh home'

PS1='\h:\w/ '

export EDITOR='vim'
export VISUAL='vim'
pager='less'

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/X11R6/bin:$HOME/bin

if [ -a "${HOME}/.bash_local" ]
then
	source ~/.bash_local
fi
