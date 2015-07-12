on runInNextPane(_command)
  tell application "iTerm"
    set isRunning to (it is running)
    set myterm to (current terminal)
    try
      set tmp to myterm
    on error
      set myterm to (make new terminal)
    end try
    tell myterm
      if not isRunning then
        activate
      end if
      tell current session
        write text _command
      end tell
    end tell
  end tell
end runInNextPane

on run argv
  set _command to item 1 of argv
  runInNextPane(_command)
end run
