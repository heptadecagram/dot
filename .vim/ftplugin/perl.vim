" 
" Project  Name: Vim Settings
" File / Folder: .vim/ftplugin/perl.vim
" File Language: vim
" Copyright (C): 2004 Liam Bryan
" First  Author: Liam Bryan
" First Created: 2004.10.21 18:40:00
" Last Modifier: Liam Bryan
" Last Modified: 2005.03.23 14:28:02

nmap <silent> gd "lyiwh"ry :call Perl_gd(@l, @r)<CR>

function! Perl_gd(word, type)
	if a:type == '$' || a:type == '@' || a:type == '%' || a:type == '*'
		call search('my[^=]\+\<' . a:word . '\>', 'b')
	elseif !search('sub ' . a:word . '\>', 'b')
		call search('use.*\<' . a:word . '\>', 'b')
	endif
endfunction


nmap ,t :call Prove(0)
nmap ,T :call Prove(1)
nmap ,v :call Compile()
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
