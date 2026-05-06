@echo off
title Staff Document Repository
echo ============================================
echo   Staff Document Repository
echo ============================================
echo.

:: Check if JAR exists, build if not
if not exist "target\staff-doc-repository-1.0.0.jar" (
    echo JAR not found. Building project...
    echo.
    call mvn clean package -DskipTests
    if errorlevel 1 (
        echo.
        echo BUILD FAILED. Please check the errors above.
        pause
        exit /b 1
    )
    echo.
)

echo Starting application on http://localhost:8080
echo Press Ctrl+C to stop the server.
echo.

:: Start the app in a new window
start "Staff Document Repository" java -Djava.net.preferIPv4Stack=true -jar target\staff-doc-repository-1.0.0.jar

:: Wait for the app to respond before opening browser
echo Waiting for application to start...
:wait_loop
timeout /t 2 /nobreak >nul
curl -s --max-time 2 http://localhost:8080 >nul 2>&1
if errorlevel 1 goto wait_loop

echo Application is ready. Opening browser...
start "" "http://localhost:8080"
