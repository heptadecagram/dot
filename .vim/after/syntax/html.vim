" Language:		HTML-Template ( Perl Module HTML/Template.pm )
" Referencess:	Perl Module - HTML::Template v2.5
" Last Change:	26 Mar 2002 17:44:34.


syntax cluster htmlPreproc add=htmltmpl_start,htmltmpl_end
syntax cluster htmlPreproc add=tt_start,tt_end

" Template Toolkit
syntax region tt_start keepend matchgroup=Delimiter
			\ start=+\[% \(GET\|CALL\|SET\|DEFAULT\|INSERT\|INCLUDE\|PROCESS\|WRAPPER\|BLOCK\|IF\|UNLESS\|ELSIF\|ELSE\|SWITCH\|CASE\|FOREACH\|WHILE\|FILTER\|USE\|MACRO\|PERL\|RAWPERL\|TRY\|THROW\|CATCH\|FINAL\|NEXT\|LAST\|RETURN\|STOP\|CLEAR\|META\|TAGS\|DEBUG\)+	end=+%\]+
			\ containedin=ALL
			\ contains=tt_attribute_name,tt_attribute_value,tt_bare_attribute,tt_operator
syntax region tt_end oneline keepend
			\ start=+\[% END+	end=+%\]+
			\ containedin=ALL

syntax match tt_operator "[+*/%:?-]"                       contained
syntax match tt_operator "\<\(mod\|div\|or\|and\|not\)\>"  contained
syntax match tt_operator "[!=<>]=\=\|&&\|||"               contained
syntax match tt_operator "\(\s\)\@<=_\(\s\)\@="            contained
syntax match tt_operator "=>\|,"                           contained

hi def link tt_operator Statement



" HTML-Template
syntax region htmltmpl_start keepend matchgroup=Delimiter
			\ start=+<\(!\z(--\)\)\= *tmpl_\(var\|if\|include\|else\|unless\|loop\)+	end=+\z1>+
			\ containedin=ALL
			\ contains=htmltmpl_attribute_name,htmltmpl_attribute_value,htmltmpl_bare_attribute
syntax region htmltmpl_end oneline keepend
			\ start=+<\(!\z(--\)\)\= */tmpl_\(if\|unless\|else\|loop\)+	end=+\z1>+
			\ containedin=ALL

" TMPL Element name Matching
"syn match htmltmpl_tagname contained +tmpl_\(if\|include\|else\|var\|unless\)+
"syn keyword htmltmpl_loop_tagname contained TMPL_LOOP


" Brakets
"syn match htmltmpl_brakets contained +<\|>+


" Attribute
syn match htmltmpl_bare_attribute contained skipwhite
			\ +[^>='"[:blank:]-]\+\(\s\|>\)\@=+
			\ nextgroup=htmltmpl_bare_attribute

syn region htmltmpl_attribute contained keepend skipwhite
			\ start=+\a\+=+ end=+\s\|\(>\)\@=+
			\ contains=htmltmpl_attribute_name,htmltmpl_attribute_value
			\ nextgroup=htmltmpl_attribute

syn region htmltmpl_attribute
			\ start=+\a\+=\z(["']\)+ end=+\z1+
			\ contained keepend skipwhite
			\ contains=htmltmpl_attribute_name,htmltmpl_attribute_value
			\ nextgroup=htmltmpl_attribute

" Hilighting
syn match htmltmpl_attribute_name contained +\(name\|escape\|default\)\(\s*=\)\@=+

syn match htmltmpl_attribute_value contained +=\zs["'][^"']*["']+
			\ contains=htmltmpl_attribute_loop_value
syn match htmltmpl_attribute_value contained +=\zs *[^"'> ]\++
			\ contains=htmltmpl_attribute_loop_value

"syn match htmltmpl_attribute_loop_value contained
			"\ +\(=["']\)\@<=__\(FIRST\|LAST\|INNER\|ODD\)__\(["']\)\@=\|\(=\)\@<=__\(FIRST\|LAST\|INNER\|ODD\)__\([[:blank:]>]\)\@=+

" ???
"syn clear htmlEvent
" start=+on\a... => start=+\<on\a...
"                          ^^
"if exists("html_extended_events")
	"syn region htmlEvent	contained start=+\<on\a\+\s*=[\t ]*'+ end=+'+ contains=htmlEventSQ
	"syn region htmlEvent	contained start=+\<on\a\+\s*=[\t ]*"+ end=+"+ contains=htmlEventDQ
"else
	"syn region htmlEvent	contained start=+\<on\a\+\s*=[\t ]*'+ end=+'+ keepend contains=htmlEventSQ
	"syn region htmlEvent	contained start=+\<on\a\+\s*=[\t ]*"+ end=+"+ keepend contains=htmlEventDQ
"endif



hi link htmltmpl_start                  Preproc
hi link htmltmpl_end                    Preproc
"hi link htmltmpl_tagname                Identifier
hi link htmltmpl_loop_tagname           Identifier
hi link htmltmpl_brakets                Special
hi link htmltmpl_attribute_name         Type
hi link htmltmpl_attribute_value        String
hi link htmltmpl_bare_attribute         Function
hi link htmltmpl_attribute_loop_value   Special

