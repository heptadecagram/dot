
set mousehide		" Hide the mouse when typing text

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

set guifont=Monaco:h19

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
