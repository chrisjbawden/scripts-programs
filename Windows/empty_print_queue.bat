@echo off
TITLE PRINTER QUEUE EMPTIER - Made by Chris Bawden
::-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting a-dash credentials...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
::--------------------------------------
cls
echo ---------------------------------------
echo ---------------------------------------
echo.
net stop spooler
timeout /t 1 > null
del %systemroot%\System32\spool\printers\* /Q
IF ERRORLEVEL 1 GOTO error_handling
net start spooler
cls
echo -----------------------------------------
echo.
echo.
echo Print queue for asset - %computername% has been cleared.
echo.
echo.
echo -----------------------------------------
timeout /t 5 >nul
goto exit



:erro_handling
echo Soemthing went wrong. You may need to reboot the computer to clear print queue.
timeout /t 5
goto exit


:exit
del nul
exit