" 
" Project  Name: None
" File / Folder: .vim\ftplugin\cs.vim
" File Language: vim
" Copyright (C): 2006 Richard Group, Inc.
" First  Author: Liam Bryan
" First Created: 2006.02.28 
" Last Modifier: Liam Bryan
" Last Modified: 2006.02.28 

nmap <silent> lf :call CSharpFunctionList()<CR>

nmap <silent> gd "lyiw :call CSharp_gd(@l)<CR>

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
