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
echo   正在推送...（代理偶尔 502，脚本会自动重试，最多 5 次）
echo   ------------------------------------------------------------------
echo   若弹出 "Connect to GitHub" 登录窗口：
echo     1) 点上面的 Token 标签页
echo     2) 粘贴访问令牌，点 Sign in
echo     3) 以后就不用再授权了
echo.
echo   若没有弹窗、而是这里直接问 Username / Password：
echo     Username 输入： bezeisme
echo     Password 粘贴： 你的访问令牌（粘贴时屏幕上不显示，属正常）
echo   ------------------------------------------------------------------

set /a TRY=0

:retry
set /a TRY+=1
echo.
echo   ---------- 第 %TRY% 次尝试 ----------
git push -u origin main
if %errorlevel%==0 goto ok
if %TRY% GEQ 5 goto fail
echo.
echo   这次没成功，等 3 秒再试...
ping -n 4 127.0.0.1 >nul
goto retry

:ok
echo.
echo   [成功] 推送完成！
echo   去这里看自动构建进度（约 1-2 分钟）：
echo     https://github.com/bezeisme/bezeisme.github.io/actions
echo   构建完成后访问： https://bezeisme.github.io
goto end

:fail
echo.
echo   [失败] 连续 5 次都没成功。
echo   把这一整屏截图发给 AI（令牌那行记得打码）。

:end
echo.
pause
