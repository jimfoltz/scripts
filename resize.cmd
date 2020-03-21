@echo off
REM Set the COLUMNS and LINES environment variable which is used by 
REM ls.exe to determine the column width for file listings.
REM https://u-tools.com/msls
for /F "tokens=1,2 delims=, usebackq" %%a in (`console-size`) do (
  setx COLUMNS %%a >NUL
  set COLUMNS=%%a
  setx LINES %%b >NUL
  set LINES=%%b
)
