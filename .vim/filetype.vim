"
" Project  Name: Vim Settings
" File / Folder: .vim/filetype.vim
" File Language: vim
" Copyright (C): 2004 Liam Bryan
" First  Author: Liam Bryan
" First Created: 2004.10.17 08:18:55
" Last Modifier: Liam Echlin
" Last Modified: 2008.05.05

autocmd BufNewFile,BufRead	~/.vim/*
			\   let g:Project_Path = expand('~/')
			\ | let g:Project_Name = 'Vim Settings'

" Personal
autocmd BufNewFile,BufRead	~/wind/*
			\   let g:Project_Path = expand('~/wind/')
			\ | let g:Project_Name = 'wind'
