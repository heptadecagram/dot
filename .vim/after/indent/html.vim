"
" Project  Name: Vim Settings
" File / Folder: .vim/after/indent/html.vim
" File Language: vim
" Copyright (C): 2007 Richard Group, Inc.
" First  Author: Liam Bryan
" First Created: 2007.05.04 15:10:05
" Last Modifier: Liam Bryan
" Last Modified: 2007.05.04 15:11:44


fun! <SID>HtmlIndentPush(tag)
    if exists('g:html_indent_tags')
	let g:html_indent_tags = g:html_indent_tags.'\|'.a:tag
    else
	let g:html_indent_tags = a:tag
    endif
endfun


" [-- <ELEMENT ? - - ...> --]
call <SID>HtmlIndentPush('tmpl_if')
call <SID>HtmlIndentPush('tmpl_loop')
call <SID>HtmlIndentPush('tmpl_unless')

delfun <SID>HtmlIndentPush
