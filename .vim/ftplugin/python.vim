vim9script

setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=80
setlocal smarttab
setlocal expandtab
setlocal smartindent

def Python_gd(word: string)
	search('\<def\> ' .. word .. '\>', 'b')
enddef
nmap <silent> gd "lyiw :silent call <SID>Python_gd(@l)<CR>

def PythonFunctionList()
	const saved = winsaveview()
	belowright new

	setlocal noreadonly modifiable noswapfile nowrap
	setlocal buftype=nowrite
	setlocal bufhidden=delete

	setline('.', '# Function List')
	wincmd k

	cursor(0, 0)
	while search('\<def\s\+\w\+', 'W') > 0
		normal w"lY
		wincmd j
		append('$', @l)
		wincmd k
	endwhile
	winrestview(saved)

	wincmd j
	execute 'resize ' .. line('$')
	setlocal nomodifiable
	normal! j

	map <silent> <buffer> <CR> "lyiw:q<CR>:silent call <SID>Python_gd(@l)<CR>
enddef
nmap <silent> lf :silent call <SID>PythonFunctionList()<CR>
