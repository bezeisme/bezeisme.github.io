@echo off
cd /d "%~dp0"
set "PATH=%ProgramFiles%\nodejs;%LOCALAPPDATA%\Programs\PortableGit\cmd;%PATH%"

for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd_HHmm"') do set "STAMP=%%i"

echo.
echo   ===== 存档（保存当前所有改动）=====
git add -A

git diff --cached --quiet
if not errorlevel 1 (
  echo   工作区是干净的，没有需要存档的改动。
  pause
  exit /b 0
)

echo   本次将存档以下文件：
echo.
git diff --cached --name-only
echo.
git commit -m "snapshot %STAMP%"

if errorlevel 1 (
  echo.
  echo   提交失败，把上面的报错发给 AI 看看。
) else (
  echo.
  echo   已存档，当前版本号：
  git log --oneline -1
  echo.
  echo   如果之后改坏了想回到这次存档，在 myblog 目录执行：git checkout .
)
pause
