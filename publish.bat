@echo off
REM ===== Publish eddiekuoha.com =====
REM Double-click this file after you change anything in the site folder.
cd /d "%~dp0"

echo Publishing your site...
echo.

git add .
git commit -m "Update site (%date%)"
git push

echo.
echo ============================================
echo  Done. Your site updates in about a minute.
echo  If you see red error text above, copy it to Claude.
echo ============================================
echo.
pause
