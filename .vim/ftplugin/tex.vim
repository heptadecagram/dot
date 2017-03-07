
set sw=3
set ts=3

let mapleader='"'

inoremap <buffer> <Leader>c	\chapter{}<LEFT>
vnoremap <buffer> <Leader>c	<ESC>`>a}<ESC>`<i\chapter{<ESC>

inoremap <buffer> <Leader>S	\section{}<LEFT>
vnoremap <buffer> <Leader>S	<ESC>`>a}<ESC>`<i\section{<ESC>

inoremap <buffer> <Leader>s	\subsection{}<LEFT>
vnoremap <buffer> <Leader>s	<ESC>`>a}<ESC>`<i\subsection{<ESC>

inoremap <buffer> <Leader>e	\begin{enumerate}\end{enumerate}<UP>
" TODO: Make each non-blank line that doesn't start with \item get prepended
" with \item
vnoremap <buffer> <Leader>e	<ESC>`>o\end{enumerate}<ESC>`<O\begin{enumerate}<ESC>0

inoremap <buffer> <Leader>i	\begin{itemize}\end{itemize}<UP>
" TODO: Make each non-blank line that doesn't start with \item get prepended
" with \item
vnoremap <buffer> <Leader>i	<ESC>`>o\end{itemize}<ESC>`<O\begin{itemize}<ESC>0

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
setlocal makeprg=xelatex\ -shell-escape\ -interaction\ nonstopmode\ \"%\"

