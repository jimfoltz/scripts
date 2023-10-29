@echo off
rem setlocal EnableDelayedExpansion

:: fcd.cmd - fuzzy change directory
::
:: needs:
::   fd - https://github.com/sharkdp/fd
:: Search for files and directories.
:: try to cd to selected. Will suceed if directory
:: else try to cd to path minus filename.

for /f "delims=" %%i in ('fd -d2 ^| fzf --header=%cd%') do (
  cd "%%i" 2>nul || cd %%~dpi 2>nul
  break
)
