"
" Project  Name: Vim Settings
" File / Folder: .vim/filetype.vim
" File Language: vim
" Copyright (C): 2004 Liam Bryan
" First  Author: Liam Bryan
" First Created: 2004.10.17 08:18:55
" Last Modifier: Liam Bryan
" Last Modified: 2005.08.16 17:40:08

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
autocmd BufNewFile,BufRead /Library/WebServer/CGI-Executables/mailer/*
      \   let g:Project_Path = '/Library/WebServer/CGI-Executables/mailer/'
      \ | let g:Project_Name = 'RG_MAILER'

autocmd BufNewFile,BufRead /Library/WebServer/Documents/grovestreetwinery.com/*
      \   let g:Project_Path = '/Library/WebServer/Documents/grovestreetwinery.com/'
      \ | let g:Project_Name = 'grovestreetwinery.com'
autocmd BufNewFile,BufRead /Library/WebServer/Documents/peterpaulwines.com/*
      \   let g:Project_Path = '/Library/WebServer/Documents/peterpaulwines.com/'
      \ | let g:Project_Name = 'peterpaulwines.com'
autocmd BufNewFile,BufRead /Library/WebServer/Documents/simplysoles.com/*
      \   let g:Project_Path = '/Library/WebServer/Documents/simplysoles.com/'
      \ | let g:Project_Name = 'simplysoles.com'
autocmd BufNewFile,BufRead /Library/WebServer/Documents/sfsassociation.org/*
      \   let g:Project_Path = '/Library/WebServer/Documents/sfsassociation.org/'
      \ | let g:Project_Name = 'sfsassociation.org'
autocmd BufNewFile,BufRead /Library/WebServer/Documents/hannawinery.com/*
      \   let g:Project_Path = '/Library/WebServer/Documents/sfsassociation.com/'
      \ | let g:Project_Name = 'hannawinery.com'
autocmd BufNewFile,BufRead /Library/WebServer/Documents/solesonsale.com/*
      \   let g:Project_Path = '/Library/WebServer/Documents/solesonsale.com/'
      \ | let g:Project_Name = 'solesonsale.com'
