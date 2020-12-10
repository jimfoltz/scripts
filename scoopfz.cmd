@echo off
setlocal

if "%1%"=="update" (
rem call scoop update *
call ruby %~dp0\scoopfz\build-app-list.rb
)

set "FZF_DEFAULT_COMMAND=type %~dp0\scoopfz\app-list"

fzf --reverse -d "\|" ^
  --no-hscroll ^
  --header "HELP: [ F1:Homepage | F2:Install | F3:Uninstall | F4:Scoop Update | ctrl-u: update app-list | ESC:quit ]" ^
  --bind "f1:execute-silent(scoop home {3})" ^
  --bind "f2:execute(cmd /c scoop install {3})" ^
  --bind "f3:execute(cms /c scoop uninstall {3})" ^
  --bind "f4:execute(cmd /c scoop update *)" ^
  --bind "home:top" ^
  --bind "change:top" ^
  --bind "ctrl-u:execute(cmd /c ruby %~dp0\scoopfz\build-app-list.rb)+reload(%FZF_DEFAULT_COMMAND%)" ^
  --with-nth "1..4" ^
  --preview "echo {3} & echo {4} & echo {5}" ^
  --preview-window "top:3:wrap"

