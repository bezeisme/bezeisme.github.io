@echo off
cd /d "%~dp0"
set "PATH=%ProgramFiles%\nodejs;%LOCALAPPDATA%\Programs\PortableGit\cmd;%PATH%"

echo.
echo   ===== 推送到 GitHub（会自动触发 Pages 重新部署）=====

git add -A
git diff --cached --quiet
if errorlevel 1 (
  for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd_HHmm"') do set "STAMP=%%i"
  git commit -m "update %STAMP%"
)

echo.
echo   正在推送...
echo   ------------------------------------------------------------------
echo   若弹出 "Connect to GitHub" 登录窗口：
echo     1) 点上面的 Token 标签页
echo     2) 把访问令牌粘贴进去，点 Sign in
echo     3) 之后就不用再授权了
echo.
echo   若没有弹窗、而是这里直接问 Username / Password：
echo     Username 输入： bezeisme
echo     Password 粘贴： 你的访问令牌（粘贴时屏幕不显示，正常现象）
echo   ------------------------------------------------------------------
echo.

git push -u origin main

echo.
echo   退出码 = %errorlevel%
echo   0 = 成功；非 0 = 失败，把上面整屏内容截图发给 AI
echo.
pause
