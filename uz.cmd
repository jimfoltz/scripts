@echo off

where /q 7z.exe
if %errorlevel% neq 0 (
	echo could not find 7z.exe
	exit /b
)

if [%1] == [] (
  echo Usage:
  echo   uz filename.zip - unzip filename to temp folder.
  echo   uz [cleanup] - delete all folders ending with ".uz"
  goto eof
)

if [%1] == [cleanup]  (
  forfiles /m *.uz /c "cmd /c rd /q/s @file" 
  goto eof
)

set UZTEMP="%1.uz"

md %UZTEMP%
if %errorlevel% neq 0 (
	exit /b
)

cd %UZTEMP%
call 7z.exe x ..\%1

:cleanup
set UZTEMP=
