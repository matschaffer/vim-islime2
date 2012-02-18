" iSlime2.vim - SLIME-like support for running Vim with iTerm2
" Maintainer:   Mat Schaffer <http://matschaffer.com>
" Version:      0.1

" Rerun the previous iSlime2 command
nnoremap <leader>ff :call <SID>iTermRerun()<CR>
function! s:iTermRerun()
  if exists("t:islime2_last_command")
    call s:iTermSendNext(t:islime2_last_command)
  else
    echoerr "No previous command. Try running a test first (with <leader>ft). Or you can store a command with `let t:islime2_last_command=\"my command\"`"
  endif
endfunction

" Run rake
nnoremap <leader>fr :call <SID>iTermSendNext("rake")<CR>

" Run file as a test (assumes ./script/test)
nnoremap <leader>ft :call <SID>iTermRunTest(expand("%"))<CR>

" Run focused unit test (assumes ./script/test understands file:line notation)
nnoremap <leader>fT :call <SID>iTermRunTest(expand("%") . ":" . line("."))<CR>

function! s:iTermRunTest(file)
  if filereadable("script/test")
    call s:iTermSendNext("script/test " . a:file)
  else
    echoerr "Couldn't execute " . getcwd() . "/script/test, please create test runner script."
  endif
endfunction

let s:current_file=expand("<sfile>")

" Sends the passed command to the next iTerm2 panel using Cmd+]
function! s:iTermSendNext(command)
  let l:run_command = fnamemodify(s:current_file, ":p:h:h") . "/scripts/run_command.scpt"
  let t:islime2_last_command = a:command
  call system("osascript " . l:run_command . " " . s:shellesc(a:command))
endfunction

" From github.com/tpope/vim-fugitive
function! s:shellesc(arg) abort
  if a:arg =~ '^[A-Za-z0-9_/.-]\+$'
    return a:arg
  elseif &shell =~# 'cmd' && a:arg !~# '"'
    return '"'.a:arg.'"'
  else
    return shellescape(a:arg)
  endif
endfunction
