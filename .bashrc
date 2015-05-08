
source $HOME/.bash_profile

if [ "$USER" = 'root' ]; then
	PS1="root@$PS1"
fi
