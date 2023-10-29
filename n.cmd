@echo off
setlocal

where /q k.cmd
if %errorlevel% neq 0 (
	echo Could not find k.cmd.
	exit /b
)

set NOTESDIR=%USERPROFILE%\notes
set KEG_CURRENT=%NOTESDIR%

if [%1]==[-h] (
    echo %~n0
    exit /b
)

if [%1]==[-g] (
    cd %NOTESDIR%
    exit /b
)

if [%1]==[] (
    pushd %NOTESDIR%
    call k
    popd
)
