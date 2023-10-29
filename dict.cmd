@echo off
setlocal

curl -s dict://dict.org/d:%1 -o C:\Users\Jim\dict\%1
%PAGER% -F C:\Users\Jim\dict\%1
