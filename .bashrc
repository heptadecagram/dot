#!/bin/sh
# Project  Name: None
# File / Folder: .bashrc
# File Language: sh
# Copyright (C): 2006 Liam Bryan
# First  Author: Liam Bryan
# First Created: 2006.07.20 09:19:23
# Last Modifier: Liam Echlin
# Last Modified: 2008.04.12 19:36:20

source $HOME/.bash_profile

if [ "$USER" = 'root' ]; then
	PS1="root@$PS1"
fi
