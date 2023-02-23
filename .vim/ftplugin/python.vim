
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=80
setlocal smarttab
setlocal expandtab
setlocal smartindent

nmap <silent> gd "lyiw :call Python_gd(@l)<CR>

function! Python_gd(word)
	call search('\<def\> ' . a:word . '\>', 'b')
endfunction

nmap <silent> lf :call PythonFunctionList()<CR>

function! PythonFunctionList()
	normal mlgg
	belowright new

	setlocal noreadonly modifiable noswapfile nowrap
	setlocal buftype=nowrite
	setlocal bufhidden=delete

	call setline('.', '# Function List')
	wincmd k
	while search('\<def\s\+\w\+', 'W')
		normal w"rY
		wincmd j
		call append('$', @r)
		wincmd k
	endwhile
	normal 'l

	wincmd j
	execute 'resize ' . line('$')
	setlocal nomodifiable
	normal t

	map <silent> <buffer> <CR> "lyiw:q<CR>:call Python_gd(@l)<CR>
endfunction
