"
" Project  Name: None
" File / Folder: ~/.vimrc
" File Language: vim
" Copyright (C): 2004 Liam Bryan
" First  Author: Liam Bryan
" First Created: 2004.10.16 10:43:13
" Last Modifier: Liam Echlin
" Last Modified: 2008.04.29
" CVS Committed:
" Compile Flags:
" Ducks Flogged:

" check out
" modeline
" 43.1
" <C-O>
" format-comments
" formatoptions
" mapleader
" noremenu
" command

" Fixings
set nocompatible
if !(&term == 'cons25' || &term == 'xterm' || &term == 'xterm-color')
	fixdel
endif
if &term == 'cons25'
	set t_kb=
	set t_kD=
endif

set cpoptions-=<
set nobackup
set backspace=indent,start
set history=50  " keep 50 lines of command line history
set incsearch   " do incremental searching
set background=light

set nojoinspaces
highlight MatchParen ctermbg=DarkBlue

" Dvorak
noremap t j
noremap n k
noremap s l
noremap j n
noremap gn gk
noremap gt gj

" Kinesis Mappings
nnoremap  b
vnoremap  b

" More logical function
nmap Y y$

" One True Brace Style
nmap [[ 99[{
nmap ]] 99]}

" Tab settings
set ts=2
set sw=2
" show the cursor position all the time
set ruler

" Window mappings
set wmh=0
nmap <C-T> <C-W>j<C-W>_
nmap <C-N> <C-W>k<C-W>_
" Tabbed Editing
nnoremap <C-_> gt
nnoremap <C-S> gt
nnoremap <C-H> gT

let &titlestring = hostname() . ":" . fnamemodify(expand("%:p"), ":~")
let &titleold = hostname()
set title

" Mappings for diffmode, to take or put a change and then immediately move
" to the next difference.
nnoremap do do[c
nnoremap dp dp[c

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
	" Enable file type detection, load indent files.
	filetype plugin indent on

	" For all text files set 'textwidth' to 78 characters.
	autocmd FileType text setlocal textwidth=78

	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	" (happens when dropping a file on gvim).
	autocmd BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line('$') |
			\   execute 'normal g`"' |
			\ endif

endif " has("autocmd")

autocmd BufReadPost *.tt set filetype=html
autocmd BufReadPost *.tt source ~/.vim/syntax/tt2html.vim

autocmd BufReadPost *.t set filetype=perl
autocmd BufReadPost /tmp/* set nobackup|set nowritebackup

function UpdateFileLastModified()
	7,8s/Last Modifier: [^$].\+/Last Modifier: Liam Echlin/
	8,9s/Last Modified: [^$].\+/\='Last Modified: ' . strftime('%Y.%m.%d')/
endfunction

function CreateFileHeader()
	" Autodetect the path if it is not set
	if filereadable(".svn/entries") && !exists('g:Project_Path')
		let g:Project_Name = substitute(system("svn info | sed -n '/^Repository Root/s#.*/\\([^/]*\\)$#\\1#p'"), "\n", '', '')
		let g:Project_Path = substitute(expand("%:p:h"), substitute(substitute(system('grep url= .svn/entries | sed s/\ \ \ url=\"//'), '"\n', '', ''), substitute(system('grep repos= .svn/entries | sed s/\ \ \ repos=\"//'), '"\n', '', '') . '/', '', ''), '', '')
	endif

	execute 'normal aProject  Name: ' .
				\ (exists('g:Project_Name') ? g:Project_Name : 'None') . '' .
				\ 'File / Folder: ' .
				\ (exists('g:Project_Path') ?
				\ substitute(expand('%:p'), g:Project_Path, '', '') :
				\ expand('%') ) . '' .
				\ 'File Language: ' . &syntax . '' .
				\ 'Copyright (C): ' . strftime('%Y') . ' ' . $COPYRIGHT . '' .
				\ 'First  Author: Liam Echlin' . '' .
				\ 'First Created: ' . strftime('%Y.%m.%d') . '' .
				\ 'Last Modifier: Liam Echlin' . '' .
				\ 'Last Modified: ' . strftime('%Y.%m.%d')
  append

.

endfunction


function NewProgramHeader()
	if strlen(&syntax) < 1
		return
	endif

	setlocal formatoptions+=cr

	let s:comment = matchstr(&comments, '\(\_^\|,\):\zs[^,]\+')
	if &syntax == 'c' || &syntax == 'css'
		let s:comment = '/*'
	elseif &syntax == 'python'
		let s:comment = '#'
	endif

	if &syntax == 'html'
		normal i`ht`ti
		return
	endif

	execute 'normal i' . s:comment . ' '
	call CreateFileHeader()

	if &syntax == 'c' || &syntax == 'css'
		normal no/t
	endif
	if &syntax == 'python'
		1substitute'.*'#!/usr/local/bin/python'
	endif
	if &syntax == 'ruby'
		1substitute'.*'#!/usr/local/bin/ruby'
	endif
	if &syntax == 'sh'
		1substitute'.*'#!/bin/sh'
	endif
	if &syntax == 'perl'
		1substitute'.*'#!/usr/bin/perl'
		10append
use strict;
use warnings;

.
		" Modules get a package name automatically
		if -1 < match(expand('%'), '\.pm$')
			let s:module_name = substitute(
						\ exists('g:Project_Path') ?
							\ substitute(expand('%:p'), g:Project_Path, '', '') :
							\ expand('%'),
						\ '/', '::', 'g')
			let s:module_name = strpart(s:module_name, 0, strlen(s:module_name) - 3)
			execute 'normal :10ipackage ' . s:module_name . ';Go1;n'


		endif
	endif
endfunction

autocmd BufWritePre,FileWritePre *  kl|silent! call UpdateFileLastModified()|'l

autocmd BufRead * silent! %s/[\r \t]\+$//

autocmd BufNewFile *    call NewProgramHeader()
