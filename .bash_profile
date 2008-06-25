#!/bin/sh
# Project  Name: dot
# File / Folder: ~/.bash_profile
# File Language: sh
# Copyright (C): 2004 Liam Bryan
# First  Author: Liam Bryan
# First Created: 2004.08.11
# Last Modifier: Liam Echlin
# Last Modified: 2008.06.24

export TZ='America/New_York'
export COPYRIGHT='Liam Echlin'

shopt -s histappend

alias ls='ls -FG'
alias grep='grep --color'

alias n='ls'
alias nn='ls -lA'
alias N='ls -la'
alias s='svn'
alias c='cvs'
alias g='git'
alias oo='vimdiff'

alias home='ssh home'

alias perl="perl -I${HOME}/src"
alias ri='ri -Tf ansi'

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
	PS1="\n`if [ -d CVS ]; then cat CVS/Root 2>/dev/null | sed -ne's/$/\//p'; fi``cat CVS/Repository 2>/dev/null | sed -ne's/$/\\\n/p'``if [ -d .svn ]; then svn info 2>/dev/null | sed -ne's/$/\\/)\\\n/;s/URL: /(/p'; fi`$CODE_YELL\A$CODE_NORM $PS1:\w/\\n> "
}
PROMPT_COMMAND="prompt_command"

export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/X11R6/bin:$HOME/bin

mutt () {
	if [ "$USER" = wechlin ]; then
		command mutt -F ~/.mutt/sourcefire.com
	else
		command mutt -F ~/.mutt/heptadecagram.net
	fi
}

# Vim alias with sudo built-ins
o () {
	for file in "$@"; do
		if [ ! -e "$file" -a ! -w "`dirname "$file"`" ] || [ -e "$file" -a ! -w "$file" -a ! -O "$file" ]; then
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

# Version Control diff editor
_vc-diff () {
	local vc=$1
	shift

	for file in "$@"; do
		if [ ! -e "$file" ]; then
			echo "File not found: $file"
		else
			TEMP=/tmp/tmp.$$.`basename $file`
			$vc "$file" | patch -sRo "$TEMP" "$file"
			#vimdiff -c 'set diffopt=filler,iwhite' -c 'wincmd l' -c 'set readonly' -c 'set nomodifiable' -c 'wincmd h' -c '0' -c 'normal ]c' "$TEMP" "$file"
			meld "$TEMP" "$file"
			rm -f "$TEMP"
		fi
	done
}

gd () {
	_vc-diff 'git diff' "$@"
}
gd-all () {
	_vc-diff 'git diff --cached' `git-status | sed -ne's/^#\s*\S*:\s*//p'`
}

sd () {
	_vc-diff 'svn diff' "$@"
}

cvs-diff () {
	_vc-diff 'cvs diff' "$@"
}


# Completion functions

complete -A directory a cd rmdir
complete -A command man which sudo

_cvs () {
	local current=$2
 	local previous=$3

	local global_options='-a -d -e -f -H -l -n -q -Q -r -s -t -w -x -z'
	local commands='ad add new  admin annotate checkout ci co commit diff edit editors export
	history import init log login logout pserver rannotate rdiff release remove
	rlog rtag server status tag unedit update version watch watchers'

	COMPREPLY=()

	if [ $COMP_CWORD -eq 1 ]; then
		if [ "${current#-}" != "$current" ]; then
			COMPREPLY=(`compgen -W "$global_options" -- $current`)
		else
			COMPREPLY=(`compgen -W "$commands" -- $current`)
		fi
		return
	fi

	COMPREPLY=(`compgen -X 'CVS' -f -- $current`)
}
complete -o filenames -F _cvs cvs c

_svn () {
	local current=$2
	local prev=$3
	local opts='add blame praise annotate ann cat checkout co cleanup commit ci
	copy cp delete del remove rm diff di export help h \? import info list ls
	lock log merge mkdir move mv rename ren propdel propedit propget proplist
	propset resolved revert status stat st switch sw unlock update up'
	COMPREPLY=()

	if [ $COMP_CWORD -eq 1 ]; then
		COMPREPLY=(`compgen -W "$opts" -- "$current"`)
		return
	fi

	case "$prev" in
	add)
		# If the current directory is unversioned, nothing can be added
		if [ ! -d "`dirname "$current"`/.svn" ] || [ -d "$current" -a ! -d "$current/.svn" ]; then
			COMPREPLY=()
			return
		fi

		if [ "$current" ]; then
			opts=`svn status "$current"* | sed -ne's#^?\s*##p'`
		else
			opts=`svn status | sed -ne's#^?\s*##p'`
		fi

		# The goal here is to adjust the completion options to get directories
		# to work properly.  Currently, only the basename of a path is displayed
		# for completion, when it should be the next step in a directory tree.
		#if [ "${opts#*/}" != "$opts" ]; then
			#if [ "${current#*/}" != "$current" ]; then
				#opts=`echo "$opts" | sed -e"s#${current%/*}##" -e's#/.*##' | uniq`
			#else
				#opts=`echo "$opts" | sed -e's#/.*##' | uniq`
			#fi
		#fi

		# If the directory errors on svn status, it is unversioned, so
		# display all its contents
		# If nothing is returned, there is nothing to add.  Stop.
		if [ -z "$opts" ]; then
			COMPREPLY=()
		# If something is returned, this is a repository, and show the new files
		else
			COMPREPLY=(`compgen -X '.svn' -W "$opts" -- "$current"`)
		fi
		return
		;;
	ci | commit)
		if [ "$current" ]; then
			opts=`svn status "$current"* 2>/dev/null | sed -ne's#^[AM]\s*##p'`
		else
			opts=`svn status 2>/dev/null | sed -ne's#^[AM]\s*##p'`
		fi
		# If nothing is returned, there is nothing to commit.  Stop.
		if [ -z "$opts" ]; then
			COMPREPLY=()
		else
			COMPREPLY=(`compgen -X '.svn' -W "$opts" -- "$current" `)
		fi
		return
		;;
	prop* | pd | pe | pg | pl | ps)
		COMPREPLY=(`compgen -P 'svn:' -W 'executable externals ignore' -- "$current"`)
		return
		;;
	resolved)
		if [ "$current" ]; then
			opts=`svn status "$current"* 2>/dev/null | grep ^C | cut -c 8-`
		else
			opts=`svn status 2>/dev/null | grep ^C | cut -c 8-`
		fi
		# If nothing is returned, there is nothing to commit.  Stop.
		if [ -z "$opts" ]; then
			COMPREPLY=()
		else
			COMPREPLY=(`compgen -X '.svn' -W "$opts"`)
		fi
		return
		;;
	'\?' | h | help)
		COMPREPLY=(`compgen -W "$opts" -- "$current"`)
		return
		;;
	esac

	COMPREPLY=(`compgen -X '.svn' -f -- "$current"`)
}
complete -o filenames -F _svn svn s

_svnadmin () {
	local current=$2
	local previous=$3
	local commands='crashtest create deltify dump help hotcopy list-dblogs
	list-unused-dblogs load lslocks lstxns recover rmlocks rmtxns setlog verify'

	if [ $COMP_CWORD -eq 1 ]; then
		COMPREPLY=(`compgen -W "$commands" -- "$current"`)
		return
	else
		COMPREPLY=(`compgen -f -- "$current"`)
	fi
}
complete -o filenames -F _svnadmin svnadmin

_git () {
	local current=$2
	local previous=$3
	local commands='add am annotate apply archive bisect blame branch bundle cat-file check-attr checkout checkout-index check-ref-format cherry cherry-pick
	clean clone commit commit-tree config count-objects cvsexportcommit cvsimport cvsserver daemon describe diff diff-files diff-index diff-tree fast-export
	fast-import fetch fetch-pack filter-branch fmt-merge-msg for-each-ref format-patch fsck fsck-objects gc get-tar-commit-id grep hash-object help
	http-fetch http-push imap-send index-pack init init-db instaweb log lost-found ls-files ls-remote ls-tree mailinfo mailsplit merge merge-base merge-file
	merge-index merge-octopus merge-one-file merge-ours merge-recursive merge-resolve merge-stupid merge-subtree merge-tree mergetool mktag mktree mv
	name-rev pack-objects pack-redundant pack-refs parse-remote patch-id peek-remote prune prune-packed pull push quiltimport read-tree rebase receive-pack
	reflog relink remote repack repo-config request-pull rerere reset revent rev-list rev-parse rm send-pack shell shortlog show show-branch show-index
	show-ref sh-setup stash status stripspace submodule svn symbolic-ref tag tar-tree unpack-file unpack-objects update-index update-ref update-server-info
	upload-archive upload-pack var verify-pack verify-tag whatchanged write-tree'

	if [ $COMP_CWORD -eq 1 ]; then
		COMPREPLY=(`compgen -W "$commands" -- "$current"`)
	else
		COMPREPLY=(`compgen -X '.git' -f -- "$current"`)
	fi

	if [ "$previous" = 'checkout' ]; then
		COMPREPLY=(`compgen -W "$(git-branch)" -- "$current"`)
	fi
}
complete -F _git git g

_git-checkout () {
	local current=$2
	local previous=$3

	if [ "$previous" = '-b' ]; then
		COMPREPLY=()
	else
		COMPREPLY=(`compgen -W "$(git-branch | sed -e's/\*//')" -- "$current"`)
	fi
}
complete -o default -F _git-checkout git-checkout

_vmrun () {
	local current=$2
	local previous=$3
	local commands='start stop reset suspend listSnapshots snapshot deleteSnapshot revertToSnapshot runProgramInGuest fileExistsInGuest setSharedFolderState addSharedFolder removeSharedFolder listProcessesInGuest killProcessInGuest runScriptInGuest deleteFileInGuest createDirectoryInGuest deleteDirectoryInGuest listDirectoryInGuest copyFileFromHostToGuest copyFileFromGuestToHosta renameFileInGuest list upgradevm installtools'

	local vmdir=/home/$USER/vmware

	if [ $COMP_CWORD -eq 1 ]; then
		COMPREPLY=(`compgen -W "$commands" -- "$current"`)
		return
	fi

	if [ "$previous" = 'listSnapshots' ]; then
		COMPREPLY=(`compgen -P "$vmdir/" -S '.vmx' -W "$(command ls $vmdir | sed -e's#.*#&/&#')" -- "$current"`)
	fi

}
complete -o default -F _vmrun vmrun


_ssh () {
	local current=$2
	local hosts=`sed -ne's/Host //p' ~/.ssh/config`

	COMPREPLY=(`compgen -W "$hosts" -- "$current"`)
}
complete -F _ssh ssh


# This function expands tildes in pathnames
#
_expand () {
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
_filedir () {
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
_command () {
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
complete -o nospace -o filenames -F _command sudo nohup exec nice eval strace time ltrace then else do command xargs

if [ -a "$HOME/.local/bash_profile" ]; then
	source ~/.local/bash_profile
fi

fix_everything () {
	i=1
	sp='/-\|'
	echo -n ' '
	while true; do
		echo -en "\b${sp:i++%${#sp}:1}"
	done
}
