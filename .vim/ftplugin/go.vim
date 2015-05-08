
if exists('b:loaded_golang')
	finish
endif
let b:loaded_golang = 1

function! Golang_gd(word)
	call search('^func\( \+\| *([^()]*) *\)' . a:word, 'b')
endfunction

function! GolangFunctionList()
	normal! mlgg
	belowright new

	setlocal noreadonly modifiable noswapfile nowrap
	setlocal buftype=nowrite
	setlocal bufhidden=delete

	call setline('.', '# Function List')
	wincmd k
	while search('^func\( \+\| *([^()]*) *\)\([^ ()]\+\)', 'W')
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

"autocmd BufWritePost *.go :silent Fmt
