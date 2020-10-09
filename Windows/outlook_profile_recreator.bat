@echo off
TITLE - Outlook Fix Tool - Chris Bawden
del "%temp%\email addresses.txt"
REG EXPORT "HKCU\Software\Microsoft\Office\16.0\Outlook\Profiles" "%temp%\email addresses.txt"
cls
echo.
echo.
echo.
findstr @ "%temp%\email addresses.txt"
echo.
echo.
echo.
echo Copy these email address's for when you re-create the profile. Press enter to continue when your ready.
pause > nul
echo killing applications ....

taskkill /IM "lync.exe" /F
taskkill /IM "teams.exe" /F
taskkill /IM "outlook.exe" /F

cls
echo.
echo.
echo.
echo.
set /p profile_name=New profile name:
reg add HKCU\Software\Microsoft\Office\16.0\Outlook\Profiles\%profile_name%
reg add "HKCU\Software\Microsoft\Office\16.0\Outlook" /v DefaultProfile /t REG_SZ /d "%profile_name%" /F
cls
echo.
echo.
echo.
echo.
echo Starting Outlook ...
timeout /t 1 >nul
start outlook
cls
echo.
echo.
echo Just in case ...
echo. 
echo.
echo.
findstr @ "%temp%\email addresses.txt"
echo. 
echo.
timeout /t 300 >nul
exit