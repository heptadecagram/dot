"
" Project  Name: Vim Settings
" File / Folder: .vim/ftplugin/lisp.vim
" File Language: vim
" Copyright (C): 2004 Liam Bryan
" First  Author: Liam Bryan
" First Created: 2004.11.18 21:02:48
" Last Modifier: Liam Bryan
" Last Modified: 2007.03.05 20:24:58

setlocal showmatch
setlocal expandtab

setlocal omnifunc=lispcomplete#Complete

function! TabComplete()
	if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
		return "\<Tab>"
	else
		return "\<C-X>\<C-O>"
	endif
endfunction
inoremap <Tab> <C-R>=TabComplete()<CR>
