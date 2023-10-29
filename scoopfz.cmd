@echo off
setlocal

set LOGFILE=%USERPROFILE%\tmp\scoopfz.log
set UPLOGFILE=%USERPROFILE%\tmp\scoop-update.log

if [%1]==[log] (
	echo viewing: %LOGFILE%
	%PAGER% %LOGFILE%
	goto :EOF
)

call now -l -q
set /p stamp=<%ANS_FILE%

if [%1]==[-c] (
	echo clear log file. exiting.
	echo. > %LOGFILE%
	exit /b
)

echo( >> %LOGFILE%
echo %stamp% >> %LOGFILE%
set appfile=%~dp0\scoopfz\app-list-%COMPUTERNAME%
echo appfile:%appfile%

if not exist %appfile% call %~dp0\scoopfz\gen-app-list

if "%1%"=="u" (
	rem call ruby %~dp0\scoopfz\build-app-list.rb 2>>%LOGFILE%
	echo Updating app list...
	echo. > %LOGFILE%
	call %~dp0\scoopfz\gen-app-list update 2>>%LOGFILE%
	echo ERRORLEVEL: %ERRORLEVEL% >>%LOGFILE%
	REM exit /b
)

:main
set "FZF_DEFAULT_COMMAND=type %appfile%
set FZF_DEFAULT_OPTS=--reverse --no-hscroll --ansi +s

rem --bind "ctrl-u:execute(cmd /c ruby %~dp0\scoopfz\gen-app-list.exe && pause)+reload(%FZF_DEFAULT_COMMAND%)" ^
fzf -d "\|" --ansi ^
--info inline ^
--header "HELP: [ F1:Homepage | F2:Install | F3:Uninstall | F4:Scoop Update | ctrl-u: update app-list | ESC:quit ]" ^
--bind "f1:execute-silent(scoop home {3})" ^
--bind "f2:execute(cmd /c scoop install {3} && pause)" ^
--bind "f3:execute(cmd /c scoop uninstall {3} && pause)" ^
--bind "ctrl-p:execute(cmd /c scoop uninstall -p {3} |tee -a %LOGFILE%)" ^
--bind "f4:execute(cmd /c scoopfz u && pause)" ^
--bind "home:top" ^
--bind "change:top" ^
--bind "ctrl-i:change-query(^1)" ^
--bind "ctrl-j:change-query(^01)" ^
--bind "ctrl-u:execute(%~dp0\scoopfz\gen-app-list && pause)+reload(%FZF_DEFAULT_COMMAND%)" ^
--with-nth "1..4" ^
--preview "echo {3} & echo {4} & echo {5}" ^
--preview-window "top:3:wrap"  | tee -a %LOGFILE% 

echo LOG: %LOGFILE%
rem type %LOGFILE%

