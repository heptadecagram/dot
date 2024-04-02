vim9script

" Set 'comments' to format dashed lists in comments.
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/

setlocal formatoptions+=o

if exists('+omnifunc')
	setlocal omnifunc=csscomplete#CompleteCSS
endif
