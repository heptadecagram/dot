if !has('vim9script')
   finish
endif
vim9script

nmap <silent> gd "lyiw:silent call search('func\S*!\?\s\+' .. @l .. '\>', 'b')
