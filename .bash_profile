export TZ='America/New_York'

alias ls='ls -FG'

alias startk='sudo kbdcontrol -k /dev/kbd1 < /dev/ttyv0 > /dev/null'
alias endk='sudo kbdcontrol -k /dev/kbd0 < /dev/ttyv0 > /dev/null'

PS1='\h:\w/ '

export EDITOR='vim'
export VISUAL='vim'
pager='less'

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/X11R6/bin:$HOME/bin

#/usr/local/bin/pg_ctl -D /usr/local/share/postgresql/data -l logfile start
