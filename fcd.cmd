@echo off

:: fcd.cmd - fuzzy change directory
::
:: needs:
::   fd - https://github.com/sharkdp/fd

for /f "delims=" %%i in ('fd --type d ^| fzf') do (
  cd "%%i"
  break
)
