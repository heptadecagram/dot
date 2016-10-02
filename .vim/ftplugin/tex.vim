
set sw=3
set ts=3

let mapleader='"'

inoremap <buffer> <Leader>c	\chapter{}<LEFT>
inoremap <buffer> <Leader>S	\section{}<LEFT>
inoremap <buffer> <Leader>s	\subsection{}<LEFT>

inoremap <buffer> <Leader>e	\begin{enumerate}\end{enumerate}<UP>
inoremap <buffer> <Leader>i	\begin{itemize}\end{itemize}<UP>
inoremap <buffer> <Leader>d	\begin{description}\end{description}<UP>

inoremap <buffer> <Leader>t	\begin{tabular}{}\end{tabular}<UP><UP><RIGHT><RIGHT><RIGHT>
inoremap <buffer> <Leader>T	\begin{table}\end{table}<UP>

nmap <silent> lf :call TexFunctionList()<CR>
function! TexFunctionList()
	normal mlgg
	leftabove vnew

	setlocal noreadonly modifiable noswapfile nowrap
	setlocal buftype=nowrite
	setlocal bufhidden=delete

	call setline('.', '% Section List')
	wincmd l
	while search('\\\zs\%(sub\)*\%(section\|chapter\)\>', 'W')
		normal "gywf{"ry%
		wincmd h
		call append('$', substitute(substitute(substitute(@g, 'chapter', '', ''), 'section', "\t", ''), 'sub', "\t", 'g') . @r[1:-2])
		wincmd l
	endwhile
	normal 'l

	wincmd h

	silent %s/\t/  /g
	silent %yank
	silent %!awk '{x = (length > x ? length : x)}; END {print x+1}'
	silent put
	silent 1delete

	execute 'vert resize ' . @"[:-2]

	setlocal nomodifiable
	normal t

	map <silent> <buffer> <CR> ^"lY:q<CR>:call Tex_gd(@l)<CR>
endfunction

function! Tex_gd(section)
	call search('\\\%(sub\)*\%(section\|chapter\){' . escape(a:section, '\\') . '}', 'b')
endfunction

"setlocal errorformat=%f:%l:\ %m,%f:%l-%\\d%\\+:\ %m
setlocal makeprg=pdflatex\ -shell-escape\ -interaction\ nonstopmode\ \"%\"

