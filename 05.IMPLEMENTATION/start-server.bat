@echo off
echo Stopping any running Node.js servers...
taskkill /F /IM node.exe 2>nul
echo.
echo Starting the server...
node server.js
pause 