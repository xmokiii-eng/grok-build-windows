@echo off
setlocal
chcp 65001 >nul
cd /d "%~dp0"
if exist "C:\GrokBuild" cd /d "C:\GrokBuild"
if exist "%USERPROFILE%\.grok\bin" set "PATH=%USERPROFILE%\.grok\bin;%PATH%"
where grok >nul 2>&1
if errorlevel 1 (
  echo Zuerst INSTALLIEREN.bat doppelklicken.
  pause
  exit /b 1
)
grok
pause
