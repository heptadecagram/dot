"
" Project  Name: dot
" File / Folder: .gvimrc
" File Language: vim
" Copyright (C): 2008 Liam Echlin
" First  Author: Liam Echlin
" First Created: 2008.05.02
" Last Modifier: Liam Echlin
" Last Modified: 2008.09.03

set mousehide		" Hide the mouse when typing text

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

set guifont=Monospace\ 13
if exists('&macatsui')
	set nomacatsui
	set guifont=Monaco:h16
endif

set antialias
set lines=40
colorscheme koehler

if has("autocmd")
	autocmd FocusLost *
				\ set cursorcolumn |
				\ set cursorline

	autocmd FocusGained *
				\ set nocursorcolumn |
				\ set nocursorline
endif
