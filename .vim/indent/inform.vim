" 
" Project  Name: Vim Settings
" File / Folder: .vim/indent.vim
" File Language: vim
" Copyright (C): 2004 Liam Bryan
" First  Author: Liam Bryan
" First Created: 2004.12.03 14:49:50
" Last Modifier: Liam Bryan
" Last Modified: 2004.12.06 21:50:49

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetInformIndent()
setlocal indentkeys+==],=},=with,=has

" Only define the function once.
if exists("*GetInformIndent")
  finish
endif

function GetInformIndent()
  " At the start of the file use zero indent.
  if v:lnum == 1
    return 0
  endif

  " Find a non-blank line above the current line.
  let lnum = prevnonblank(v:lnum - 1)

  let Current = getline(v:lnum)
  let Indent = indent(lnum)

  " String continuations get set to same indent indent
  if synIDattr(synID(lnum, strlen(getline(lnum) ), 0), "name") =~? 'string'
	return Indent
  endif
  " String continuations' ends get set to what it was previously
  while synIDattr(synID(lnum, 1, 0), "name") =~? 'string'
	let lnum = prevnonblank(lnum - 1)
	let Indent = indent(lnum)
  endwhile

  if Current =~? '^\s*\(Verb\|Object\|with\|has\)\>'
	return 0
  endif

  "if searchpair(')
  "
  let Last = getline(lnum)

  " Add a 'shiftwidth' after Verb, with, has, if, else, switch, for
  if Last =~? '^\s*\(Object\|Verb\|with\|has\|if\|else\|case\)\>'
    let Indent = Indent + &sw
  elseif Last =~ '[\[{:]$'
    let Indent = Indent + &sw
  elseif Last =~ '^\s*\['
    let Indent = Indent + &sw
  endif

"  if Last =~ ';$'
"	if Indent == &sw
"	  let Indent = 0
"	elseif getline(lnum) =~ '^\s\(if\|else\)\>' && getline(lnum) !~ '[\[{]$'
"	  let Indent = Indent - &sw
"	endif
"  endif

  " Subtract a 'shiftwidth' on a grouping's end
  if Current =~ '^\s*[}\]]'
    let Indent = Indent - &sw
  elseif Current =~ ':$'
	let Indent = Indent - &sw
  endif

  return Indent
endfunction
