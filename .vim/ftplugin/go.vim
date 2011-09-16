"
" Project  Name: Vim Settings
" File / Folder: .vim/ftplugin/go.vim
" File Language: vim
" Copyright (C): 2011 Liam Echlin
" First  Author: Liam Echlin
" First Created: 2011.09.15
" Last Modifier: Liam Echlin
" Last Modified: 2011.09.16

if exists('b:loaded_golang')
	finish
endif
let b:loaded_golang = 1

function! Golang_gd(word)
	call search('func\( \+\| *([^()]*) *\)' . a:word, 'b')
endfunction

function! GolangFunctionList()
	normal! mlgg
	belowright new

	setlocal noreadonly modifiable noswapfile nowrap
	setlocal buftype=nowrite
	setlocal bufhidden=delete

	call setline('.', '# Function List')
	wincmd k
	while search('func\( \+\| *([^()]*) *\)\([^ ()]\+\)', 'W')
		normal! w"ryt{
		wincmd j
		call append('$', @r)
		wincmd k
	endwhile
	normal 'l

	wincmd j
	execute 'resize ' . line('$')
	setlocal nomodifiable
	normal t

	map <silent> <buffer> <CR> ^f("lyb:q<CR>:call Golang_gd(@l)<CR>
endfunction

nmap <silent> lf :call GolangFunctionList()<CR>

