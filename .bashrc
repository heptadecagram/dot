
alias ls='ls -FG'
alias grep='grep --color'

alias n='ls'
alias nn='ls -lA'
alias N='ls -la'
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

PATH=$PATH:$HOME/bin

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

# Handle large bash completions and helpers based
# on what is available.
if [ -d $HOME/.bash ]; then
	for file in $HOME/.bash/*; do
		if [ -x "`which ${file#*.bash/} 2>/dev/null`" ]; then
			source $file
		fi
	done
fi


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


# Completion functions

_ssh () {
	local current=$2
	local hosts=`cat ~/.ssh/config ~/.ssh/known_hosts | sed -ne's/Host //p ; s/^\([^,]*\),.*/\1/p' | sort | uniq`

	COMPREPLY=(`compgen -W "$hosts" -- "$current"`)
}
complete -F _ssh ssh

_scp () {
	local current=$2
	local hosts=`cat ~/.ssh/config ~/.ssh/known_hosts | sed -ne's/Host //p ; s/^\([^,]*\),.*/\1/p' | sort | uniq`

	COMPREPLY=(`compgen -S ":" -W "$hosts" -- "$current"`)
}
complete -F _scp scp

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
complete -A command man which

__get_action() {
	local index=1
	# Find the current action being taken
	while [ $index -lt $COMP_CWORD ]; do
		if [ "${COMP_WORDS[$index]##-*}" ]; then
			return "${COMP_WORDS[$index]}"
		fi
		index=$(($index + 1))
	done
}

_flag_option_action_complete() {
	local FLAGS=$1
	local OPTIONS=$2
	local ACTIONS=$3

	local current_action=__get_action

	# Default to the list of files available
	COMPREPLY=(`compgen -o filenames -X '.git' -f -- "$current"`)

	# If a full command was not found, then complete on that command or option
	if [ -z "$current_action" ]; then
		if [ "${current##-*}" ]; then
			COMPREPLY=(`compgen -W "$ACTIONS" -- "$current"`)
		elif [ "${current##--*}" ]; then
			COMPREPLY=(`compgen -o default -W "$OPTIONS" -- "$current"`)
		else
			COMPREPLY=(`compgen -o default -W "$FLAGS" -- "$current"`)
		fi
	fi

}

fix_everything () {
	i=1
	s='/-\|'
	echo -n ' '
	while true; do
		echo -en "\b${s:i++%${#s}:1}"
	done
}
