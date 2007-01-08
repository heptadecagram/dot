"
" Project  Name: Vim Settings
" File / Folder: .vim/ftplugin/css.vim
" File Language: vim
" Copyright (C): 2005 Liam Bryan
" First  Author: Liam Bryan
" First Created: 2005.09.29 18:42:16
" Last Modifier: Liam Bryan
" Last Modified: 2007.01.08 07:24:44

" Set 'comments' to format dashed lists in comments.
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/

setlocal formatoptions+=o

if has('omnifunc')
	setlocal omnifunc=csscomplete#CompleteCSS

	function! TabComplete()
		if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
			return "\<Tab>"
		else
			return "\<C-X>\<C-O>"
		endif
	endfunction
	inoremap <Tab> <C-R>=TabComplete()<CR>
endif
