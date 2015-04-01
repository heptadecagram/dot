" Take a look at:
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

set t_te= t_ti=

set cpoptions-=<
set nobackup
set backspace=indent,start
set history=50  " keep 50 lines of command line history
set incsearch   " do incremental searching
set background=light

set nojoinspaces
highlight MatchParen ctermbg=DarkBlue

function Kinesis()
	" Dvorak
	noremap t j
	noremap n k
	noremap s l
	noremap j n
	noremap gn gk
	noremap gt gj

	" Kinesis Mappings
	nnoremap <CR> b
	vnoremap <CR> b
endfunction

function DeKinesis()
	" Dvorak
	unmap t
	unmap n
	unmap s
	unmap j
	unmap gn
	unmap gt

	" Kinesis Mappings
	nunmap <CR>
	vunmap <CR>
endfunction

if executable('lsusb')
	if strlen(system('lsusb | grep Kinesis')) > 8
		call Kinesis()
	endif
	endif
if executable('system_profiler')
	if strlen(system('system_profiler SPUSBDataType | grep Kinesis')) > 8
		call Kinesis()
	endif
endif

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
" Adding the control keys to hjkl jump to the window and make it full-screen
nmap <C-J> <C-W>j<C-W>_
nmap <C-K> <C-W>k<C-W>_
" Move between windows using arrow keys
nnoremap <left> <C-W>h
nnoremap <right> <C-W>l
nnoremap <up> <C-W>k
nnoremap <down> <C-W>j

" Move between tabs using shifted arrow keys
" Note: Getting these to work in Mac Terminal involved checking terminfo
" for a terminal that supported kRIT and kLFT (xterm), and adding the
" input strings to Terminal's keycombo settings.
nnoremap <S-left> gT
nnoremap <S-right> gt

let &titlestring = hostname() . ":" . fnamemodify(expand("%:p"), ":~")
let &titleold = hostname()
set title

" Mappings for diffmode, to take or put a change and then immediately move
" to the next difference.
nnoremap do do]c
nnoremap dp dp]c

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

set runtimepath+=$GOROOT/misc/vim

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

autocmd BufEnter *.go set filetype=go

autocmd BufEnter *.mkd set filetype=mkd

autocmd BufEnter *.tt set filetype=html
autocmd BufEnter *.tt set filetype=tt
autocmd BufEnter *.tt source ~/.vim/syntax/tt2html.vim

autocmd BufEnter /tmp/* set nobackup|set nowritebackup


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

	if &syntax == 'html' || &syntax == 'tt'
		normal i`ht`ti
		return
	endif

	if &syntax == 'c' || &syntax == 'cpp'
		if match(expand('%'), '.h$')
			1append

#ifndef
# define



#endif
.
			let header = toupper(substitute(expand('%'), '\.', '_', ''))
			2substitute'$'\=" " . header '
			3substitute'$'\=" " . header '
			5
		else
			1append



main(int argc, char *argv[])
{

	return 0;
}
.
			" Prevent vim from thinking the return value is the :intro call
			4substitute'^'int '
			2
		endif
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
		1append

use strict;
use warnings;
use 5.20.0;

.
		" Modules get a package name automatically
		if -1 < match(expand('%'), '\.pm$')
			let s:module_name = substitute(
						\ exists('g:Project_Path') ?
							\ substitute(expand('%:p'), g:Project_Path, '', '') :
							\ expand('%'),
						\ '/', '::', 'g')
			let s:module_name = strpart(s:module_name, 0, strlen(s:module_name) - 3)
			execute 'normal :2ipackage ' . s:module_name . ';Go1;n'
		endif

	endif
endfunction

"autocmd BufWritePre,FileWritePre *  kl|silent! call UpdateFileLastModified()|'l

autocmd BufRead *   silent! %s/[\r \t]\+$//

autocmd BufNewFile *   call NewProgramHeader()

function! TabComplete()
	if !strlen(&omnifunc) || strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$' || exists(&paste)
		return "\<Tab>"
	else
		return "\<C-X>\<C-O>"
	endif
endfunction
inoremap <Tab> <C-R>=TabComplete()<CR>

function! SyntaxItem()
	return synIDattr(synID(line("."),col("."),1),"name")
endfunction
