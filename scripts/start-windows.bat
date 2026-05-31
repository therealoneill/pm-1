@echo off
REM Start the Project Management MVP application on Windows

echo Building Docker image...
docker-compose build

if %ERRORLEVEL% neq 0 (
    echo Error building Docker image
    exit /b 1
)

echo Starting application...
docker-compose up

echo Application is running at http://localhost:8000
echo Press Ctrl+C to stop
