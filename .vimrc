"
" Project  Name: None
" File / Folder: ~/.vimrc
" File Language: vim
" Copyright (C): 2004 Liam Bryan
" First  Author: Liam Bryan
" First Created: 2004.10.16 10:43:13
" Last Modifier: Liam Bryan
" Last Modified: 2005.01.29 08:16:28
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

set nojoinspaces
set incsearch

" Dvorak
noremap t j
noremap n k
noremap s l
noremap j n
noremap gn gk
noremap gt gj

" Kinesis
nmap  b

" One True Brace Style
nmap [[ 99[{
nmap ]] 99]}

" Tab settings
set ts=4
set sw=4
" show the cursor position all the time
set ruler

" Window mappings
set wmh=0
nmap <C-T> <C-W>j<C-W>_
nmap <C-N> <C-W>k<C-W>_
set wmw=0
nmap <C-S> <C-W>l<C-W><BAR>
nmap <C-H> <C-W>h<C-W><BAR>

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
	autocmd FileType text	setlocal textwidth=78

	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	" (happens when dropping a file on gvim).
	autocmd BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line('$') |
			\   execute 'normal g`"' |
			\ endif

endif " has("autocmd")

function UpdateFileLastModified()
	8,9s/Last Modified: [^$].\+/\='Last Modified: ' . strftime('%Y.%m.%d %T')/
endfunction

function CreateFileHeader()
	execute 'normal aProject  Name: ' .
			\ (exists('g:Project_Name') ? g:Project_Name : 'None') . '' .
			\ 'File / Folder: ' .
			\ (exists('g:Project_Path') ? 
			\ substitute(expand('%:p'), g:Project_Path, '', '') :
			\ expand('%') ) . '' .
			\ 'File Language: ' . &syntax . '' .
			\ 'Copyright (C): ' . strftime('%Y') . ' Liam Bryan' . '' .
			\ 'First  Author: Liam Bryan' . '' .
			\ 'First Created: ' . strftime('%Y.%m.%d %T') . '' .
			\ 'Last Modifier: Liam Bryan' . '' .
			\ 'Last Modified: ' . strftime('%Y.%m.%d %T')
endfunction

function NewProgramHeader()
	if strlen(&syntax) < 1
		return
	endif

	let s:comment = matchstr(&comments, '\(\_^\|,\):\zs[^,]\+')
	if &syntax == 'c'
		let s:comment = '/*'
	elseif &syntax == 'inform'
		let s:comment = '!'
	endif

	execute 'normal i' . s:comment . ' '
	call CreateFileHeader()

	if &syntax == 'c'
		normal o/
	endif
	if &syntax == 'perl'
		1substitute'.*'#!/usr/bin/perl'
		$
		append

use strict;
use warnings;

.
	endif
	append

.
endfunction

autocmd BufWritePre,FileWritePre *	kl|silent! call UpdateFileLastModified()|'l

autocmd BufNewFile *	call NewProgramHeader()
