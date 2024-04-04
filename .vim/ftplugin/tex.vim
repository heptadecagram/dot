vim9script

setlocal sw=3
setlocal ts=3
setlocal noet

#setlocal errorformat=%f:%l:\ %m,%f:%l-%\\d%\\+:\ %m
setlocal makeprg=xelatex\ -shell-escape\ -interaction\ nonstopmode\ \"%\"

g:mapleader = '"'

inoremap <buffer> <Leader>c	\chapter{}<LEFT>
vnoremap <buffer> <Leader>c	<ESC>`>a}<ESC>`<i\chapter{<ESC>

inoremap <buffer> <Leader>S	\section{}<LEFT>
vnoremap <buffer> <Leader>S	<ESC>`>a}<ESC>`<i\section{<ESC>

inoremap <buffer> <Leader>s	\subsection{}<LEFT>
vnoremap <buffer> <Leader>s	<ESC>`>a}<ESC>`<i\subsection{<ESC>

inoremap <buffer> <Leader>e	\begin{enumerate}\end{enumerate}<UP>
# TODO: Make each non-blank line that doesn't start with \item get prepended with \item
vnoremap <buffer> <Leader>e	<ESC>`>o\end{enumerate}<ESC>`<O\begin{enumerate}<ESC>0

inoremap <buffer> <Leader>i	\begin{itemize}\end{itemize}<UP>
# TODO: Make each non-blank line that doesn't start with \item get prepended with \item
vnoremap <buffer> <Leader>i	<ESC>`>o\end{itemize}<ESC>`<O\begin{itemize}<ESC>0

inoremap <buffer> <Leader>d	\begin{description}\end{description}<UP>

inoremap <buffer> <Leader>t	\begin{tabular}{}\end{tabular}<UP><UP><RIGHT><RIGHT><RIGHT>
inoremap <buffer> <Leader>T	\begin{table}\end{table}<UP>

nmap <buffer> <silent> lf :silent call <SID>TexFunctionList()<CR>
def TexFunctionList()
	const saved = winsaveview()
	leftabove vnew

	setlocal noreadonly modifiable noswapfile nowrap
	setlocal buftype=nowrite
	setlocal bufhidden=delete

	call setline('.', '% Section List')
	var max_length = strlen(getline('.'))
	wincmd l

	cursor(0, 0)
	while search('\\\zs\%(sub\)*\%(section\|chapter\)\>', 'W') > 0
		normal! "lywf{"ry%
		wincmd h
		append('$', substitute(substitute(substitute(@l, 'chapter', '', ''), 'section', ' ', ''), 'sub', ' ', 'g') .. @r[1 : -2])
		max_length = max([max_length, strlen(getline('$'))])
		wincmd l
	endwhile
	winrestview(saved)

	wincmd h

	execute 'vert resize ' .. (1 + max_length)

	setlocal nomodifiable
	normal! j

	map <silent> <buffer> <CR> ^"lY:q<CR>:silent call <SID>Tex_gd(@l)<CR>
enddef

def Tex_gd(section: string)
	search('\\\%(sub\)*\%(section\|chapter\){' .. escape(section, '\\') .. '}', 'b')
enddef
