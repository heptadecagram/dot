
autocmd BufNewFile,BufRead	~/.vim/*
			\   let g:Project_Path = expand('~/')
			\ | let g:Project_Name = 'Vim Settings'

" Personal
autocmd BufNewFile,BufRead	~/wind/*
			\   let g:Project_Path = expand('~/wind/')
			\ | let g:Project_Name = 'wind'
