# iSlime2.vim

SLIME-like support for running vim with iTerm2

## What is it?

For the video-inclined [watch it here](http://www.youtube.com/watch?v=33Hz6OguYT8).

It lets you send commands from Vim to an iTerm2 session. This is handy if you need to run a command repeatedly (like a test) and want to see the output. This is especially nice in text-mode Vim, but it should work fine from MacVim's GUI too.

It works by using AppleScript to switch to the next iTerm2 Pane (using `Cmd+]`), writing the appropriate text then switching back (using `Cmd+[`).

## Installation

Include with [Vundle](https://github.com/gmarik/vundle), [Pathogen](https://github.com/tpope/vim-pathogen) or drop the project files into your `~/.vim` directory. I use and test this with Vundle.

## Caveats

At the moment rather than support all the possible testing methods I have `<leader>ft` try to run `script/test` against the current file and `<leader>fT` pass the current file as `path:line_number`. I'll include a contrib directory with various testing tools in the near future but for now a simple `script/test` for Rails would be:

    #!/bin/sh
    ruby -Itest "$@"

Of course this wouldn't support focused unit testing. More on that to come soon.

## Usage

* `<leader>ft` - runs `script/test path/to/current/file`
* `<leader>fT` - runs `script/test path/to/current/file:line_number`
* `<leader>ff` - runs the last run command
* `let t:islime2_last_command="rake"` - sets the last command to `rake` so we can run it with `<leader>ff`

## Contributions

Are welcome! Pull request to your heart's content. I'd love to turn this into a general purpose testing tool. Also if you know how to make setting the last command easier (maybe `:iSlime <command>`), please let me know. I'm new to Vim scripting and couldn't figure this bit out.

## License

Copyright &copy; Mat Schaffer. Distributed under the same terms as Vim itself. See :help license.

## Thanks

* [Tim Pope](https://github.com/tpope), for vim-fugitive which was a nice reference for how to run stuff from Vim script.
* [Jonathan Palardy](https://github.com/jpalardy), for vim-slime, the original inspiration for this plugin.
* [Troy Bollinger](http://code.google.com/p/iterm2/issues/detail?id=559) and [Patrick Bacon](http://spin.atomicobject.com/2011/09/27/run-tests-from-macvim/) for writing the AppleScript that helped me write my own.
* [George Nachman](http://www.iterm2.com/) for writing iTerm2, easily the most bad-ass terminal emulator I know of.
* [Lar Van Der Jagt](https://twitter.com/supaspoida), [Shay Arnett](https://twitter.com/shayarnett), [Josh Davey](https://twitter.com/joshuadavey) and [Robert Pitts](https://twitter.com/rbxbx) for the tweets that got me going on this
