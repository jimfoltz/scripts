@echo off


if [%1] == [] (
  echo Usage:
  echo   uz filename.zip - unzip filename to temp folder.
  echo   uz [clean] - delete all folders starting with "uz-"
  goto eof
)

if [%1] == [clean]  (
  forfiles /m uz-* /c "cmd /c rd /q/s @file" 
  goto eof
)

set "UZTEMP=uz-tmp%RANDOM%"
md %UZTEMP%
cd %UZTEMP%
unzip ..\%1
cd %UZTEMP%
set UZTEMP=

:eof
