
set sw=8
set ts=8

let mapleader='"'

inoremap <buffer> <Leader>c	\chapter{}<LEFT>
inoremap <buffer> <Leader>S	\section{}<LEFT>
inoremap <buffer> <Leader>s	\subsection{}<LEFT>

inoremap <buffer> <Leader>e	\begin{enumerate}\end{enumerate}<UP>
inoremap <buffer> <Leader>i	\begin{itemize}\end{itemize}<UP>

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
	while search('\\\zs\%(sub\)*section\>', 'W')
		normal "gywf{"ry%
		wincmd h
		call append('$', substitute(@g[:-8], 'sub', "\t", 'g') . @r[1:-2])
		wincmd l
	endwhile
	normal 'l

	wincmd h

	silent %yank
	silent %s/\t/  /g
	silent %!wc -L
	silent put
	silent 1delete

	execute 'vert resize ' . @"[:-2]

	setlocal nomodifiable
	normal t

	map <silent> <buffer> <CR> ^"lY:q<CR>:call Tex_gd(@l)<CR>
endfunction

function! Tex_gd(section)
	call search('\\\%(sub\)*section{' . a:section . '}', 'b')
endfunction

"setlocal errorformat=%f:%l:\ %m,%f:%l-%\\d%\\+:\ %m
setlocal makeprg=pdflatex\ -shell-escape\ -interaction\ nonstopmode\ \"%\"

