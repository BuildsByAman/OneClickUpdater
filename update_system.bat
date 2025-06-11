@echo off
cls
echo =========================================
echo       Windows, Driver & Software Update
echo =========================================
echo.

:: --- Request Admin Privileges ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting Admin Privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: --- Install PSWindowsUpdate Module if Missing ---
echo Checking for PSWindowsUpdate Module...
powershell -Command "if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) { Install-PackageProvider -Name NuGet -Force; Install-Module -Name PSWindowsUpdate -Force }"

:: --- Import Module and Perform Windows Update ---
echo Checking for Windows Updates...
powershell -Command "Import-Module PSWindowsUpdate; Get-WindowsUpdate"

echo Installing Windows Updates...
powershell -Command "Import-Module PSWindowsUpdate; Install-WindowsUpdate -AcceptAll -AutoReboot"

:: --- Driver & Optional Updates ---
echo Checking for Driver & Optional Updates...
powershell -Command "Import-Module PSWindowsUpdate; Get-WindowsUpdate -MicrosoftUpdate -Category 'Drivers'"

:: --- Software Updates via Winget ---
echo.
echo =========================================
echo   Detecting and Updating Installed Apps
echo =========================================

:: List upgradeable packages and update them
powershell -Command "winget upgrade --accept-source-agreements --accept-package-agreements | Out-String | ForEach-Object { Write-Output $_ }; winget upgrade --all --accept-source-agreements --accept-package-agreements"

:: --- Completion Message ---
echo.
echo =========================================
echo     All System & App Updates Done!
echo =========================================
echo Press any key to exit...
pause >nul
exit
