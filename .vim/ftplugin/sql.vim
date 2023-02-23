
setlocal formatoptions+=or

setlocal comments=:--
setlocal commentstring=--%s

setlocal foldmethod=marker

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
