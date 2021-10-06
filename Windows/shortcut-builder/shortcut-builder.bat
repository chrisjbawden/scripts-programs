@echo off
TITLE Shortcut Builder Tool - By Chris Bawden V1.1

REM -------------------   defining a work directory

set tempfilename=%TEMP%\%RANDOM%_%RANDOM%.txt
echo . > %tempfilename%


REM -------------------   prompting user to chose a browser

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
REM IF ERRORLEVEL 4 set browser="C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" && goto name
REM IF ERRORLEVEL 4 set browser=C:\Windows\explorer.exe && goto edge
IF ERRORLEVEL 4 set browser="C:\Windows\explorer.exe" && goto edge
IF ERRORLEVEL 3 set browser="C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" && goto name
IF ERRORLEVEL 2 set browser="C:\Program Files\Mozilla Firefox\firefox.exe" && goto name
IF ERRORLEVEL 1 set browser="C:\Program Files\Internet Explorer\iexplore.exe" && goto name


REM ----------------------- prompting the user for the name of the shortcut

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

:name_in_use
cls
echo.
echo.
echo Name already in use...Please chose a different name.
timeout /nobreak /t 2 >nul
goto name

REM ------------------------- prompting the user for the URL

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
goto createshortcut


REM ---------------------- powershell script to create shortcut from the information gathered

:createshortcut
del %tempfilename%
set SHORTCUT=C:\users\%username%\Desktop\%name%.lnk
set PWS=powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile
%PWS% -Command "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%SHORTCUT%'); $S.TargetPath = '%browser%'; $S.Arguments = "'"%URL%"'"; $S.Save()"
cls
ECHO.
ECHO.
ECHO.
echo. Shortcut created and stored on desktop. Press any key to exit.
timeout 5 > nul
goto exit





REM ----------------------- success notification and closure/exit

:completion
cls
ECHO.
ECHO.
ECHO.
echo. Shortcut created and stored on desktop. Press any key to exit.
timeout 5 > nul
goto exit








:exit
del nul
exit











REM ------------- because edge is special



:edge
timeout /t 1 /nobreak >nul
cls
ECHO.
ECHO.
ECHO.
ECHO.
set /p name=enter name of shortcut: 
timeout /nobreak /t 1 >nul
IF EXIST "C:\users\%username%\Desktop\%name%.lnk" (cls && echo. && echo. && echo Error - File with existing name detected... && timeout /t 5 > nul && goto edge)

:edgeurl
cls
ECHO.
ECHO.
ECHO.
ECHO Note: Copy and paste your URL or website address here for the best accuracy.
ECHO.
echo Shortcut name - %name%
ECHO.
set /p URL=enter URL of shortcut: 
(echo %URL% | findstr /i /c:"http" >nul) && (goto edgebuild) || (cls && echo. && echo. && echo ERROR: URL does not contain "https://" or "http://" && timeout /t 5 >nul && goto edgeurl)


:edgebuild
del %tempfilename%
set SHORTCUT=C:\users\%username%\Desktop\%name%.lnk
set PWS=powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile
set argument=microsoft-edge:%URL%
%PWS% -Command "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%SHORTCUT%'); $S.TargetPath = '%browser%'; $S.Arguments = '%argument%'; $S.IconLocation='"C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe,0"'; $S.Save()"
goto completion
