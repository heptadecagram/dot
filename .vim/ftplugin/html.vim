" 
" Project  Name: Vim Settings
" File / Folder: .vim/ftplugin/html.vim
" File Language: vim
" Copyright (C): 2004 Liam Bryan
" First  Author: Liam Bryan
" First Created: 2004.11.17 09:57:23
" Last Modifier: Liam Bryan
" Last Modified: 2005.04.04 15:47:34

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
inoremap &< &lt;
inoremap &> &gt;

inoremap ;; ;

inoremap ;<CR> o

imap ;cm <!--  -->bhi

imap ;tv <!-- tmpl_var name="" -->bhhi
imap ;tf <!-- tmpl_if name="" --><!-- /tmpl_if -->4Bhhi
imap ;tu <!-- tmpl_unless name="" --><!-- /tmpl_unless -->4Bhhi
imap ;tl <!-- tmpl_loop name="" --><!-- /tmpl_loop -->4Bhhi

imap ;ht <?xml version="1.0" encoding="iso-8859-1"?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml" lang="en-US" xml:lang="en-US"><head></head><body></body></html>3nO
imap ;ti <title></title>bba

imap ;h1 <h1></h1>bba
imap ;h2 <h2></h2>bba
imap ;h3 <h3></h3>bba
imap ;h4 <h4></h4>bba
imap ;h5 <h5></h5>bba

imap ;pp <p></p>bba

imap ;fm <form action="" method="POST"></form>BBhhi
imap ;fe <select name=""></select>Bbsa
imap ;fo <option value="">OPTION</option>Bwsa
imap ;ft <input name="" value="" size="16" maxlength="16"/>B;n
imap ;fp <input type="password" name="" value="" size="16" maxlength="16"/>B;n
imap ;fh <input type="hidden" name="" value=""/>B;n
imap ;fs <input type="submit" value=""/>hhi
imap ;fr <input type="radio" name="" value=""/>B;n
imap ;fc <input type="checkbox" name="" value=""/>B;n

imap ;im <img src=""/>Bhhi
imap ;ah <a href="">LINK</a>Bwla

imap ;ta :call TableMaker()<LEFT>
imap ;tr <tr></tr>no
imap ;td <td></td>no

function! FindCurrentTag()
	call searchpair('<', '', '>', 'b')
	call search('\S')
	normal "lyw
	return @l
endfunction

imap ;n :silent call HTMLAttribute('name')<CR>
nmap ;n :silent call HTMLAttribute('name')<CR>

imap ;v :silent call HTMLAttribute('value')<CR>
nmap ;v :silent call HTMLAttribute('value')<CR>

imap ;s :silent call HTMLAttribute('size')<CR>
nmap ;s :silent call HTMLAttribute('size')<CR>

imap ;c :silent call HTMLAttribute('class')<CR>
nmap ;c :silent call HTMLAttribute('class')<CR>

imap ;e :silent call HTMLAttribute('escape')<CR>
nmap ;e :silent call HTMLAttribute('escape')<CR>

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
			normal o<td></td>
			let idx = idx - 1
		endwhile

		normal o</tr>
		let Rows = Rows - 1
	endwhile

	normal o</table>?<tablettw

endfunction "TableMaker()
