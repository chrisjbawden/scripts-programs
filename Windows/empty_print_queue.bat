@echo off
TITLE PRINTER QUEUE EMPTIER - Made by Chris Bawden
::-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrator credentials...
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
IF "%ERRORLEVEL%" NEQ 0 (
GOTO error_handling
) else (
net start spooler
cls
echo -----------------------------------------
echo.
echo.
echo Print queue cleared
echo.
echo.
echo -----------------------------------------
timeout /t 5 >nul
goto exit
)



:erro_handling
echo Soemthing went wrong. You may need to reboot the computer to clear print queue.
timeout /t 5
goto exit


:exit
del nul
exit
