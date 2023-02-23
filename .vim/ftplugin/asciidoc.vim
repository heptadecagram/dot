
setlocal sw=4
setlocal ts=4
setlocal noet

setlocal makeprg=asciidoctor-pdf\ \"%\"

nmap <silent> lf :call AsciidocSectionList()<CR>
function! AsciidocSectionList()
	normal mlgg
	leftabove vnew

	setlocal noreadonly modifiable noswapfile nowrap
	setlocal buftype=nowrite
	setlocal bufhidden=delete

	call setline('.', '// Section List')
	wincmd l

	" Find the first entry if it's on the first line
	call search('^=', 'cW')
	normal "gy$
	wincmd h
	call append('$', substitute(substitute(@g[1:], '=', "\t", 'g'), ' ', '', ''))
	wincmd l

	while search('^=', 'W')
		normal "gy$
		wincmd h
		call append('$', substitute(substitute(@g[1:], '=', "\t", 'g'), ' ', '', ''))
		wincmd l
	endwhile
	normal 'l

	wincmd h

	silent %s/\t/  /g
	silent %yank
	silent %!awk '{x = (length > x ? length : x)}; END {print x+1}'
	silent put
	silent 1delete

	execute 'vert resize ' . @"[:-2]

	setlocal nomodifiable
	normal t

	map <silent> <buffer> <CR> ^"lY:q<CR>:call Asciidoc_gd(@l)<CR>
endfunction

function! Asciidoc_gd(section)
	call search('\%(=\)\+ ' . escape(a:section, '\\'), 'b')
endfunction
