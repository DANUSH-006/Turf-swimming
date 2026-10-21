@echo off
setlocal
set "CATALINA_HOME=%~dp0apache-tomcat-10.1.59"

if not exist "%CATALINA_HOME%\bin\shutdown.bat" (
  echo Tomcat not found.
  pause
  exit /b 1
)

call "%CATALINA_HOME%\bin\shutdown.bat"
echo Tomcat stopped.
pause
endlocal
