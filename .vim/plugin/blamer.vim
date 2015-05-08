
if exists('loaded_blamer') || &cp
    finish
endif
let loaded_blamer=1

" Each command should be a shell command that spits out each line in the
" format of `Revision (Author Date)`, where date is just the calendar date
" (not time).
"Git annotate: git annotate % | awk '{print$1,"("$3,$4")"}'
"SVN annotate: svn annotate -v % | awk '{print$1,"("$2,$3")"}'
"CVS annotate: cvs -q annotate % 2>/dev/null | awk '{print"$1,$2,substr($3,0,11)}'

" TODO:
"   Local modifications annotated in CVS (Git/SVN do it for free)
"   Update annotations when the source buffer changes
"   Version syntax highlighting in the annotation window
"   Bazaar, Mercurial, etc. support

function! CVSAnnotate()
	call Annotate("cvs -q annotate % 2>/dev/null | cut -d: -f1 | tr -s ' '")
endfunction

function! SVNAnnotate()
	call Annotate("svn annotate -v % | awk '{print$1,\"(\"$2,$3\")\"}'")
endfunction

function! GitAnnotate()
	call Annotate("git annotate % | awk '{print$1,\"(\"$3,$4\")\"}'")
endfunction

function! Annotate(command)
	let l:annotation_buffer = "_annotation_" . bufnr('%') . '_' . expand('%')

	if bufnr(l:annotation_buffer) == -1
		let l:command_split = split(escape(a:command, ' "\'), '%', 2)

		setlocal scrollbind nowrap
		let l:current_line = line('.')
		let w:_annotation_link = 1

		execute 'autocmd BufWinLeave ' . expand('%') . ' bwipeout ' . l:annotation_buffer
		execute 'autocmd BufWinLeave ' . l:annotation_buffer . ' buffer ' . expand('%') . '|set wrap& '

		silent execute 'vnew +silent\ %!' . l:command_split[0] . expand('%') . l:command_split[1] . ' ' . l:annotation_buffer

		setlocal ft=none noswapfile nowrap scrollbind buftype=nowrite bufhidden=hide
		let maxsize=max(map(getline(1,'$'), 'len(v:val)'))

		execute 'vert resize ' . maxsize

		nmap <silent> <buffer> <CR> :call ExecuteHighlight()<CR>
		call cursor(l:current_line, 0)

		setlocal readonly nomodifiable winfixwidth
	else
		if bufwinnr(l:annotation_buffer) == -1
			execute 'vsplit +buffer' . bufnr(l:annotation_buffer)

			setlocal noreadonly modifiable
			let maxsize=max(map(getline(1,'$'), 'len(v:val)'))

			execute 'vert resize ' . maxsize
			setlocal readonly nomodifiable winfixwidth
		else
			execute 'buffer ' . l:annotation_buffer
		endif
	endif
endfunction

function! ExecuteHighlight()
	normal mkHmr`k

	let l:lines = s:GetCurrentVersionLines()

	let l:source_buffer = matchstr(expand('%'), '\(_annotation_\)\@<=\(\d*\)')
	let l:history_window = winnr()

	let l:max_window = tabpagewinnr(tabpagenr(), '$')
	while l:max_window > 0 && getwinvar(l:max_window, '_annotation_link') != 1 && winbufnr(l:max_window) != l:source_buffer
		let l:max_window -= 1
	endwhile

	if l:max_window == 0
		return
	endif

	execute l:max_window . 'wincmd w'
	call s:HighlightLines(l:lines)
	execute l:history_window . 'wincmd w'

	normal `rzt`k
endfunction

function! s:HighlightLines(line_numbers)
	let l:line_set = join(map(copy(a:line_numbers), '"\\%" . v:val . "l"'), '\|')
	if l:line_set == get(matcharg(1), 1, "")
		match
	else
		execute 'match Search /' . l:line_set . '/'
	endif
endfunction

function! s:GetCurrentVersionLines()
	let l:current_line = line('.')
	let l:current_column = col('.')
	normal 0"lyf 0gg
	let l:line_numbers = []
	while search('^' . getreg('l'), 'eW', line('$'))
		let l:line_numbers += [line('.')]
	endwhile

	call cursor(l:current_line, l:current_column)
	return l:line_numbers
endfunction
