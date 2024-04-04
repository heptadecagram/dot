vim9script

inoremap <buffer> #I #include <.h>hhi
inoremap <buffer> #i #include ".h"hhi

inoremap <buffer> #d #define<SPACE>
inoremap <buffer> #f #ifdef<SPACE>
inoremap <buffer> #e #else<SPACE>
inoremap <buffer> #n #endif<SPACE>

def CFunctionList()
	const saved = winsaveview()
	belowright new

	setlocal noreadonly modifiable noswapfile nowrap
	setlocal buftype=nowrite
	setlocal bufhidden=delete

	setline('.', '// Function List')
	wincmd k

	cursor(0, 0)
	while search('^\S.*\(\S*\)(.*)$', 'W') > 0
		normal $%b"lyiw
		if @l == '{'
			continue
		endif
		wincmd j
		append('$', @l)
		wincmd k
	endwhile
	winrestview(saved)

	wincmd j
	execute 'resize ' .. line('$')
	setlocal nomodifiable
	normal! j

	map <silent> <buffer> <CR> "lyiw:q<CR>:silent call <SID>C_gd(@l)<CR>
enddef
nmap <silent> lf :silent call <SID>CFunctionList()<CR>

def C_gd(word: string)
	search('^\S.*\<' .. word .. '\>(.*)$', 'b')
enddef

nmap <silent> gd "lyiw :silent call <SID>C_gd(@l)<CR>
