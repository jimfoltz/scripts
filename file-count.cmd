@echo off
REM display the number of files in a folder.
REM Does not count folders themselves, only files.
REM
dir /a-d /b %* | find /v /c ""
