
if exists('b:loaded_html')
	finish
endif
let b:loaded_html = 1

let maplocalleader='&'

inoremap <buffer> <LocalLeader>& &amp;
inoremap <buffer> <LocalLeader>. &hellip;
inoremap <buffer> <LocalLeader>- &ndash;
inoremap <buffer> <LocalLeader>/ &frasl;
inoremap <buffer> <LocalLeader>< &lt;
inoremap <buffer> <LocalLeader>> &gt;
inoremap <buffer> <LocalLeader>c &copy;
inoremap <buffer> <LocalLeader>r &reg;
inoremap <buffer> <LocalLeader>x &times;
inoremap <buffer> <LocalLeader><RIGHT> &rarr;
inoremap <buffer> <LocalLeader><LEFT> &larr;
inoremap <buffer> <LocalLeader><SPACE> &nbsp;

let mapleader='`'

" When typing, hit `-<Enter> to hop to the next line
inoremap <buffer> <Leader><CR> o

imap <buffer> <Leader>cm <!--  -->bhi
vmap <buffer> <Leader>cm `>a -->`<i<!--


imap <buffer> <Leader>ht <!DOCTYPE html><html><head><title></title><meta charset="utf-8"></head><body></body></html>:7o


" NOTE: Using <expr> when defining these mappings would, indeed, be
" less buggy, error-prone, and expandable, but <expr> does not allow
" cursor movement, which is part of what makes these so pleasant to use.
"
inoremap <buffer> <Leader>sc <script type="text/javascript"><!----></script>nO

inoremap <buffer> <Leader>sy <style type="text/css"><!----></style>nO

imap <buffer> <Leader>ln <link href="" rel="" type="">BBhhi


" HTML5 elements
" <section>
" <nav>
" <article>
" <aside>
" <hgroup>
" <header>
" <footer>
" <time>
" <mark>

imap <buffer> <Leader>he <header></header>O
vmap <buffer> <Leader>he `>a</header>`<i<header>

imap <buffer> <Leader>hg <hgroup></hgroup>O
vmap <buffer> <Leader>hg `>a</hgroup>`<i<hgroup>

imap <buffer> <Leader>ar <article></article>O
vmap <buffer> <Leader>ar `>a</article>`<i<article>

imap <buffer> <Leader>se <section></section>O
vmap <buffer> <Leader>se `>a</section>`<i<section>

imap <buffer> <Leader>ti <time></time>bba
vmap <buffer> <Leader>ti `>a</time>`<i<time>

imap <buffer> <Leader>na <nav></nav>O
vmap <buffer> <Leader>na `>a</nav>`<i<nav>

imap <buffer> <Leader>fo <footer></footer>bba
vmap <buffer> <Leader>fo `>a</footer>`<i<footer>


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

imap <buffer> <Leader>oo <option value="">OPTION</option>Bwsa
vmap <buffer> <Leader>oo `>a</option>`<i<option value="">Bwsa

imap <buffer> <Leader>ft <input name="" value="" maxlength="255">B`n a
vmap <buffer> <Leader>ft `>a" maxlength="255">`<i<input name="" value="`n a

" placeholder="Placeholder text"
" autofocus="autofocus"
" novalidate="novalidate"
" required="required"
" <input type="email">
" <input type="url">
" <input type="number" min="0" max="10" step="2" value="6"> Spinbox
" <input type="range" min="0" max="10" step="2" value="6"> Slider
" <input type="date, datetime, datetime-local, month, week, time">
" <input type="search">
" <input type="color">
imap <buffer> <Leader>fh <input type="hidden" name="" value="">B`n a
imap <buffer> <Leader>fs <input type="submit" value="">hhi
imap <buffer> <Leader>fr <input type="radio" name="" value="">B`n a
imap <buffer> <Leader>fc <input type="checkbox" name="" value="">B`n a
imap <buffer> <Leader>fb <input type="button" name="" value="">B`n a
imap <buffer> <Leader>fx <textarea rows="6" cols="60"></textarea>bhhi
imap <buffer> <Leader>fp <input type="password" name="" value="" maxlength="255">B`n a

imap <buffer> <Leader>bu <button></button>bba
vmap <buffer> <Leader>bu `>a</button>`<i<button>

imap <buffer> <Leader>im <img src="" alt="">Bhhi

imap <buffer> <Leader>ol <ol></ol>O
imap <buffer> <Leader>ul <ul></ul>O
imap <buffer> <Leader>dl <dl></dl>O
imap <buffer> <Leader>li <li></li>bba
vmap <buffer> <Leader>li `>a</li>`<i<li>
imap <buffer> <Leader>dt <dt></dt>bba
imap <buffer> <Leader>dd <dd></dd>bba

imap <buffer> <Leader>cd <code></code>bba
vmap <buffer> <Leader>cd `>a</code>`<i<code>

imap <buffer> <Leader>pp <p></p>bba
vmap <buffer> <Leader>pp `>a</p>`<i<p>

imap <buffer> <Leader>as <aside></aside>bba
vmap <buffer> <Leader>as `>a</aside>`<i<aside>

imap <buffer> <Leader>bq <blockquote></blockquote>O

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

imap <buffer> <Leader>dn <dfn></dfn>bba
vmap <buffer> <Leader>dn `>a</dfn>`<i<dfn>

imap <buffer> <Leader>ci <cite></cite>bba
vmap <buffer> <Leader>ci `>a</cite>`<i<cite>
imap <buffer> <Leader>df <dfn></dfn>bba
vmap <buffer> <Leader>df `>a</dfn>`<i<dfn>

imap <buffer> <Leader>hr <hr>
imap <buffer> <Leader>br <br>

imap <buffer> <Leader>ta :call TableMaker()<LEFT>
imap <buffer> <Leader>ca <caption></caption>bhhi
imap <buffer> <Leader>tb <tbody></tbody>O
imap <buffer> <Leader>tf <tfoot></tfoot>O
imap <buffer> <Leader>tr <tr></tr>O
imap <buffer> <Leader>td <td></td>bhhi
vmap <buffer> <Leader>td `>a</td>`<i<td>
imap <buffer> <Leader>th <th></th>bhhi
imap <buffer> <Leader>cg <colgroup></colgroup>O
imap <buffer> <Leader>co <col>

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

imap <buffer> <Leader>c<SPACE> :silent call HTMLAttribute('class')<CR>
nmap <buffer> <Leader>c<SPACE> :silent call HTMLAttribute('class')<CR>

imap <buffer> <Leader>l<SPACE> :silent call HTMLAttribute('lang')<CR>
nmap <buffer> <Leader>l<SPACE> :silent call HTMLAttribute('lang')<CR>

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
		execute 'normal i ' .. a:attribute .. '=""'
		startinsert
	else
		normal wss
		startinsert
	endif
endfunction


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

map <F3> ciw=ExpandColor('"')F#
function! ExpandColor(word)
	let numbers = substitute(a:word, '^#', '', '')
	if(len(numbers) == 6)
		return 'rgb(' .. str2nr(numbers[0:1], 16) .. ', ' .. str2nr(numbers[2:3], 16) .. ', ' .. str2nr(numbers[4:5], 16) .. ')'
	endif
endfunction
