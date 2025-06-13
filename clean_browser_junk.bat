@echo off
cls
echo ================================
echo     Browser Junk Cleaner Script
echo ================================
echo.

:: Request Admin Privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting Admin Privileges...
    powershell start -verb runas '%0'
    exit
)

:: Closing Browsers to Prevent Issues
echo Closing Browsers...
taskkill /IM chrome.exe /F >nul 2>&1
taskkill /IM msedge.exe /F >nul 2>&1
taskkill /IM firefox.exe /F >nul 2>&1
taskkill /IM brave.exe /F >nul 2>&1

:: Cleaning Chrome (Excluding History)
echo Cleaning Chrome Cache & Cookies (History Excluded)...
powershell -Command "Remove-Item -Path \"$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache\*\" -Force -Recurse -ErrorAction SilentlyContinue"
powershell -Command "Remove-Item -Path \"$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cookies\" -Force -ErrorAction SilentlyContinue"

:: Cleaning Edge
echo Cleaning Microsoft Edge History, Cache & Cookies...
powershell -Command "Remove-Item -Path \"$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\History\" -Force -ErrorAction SilentlyContinue"
powershell -Command "Remove-Item -Path \"$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache\*\" -Force -Recurse -ErrorAction SilentlyContinue"
powershell -Command "Remove-Item -Path \"$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cookies\" -Force -ErrorAction SilentlyContinue"

:: Cleaning Firefox
echo Cleaning Firefox History, Cache & Cookies...
powershell -Command "Remove-Item -Path \"$env:APPDATA\Mozilla\Firefox\Profiles\*.default-release\places.sqlite\" -Force -ErrorAction SilentlyContinue"
powershell -Command "Remove-Item -Path \"$env:APPDATA\Mozilla\Firefox\Profiles\*.default-release\cache2\*\" -Force -Recurse -ErrorAction SilentlyContinue"
powershell -Command "Remove-Item -Path \"$env:APPDATA\Mozilla\Firefox\Profiles\*.default-release\cookies.sqlite\" -Force -ErrorAction SilentlyContinue"

:: Cleaning Brave
echo Cleaning Brave Browser History, Cache & Cookies...
powershell -Command "Remove-Item -Path \"$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\User Data\Default\History\" -Force -ErrorAction SilentlyContinue"
powershell -Command "Remove-Item -Path \"$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\User Data\Default\Cache\*\" -Force -Recurse -ErrorAction SilentlyContinue"
powershell -Command "Remove-Item -Path \"$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\User Data\Default\Cookies\" -Force -ErrorAction SilentlyContinue"

:: Completion Message
echo.
echo ================================
echo     Browser Cleanup Completed! 
echo     (Chrome History Not Deleted)
echo ================================
echo Press any key to exit...
pause >nul
exit
