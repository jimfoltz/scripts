@echo off
setlocal

REM https://ponderingdeveloper.com/2013/05/06/237/

set macrofile=c:\users\jim\scripts\doskey\macros.txt

IF "%*" == "" goto displayMacros
IF /I "%1" == "SAVE" goto saveMacro
IF /I "%1" == "LOAD" goto loadMacro
IF /I "%1" == "EDIT" goto editMacroFile
goto runMacro

:displayMacros
doskey /macros
goto end

:saveMacro
doskey /macros > %macrofile% & ECHO Aliases SAVED
goto end

:loadMacro
doskey /macrofile=%macrofile% & ECHO Aliases LOADED & doskey /macros
goto end

:editMacroFile
%editor% %macrofile%
goto end

:runMacro
doskey %*
goto end

:end
