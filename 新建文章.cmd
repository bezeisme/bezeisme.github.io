@echo off
cd /d "%~dp0"
set "PATH=%ProgramFiles%\nodejs;%LOCALAPPDATA%\Programs\PortableGit\cmd;%PATH%"

echo.
echo   ===== 新建文章 =====
echo   提示：标题里不要带引号和冒号
echo.
set "TITLE="
set /p "TITLE=请输入文章标题（直接回车取消）: "
if not defined TITLE (
  echo   已取消。
  pause
  exit /b 0
)

npx hexo new post "%TITLE%"
echo.
echo   已创建，正在打开 source\_posts 文件夹...
start "" "%~dp0source\_posts"
echo.
echo   回到浏览器刷新页面即可看到新文章（预览服务会自动重建）。
pause
