vim9script

g:maplocalleader = '&'
g:mapleader = '`'


inoremap <buffer> <LocalLeader>& &amp;
inoremap <buffer> <LocalLeader>< &lt;
inoremap <buffer> <LocalLeader>> &gt;


# When typing, hit `-<Enter> to hop to the next line
inoremap <buffer> <Leader><CR> o

imap <buffer> <Leader>cm <!--  -->bhi
vmap <buffer> <Leader>cm `>a -->`<i<!--


imap <buffer> <Leader>svg <?xml version="1.0" encoding="UTF-8"?><!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd"><svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="-1 -1 100 100"></svg>O



# NOTE: Using <expr> when defining these mappings would, indeed, be
# less buggy, error-prone, and expandable, but <expr> does not allow
# cursor movement, which is part of what makes these so pleasant to use.
#
inoremap <buffer> <Leader>sc <script type="text/javascript"><!----></script>nO

inoremap <buffer> <Leader>sy <style type="text/css"><!----></style>nO

imap <buffer> <Leader>ln <link href="" rel="" type="">BBhhi

imap <buffer> <Leader>de <defs></defs>O
vmap <buffer> <Leader>de `>a</defs>`<i<defs>

imap <buffer> <Leader>gg <g></g>O
vmap <buffer> <Leader>gg `>a</g>`<i<g>

imap <buffer> <Leader>te <text x="" y=""></text>bba
vmap <buffer> <Leader>te `>a</text>`<i<text x="" y="">


imap <buffer> <Leader>re <rect x="" y="" width="" height=""/>BBBBhhi
imap <buffer> <Leader>ci <circle x="" y="" width="" height=""/>BBBhhi
imap <buffer> <Leader>li <line x1="" y1="" x2="" y2="" stroke="black"/>BBBBhhi
imap <buffer> <Leader>us <use x="" y="" href=""/>BBhhi

def FindCurrentTag(): string
	search('<\|>', 'b')
	searchpair('<', '', '>', 'b')
	search('\S')

	const old_l = getreginfo('l')
	normal! "lyw
	const tag = @l
	call setreg('l', old_l)

	return tag
enddef

imap <buffer> <Leader>f<SPACE> :silent call <SID>SVGAttribute('fill')<CR>
nmap <buffer> <Leader>f<SPACE> :silent call <SID>SVGAttribute('fill')<CR>

imap <buffer> <Leader>h<SPACE> :silent call <SID>SVGAttribute('height')<CR>
nmap <buffer> <Leader>h<SPACE> :silent call <SID>SVGAttribute('height')<CR>

imap <buffer> <Leader>i<SPACE> :silent call <SID>SVGAttribute('id')<CR>
nmap <buffer> <Leader>i<SPACE> :silent call <SID>SVGAttribute('id')<CR>

imap <buffer> <Leader>w<SPACE> :silent call <SID>SVGAttribute('width')<CR>
nmap <buffer> <Leader>w<SPACE> :silent call <SID>SVGAttribute('width')<CR>

imap <buffer> <Leader>s<SPACE> :silent call <SID>SVGAttribute('stroke')<CR>
nmap <buffer> <Leader>s<SPACE> :silent call <SID>SVGAttribute('stroke')<CR>

imap <buffer> <Leader>x<SPACE> :silent call <SID>SVGAttribute('x')<CR>
nmap <buffer> <Leader>x<SPACE> :silent call <SID>SVGAttribute('x')<CR>

imap <buffer> <Leader>x1 :silent call <SID>SVGAttribute('x1')<CR>
nmap <buffer> <Leader>x1 :silent call <SID>SVGAttribute('x1')<CR>
imap <buffer> <Leader>x2 :silent call <SID>SVGAttribute('x2')<CR>
nmap <buffer> <Leader>x2 :silent call <SID>SVGAttribute('x2')<CR>

imap <buffer> <Leader>y<SPACE> :silent call <SID>SVGAttribute('y')<CR>
nmap <buffer> <Leader>y<SPACE> :silent call <SID>SVGAttribute('y')<CR>

imap <buffer> <Leader>y1 :silent call <SID>SVGAttribute('y1')<CR>
nmap <buffer> <Leader>y1 :silent call <SID>SVGAttribute('y1')<CR>
imap <buffer> <Leader>y2 :silent call <SID>SVGAttribute('y2')<CR>
nmap <buffer> <Leader>y2 :silent call <SID>SVGAttribute('y2')<CR>

imap <buffer> <Leader>ta :silent call <SID>SVGAttribute('text-anchor')<CR>
nmap <buffer> <Leader>ta :silent call <SID>SVGAttribute('text-anchor')<CR>
imap <buffer> <Leader>ab :silent call <SID>SVGAttribute('alignment-baseline')<CR>
nmap <buffer> <Leader>ab :silent call <SID>SVGAttribute('alignment-baseline')<CR>

def StandardPopup(options: list<string>)
	popup_create(options, {
		pos: 'topleft',
		line: 'cursor+1',
		col: 'cursor',
		cursorline: 1,
		mapping: 0,
		filter: (id, key) => {
			if key == "\<Enter>" || key == "\<Tab>"
				popup_close(id, line('.', id))
			endif
			return popup_filter_menu(id, key)
		},
		callback: (_, result) => {
			if result == -1
				return
			endif

			@l = options[result - 1]
			normal "lP
		},
	})
enddef

def SVGAttribute(attribute: string)
	const optionValues = {
		alignment-baseline: ['baseline', 'text-before-edge', 'middle', 'central', 'text-after-edge',
			'ideographic', 'alphabetic', 'hanging', 'mathematical', 'top', 'center', 'bottom'],
		fill: ['none', 'black', 'silver', 'gray', 'white', 'maroon', 'red', 'purple', 'fuchsia',
			'green', 'lime', 'olive', 'yellow', 'navy', 'blue', 'teal', 'aqua'], #, 'context-fill', 'context-stroke'],
		stroke: ['none', 'black', 'silver', 'gray', 'white', 'maroon', 'red', 'purple', 'fuchsia',
			'green', 'lime', 'olive', 'yellow', 'navy', 'blue', 'teal', 'aqua'], #, 'context-fill', 'context-stroke'],
		text-anchor: ['start', 'middle', 'end'],
	}

	const Current_Tag = FindCurrentTag()
	searchpair('<', attribute, '/\=>')

	const old_l = getreginfo('l')
	normal! "lyl
	const end = @l
	setreg('l', old_l)

	if end == '>' || end == '/'
		if Current_Tag == '!-- '
			normal! bh
		endif
		execute 'normal! i ' .. attribute .. '=""'

		if has_key(optionValues, attribute)
			StandardPopup(optionValues[attribute])
		else
			startinsert
		endif
	else
		normal! f=ll
		if has_key(optionValues, attribute)
			StandardPopup(optionValues[attribute])
		else
			startinsert
		endif
	endif
enddef

def g:BoundingRect()
	const old_l = getreginfo('l')
	normal! /svg/viewBox/e3WW"lyw
	const width = @l
	normal! W"lyw/>
	const height = @l
	@l = '<rect id="BoundingBox" x="0" y="0" width="' .. width .. '" height="' .. height ..
		'" stroke="blue" fill="none"/>'

	put l
	setreg('l', old_l)
enddef

function g:DeltaX(amt) range
	let saved = winsaveview()
	call cursor(a:firstline, 1)
	while search('\<x.\?=', 'ecW', a:lastline) > 0
		if a:amt > 0
			execute 'normal ' .. a:amt .. ''
		else
			execute 'normal ' .. -a:amt .. ''
		endif
	endwhile
	call winrestview(saved)
endfunction

function g:DeltaY(amt) range
	let saved = winsaveview()
	call cursor(a:firstline, 1)
	while search('\<y.\?=', 'ecW', a:lastline) > 0
		if a:amt > 0
			execute 'normal ' .. a:amt .. ''
		else
			execute 'normal ' .. -a:amt .. ''
		endif
	endwhile
	call winrestview(saved)
endfunction
