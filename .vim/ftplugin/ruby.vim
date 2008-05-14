"
" Project  Name: Vim Settings
" File / Folder: .vim/ftplugin/ruby.vim
" File Language: vim
" Copyright (C): 2005 Liam Bryan
" First  Author: Liam Bryan
" First Created: 2005.09.04 09:10:41
" Last Modifier: Liam Echlin
" Last Modified: 2008.05.13


setlocal comments=:#
setlocal commentstring=#%s
setlocal formatoptions+=cr

nmap <silent> gd "lyiw:call Ruby_gd(@l)<CR>

setlocal omnifunc=rubycomplete#Complete

function! Ruby_gd(word)
	if !search('\<def\s\+' . a:word . '\>', 'b')
		if !search('\<class\s\+' . a:word . '\>', 'b')
			call search('\<module\s\+' . a:word . '\>', 'b')
		endif
	endif
endfunction

nmap <silent> lf :call RubyFunctionList()<CR>

function! RubyFunctionList()
	normal mlgg
	belowright new

	setlocal noreadonly modifiable noswapfile nowrap
	setlocal buftype=nowrite
	setlocal bufhidden=delete

	call setline('.', '# Function List')
	wincmd k
	while search('\<def\s\+', 'W')
		normal w"ryiw
		wincmd j
		call append('$', @r)
		wincmd k
	endwhile
	normal 'l

	wincmd j
	execute 'resize ' . line('$')
	setlocal nomodifiable
	normal t

	map <silent> <buffer> <CR> "lyiw:q<CR>:call Ruby_gd(@l)<CR>
endfunction
