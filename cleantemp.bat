@echo off
cls
echo ================================
echo     Windows Junk Cleaner Script
echo ================================
echo.

:: Request Admin Privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting Admin Privileges...
    powershell start -verb runas '%0'
    exit
)

:: Stopping Windows Update Services to delete update cache
echo Stopping Windows Update Service...
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1

:: Deleting %temp% files
echo Deleting %temp% Files...
del /s /q "%temp%\*.*" >nul 2>&1
rd /s /q "%temp%" >nul 2>&1
mkdir "%temp%" >nul 2>&1

:: Deleting C:\Windows\Temp files
echo Deleting Windows Temp Files...
del /s /q "C:\Windows\Temp\*.*" >nul 2>&1
rd /s /q "C:\Windows\Temp" >nul 2>&1
mkdir "C:\Windows\Temp" >nul 2>&1

:: Deleting Prefetch files
echo Deleting Prefetch Files...
del /s /q "C:\Windows\Prefetch\*.*" >nul 2>&1
rd /s /q "C:\Windows\Prefetch" >nul 2>&1
mkdir "C:\Windows\Prefetch" >nul 2>&1

:: Deleting Windows Update Cache
echo Deleting Windows Update Cache...
del /s /q "C:\Windows\SoftwareDistribution\Download\*.*" >nul 2>&1

:: Deleting System Log Files
echo Deleting System Log Files...
del /s /q "C:\Windows\Logs\*.*" >nul 2>&1

:: Restarting Windows Update Services
echo Restarting Windows Update Service...
net start wuauserv >nul 2>&1
net start bits >nul 2>&1

:: Completion Message
echo.
echo ================================
echo     Cleanup Completed done! 
echo ================================
echo Press any key to exit...
pause >nul
exit
