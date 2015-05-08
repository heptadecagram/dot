
nmap <silent> gd "lyiwh"ry :call Perl_gd(@l, @r)<CR>

function! Perl_gd(word, type)
	if a:type == '$' || a:type == '@' || a:type == '%' || a:type == '*'
		call search('my[^=]\+\<' . a:word . '\>', 'b')
	elseif !search('sub ' . a:word . '\>', 'b')
		call search('use.*\<' . a:word . '\>', 'b')
	endif
endfunction

nmap <silent> lf :call PerlFunctionList()<CR>

vnoremap <silent> # :call PerlCommentLine('.')<CR>

function! PerlCommentLine(line_number)
		if match(getline(a:line_number), '^\s*#') != -1
			normal ^x==
		else
			normal I#
		endif
endfunction

function! PerlFunctionList()
	normal mlgg
	belowright new

	setlocal noreadonly modifiable noswapfile nowrap
	setlocal buftype=nowrite
	setlocal bufhidden=delete

	call setline('.', '# Function List')
	wincmd k
	while search('[$@%]\@<!\<sub\s\+[^{]', 'W')
		normal w"ryiw
		if @r == '{'
			continue
		endif
		wincmd j
		call append('$', @r)
		wincmd k
	endwhile
	normal 'l

	wincmd j
	execute 'resize ' . line('$')
	setlocal nomodifiable
	normal t

	map <silent> <buffer> <CR> "lyiw:q<CR>:call Perl_gd(@l, '&')<CR>
endfunction

nmap ,t :call Prove(0)<CR>
nmap ,T :call Prove(1)<CR>
nmap ,v :call Compile()<CR>
nmap ,w :let g:testfile = expand('%',':p'):echo 'testfile is now' g:testfile
nmap ,W :unlet g:testfile:echo 'testfile undefined; will run all tests'


if !exists('*Prove')
	function! Prove(Verbose)
		if !exists('g:testfile')
			let g:testfile = expand('',':p')
		endif
		if g:testfile =~ '/t/' || g:testfile =~ '\.t$'
			set makeprg=prove\ -l
			if a:Verbose
				execute('make -v ' . g:testfile)
			else
				execute('make ' . g:testfile)
			endif
		else
			call Compile()
		endif
	endfunction
endif

if !exists('*Compile')
	function! Compile()
		set makeprg=perl
		make -wc %
	endfunction
endif

set errorformat=
			\%m\ in\ @INC\ (%.%#at\ %f\ line\ %l.
			\,%E%.%#\ \ \ \ \ Failed\ test\ (%f\ at\ line\ %l)
			\,%C#\ %\\+got:\ %m
			\,%Z#\ %\\+expected:\ %m
			\,%C#\ %\\+'%m
			\,%C#\ %\\+'
			\,%Z#\ %\\+doesn't\ match\ '%m'

function! SkipBlock()
	append

=comment

Tests for

=cut

SKIP: {
	skip 'not implemented', 0
		unless(can_ok('ECommerce::', qw(new) ) );

}
.
	normal 8n$
endfunction
