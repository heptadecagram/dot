

" Read the HTML syntax to start with
if version < 600
	source <sfile>:p:h/html.vim
else
	runtime! syntax/html.vim
	unlet b:current_syntax
endif

syntax clear HtmlError

if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

" don't use standard HiLink, it will not work with included syntax files
if version < 508
	command! -nargs=+ MkdHiLink hi link <args>
else
	command! -nargs=+ MkdHiLink hi def link <args>
endif

syn spell toplevel
syn sync linebreaks=1

"additions to HTML groups
syn region mkdCode start=/\z\(`\+\)/ end=/\z1/

syn region htmlItalic start=/\\\@<!\z\(_\|\*\)[ \t]\@!/    end=/[ \t]\@<!\z1/ contains=@Spell
syn region htmlBold   start=/\\\@<!\z\(__\|\*\*\)[ \t]\@!/ end=/[ \t]\@<!\z1/ contains=@Spell

syn region mkdLink          start="\["ms=s+1           end="\]"me=e-1  contains=@Spell
syn region mkdURL           start="]("ms=s+2           end=")"me=e-1
syn region mkdURL           start="\(\[.*]: *\)\@<=.*" end="$"
syn region mkdURLIdentifier start="\]\s*\["ms=e+1      end="\]"me=e-1  oneline
syn region mkdURLIdentifier start="^\s*\["ms=e+1       end="\]:"me=e-2 oneline nextgroup=mkdURL

syn cluster mkdSpan contains=mkdCode,mkdLink,mkdImage

"define Markdown groups
syn match  mkdLineContinue       ".$"                                       contained
syn match  mkdListItem           /^\( *\([-*+]\|\d\+\.\)\)\+\s\+/
syn match  mkdPre                /^\s*\n\(\( \{4,}\|\t\+\).*\n\)\+/
syn region mkdBlockquote   start=/^ \{,3}>/                         end=/$/ contains=mkdLineContinue,@Spell,@mkdSpan

syn match  mkdRule /^ \{,3}\%\(\([*_-]\) \{0,2}\)\%\(\1 \{0,2}\)\{2,}\s*$/

"HTML headings
syn match  mkdHeader       /^.\+\n=\+$/                      contains=@Spell,@mkdSpan
syn match  mkdHeader       /^.\+\n-\+$/                      contains=@Spell,@mkdSpan
syn region mkdHeader start="^ \{,3}#\{1,6}" end="\($\|#\+\)" contains=@Spell,@mkdSpan keepend

"highlighting for Markdown groups
MkdHiLink mkdURL            String
MkdHiLink mkdURLIdentifier  Statement
MkdHiLink mkdPre            PreProc
MkdHiLink mkdCode           PreProc
MkdHiLink mkdBlockquote     Comment
MkdHiLink mkdLineContinue   Comment
MkdHiLink mkdListItem       Identifier
MkdHiLink mkdRule           Identifier
MkdHiLink mkdLink           Identifier
MkdHiLink mkdHeader         Statement


let b:current_syntax = "mkd"

delcommand MkdHiLink
