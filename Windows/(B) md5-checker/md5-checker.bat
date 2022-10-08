@echo off
title MD5 file checker
set fil=
set has=
:start
cls
set fil=
set has=
echo.
echo Drag your file below and press enter
echo.
set /p fil="|      " 
if "%fil:"=%" == "history" goto history
if "%fil:"=%" == "" goto start
echo.
echo Checking ....
certutil -hashfile "%fil:"=%" MD5 | find /V "CertUtil:" | find  /v "MD5 hash of" >%temp%\36472
set /p has=<%temp%\36472
if  "%has%" == "" cls && echo. && echo. && echo        Error ! && timeout /t 5 >nul && del %temp%\36472 && goto start
del %temp%\36472
echo %fil%       %has% >> %temp%\md5-checker.log
cls
echo.
echo.
echo.
Echo Filename:     %fil% 
echo.
echo MD5 Hash:     %has%
echo.
echo.
echo.
echo          History:
echo.
type %temp%\md5-checker.log | find /i "%fil%"
echo.
echo Press any key to return
pause >nul
goto start


:history
cls
%temp%\md5-checker.log
goto start
