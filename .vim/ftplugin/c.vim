
inoremap <buffer> #I #include <.h>hhi
inoremap <buffer> #i #include ".h"hhi

inoremap <buffer> #d #define<SPACE>
inoremap <buffer> #f #ifdef<SPACE>
inoremap <buffer> #e #else<SPACE>
inoremap <buffer> #n #endif<SPACE>

nmap <silent> lf :call CFunctionList()<CR>
nmap <silent> gd "lyiw :call C_gd(@l)<CR>

function! C_gd(word)
	call search('^\S.*\<' . a:word . '\>(.*)$', 'b')
endfunction

function! CFunctionList()
	normal mlgg
	belowright new

	setlocal noreadonly modifiable noswapfile nowrap
	setlocal buftype=nowrite
	setlocal bufhidden=delete

	call setline('.', '// Function List')
	wincmd k
	while search('^\S.*\(\S*\)(.*)$', 'W')
		normal $%b"ryiw
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

	map <silent> <buffer> <CR> "lyiw:q<CR>:call C_gd(@l)<CR>
endfunction
