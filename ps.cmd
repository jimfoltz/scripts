@echo off
setlocal

rem doc: ps.cmd
rem doc:   list process sorted by memory use.
rem doc:
rem doc: Options:
rem doc:  -n  sort by process name

set SORT=sort /+65

if [%1]==[-h] goto usage
if "%1"=="-n" set SORT=sort /+1
tasklist /nh | findstr /v svchost | findstr exe | %SORT%

goto:eof

:usage
echo ps - list processes
echo ps -n sort by name
