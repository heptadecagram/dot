"
" Project  Name: Vim Settings
" File / Folder: .vim/filetype.vim
" File Language: vim
" Copyright (C): 2004 Liam Bryan
" First  Author: Liam Bryan
" First Created: 2004.10.17 08:18:55
" Last Modifier: Liam Bryan
" Last Modified: 2005.03.23 14:21:46

autocmd BufNewFile,BufRead	~/.vim/*
			\   let g:Project_Path = expand('~/')
			\ | let g:Project_Name = 'Vim Settings'

" Personal
autocmd BufNewFile,BufRead	~/wind/*
			\   let g:Project_Path = expand('~/wind/')
			\ | let g:Project_Name = 'wind'

" Work-related
autocmd BufNewFile,BufRead /Library/WebServer/CGI-Executables/cms/*
      \   let g:Project_Path = '/Library/WebServer/CGI-Executables/cms/'
      \ | let g:Project_Name = 'RG_CMS'
autocmd BufNewFile,BufRead /Library/WebServer/CGI-Executables/ecommerce/*
      \   let g:Project_Path = '/Library/WebServer/CGI-Executables/ecommerce/'
      \ | let g:Project_Name = 'RG_ECOMMERCE'
