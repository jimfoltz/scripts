@echo off
setlocal

if "%1%"=="update" (
rem call scoop update *
call ruby %~dp0\scoopfz\scooby.rb
)

type %~dp0\scoopfz\app-list | fzf -d "\|" ^
  --no-hscroll ^
  --prompt "query> " ^
  --header "KEYS: [ F1:Homepage | F2:Install | F3:Uninstall | F4:Update | ESC:quit ]" ^
  --bind "f1:execute-silent(scoop home {3})" ^
  --bind "f2:execute(scoop install {3})" ^
  --bind "f3:execute(scoop uninstall {3},abort)" ^
  --bind "f4:execute(scoop update *)" ^
  --bind "home:top" ^
  --bind "change:top" ^
  --with-nth "1..4" ^
  --preview "echo {3} & echo {4} & echo {5}" ^
  --preview-window "top:3"

