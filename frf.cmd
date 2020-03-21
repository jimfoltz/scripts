@echo off
setlocal

if "%1"=="-h" goto :usage

set dur=%1
if "%dur%"=="" set dur=1d

set depth=%2
if "%depth%"=="" set depth=2

echo cmd: fd --changed-within %dur% --max-depth %depth%
fd --changed-within %dur% --max-depth %depth% 

goto :eof

:usage
echo Usage: fdr [duration = 1d] [depth = 2]
echo.
echo example durations: 2weeks, 20min, 3d, 1month, 4days, 30sec
