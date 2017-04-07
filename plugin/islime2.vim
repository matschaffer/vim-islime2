command! -nargs=+ ISlime2 :call islime2#iTermSendNext("<args>")

command! ISlime2CurrentLine :call islime2#iTermSendNext(getline('.'))

" Literally `j` then ISlime2CurrentLine
command! ISlime2NextLine :execute "norm j:ISlime2CurrentLine<CR>"

" Literally `k` then ISlime2CurrentLine
command! ISlime2PreviousLine :execute "norm k:ISlime2CurrentLine<CR>"
