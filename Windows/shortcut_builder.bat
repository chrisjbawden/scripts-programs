@echo off
TITLE Shortcut Builder Tool - By Chris Bawden

REM creat working location
set tempfilename=%TEMP%\%RANDOM%_%RANDOM%.txt
echo . > %tempfilename%


:browser
ECHO.
ECHO Pick the browser you would like to set as the default browser for this shortcut.
ECHO.
ECHO -------------------------
ECHO -------------------------
ECHO.
ECHO 1.Internet Explorer
ECHO.
ECHO 2.Firefox
ECHO.
ECHO 3.Chrome
ECHO.
ECHO 4.EDGE
ECHO.
ECHO -------------------------
ECHO -------------------------
ECHO.
ECHO 5.Exit
ECHO.

CHOICE /D 4 /T 45 /C 1234  /M "Enter your choice:"
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 5 goto exit
IF ERRORLEVEL 4 set browser="C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" && goto name
IF ERRORLEVEL 3 set browser="C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" && goto name
IF ERRORLEVEL 2 set browser="C:\Program Files\Mozilla Firefox\firefox.exe" && goto name
IF ERRORLEVEL 1 set browser="C:\Program Files\Internet Explorer\iexplore.exe" && goto name

:name_in_use
cls
echo.
echo.
echo Name already in use...In a moment you will be asked again.
timeout /nobreak /t 2 >nul
goto name

:name
timeout /t 1 /nobreak >nul
cls
ECHO.
ECHO.
ECHO.
ECHO.
set /p name=enter name of shortcut: 
timeout /nobreak /t 1 >nul
IF EXIST "C:\users\%username%\Desktop\%name%.lnk" (goto name_in_use)
goto url

:url
cls
ECHO.
ECHO.
ECHO.
ECHO Note: Copy and paste your URL or website address here for the best accuracy.
ECHO.
echo Shortcut name - %name%
ECHO.
set /p URL=enter URL of shortcut: 


set TARGET=%URL%
del %tempfilename%
set SHORTCUT=C:\users\%username%\Desktop\%name%.lnk
set PWS=powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile



:create shortcut

%PWS% -Command "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%SHORTCUT%'); $S.TargetPath = '%browser%'; $S.Arguments = "'"%URL%"'";$S.Save()"

cls
echo. Shortcut created and stored on desktop. Press any key to exit.
timeout 5 > nul
:exit
del nul
exit