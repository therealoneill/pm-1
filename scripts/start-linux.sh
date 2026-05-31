#!/bin/bash
# Start the Project Management MVP application on Linux

set -e

echo "Building Docker image..."
docker-compose build

echo "Starting application..."
docker-compose up

echo "Application is running at http://localhost:8000"
echo "Press Ctrl+C to stop"
