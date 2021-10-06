 @echo off
MODE CON: COLS=68 LINES=40
setlocal enabledelayedexpansion
title Wireless scrubber
if EXIST %temp%\888563.txt del %temp%\888563.txt 
if EXIST %temp%\888562.txt del %temp%\888562.txt
if EXIST %temp%\888561.txt del %temp%\888561.txt
set wi=
set _string=
cls
echo.
echo ------------------------ Wireless networks  ------------------------
echo.
echo.
echo.
echo                        ... processing ...
echo.
echo.
echo --------------------------------------------------------------------
timeout /t 2 >nul
echo.
call :collect
call :extract
call :remo
goto end



:collect
set wi=
NETSH WLAN SHOW PROFILE | find /i " All User Profile">%temp%\888562.txt
REM type %temp%\888562.txt
exit /b

:extract
set wi=
set _string=
set /p _string=<%temp%\888562.txt
if "%_string%" == "" exit /b
REM echo %_string%
for /f "tokens=2 delims=:" %%a in ("%_string%") do (
  set wi=%%a
  )
echo %wi% >> %temp%\888561.txt
type %temp%\888562.txt | find /V /i "%wi%" >%temp%\888563.txt
move %temp%\888563.txt %temp%\888562.txt >nul
goto extract

:remo
cls
echo.
echo ------------------------ Wireless networks  ------------------------
echo.
type %temp%\888561.txt
echo.
echo --------------------------------------------------------------------
echo                                         NOTE: "all" = remove all
echo.
echo  Wireless network to remove:
echo.
set /p wir="-- "
echo.
if "%wir%" == "all" goto remoplus && exit /b
if "%wir%" == "All" goto remoplus && exit /b
if "%wir%" == "ALL" goto remoplus && exit /b
if "%wir%" == "" goto remo
type %temp%\888561.txt | find /i "%wir%" > %temp%\8829.txt
if %errorlevel% NEQ 0 echo error ! && timeout /t 5 >nul && goto remo
set /p wr=<%temp%\8829.txt
del %temp%\8829.txt
cls
echo.
echo -------------------------------------------------------------------
echo.
echo.
echo                       ... Clearing ...
echo.
echo.
NETSH WLAN DELETE PROFILE %wr%
echo.
exit /b


:remoplus
cls
echo.
echo -------------------------------------------------------------------
echo.
echo.
echo             ... Removing all wireless networks ...
echo.
echo.
netsh wlan delete profile name=* i=*
exit /b

:end
if EXIST %temp%\888563.txt del %temp%\888563.txt 
if EXIST %temp%\888562.txt del %temp%\888562.txt
if EXIST %temp%\888561.txt del %temp%\888561.txt
echo.
echo.
echo                    NOTE: Window will auto close
echo -------------------------------------------------------------------
timeout /t 30 >nul

exit
