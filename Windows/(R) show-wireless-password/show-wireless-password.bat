@echo off
setlocal enabledelayedexpansion
set wi=
set _string=
echo.
echo ---------- Wireless network keys ----------

call :collect
:loop
call :extract
if "%wi%" == "" goto end
call :output
goto loop



:collect
set wi=
NETSH WLAN SHOW PROFILE | find /i " All User Profile">%temp%\888562.txt
exit /b

:extract
set wi=
set _string=
set /p _string=<%temp%\888562.txt
REM echo %_string%
for /f "tokens=2 delims=:" %%a in ("%_string%") do (
  set wi=%%a
  )
type %temp%\888562.txt | find /V /i "%wi%" >%temp%\888563.txt
move %temp%\888563.txt %temp%\888562.txt >nul
exit /b

:output
echo.
echo.
echo Wireless SSID: %wi%
echo.
NETSH WLAN SHOW PROFILE %wi% KEY=CLEAR | find /i "Key Content"
exit /b

:end
if EXIST %temp%\888563.txt del %temp%\888563.txt 
if EXIST %temp%\888562.txt del %temp%\888562.txt
echo.
echo.
echo -----------------------------------------
pause >nul

exit
