"
" Project  Name: Vim Settings
" File / Folder: .vim/ftplugin/html.vim
" File Language: vim
" Copyright (C): 2004 Liam Bryan
" First  Author: Liam Bryan
" First Created: 2004.11.17 09:57:23
" Last Modifier: Liam Echlin
" Last Modified: 2008.06.02

if exists('b:loaded_html')
	finish
endif
let b:loaded_html = 1

" Update an image tag's WIDTH & HEIGHT attributes (experimental!):
runtime! MangleImageTag.vim
if exists("*MangleImageTag")
	nnoremap ;mi :call MangleImageTag()<CR>
endif

let maplocalleader='&'

inoremap <buffer> <LocalLeader>& &amp;
inoremap <buffer> <LocalLeader>. &hellip;
inoremap <buffer> <LocalLeader>- &mdash;
inoremap <buffer> <LocalLeader>/ &frasl;
inoremap <buffer> <LocalLeader>< &lt;
inoremap <buffer> <LocalLeader>> &gt;
inoremap <buffer> <LocalLeader>c &copy;
inoremap <buffer> <LocalLeader>r &reg;
inoremap <buffer> <LocalLeader><SPACE> &nbsp;

let mapleader='`'

inoremap <buffer> <Leader><CR> o

imap <buffer> <Leader>cm <!--  -->bhi
vmap <buffer> <Leader>cm `>a -->`<i<!--

" Template::Toolkit mappings
imap <buffer> <Leader>tt [%  %]hhi
imap <buffer> <Leader>tg [% GET  %]hhi
imap <buffer> <Leader>tc [% CALL  %]hhi
imap <buffer> <Leader>ts [% SET  %]hhi
"imap <buffer> <Leader>ti [% INSERT  %]hhi
"imap <buffer> <Leader>ti [% INCLUDE  %]hhi
imap <buffer> <Leader>tp [% PROCESS  %]hhi
imap <buffer> <Leader>tw [% WRAPPER %][% END %]nnA
vmap <buffer> <Leader>tw `>o[% END %]`<O[% WRAPPER %]nA
"imap <buffer> <Leader>tb [% BLOCK  %][% END %]na
"vmap <buffer> <Leader>tb `>o[% END %]`<O[% BLOCK  %]hhi
imap <buffer> <Leader>tf [% IF  %][% END %]nhhi
imap <buffer> <Leader>tef [% ELSIF  %]hhi
imap <buffer> <Leader>tel [% ELSE  %]hhi
imap <buffer> <Leader>tu [% UNLESS  %][% END %]nssi
"imap <buffer> <Leader>ts [% SWITCH  %][% END %]nssi
"imap <buffer> <Leader>tc [% CASE  %]hhi
"imap <buffer> <Leader>tf [% FOREACH  IN  %][% END %]nwhi
"imap <buffer> <Leader>tn [% NEXT  %]hhi
"imap <buffer> <Leader>tl [% LAST  %]hhi
"imap <buffer> <Leader>tf [% FILTER  %]hhi
"imap <buffer> <Leader>tu [% USE  %]hhi
"imap <buffer> <Leader>tm [% MACRO  %]hhi
"


imap <buffer> <Leader>ht <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN""http://www.w3.org/TR/html4/strict.dtd"><html><head></head><body></body></html>3nO

imap <buffer> <Leader>ti <title></title>bba
vmap <buffer> <Leader>ti `>a</title>`<i<title>

imap <buffer> <Leader>sc <script type="text/javascript"><!----></script>nO

imap <buffer> <Leader>sy <style type="text/css"><!----></style>nO

imap <buffer> <Leader>ln <link href="" rel="" type=""/>BBhhi

imap <buffer> <Leader>h1 <h1></h1>bba
vmap <buffer> <Leader>h1 `>a</h3>`<i<h3>
imap <buffer> <Leader>h2 <h2></h2>bba
vmap <buffer> <Leader>h2 `>a</h2>`<i<h2>
imap <buffer> <Leader>h3 <h3></h3>bba
vmap <buffer> <Leader>h3 `>a</h3>`<i<h3>
imap <buffer> <Leader>h4 <h4></h4>bba
vmap <buffer> <Leader>h4 `>a</h4>`<i<h4>
imap <buffer> <Leader>h5 <h5></h5>bba
vmap <buffer> <Leader>h5 `>a</h5>`<i<h5>

imap <buffer> <Leader>fm <form action="" method="post"></form>BBhhi
imap <buffer> <Leader>ff <fieldset></fieldset>O
imap <buffer> <Leader>la <label></label>nA
vmap <buffer> <Leader>la `>a</label>`<i<label>
imap <buffer> <Leader>le <legend></legend>bba
vmap <buffer> <Leader>le `>a</legend>`<i<legend>
imap <buffer> <Leader>fe <select name=""></select>Bbsa

imap <buffer> <Leader>fo <option value="">OPTION</option>Bwsa
vmap <buffer> <Leader>fo `>a</option>`<i<option value="">Bwsa

imap <buffer> <Leader>ft <input name="" value="" maxlength="255"/>B`n a
vmap <buffer> <Leader>ft `>a" maxlength="255"/>`<i<input name="" value="`n a

imap <buffer> <Leader>fh <input type="hidden" name="" value=""/>B`n a
imap <buffer> <Leader>fs <input type="submit" value=""/>hhi
imap <buffer> <Leader>fr <input type="radio" name="" value=""/>B`n a
imap <buffer> <Leader>fc <input type="checkbox" name="" value=""/>B`n a
imap <buffer> <Leader>fb <input type="button" name="" value=""/>B`n a
imap <buffer> <Leader>fx <textarea rows="6" cols="60"></textarea>bhhi
imap <buffer> <Leader>fp <input type="password" name="" value="" maxlength="255"/>B`n a

imap <buffer> <Leader>bu <button></button>bba
vmap <buffer> <Leader>bu `>a</button>`<i<button>

imap <buffer> <Leader>im <img src="" alt=""/>Bhhi

imap <buffer> <Leader>ol <ol></ol>O
imap <buffer> <Leader>ul <ul></ul>O
imap <buffer> <Leader>dl <dl></dl>O
imap <buffer> <Leader>li <li></li>bba
vmap <buffer> <Leader>li `>a</li>`<i<li>
imap <buffer> <Leader>dt <dt></dt>bba
imap <buffer> <Leader>dd <dd></dd>bba

imap <buffer> <Leader>pp <p></p>bba
vmap <buffer> <Leader>pp `>a</p>`<i<p>

imap <buffer> <Leader>qq <q lang="en-US"></q>Bwla
vmap <buffer> <Leader>qq `>a</q>`<i<q lang="en-US">

imap <buffer> <Leader>aa <a href="">LINK</a>Bwla
vmap <buffer> <Leader>aa `>a</a>`<i<a href="">hi

imap <buffer> <Leader>bb <b></b>bba
vmap <buffer> <Leader>bb `>a</b>`<i<b>
imap <buffer> <Leader>ii <i></i>bba
vmap <buffer> <Leader>ii `>a</i>`<i<i>

imap <buffer> <Leader>di <div></div>O
vmap <buffer> <Leader>di `>a</div>`<i<div>

imap <buffer> <Leader>st <strong></strong>bba
vmap <buffer> <Leader>st `>a</strong>`<i<strong>

imap <buffer> <Leader>em <em></em>bba
vmap <buffer> <Leader>em `>a</em>`<i<em>

imap <buffer> <Leader>sp <span></span>bba
vmap <buffer> <Leader>sp `>a</span>`<i<span>

imap <buffer> <Leader>ci <cite></cite>bba
vmap <buffer> <Leader>ci `>a</cite>`<i<cite>

imap <buffer> <Leader>hr <hr/>
imap <buffer> <Leader>br <br/>

imap <buffer> <Leader>ta :call TableMaker()<LEFT>
imap <buffer> <Leader>ca <caption></caption>bhhi
imap <buffer> <Leader>tb <tbody></tbody>no
imap <buffer> <Leader>tr <tr></tr>no
imap <buffer> <Leader>td <td></td>bhhi
vmap <buffer> <Leader>td `>a</td>`<i<td>
imap <buffer> <Leader>th <th></th>bhhi
imap <buffer> <Leader>cg <colgroup></colgroup>no
imap <buffer> <Leader>co <col/>

function! FindCurrentTag()
	call search('<\|>', 'b')
	call searchpair('<', '', '>', 'b')
	call search('\S')
	normal "lyw
	return @l
endfunction

imap <buffer> <Leader>i<SPACE> :silent call HTMLAttribute('id')<CR>
nmap <buffer> <Leader>i<SPACE> :silent call HTMLAttribute('id')<CR>

imap <buffer> <Leader>a<SPACE> :silent call HTMLAttribute('alt')<CR>
nmap <buffer> <Leader>a<SPACE> :silent call HTMLAttribute('alt')<CR>

imap <buffer> <Leader>h<SPACE> :silent call HTMLAttribute('href')<CR>
nmap <buffer> <Leader>h<SPACE> :silent call HTMLAttribute('href')<CR>

imap <buffer> <Leader>n<SPACE> :silent call HTMLAttribute('name')<CR>
nmap <buffer> <Leader>n<SPACE> :silent call HTMLAttribute('name')<CR>

imap <buffer> <Leader>v<SPACE> :silent call HTMLAttribute('value')<CR>
nmap <buffer> <Leader>v<SPACE> :silent call HTMLAttribute('value')<CR>

imap <buffer> <Leader>s<SPACE> :silent call HTMLAttribute('src')<CR>
nmap <buffer> <Leader>s<SPACE> :silent call HTMLAttribute('src')<CR>

imap <buffer> <Leader>c<SPACE> :silent call HTMLAttribute('class')<CR>
nmap <buffer> <Leader>c<SPACE> :silent call HTMLAttribute('class')<CR>

imap <buffer> <Leader>e<SPACE> :silent call HTMLAttribute('escape')<CR>
nmap <buffer> <Leader>e<SPACE> :silent call HTMLAttribute('escape')<CR>

imap <buffer> <Leader>y<SPACE> :silent call HTMLAttribute('style')<CR>
nmap <buffer> <Leader>y<SPACE> :silent call HTMLAttribute('style')<CR>

function! HTMLAttribute(attribute)
	let Current_Tag = FindCurrentTag()
	call searchpair('<', a:attribute, '/\=>')
	normal "lyl
	if getreg('l') == '>' || getreg('l') == '/'
		if Current_Tag == '!-- '
			normal bh
		endif
		execute 'normal i ' . a:attribute . '=""'
		startinsert
	else
		normal wss
		startinsert
	endif
endfunction

function! Lisp2HTML()
	call searchpair('(', '', ')', 'b')
	normal s"lyw aoeu
	if getreg('l') == 'doctype'
		normal! w"lyt hl
		if getreg('l') == '4.01'
			insert
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN""http://www.w3.org/TR/html4/strict.dtd">
.
		endif
	endif
endfunction


" HTML helper macros
map <F2> :call TableMaker()<LEFT>
" TableMaker( [rows = 1 [, cols = 1] ] )
function! TableMaker(...)
	let Cols = 1
	let Rows = 1
	if a:0 == 1
		let Cols = a:1
	endif
	if a:0 == 2
		let Rows = a:2
		let Cols = a:1
	endif

	normal o<table>

	while Rows > 0
		normal o<tr>

		let idx = Cols
		while idx > 0
			normal o<td></td>
			let idx = idx - 1
		endwhile

		normal o</tr>
		let Rows = Rows - 1
	endwhile

	normal o</table>?<tablettw

endfunction "TableMaker()
