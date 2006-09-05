#!/bin/sh
# Project  Name: dot
# File / Folder: ~/.bash_profile
# File Language: sh
# Copyright (C): 2004 Liam Bryan
# First  Author: Liam Bryan
# First Created: 2004.08.11
# Last Modifier: Liam Bryan
# Last Modified: 2006.09.05 12:01:44

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

function ap_log {
	if [ -e '/var/log/apache2/error.log' ]; then
		sudo tail -f /var/log/apache2/error.log
	elif [ -e '/usr/local/apache2/logs/error_log' ]; then
		tail -f /usr/local/apache2/logs/error_log
	else
		echo "Don't know where Apache2 error log is found"
		return 2
	fi
}

PS1='\h:\w/ '

export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/X11R6/bin:$HOME/bin

complete -A directory a
complete -A directory cd
complete -A command sudo
complete -A command man
function _svn {
	local cur=$2
 	local prev=$3
	COMPREPLY=()
	local opts="add blame praise annotate ann cat checkout co cleanup commit ci copy cp delete del remove rm diff di export help h ? import info list ls lock log merge mkdir move mv rename ren propdel propedit propget proplist propset resolved revert status stat st switch sw unlock update up"

	if [ $COMP_CWORD -eq 1 ]; then
		COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
		return 0
	fi

	case "${prev}" in
	prop* | pd | pe | pg | pl | ps)
		opts="ignore executable externals"
		COMPREPLY=( $(compgen -P "svn:" -W "${opts}" -- ${cur}) )
		return 0
		;;
	add)
		if [ "$cur" ]; then
			opts=`svn status ${cur}* 2>/dev/null | grep ^? | sed s/\?[[:space:]]*//`
		else
			opts=`svn status 2>/dev/null | grep ^? | sed s/\?[[:space:]]*//`
		fi
		svn status ${cur}* 2>/dev/null >/dev/null
		# If the directory errors on svn status, it is unversioned, so
		# display all its contents
		if [ $? -eq 1 ]; then
			COMPREPLY=( $(compgen -X ".swp" -f "${cur}") )
		# If nothing is returned, there is nothing to add.  Stop.
		elif [ -z "$opts" ]; then
			COMPREPLY=()
		# If something is returned, this is a repository, and show the new files
		else
			COMPREPLY=( $(compgen -X ".svn" -W "${opts}") )
		fi
		return 0
		;;
	ci | commit)
		if [ "$cur" ]; then
			opts=`svn status ${cur}* 2>/dev/null | grep ^M | sed s/M[[:space:]]*//`
		else
			opts=`svn status 2>/dev/null | grep ^M | sed s/M[[:space:]]*//`
		fi
		# If nothing is returned, there is nothing to commit.  Stop.
		if [ -z "$opts" ]; then
			COMPREPLY=()
		else
			COMPREPLY=( $(compgen -X ".svn" -W "${opts}") )
		fi
		return 0
		;;
	? | h | help)
		COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
		return 0
		;;
	esac

	COMPREPLY=( $(compgen -X ".svn" -f ${cur}) )
}
complete -o filenames -F _svn svn
complete -o filenames -F _svn s

if [ -a "${HOME}/.bash_local" ]
then
	source ~/.bash_local
fi
