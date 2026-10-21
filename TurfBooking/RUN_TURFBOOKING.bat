@echo off
setlocal

set "PROJECT_HOME=%~dp0TurfBooking"
set "WEBAPP=%PROJECT_HOME%\src\main\webapp"
set "CATALINA_HOME=%~dp0apache-tomcat-10.1.59"
set "CLASSES=%WEBAPP%\WEB-INF\classes"

if not exist "%CATALINA_HOME%\bin\startup.bat" (
  echo [ERROR] Tomcat 10.1.59 not found.
  pause
  exit /b 1
)

if not exist "%JAVA_HOME%\bin\javac.exe" (
  echo [ERROR] JAVA_HOME is not set correctly.
  echo Set JAVA_HOME to your JDK folder, then run this file again.
  pause
  exit /b 1
)

echo.
echo [1/5] Cleaning old compiled classes...
if exist "%CLASSES%" rmdir /s /q "%CLASSES%"
mkdir "%CLASSES%"

echo [2/5] Compiling Java source...
set "CP=%CATALINA_HOME%\lib\*;%WEBAPP%\WEB-INF\lib\*"
dir /s /b "%PROJECT_HOME%\src\main\java\*.java" > "%TEMP%\turf_sources.txt"
"%JAVA_HOME%\bin\javac.exe" -encoding UTF-8 -cp "%CP%" -d "%CLASSES%" @"%TEMP%\turf_sources.txt"
if errorlevel 1 (
  echo [ERROR] Java compilation failed.
  del "%TEMP%\turf_sources.txt" >nul 2>&1
  pause
  exit /b 1
)
del "%TEMP%\turf_sources.txt" >nul 2>&1

echo [3/5] Deploying web application to Tomcat...
if exist "%CATALINA_HOME%\webapps\TurfBooking" rmdir /s /q "%CATALINA_HOME%\webapps\TurfBooking"
xcopy "%WEBAPP%\*" "%CATALINA_HOME%\webapps\TurfBooking\" /E /I /Y /Q >nul
if errorlevel 1 (
  echo [ERROR] Web application copy failed.
  pause
  exit /b 1
)

echo [4/5] Starting Tomcat...
call "%CATALINA_HOME%\bin\startup.bat"

echo [5/5] Done.
echo.
echo Open: http://localhost:8080/TurfBooking/
echo.
echo IMPORTANT:
echo - Start MySQL before using login, registration or booking.
echo - Import TurfBookingDB.sql into MySQL.
echo - For Gmail OTP, set TURF_GMAIL_APP_PASSWORD before starting Tomcat.
echo.
pause
endlocal
