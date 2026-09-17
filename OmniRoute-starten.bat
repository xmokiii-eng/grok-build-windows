@echo off
setlocal
chcp 65001 >nul
cd /d "%~dp0"
where omniroute >nul 2>&1
if errorlevel 1 (
  where npm >nul 2>&1
  if errorlevel 1 (
    echo npm fehlt. Zuerst INSTALLIEREN.bat
    pause
    exit /b 1
  )
  call npm install -g omniroute
)
echo OmniRoute laeuft. Dieses Fenster offen lassen.
omniroute
pause
