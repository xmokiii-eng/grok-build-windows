@echo off
setlocal EnableExtensions
chcp 65001 >nul
cd /d "%~dp0"

echo.
echo  Grok Build  —  C:\GrokBuild
echo.

if /I not "%CD%"=="C:\GrokBuild" (
  if not exist "C:\GrokBuild" mkdir "C:\GrokBuild"
  copy /Y "%~dp0INSTALLIEREN.bat" "C:\GrokBuild\" >nul
  copy /Y "%~dp0OmniRoute-starten.bat" "C:\GrokBuild\" >nul
  copy /Y "%~dp0Grok-starten.bat" "C:\GrokBuild\" >nul
  if exist "%~dp0LESEN.txt" copy /Y "%~dp0LESEN.txt" "C:\GrokBuild\" >nul
  cd /d "C:\GrokBuild"
)

echo Installiere Grok CLI...
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://x.ai/cli/install.ps1 | iex"
if exist "%USERPROFILE%\.grok\bin" set "PATH=%USERPROFILE%\.grok\bin;%PATH%"

where grok >nul 2>&1
if errorlevel 1 (
  echo.
  echo grok nicht gefunden. Dieses Fenster schliessen,
  echo neues oeffnen, dann INSTALLIEREN.bat nochmal.
  pause
  exit /b 1
)

echo.
echo Login im Browser (SuperGrok oder X Premium+)...
grok login

where npm >nul 2>&1
if errorlevel 1 (
  echo.
  echo npm fehlt. Node.js LTS von nodejs.org, dann INSTALLIEREN.bat nochmal.
) else (
  echo.
  echo OmniRoute — Standard-Plugin...
  call npm install -g omniroute
  grok mcp add omniroute --command omniroute --args "--mcp"
  echo.
  echo Danach zwei Fenster:
  echo   OmniRoute-starten.bat
  echo   Grok-starten.bat
)

echo.
echo Starte grok in %CD%
grok
pause
