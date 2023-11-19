@echo off
setlocal

if [%1]==[/h] goto :usage
if [%1]==[-h] goto :usage

if [%1]==[] (
    echo %cd%
    echo %cd% | clip
    exit /b
)

if [%1]==[/] (
    if [%2]==[] (
        echo %cd:\=/%
        echo %cd:\=/% | clip
    ) else (
        echo %cd:\=/%/%2
        echo %cd:\=/%/%2 | clip
    )
) else (
    echo %cd%\%1
    echo %cd%\%1 | clip
)
goto :eof

:usage
echo cpd.cmd - copy file and directory paths to the clipboard
echo Usage: cpd [/] [filename.ext]
echo  cpd             - copies the current directory.
echo  cpd file.ext    - copies the full path of the file.
echo  cpd /           - copies the current directory using / instead of \
echo  cpd / file.ext  - copies the full file path using / instead of \
