#!/bin/sh
# Project  Name: dot
# File / Folder: ~/.bash_profile
# File Language: sh
# Copyright (C): 2004 Liam Bryan
# First  Author: Liam Bryan
# First Created: 2004.08.11
# Last Modifier: Liam Bryan
# Last Modified: 2007.02.22 07:06:47

export TZ='America/New_York'
export COPYRIGHT='Liam Bryan'

alias ls='ls -FG'
alias grep='grep --color'

alias n='ls'
alias nn='ls -lA'
alias s='svn'
alias oo='vimdiff'

alias home='ssh home'
alias work='perl -MSocket -e"socket(SOCK,PF_INET,SOCK_STREAM,getprotobyname(q(tcp)));connect(SOCK,sockaddr_in(80,inet_aton(q(files.richard-group.com))))or die\$!;syswrite(SOCK,qq(GET /open/barley HTTP/1.0\\n\\n),27);"&& ssh work'

alias perl="perl -I${HOME}/src"
alias ri='ri -Tf ansi'

PS1='\h:\w/ '

export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/X11R6/bin:$HOME/bin

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

# SVN diff, loads changed version alongside current in vimdiff
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
		vimdiff -c "wincmd l" -c "set readonly" -c "set nomodifiable" -c "wincmd h" -c "0" -c "normal ]c" "$1" "$TEMP"
		rm -f "$TEMP"
	fi
}

# Apache error log
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

# Completion functions

complete -A directory a cd
complete -A command man which sudo
function _svn {
	local cur=$2
 	local prev=$3
	local opts="add blame praise annotate ann cat checkout co cleanup commit ci
	copy cp delete del remove rm diff di export help h \? import info list ls
	lock log merge mkdir move mv rename ren propdel propedit propget proplist
	propset resolved revert status stat st switch sw unlock update up"
	COMPREPLY=()

	if [ $COMP_CWORD -eq 1 ]; then
		COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
		return 0
	fi

	case "${prev}" in
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
			opts=`svn status ${cur}* 2>/dev/null | grep ^[AM] | sed s/^[AM[:space:]]*[[:space:]]//`
		else
			opts=`svn status 2>/dev/null | grep ^[AM] | sed s/^[AM[:space:]]*[[:space:]]//`
		fi
		# If nothing is returned, there is nothing to commit.  Stop.
		if [ -z "$opts" ]; then
			COMPREPLY=()
		else
			COMPREPLY=( $(compgen -X ".svn" -W "${opts}") )
		fi
		return 0
		;;
	prop* | pd | pe | pg | pl | ps)
		opts="ignore executable externals"
		COMPREPLY=( $(compgen -P "svn:" -W "${opts}" -- ${cur}) )
		return 0
		;;
	resolved)
		if [ "$cur" ]; then
			opts=`svn status ${cur}* 2>/dev/null | grep ^C | sed s/C[[:space:]]*//`
		else
			opts=`svn status 2>/dev/null | grep ^C | sed s/C[[:space:]]*//`
		fi
		# If nothing is returned, there is nothing to commit.  Stop.
		if [ -z "$opts" ]; then
			COMPREPLY=()
		else
			COMPREPLY=( $(compgen -X ".svn" -W "${opts}") )
		fi
		return 0
		;;
	'\?' | h | help)
		COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
		return 0
		;;
	esac

	COMPREPLY=( $(compgen -X ".svn" -f ${cur}) )
}
complete -o filenames -F _svn svn s

# This function expands tildes in pathnames
#
function _expand {
	[ "$cur" != "${cur%\\}" ] && cur="$cur\\"

	# expand ~username type directory specifications
	if [[ "$cur" == \~*/* ]]; then
		eval cur=$cur

	elif [[ "$cur" == \~* ]]; then
		cur=${cur#\~}
		COMPREPLY=( $( compgen -P '~' -u $cur ) )
		return ${#COMPREPLY[@]}
	fi
}
# This function performs file and directory completion. It's better than
# simply using 'compgen -f', because it honours spaces in filenames.
# If passed -d, it completes only on directories. If passed anything else,
# it's assumed to be a file glob to complete on.
#
function _filedir {
	local IFS=$'\t\n' xspec #glob

	_expand || return 0

	#glob=$(set +o|grep noglob) # save glob setting.
	#set -f		 # disable pathname expansion (globbing)

	if [ "${1:-}" = -d ]; then
		COMPREPLY=( ${COMPREPLY[@]:-} $( compgen -d -- $cur ) )
		#eval "$glob"    # restore glob setting.
		return 0
	fi

	xspec=${1:+"!*.$1"}	# set only if glob passed in as $1
	COMPREPLY=( ${COMPREPLY[@]:-} $( compgen -f -X "$xspec" -- "$cur" ) \
		    $( compgen -d -- "$cur" ) )
	#eval "$glob"    # restore glob setting.
}

# A meta-command completion function for commands like sudo(8), which need to
# first complete on a command, then complete according to that command's own
# completion definition - currently not quite foolproof (e.g. mount and umount
# don't work properly), but still quite useful.
#
function _command {
	local cur func cline cspec noglob cmd done i \
	      _COMMAND_FUNC _COMMAND_FUNC_ARGS

	COMPREPLY=()
	cur=${COMP_WORDS[COMP_CWORD]}
	# If the the first arguments following our meta-command-invoker are
	# switches, get rid of them. Most definitely not foolproof.
	done=
	while [ -z $done ] ; do
	cmd=${COMP_WORDS[1]}
	    if [[ "$cmd" == -* ]] ; then
		for (( i=1 ; i<=COMP_CWORD ; i++)) ; do
		    COMP_WORDS[i]=${COMP_WORDS[i+1]}
		done
		COMP_CWORD=$(($COMP_CWORD-1))
	    else
		done=1
	    fi
	done

	if [ $COMP_CWORD -eq 1 ]; then
		COMPREPLY=( $( compgen -c -- $cur ) )
	elif complete -p $cmd &>/dev/null; then
		cspec=$( complete -p $cmd )
		if [ "${cspec#* -F }" != "$cspec" ]; then
			# complete -F <function>
			#
			# COMP_CWORD and COMP_WORDS() are not read-only,
			# so we can set them before handing off to regular
			# completion routine

			# set current token number to 1 less than now
			COMP_CWORD=$(( $COMP_CWORD - 1 ))

			# get function name
			func=${cspec#*-F }
			func=${func%% *}
			# get current command line minus initial command
			cline="${COMP_LINE#*( )$1 }"
			# save noglob state
		      	shopt -qo noglob; noglob=$?
			# turn on noglob, as things like 'sudo ls *<Tab>'
			# don't work otherwise
		  	shopt -so noglob
			# split current command line tokens into array
			COMP_WORDS=( $cline )
			# reset noglob if necessary
			[ $noglob -eq 1 ] && shopt -uo noglob
			$func $cline
			# This is needed in case user finished entering
			# command and pressed tab (e.g. sudo ls <Tab>)
			COMP_CWORD=$(( $COMP_CWORD > 0 ? $COMP_CWORD : 1 ))
			cur=${COMP_WORDS[COMP_CWORD]}
			_COMMAND_FUNC=$func
			_COMMAND_FUNC_ARGS=( $cmd $2 $3 )
			COMP_LINE=$cline
			COMP_POINT=$(( ${COMP_POINT} - ${#1} - 1 ))
			$func $cmd $2 $3
			# remove any \: generated by a command that doesn't
			# default to filenames or dirnames (e.g. sudo chown)
			if [ "${cspec#*-o }" != "$cspec" ]; then
				cspec=${cspec#*-o }
				cspec=${cspec%% *}
				#if [[ "$cspec" != @(dir|file)names ]]; then
				#	COMPREPLY=("${COMPREPLY[@]//\\\\:/:}")
				#fi
			fi
		elif [ -n "$cspec" ]; then
			cspec=${cspec#complete};
			cspec=${cspec%%$cmd};
			COMPREPLY=( $( eval compgen "$cspec" -- "$cur" ) );
		fi
	fi

	[ ${#COMPREPLY[@]} -eq 0 ] && _filedir
}
complete -F _command nohup exec nice eval strace time ltrace then else do command xargs

if [ -a "${HOME}/.bash_local" ]; then
	source ~/.bash_local
fi
