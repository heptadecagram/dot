
function! <SID>HtmlIndentPush(tag)
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
