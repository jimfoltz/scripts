:: Fuzzy PS - Process viewer/killer
@echo off
setlocal

set "FZF_DEFAULT_OPTS=--reverse --color=16,border:6 --inline-info"
set "TASKLIST=tasklist "
set "FZF_DEFAULT_COMMAND=tasklist |findstr exe | sort /+65 /r"
set "NAME_SORT= | sort"
set "MEM_SORT= | sort /+65 /r"

set "F1=%FZF_DEFAULT_COMMAND%"

set "F5=taskkill /f /pid {2}"
set "F7=taskkill /f /im {1}"

set "F9=toggle-preview"
set "F10=taskmgr"

set "PREVIEW=wmic process where processid={2} get /format:list | findstr /v /e = | align.rb"

fzf %* ^
  --bind="alt-a:reload(%TASKLIST% %NAME_SORT%)" ^
  --bind="alt-m:reload(%TASKLIST% %MEM_SORT%)" ^
  --bind="F1:reload(%F1%)" ^
  --bind="ctrl-r:reload(%F1%)" ^
  --bind="F5:execute(%F5%)+reload(%F1%)" ^
  --bind="enter:execute(%F5%)+abort" ^
  --bind="ctrl-k:execute(%F5%)+reload(%F1%)" ^
  --bind="F7:execute(%F7%)+reload(%F1%)" ^
  --bind="F9:%F9%" ^
  --bind="F10:execute(%F10%)" ^
  --header="[ F1:refresh | F5:kill (pid) | F7:kill (name) | F9:info | F10:taskmgr | ESC:exit ]" ^
  --preview="%PREVIEW%" ^
  --preview-window="right:80%%:hidden" ^
  %q%

