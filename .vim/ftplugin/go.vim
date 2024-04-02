vim9script

def GolangFunctionList()
	const saved = winsaveview()
	:0
	belowright new

	setlocal noreadonly modifiable noswapfile nowrap
	setlocal buftype=nowrite
	setlocal bufhidden=delete

	setline('.', '// Function List')
	wincmd k
	while search('^func\( \+\| *([^()]*) *\)\([^ ()]\+\)', 'W') > 0
		normal! w"lyt{
		wincmd j
		append('$', @l)
		wincmd k
	endwhile
	winrestview(saved)

	wincmd j
	execute 'resize ' .. line('$')
	setlocal nomodifiable
	normal! j

	map <silent> <buffer> <CR> ^f("lyb:q<CR>:silent call <SID>Golang_gd(@l)<CR>
enddef

nmap <silent> lf :silent call <SID>GolangFunctionList()<CR>

def Golang_gd(word: string)
	search('^func\( \+\| *([^()]*) *\)' .. word, 'b')
enddef

#autocmd BufWritePost *.go :silent Fmt
