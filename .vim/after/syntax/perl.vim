" 
" Project  Name: Vim Settings
" File / Folder: .vim/after/syntax/perl.vim
" File Language: vim
" Copyright (C): 2004 Liam Bryan
" First  Author: Liam Bryan
" First Created: 2004.11.18 21:23:58
" Last Modifier: Liam Bryan
" Last Modified: 2005.03.29 12:46:43

unlet b:current_syntax
syntax include @SQLString syntax/sql.vim
"syntax sync clear

syntax cluster perlQQ add=@SQLString

syntax sync minlines=200
