" 
" Project  Name: Vim Settings
" File / Folder: .vim/indent/sql.vim
" File Language: vim
" Copyright (C): 2004 Richard Group, Inc.
" First  Author: Liam Bryan
" First Created: 2004.12.10 10:25:09
" Last Modifier: Liam Bryan
" Last Modified: 2004.12.10 12:38:12

if exists('b:did_indent')
	finish
endif
let b:did_indent = 1

setlocal indentkeys+==)
setlocal indentexpr=GetSQLIndent()

if exists('*GetSQLIndent')
	finish
endif

function GetSQLIndent()
	if v:lnum == 1
		return 0
	endif

	let Current = getline(v:lnum)
	let lnum = prevnonblank(v:lnum - 1)
	let Last = getline(lnum)
	let Indent = indent(lnum)

	if Last =~ '([^)]*$'
		let Indent = Indent + &sw
	elseif Last !~ ';$' &&
			Last =~? '^\s*\(SELECT\|INSERT\|UPDATE\|CREATE\|DELETE\)\>'
		let Indent = Indent + &sw
	endif
	if Last =~ ';$'
		let Indent = Indent - &sw
	endif

	if Current =~ '^\s*)'
		let Indent = Indent - &sw
	endif

	return Indent
endfunction
