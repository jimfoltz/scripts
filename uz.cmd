@echo off

where /q unzip
if %errorlevel% neq 0 (
    echo Did not find program unzip.exe. Exiting.
    exit /b
)

if [%1] == [] (
  echo Usage:
  echo   uz filename.zip - unzip filename to temp folder.
  echo   uz clean - delete all folders ending with "-uz"
  goto :eof
)

if [%1] == [clean]  (
  forfiles /m *-UZ /c "cmd /c if @isdir==TRUE rd /q/s @file" 
  goto :eof
)

set "UZTEMP=%1-UZ"
md %UZTEMP%
cd %UZTEMP%
unzip ..\%1
set UZTEMP=

