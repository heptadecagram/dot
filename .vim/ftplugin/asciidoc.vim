vim9script

setlocal sw=4
setlocal ts=4
setlocal noet

setlocal makeprg=asciidoctor-pdf\ \"%\"

def AsciidocSectionList()
	const saved = winsaveview()
	leftabove vnew

	setlocal noreadonly modifiable noswapfile nowrap
	setlocal buftype=nowrite
	setlocal bufhidden=delete

	setline('.', '// Section List')
	var max_length = strlen(getline('.'))
	wincmd l

	cursor(1, 1)
	while search('^=', 'cW') > 0
		normal! "ly$j
		wincmd h
		append('$', substitute(substitute(@l[1 : ], '=', "\t", 'g'), ' ', '', ''))
		max_length = max([max_length, strlen(@l)])
		wincmd l
	endwhile
	winrestview(saved)

	wincmd h

	setlocal expandtab
	retab 2

	execute 'vert resize ' .. max_length

	setlocal nomodifiable
	normal! j

	map <silent> <buffer> <CR> ^"lY:q<CR>:silent call <SID>Asciidoc_gd(@l)<CR>
enddef
nmap <buffer> <silent> lf :silent call <SID>AsciidocSectionList()<CR>

def Asciidoc_gd(section: string)
	search('\%(=\)\+ ' .. escape(section, '\\'), 'b')
enddef
