"
" Project  Name: None
" File / Folder: ~/.vimrc
" File Language: vim
" Copyright (C): 2004 Liam Bryan
" First  Author: Liam Bryan
" First Created: 2004.10.16 10:43:13
" Last Modifier: Liam Bryan
" Last Modified: 2005.06.20 14:33:24
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
set history=50		" keep 50 lines of command line history
set incsearch		" do incremental searching
set background=light

set nojoinspaces

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
	7,8s/Last Modifier: [^$].\+/Last Modifier: Liam Bryan/
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
				\ 'Copyright (C): ' . strftime('%Y') . ' Richard Group, Inc.' . '' .
				\ 'First  Author: Liam Bryan' . '' .
				\ 'First Created: ' . strftime('%Y.%m.%d %T') . '' .
				\ 'Last Modifier: Liam Bryan' . '' .
				\ 'Last Modified: ' . strftime('%Y.%m.%d %T')
  append

.

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
	elseif &syntax == 'sh'
		let s:comment = '#'
	endif

	execute 'normal i' . s:comment . ' '
	call CreateFileHeader()

	if &syntax == 'c'
		normal o/
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

autocmd BufNewFile *    call NewProgramHeader()

