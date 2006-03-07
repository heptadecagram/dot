" 
" Project  Name: Vim Settings
" File / Folder: .vim/ftplugin/html.vim
" File Language: vim
" Copyright (C): 2004 Liam Bryan
" First  Author: Liam Bryan
" First Created: 2004.11.17 09:57:23
" Last Modifier: Liam Bryan
" Last Modified: 2006.03.07 09:32:45

if exists('b:loaded_html')
	finish
endif
let b:loaded_html = 1

" Update an image tag's WIDTH & HEIGHT attributes (experimental!):
runtime! MangleImageTag.vim 
if exists("*MangleImageTag")
	nnoremap ;mi :call MangleImageTag()<CR>
endif

inoremap && &amp;
inoremap &. &hellip;
inoremap &- &mdash;
inoremap &< &lt;
inoremap &> &gt;
inoremap &<SPACE> &nbsp;

inoremap `<CR> o

imap `cm <!--  -->bhi
vmap `cm `>a -->`<i<!-- 

imap `tv <!-- tmpl_var name="" -->bhhi
imap `tn <!-- tmpl_include name="" -->bhhi
imap `te <!-- tmpl_else -->
imap `tf <!-- tmpl_if name="" --><!-- /tmpl_if -->4Bhhi
imap `tu <!-- tmpl_unless name="" --><!-- /tmpl_unless -->4Bhhi
imap `tl <!-- tmpl_loop name="" --><!-- /tmpl_loop -->4Bhhi

imap `ht <?xml version="1.0" encoding="iso-8859-1"?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN""http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"><html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US"><head></head><body></body></html>3nO

imap `ti <title></title>bba

imap `sc <script type="text/javascript"><!----></script>nO

imap `sy <style type="text/css"><!----></style>nO

imap `ln <link href="" rel="" type=""/>BBhhi

imap `h1 <h1></h1>bba
vmap `h1 `>a</h3>`<i<h3>
imap `h2 <h2></h2>bba
vmap `h2 `>a</h2>`<i<h2>
imap `h3 <h3></h3>bba
vmap `h3 `>a</h3>`<i<h3>
imap `h4 <h4></h4>bba
vmap `h4 `>a</h4>`<i<h4>
imap `h5 <h5></h5>bba
vmap `h5 `>a</h5>`<i<h5>

imap `fm <form action="" method="post"></form>BBhhi
imap `ff <fieldset></fieldset>O
imap `la <label></label>nA
imap `fe <select name=""></select>Bbsa

imap `fo <option value="">OPTION</option>Bwsa
vmap `fo `>a</option>`<i<option value="">Bwsa

imap `ft <input name="" value="" size="16" maxlength="16"/>B`n 
vmap `ft `>a" size="16" maxlength="16"/>`<i<input name="" value="`n 

imap `fh <input type="hidden" name="" value=""/>B`n 
imap `fs <input type="submit" value=""/>hhi
imap `fr <input type="radio" name="" value=""/>B`n 
imap `fc <input type="checkbox" name="" value=""/>B`n 
imap `fb <input type="button" name="" value=""/>B`n 
imap `fx <textarea rows="6" cols="60"></textarea>bhhi
imap `fp <input type="password" name="" value="" size="16" maxlength="16"/>B`n 

imap `im <img src="" alt=""/>Bhhi

imap `ol <ol></ol>O
imap `ul <ul></ul>O
imap `li <li></li>bba
vmap `li `>a</li>`<i<li>
imap `dl <dl></dl>O
imap `dt <dt></dt>bba
imap `dd <dd></dd>bba

imap `pp <p></p>bba
vmap `pp `>a</p>`<i<p>

imap `qq <q lang="en-US"></q>Bwla
vmap `qq `>a</q>`<i<q lang="en-US">

imap `aa <a href="">LINK</a>Bwla
vmap `aa `>a</a>`<i<a href="">hi

imap `bb <b></b>bba
vmap `bb `>a</b>`<i<b>

imap `ii <i></i>bba
vmap `ii `>a</i>`<i<i>

imap `di <div></div>O
vmap `di `>a</div>`<i<div>

imap `st <strong></strong>bba
vmap `st `>a</strong>`<i<strong>

imap `em <em></em>bba
vmap `em `>a</em>`<i<em>

imap `sp <span></span>bba
vmap `sp `>a</span>`<i<span>

imap `hr <hr/>

imap `ta :call TableMaker()<LEFT>
imap `ca <caption></caption>bhhi
imap `tb <tbody></tbody>no
imap `tr <tr></tr>no
imap `td <td></td>bhhi
vmap `td `>a</td>`<i<td>
imap `th <th></th>bhhi

function! FindCurrentTag()
	call searchpair('<', '', '>', 'b')
	call search('\S')
	normal "lyw
	return @l
endfunction

imap `a<SPACE> :silent call HTMLAttribute('alt')<CR>
nmap `a<SPACE> :silent call HTMLAttribute('alt')<CR>

imap `h<SPACE> :silent call HTMLAttribute('href')<CR>
nmap `h<SPACE> :silent call HTMLAttribute('href')<CR>

imap `n<SPACE> :silent call HTMLAttribute('name')<CR>
nmap `n<SPACE> :silent call HTMLAttribute('name')<CR>

imap `v<SPACE> :silent call HTMLAttribute('value')<CR>
nmap `v<SPACE> :silent call HTMLAttribute('value')<CR>

imap `s<SPACE> :silent call HTMLAttribute('size')<CR>
nmap `s<SPACE> :silent call HTMLAttribute('size')<CR>

imap `c<SPACE> :silent call HTMLAttribute('class')<CR>
nmap `c<SPACE> :silent call HTMLAttribute('class')<CR>

imap `e<SPACE> :silent call HTMLAttribute('escape')<CR> 
nmap `e<SPACE> :silent call HTMLAttribute('escape')<CR>

function! HTMLAttribute(attribute)
	let Current_Tag = FindCurrentTag()
	call searchpair('<', a:attribute, '/\=>') 
	normal "ly 
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

map <F8> :call JavaScriptImageSource()<LEFT>
function! JavaScriptImageSource(...)
  let idx = 1
  while idx <= a:0
    execute "normal o" . a:{idx} . " = new Image();" . a:{idx} .
          \ ".src = '/images/" . a:{idx} . ".gif';"
    execute "normal o" . a:{idx} . "over = new Image();" . a:{idx} .
          \ "over.src = '/images/" . a:{idx} . "over.gif';"
    let idx = idx + 1
  endwhile
endfunction

function! WriteSizes(name, width, height)
  execute "normal /" . a:name . "/width/"a" . a:width .
        \ "/height/"a" . a:height . "^n"
endfunction

" HTML helper macro
map <F3> :call RolloverMaker('', '')<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
function! RolloverMaker(a_href, img_name)
    execute 'normal I<a href="' . a:a_href .  '"onMouseOver = "' .
          \ "changeImages('" . a:img_name . "', '" .  a:img_name . "over')" .
          \ '"onMouseOut = "' . "changeImages('" .  a:img_name . "', '" .
          \ a:img_name . "')" . '"><img src="/images/' . a:img_name .
          \ '.gif" name="' . a:img_name . '"border="0" width="" height=""/>' .
          \ '</a>n^'
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

	normal o<table border="1">

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
