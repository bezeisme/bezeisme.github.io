@echo off
cd /d "%~dp0"
set "PATH=%ProgramFiles%\nodejs;%LOCALAPPDATA%\Programs\PortableGit\cmd;%PATH%"
set "GIT_TERMINAL_PROMPT=0"

echo.
echo   ===== 修复推送证书 ^& 推送 =====
echo   适用症状：git push 报
echo     unable to get local issuer certificate (20)
echo   或   CRYPT_E_NO_REVOCATION_CHECK
echo   原因：S302 换了中间人证书，旧的信任包对不上了
echo.

git add -A
git diff --cached --quiet
if errorlevel 1 (
  for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd_HHmm"') do set "STAMP=%%i"
  git commit -m "update %STAMP%"
) else (
  echo   没有需要提交的改动，直接推。
)

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0fix-push-ca.ps1"
set "RC=%errorlevel%"

echo.
if "%RC%"=="0" (
  echo   [成功] 已推送，约 1 分钟后线上更新：
  echo     https://github.com/bezeisme/bezeisme.github.io/actions
  echo     https://bezeisme.github.io
) else (
  echo   [失败] 修复后仍未推上去，把上面整屏截图发给 AI。
)
echo.
pause
