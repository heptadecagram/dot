if !has('vim9script')
   setlocal tabstop=4
   setlocal softtabstop=4
   setlocal shiftwidth=4
   setlocal textwidth=80
   setlocal smarttab
   setlocal expandtab
   setlocal smartindent

   function! s:Python_gd(word)
       call search('\<def\> ' . a:word . '\>', 'b')
   endfunction
   nmap <silent> <buffer> gd "lyiw :call <SID>Python_gd(@l)<CR>

   function! s:PythonFunctionList()
       let saved = winsaveview()
       belowright new

       setlocal noreadonly modifiable noswapfile nowrap
       setlocal buftype=nowrite
       setlocal bufhidden=delete

       call setline('.', '# Function List')
       wincmd k

       call cursor(1, 1)
       while search('\<def\s\+\w\+', 'W') > 0
           normal w"lY
           wincmd j
           call append('$', @l)
           wincmd k
       endwhile
       call winrestview(saved)

       wincmd j
       execute 'resize ' . line('$')
       setlocal nomodifiable
       normal! j

       map <silent> <buffer> <CR> "lyiw:q<CR>:silent call <SID>Python_gd(@l)<CR>
   endfunction
   nmap <silent> <buffer> lf :call <SID>PythonFunctionList()<CR>

   finish
endif

source <script>:h/9.<script>:t
