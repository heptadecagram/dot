"
" Project  Name: Vim Settings
" File / Folder: .vim/ftplugin/tex.vim
" File Language: vim
" Copyright (C): 2010 Liam Echlin
" First  Author: Liam Echlin
" First Created: 2010.05.02
" Last Modifier: Liam Echlin
" Last Modified: 2010.05.03

nmap <silent> lf :call TexFunctionList()<CR>
function! TexFunctionList()
	normal mlgg
	leftabove vnew

	setlocal noreadonly modifiable noswapfile nowrap
	setlocal buftype=nowrite
	setlocal bufhidden=delete

	call setline('.', '% Section List')
	wincmd l
	while search('\\\zs\%(sub\)*section\>', 'W')
		normal "gywf{"ry%
		wincmd h
		call append('$', substitute(@g[:-8], 'sub', "\t", 'g') . @r[1:-2])
		wincmd l
	endwhile
	normal 'l

	wincmd h

	silent %yank
	silent %s/\t/  /g
	silent %!wc -L
	silent put
	silent 1delete

	execute 'vert resize ' . @"[:-2]

	setlocal nomodifiable
	normal t

	map <silent> <buffer> <CR> ^"lY:q<CR>:call Tex_gd(@l)<CR>
endfunction

function! Tex_gd(section)
	call search('\\\%(sub\)*section{' . a:section . '}', 'b')
endfunction
