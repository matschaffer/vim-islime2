" iSlime2.vim - SLIME-like support for running Vim with iTerm2
" Maintainer:   Mat Schaffer <http://matschaffer.com>
" Version:      0.1

" Allows running arbitrary command with :ISlime2
command! -nargs=+ ISlime2 :call <SID>iTermSendNext("<args>")

" Rerun the previous iSlime2 command
nnoremap <leader>ff :call <SID>iTermRerun()<CR>
function! s:iTermRerun()
  if exists("g:islime2_last_command")
    call s:iTermSendNext(g:islime2_last_command)
  else
    echoerr "No previous command. Try running a test first (with <leader>ft). Or you can store a command with `ISlime2 my command`"
  endif
endfunction

" Send up and enter to re-run the previous command
nnoremap <leader>fp :call <SID>iTermSendUpEnter()<CR>
function! s:iTermSendUpEnter()
  call s:iTermSendNext("OA")
endfunction

" Send the current visual selection or paragraph
inoremap <leader>cc <Esc>vip"ry:call <SID>iTermSendNext(@r)<CR>
vnoremap <leader>cc "ry:call <SID>iTermSendNext(@r)<CR>
nnoremap <leader>cc vip"ry:call <SID>iTermSendNext(@r)<CR>

" Send the whole file
nnoremap <leader>cf :%y r<cr>:call <SID>iTermSendNext(@r)<CR>

" Run script/deliver
nnoremap <leader>fd :call <SID>iTermSendNext("./script/deliver")<CR>

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
  let l:script_name = (exists('g:islime2_29_mode') && g:islime2_29_mode == 1) ? 'run_command29' : 'run_command'

  let l:run_command = fnamemodify(s:current_file, ":p:h:h") . "/scripts/" . l:script_name . ".scpt"

  let g:islime2_last_command = a:command
  let l:mode = has('gui_running') ? 'gui' : 'terminal'
  let l:command = substitute(shellescape(substitute(a:command, '\n$', '', '')), '\\\n', '\n', 'g')

  call system("osascript " . l:run_command . " " . l:mode . " " . l:command)
endfunction
