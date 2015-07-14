on runInNextPane(_command, _mode)
  tell application "iTerm"
    tell current terminal
      if _mode = "terminal" then
        tell i term application "System Events" to keystroke "]" using command down
      end if
      tell current session
        write text _command
      end tell
      if _mode = "terminal" then
        tell i term application "System Events" to keystroke "[" using command down
      end if
    end tell
  end tell
end runInNextPane

on run argv
  set _command to item 1 of argv
  set _mode to item 2 of argv
  runInNextPane(_command, _mode)
end run
