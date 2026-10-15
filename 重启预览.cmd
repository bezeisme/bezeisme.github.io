@echo off
cd /d "%~dp0"

rem --- Make sure node/npm/git are found even if this window has a stale PATH ---
set "PATH=%ProgramFiles%\nodejs;%LOCALAPPDATA%\Programs\PortableGit\cmd;%PATH%"

echo.
echo   Stopping any preview already running on port 4000 ...
for /f "tokens=5" %%p in ('netstat -ano ^| findstr ":4000" ^| findstr "LISTENING"') do (
  taskkill /PID %%p /T /F >nul 2>&1
)
ping -n 2 127.0.0.1 >nul

echo   Starting a fresh preview with the current config ...
echo.
echo   Blog preview:  http://localhost:4000
echo   Press Ctrl+C to stop.
echo.
npx hexo server
pause
