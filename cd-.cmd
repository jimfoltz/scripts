@echo off
::setlocal
if "%1"=="" (
  cd ..
) else (
  for /l %%x in (1, 1, %1) do cd ..
)

if not "%2"=="" ( cd "%2" )
title %cd%
