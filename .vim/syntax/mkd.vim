" Vim syntax file
" Language:	Markdown
" Maintainer:	Ben Williams <benw@plasticboy.com>
" URL:		http://plasticboy.com/markdown-vim-mode/
" Version:	8
" Last Change:  2008 April 29
" Remark:	Uses HTML syntax file
" Remark:	I don't do anything with angle brackets (<>) because that would too easily
"		easily conflict with HTML syntax
" TODO: 	Do something appropriate with image syntax
" TODO: 	Handle stuff contained within stuff (e.g. headings within blockquotes)


" Read the HTML syntax to start with
if version < 600
  so <sfile>:p:h/html.vim
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
syn case ignore
syn sync linebreaks=1

"additions to HTML groups
syn region htmlItalic   start=/\\\@<!\z\(_\|\*\)[ \t]\@!/          end=/[ \t]\@<!\z1/        contains=@Spell
syn region htmlBold     start=/\\\@<!\z\(__\|\*\*\)[ \t]\@!/          end=/[ \t]\@<!\z1/        contains=@Spell

syn region mkdCode         start=/\z\(`\+\)/                   end=/\z1/

syn region mkdURL   start="]("ms=s+2             end=")"me=e-1
syn region mkdLink     start="\["ms=s+1            end="\]"me=e-1 contains=@Spell
syn region mkdURL      start="\(\[.*]: *\)\@<=.*"  end="$"

syn cluster mkdSpan contains=mkdCode,mkdLink,mkdImage

"define Markdown groups
syn match  mkdLineContinue ".$" contained
syn match  mkdListItem     /^\( *\([-*+]\|\d\+\.\)\)\+\s\+/
syn region mkdBlockquote   start=/^ \{,3}>/            end=/$/                 contains=mkdLineContinue,@Spell,@mkdSpan
syn match  mkdPre          /^\s*\n\(\( \{4,}\|\t\+\).*\n\)\+/

syn match  mkdRule         /^ \{,3}\%\(\([*_-]\) \{0,2}\)\%\(\1 \{0,2}\)\{2,}\s*$/

"HTML headings
syn match  mkdHeader     /^.\+\n=\+$/ contains=@Spell,@mkdSpan
syn match  mkdHeader     /^.\+\n-\+$/ contains=@Spell,@mkdSpan
syn region mkdHeader     start="^ \{,3}#"                   end="\($\|#\+\)" keepend contains=@Spell,@mkdSpan
syn region mkdHeader     start="^ \{,3}##"                  end="\($\|#\+\)" keepend contains=@Spell,@mkdSpan
syn region mkdHeader     start="^ \{,3}###"                 end="\($\|#\+\)" keepend contains=@Spell,@mkdSpan
syn region mkdHeader     start="^ \{,3}####"                end="\($\|#\+\)" keepend contains=@Spell,@mkdSpan
syn region mkdHeader     start="^ \{,3}#####"               end="\($\|#\+\)" keepend contains=@Spell,@mkdSpan
syn region mkdHeader     start="^ \{,3}######"              end="\($\|#\+\)" keepend contains=@Spell,@mkdSpan

"highlighting for Markdown groups
MkdHiLink mkdURL   	    String
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
" vim: ts=8
