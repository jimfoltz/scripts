@echo off
setlocal

if "%1"=="-h" (
        echo d [terms] - search duckduckgo
        exit /b
)

set TERMS=%*
set TERMS=%TERMS: =+%
REM start "" /B https://lite.duckduckgo.com/lite?q=%TERMS%
start "" /B https://duckduckgo.com/?q=%TERMS%
