@echo off
TITLE Internet reset by Chris Bawden
REM Mode con cols=60 lines=8
del %temp%\hhsjd.reg
cls


:start
if EXIST "%~dp0\proxy.ini" goto autoappl
call :proxy
call :reg_build
call :appl
cls
goto end


:proxy
cls
echo.
echo.
set /p proxy=" Enter proxy address: "
if "%proxy%" =="" echo Error! && goto proxy
echo.
exit /b

:appl
cls
echo.
echo.
echo      Applying changes ...
echo.
echo.     NOTE: You may receive a UAC prompt
timeout /t 5 >nul
regedit.exe /S %temp%\hhsjd.reg
echo.
timeout /t 5 >nul
exit /b

:end
cls
echo.
echo.
echo       Done
echo.
timeout/t 5 >nul
exit

http://wpad.health.qld.gov.au/wpad.dat


:reg_build
echo Windows Registry Editor Version 5.00 > %temp%\hhsjd.reg
echo. >> %temp%\hhsjd.reg
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings] >> %temp%\hhsjd.reg
echo "DisableCachingOfSSLPages"=dword:00000000 >> %temp%\hhsjd.reg
echo "IE5_UA_Backup_Flag"="5.0" >> %temp%\hhsjd.reg
echo "PrivacyAdvanced"=dword:00000001 >> %temp%\hhsjd.reg
echo "SecureProtocols"=dword:00000a80 >> %temp%\hhsjd.reg
echo "User Agent"="Mozilla/4.0 (compatible; MSIE 8.0; Win32)" >> %temp%\hhsjd.reg
echo "CertificateRevocation"=dword:00000001 >> %temp%\hhsjd.reg
echo "ZonesSecurityUpgrade"=hex:a2,5f,c9,f4,07,26,d5,01 >> %temp%\hhsjd.reg
echo "WarnonZoneCrossing"=dword:00000000 >> %temp%\hhsjd.reg
echo "EnableNegotiate"=dword:00000001 >> %temp%\hhsjd.reg
echo "MigrateProxy"=dword:00000001 >> %temp%\hhsjd.reg
echo "ProxyEnable"=dword:00000001 >> %temp%\hhsjd.reg
echo "AutoConfigURL"="%proxy%" >> %temp%\hhsjd.reg
echo "AutoDetect"=dword:00000000 >> %temp%\hhsjd.reg
exit /b


:autoappl
cls
echo.
echo.
echo     proxy.ini detected ....
echo.
set /p proxy=<proxy.ini
if "%proxy%" == "" Echo.    Error - proxy.ini empty && move %~dp0\proxy.ini %~dp0\proxy.ini.BROKEN >nul && timeout /t 5 >nul && goto start
Echo.    The system will apply configuration from proxy.ini
echo.
timeout /t 5 >nul
set /p proxy=<%~dp0\proxy.ini
call :reg_build
call :appl
goto end