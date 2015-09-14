on runInNextSession(theCommand)
  tell application "iTerm"
    tell current terminal
      set currentSessionId to the id of current session
      repeat with i from 1 to count sessions
        set theId to the id of session i
        if theId = currentSessionId then exit repeat
      end repeat

      set i to i + 1
      if i is greater than (count sessions) then set i to 1

      tell session i to write text theCommand
    end tell
  end tell
end runInNextPane

on runInCurrentSession(theCommand)
  tell application "iTerm"
    tell current session of current terminal
      write text theCommand
    end tell
  end tell
end runInCurrentSession

on run argv
  set theMode to item 1 of argv
  set theCommand to item 2 of argv

  if theMode = "terminal" then
    runInNextSession(theCommand)
  else
    runInCurrentSession(theCommand)
  end if
end run
