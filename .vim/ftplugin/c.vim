
inoremap <buffer> #I #include <.h>hhi
inoremap <buffer> #i #include ".h"hhi

inoremap <buffer> #d #define<SPACE>
inoremap <buffer> #f #ifdef<SPACE>
inoremap <buffer> #e #else<SPACE>
inoremap <buffer> #n #endif<SPACE>

nmap <silent> gd "lyiw :call C_gd(@l)<CR>

function! C_gd(word)
	call search('\%(static\|extern\)\%(void\|\%(signed\|unsigned\|struct\)\? \*\w\+\) \*\?' . a:word . ' \?(\.\*)\$', 'b')
endfunction

