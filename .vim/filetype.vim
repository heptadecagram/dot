"
" Project  Name: Vim Settings
" File / Folder: .vim/filetype.vim
" File Language: vim
" Copyright (C): 2004 Liam Bryan
" First  Author: Liam Bryan
" First Created: 2004.10.17 08:18:55
" Last Modifier: Liam Bryan
" Last Modified: 2008.01.02 07:21:32

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
autocmd BufNewFile,BufRead /Library/WebServer/CGI-Executables/erp/*
      \   let g:Project_Path = '/Library/WebServer/CGI-Executables/erp/'
      \ | let g:Project_Name = 'RG_ERP'
autocmd BufNewFile,BufRead /Library/WebServer/CGI-Executables/mailer/*
      \   let g:Project_Path = '/Library/WebServer/CGI-Executables/mailer/'
      \ | let g:Project_Name = 'RG_MAILER'

