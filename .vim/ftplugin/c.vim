if !has('vim9script')
   inoremap <buffer> #I #include <.h>hhi
   inoremap <buffer> #i #include ".h"hhi

   inoremap <buffer> #d #define<SPACE>
   inoremap <buffer> #f #ifdef<SPACE>
   inoremap <buffer> #e #else<SPACE>
   inoremap <buffer> #n #endif<SPACE>

   function s:CFunctionList()
      let saved = winsaveview()
      belowright new

      setlocal noreadonly modifiable noswapfile nowrap
      setlocal buftype=nowrite
      setlocal bufhidden=delete

      call setline('.', '// Function List')
      wincmd k

      call cursor(1, 1)
      while search('^\S.*\(\S*\)(.*)$', 'W') > 0
         normal $%b"lyiw
         if @l == '{'
            continue
         endif
         wincmd j
         call append('$', @l)
         wincmd k
      endwhile
      call winrestview(saved)

      wincmd j
      execute 'resize ' . line('$')
      setlocal nomodifiable
      normal! j

      map <silent> <buffer> <CR> "lyiw:q<CR>:silent call <SID>C_gd(@l)<CR>
   endfunction
   nmap <silent> <buffer> lf :silent call <SID>CFunctionList()<CR>

   function s:C_gd(word)
      call search('^\S.*\<' .. a:word .. '\>(.*)$', 'b')
   endfunction
   nmap <silent> <buffer> gd "lyiw :silent call <SID>C_gd(@l)<CR>

   finish
endif

source <script>:h/9.<script>:t
