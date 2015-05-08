
if exists('b:did_indent')
	finish
endif
let b:did_indent = 1

setlocal indentkeys+==)
setlocal indentexpr=GetSQLIndent(v:lnum)

function! <SID>CountChar(string, char)
	return count(split(a:string, '\zs'), a:char)
endfunction

function! GetSQLIndent(lnum)
	if a:lnum == 1
		return 0
	endif

	let lnum = prevnonblank(a:lnum - 1)

	let Current = getline(a:lnum)
	let Last = getline(lnum)

	let ind = 0

	if Last =~ '('
		echo "found opening"
		let ind = ind + <SID>CountChar(Last, '(')
	endif
	if Last !~ ';$' && Last =~? '^\s*\(SELECT\|INSERT\|UPDATE\|CREATE\|DELETE\)\>'
		echo "found insertion"
		let ind = ind + 1
	endif
	if Last =~ ';$'
		return 0
	endif
	if Last =~ ')'
		let ind = ind - <SID>CountChar(Last, ')')
	endif
	echo ind

	if Current =~ '^\s*)' && <SID>CountChar(Current, '(') < <SID>CountChar(Current, ')')
		let ind = ind + <SID>CountChar(Current, '(') - <SID>CountChar(Current, ')')
	endif

	return indent(lnum) + &sw * ind
endfunction
