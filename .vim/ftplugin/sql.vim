" 
" Project  Name: Vim Settings
" File / Folder: .vim/ftplugin/sql.vim
" File Language: vim
" Copyright (C): 2004 Liam Bryan
" First  Author: Liam Bryan
" First Created: 2004.12.10 10:46:28
" Last Modifier: Liam Bryan
" Last Modified: 2005.08.26 09:54:50

set formatoptions+=or

set comments=:--
set commentstring=--%s

set foldmethod=marker

nmap <silent> gd "lyiw:call SQL_gd(@l)<CR>

function! SQL_gd(word)
	call search('\cCREATE TABLE ' . a:word, 'b')
endfunction

nmap <silent> lf :call SQLFunctionList()<CR>

function! SQLFunctionList()
	normal mlgg
	belowright new

	setlocal noreadonly modifiable noswapfile nowrap
	setlocal buftype=nowrite
	setlocal bufhidden=delete

	call setline('.', '# Table List')
	wincmd k
	while search('\<\cCREATE TABLE\s\+', 'W')
		normal ww"ryf 
		if @r == '{'
			continue 
		endif
		wincmd j
		call append('$', @r)
		wincmd k
	endwhile
	normal 'l

	wincmd j
	execute 'resize ' . line('$')
	setlocal nomodifiable
	normal t

	map <silent> <buffer> <CR> "lY:q<CR>:call SQL_gd(@l)<CR>
endfunction
