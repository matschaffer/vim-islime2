# iSlime2.vim

SLIME-like support for running vim with iTerm2

## What is it?

<img src='https://raw.githubusercontent.com/ddrscott/vim-islime2/gh-pages/demo.gif'/>

It lets you send commands from Vim to an iTerm2 session. This is handy if you need to run a command repeatedly (like a test) and want to see the output. This is especially nice in text-mode Vim, but it works fine from MacVim's GUI too.

It works by using AppleScript to switch to the next iTerm2 Pane (using `Cmd+]`), writing the appropriate text then switching back (using `Cmd+[`).

## Installation

Include with [Vundle](https://github.com/gmarik/vundle), [Pathogen](https://github.com/tpope/vim-pathogen) or drop the project files into your `~/.vim` directory. I use and test this with Vundle.

If you're using this on iTerm 2.9 or above (nightly as of 2015/09/17), you'll also want to set "29" mode since the AppleScript interface has changed a bit. Use a command like so in your vimrc:

```vim
let g:islime2_29_mode=1
```

## Usage

### For any commands

* `ISlime2 echo hi mom` - runs "echo hi mom"

## Recommended Mappings

```vim
let g:islime2_29_mode=1

" Send current line
nnoremap <silent> <Leader>i<CR> :ISlime2CurrentLine<CR>

" Move to next line then send it
nnoremap <silent> <Leader>ij :ISlime2NextLine<CR>

" Move to previous line then send it
nnoremap <silent> <Leader>ik :ISlime2PreviousLine<CR>

" Send in/around text object - operation pending
nnoremap <silent> <Leader>i :set opfunc=islime2#iTermSendOperator<CR>g@

" Send visual selection
vnoremap <silent> <Leader>i :<C-u>call islime2#iTermSendOperator(visualmode(), 1)<CR>
```

## More Example Mappings

```vim
" Send the whole file
nnoremap <leader>cf :%y r<cr>:call islime2#iTermSendNext(@r)<CR>

" Rerun the previous iSlime2 command
nnoremap <leader>ff :call islime2#iTermRerun()<CR>

" Send up and enter to re-run the previous command
nnoremap <leader>fp :call islime2#iTermSendUpEnter()<CR>

" Run script/deliver
nnoremap <leader>fd :call islime2#iTermSendNext("./script/deliver")<CR>

" Run rake
nnoremap <leader>fr :call islime2#iTermSendNext("rake")<CR>

" Run file as a test (assumes ./script/test)
nnoremap <leader>ft :call islime2#iTermRunTest(expand("%"))<CR>
remap <leader>ft :call islime2#iTermRunTest(expand("%"))<CR>")

" Run focused unit test (assumes ./script/test understands file:line notation)
nnoremap <leader>fT :call islime2#iTermRunTest(expand("%") . ":" . line("."))<CR>
```

## Contributions

Are welcome! Pull request to your heart's content. I'd love to turn this into a general purpose development tool.

## License

Copyright &copy; Mat Schaffer. Distributed under the same terms as Vim itself. See :help license.

## Thanks

* [Tim Pope](https://github.com/tpope), for vim-fugitive which was a nice reference for how to run stuff from Vim script.
* [Jonathan Palardy](https://github.com/jpalardy), for vim-slime, the original inspiration for this plugin.
* [Troy Bollinger](http://code.google.com/p/iterm2/issues/detail?id=559) and [Patrick Bacon](http://spin.atomicobject.com/2011/09/27/run-tests-from-macvim/) for writing the AppleScript that helped me write my own.
* [George Nachman](http://www.iterm2.com/) for writing iTerm2, easily the most bad-ass terminal emulator I know of.
* [Lar Van Der Jagt](https://twitter.com/supaspoida), [Shay Arnett](https://twitter.com/shayarnett), [Josh Davey](https://twitter.com/joshuadavey) and [Robert Pitts](https://twitter.com/rbxbx) for the tweets that got me going on this
