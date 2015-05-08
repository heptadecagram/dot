
nmap <silent> lf :call CSharpFunctionList()<CR>

nmap <silent> gd "lyiw :call CSharp_gd(@l)<CR>

let b:match_words = '\s*#\s*region.*$:\s*#\s*endregion'

function! CSharp_gd(word)
	call search('\%(unsafe \)\?\%(\%(public\|internal\|private\|protected\%( internal\)\?\) \)\%(\%(\%(sealed \|abstract \)\?override \)\|\%(new \)\?\%(virtual\|abstract\|static\%( extern\)\? \)\?\)\?\%(void\|\w\+\) ' . a:word . ' \?([^)]*) \?{', 'b')
endfunction

function! CSharpFunctionList()
	normal mlgg
	belowright new

	setlocal noreadonly modifiable noswapfile nowrap
	setlocal buftype=nowrite
	setlocal bufhidden=delete

	call setline('.', '// Function List')
	wincmd k
	while search('\%(unsafe \)\?\%(\%(public\|internal\|private\|protected\%( internal\)\?\) \)\%(\%(\%(sealed \|abstract \)\?override \)\|\%(new \)\?\%(virtual\|abstract\|static\%( extern\)\? \)\?\)\?\%(void\|\w\+\) \(\w\+\) \?([^)]*) \?{', 'W')
		normal $F)%b"ryiw
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

	map <silent> <buffer> <CR> "lyiw:q<CR>:call CSharp_gd(@l)<CR>
endfunction
