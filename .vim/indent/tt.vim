
" Load the HTML Indentation if it has not yet been loaded
if !exists('*HtmlIndentGet')
	runtime! indent/html.vim
	unlet b:did_indent
endif
if exists("b:did_indent")
	finish
endif
let b:did_indent = 1

let g:blockstart = '\<\%(' . join(['BLOCK', 'CASE', 'CATCH', 'ELSE', 'ELSIF',
			\ 'FILTER', 'FOREACH', 'IF', 'PERL', 'RAWPERL', 'SWITCH', 'TRY',
			\ 'UNLESS', 'WHILE', 'WRAPPER'], '\|') . '\)\>'

setlocal indentexpr=TTIndentGet(v:lnum)
setlocal indentkeys=o,O,*<Return>,<>>,{,},=%],=END,=CASE,=CATCH,=ELSE,=ELSIF

function! TTIndentGet(lnum)
	" Find a non-empty line above the current line.
	let lnum = prevnonblank(a:lnum - 1)

	" Hit the start of the file, use zero indent.
	if lnum == 0
		return 0
	endif

	let ind = 0

	" Adjust indent from any previous line's opening of syntax or blocks
	let prev_line = getline(lnum)
	if prev_line =~ '\[%'
		let ind = ind + 1
	endif
	if prev_line =~ '%]'
		let ind = ind - 1
	endif
	if prev_line =~ '\%(\_^\|\[%-\?\)\s\+' . g:blockstart
		let ind = ind + 1
	endif

	" Adjust for the current line's syntax
	let this_line = getline(a:lnum)
	if this_line =~ '%]' && this_line !~ '\[%'
		let ind = ind - 1
	endif
	if this_line =~ '\%(\_^\|\[%-\?\)\s\+END'
		let ind = ind - 1
	endif
	if this_line =~ '\<\%(CATCH\|ELSE\|ELSIF\)\>'
		let ind = ind - 1
	endif
	if !(exists('g:tt_dedent') && g:tt_dedent == 0) && this_line =~ '\<CASE\>'
		let ind = ind - 1
	endif

	" If HTML has a specific indentation for the line, use that, otherwise use
	" the current indentation
	let html = HtmlIndentGet(a:lnum)
	if html == 0
		let html = indent(lnum)
	endif

	return html + (&sw * ind)
endfunction
