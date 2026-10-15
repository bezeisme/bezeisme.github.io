@echo off
cd /d "%~dp0"

rem --- Make sure node/npm/git are found even if this window has a stale PATH ---
set "PATH=%ProgramFiles%\nodejs;%LOCALAPPDATA%\Programs\PortableGit\cmd;%PATH%"

netstat -ano | findstr ":4000" | findstr "LISTENING" >nul 2>&1
if not errorlevel 1 (
  echo.
  echo   [i] Port 4000 is already in use - the blog is probably already running.
  echo       Open:  http://localhost:4000
  echo.
  echo   If that URL does not work, close the other window that is serving
  echo   port 4000 and run this script again.
  echo.
  pause
  exit /b 0
)

echo.
echo   Blog preview:  http://localhost:4000
echo   Press Ctrl+C to stop.
echo.
npx hexo server
pause
