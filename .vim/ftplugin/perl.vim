" 
" Project  Name: Vim Settings
" File / Folder: .vim/ftplugin/perl.vim
" File Language: vim
" Copyright (C): 2004 Liam Bryan
" First  Author: Liam Bryan
" First Created: 2004.10.21 18:40:00
" Last Modifier: Liam Bryan
" Last Modified: 2004.12.19 13:03:32

nmap <silent> gd "lyiwh"ry :call Perl_gd(@l, @r)<CR>

function! Perl_gd(word, type)
	if a:type == '$' || a:type == '@' || a:type == '%' || a:type == '*'
		call search('my[^=]\+\<' . a:word . '\>', 'b')
	elseif !search('sub ' . a:word . '\>', 'b')
		call search('use.*\<' . a:word . '\>', 'b')
	endif
endfunction
