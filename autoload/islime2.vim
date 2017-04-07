" iSlime2.vim - SLIME-like support for running Vim with iTerm2
" Maintainer:   Mat Schaffer <http://matschaffer.com>
" Version:      0.1

function! islime2#iTermRerun()
  if exists("g:islime2_last_command")
    call islime2#iTermSendNext(g:islime2_last_command)
  else
    echoerr "No previous command. Try running a test first (with <leader>ft). Or you can store a command with `ISlime2 my command`"
  endif
endfunction

function! islime2#iTermSendUpEnter()
  call islime2#iTermSendNext("OA")
endfunction

function! islime2#iTermRunTest(file)
  if filereadable("script/test")
    call islime2#iTermSendNext("script/test " . a:file)
  else
    echoerr "Couldn't execute " . getcwd() . "/script/test, please create test runner script."
  endif
endfunction

let s:current_file=expand("<sfile>")

" Sends the passed command to the next iTerm2 panel using Cmd+]
function! islime2#iTermSendNext(command)
  let l:script_name = (exists('g:islime2_29_mode') && g:islime2_29_mode == 1) ? 'run_command29' : 'run_command'

  let l:run_command = fnamemodify(s:current_file, ":p:h:h") . "/scripts/" . l:script_name . ".scpt"

  let g:islime2_last_command = a:command
  let l:mode = has('gui_running') ? 'gui' : 'terminal'
  call system("osascript " . l:run_command . " " . l:mode . " " . islime2#shellesc(
        \ substitute(a:command, '\n$', '', '')))
endfunction

function! islime2#shellesc(arg) abort
  return '"'.escape(a:arg, '"').'"'
endfunction

function! islime2#iTermSendOperator(type, ...) abort
  let sel_save = &selection
  let &selection = "inclusive"
  let z=@z
  try
    if a:0  " Invoked from Visual mode, use gv command.
      silent exe "normal! gv\"zy"
    elseif a:type == 'line'
      silent exe "normal! '[V']\"zy"
    else
      silent exe "normal! `[v`]\"zy"
    endif
    call islime2#iTermSendNext(@z)
  finally
    let &selection = sel_save
    let @z=z
  endtry
endfunction
