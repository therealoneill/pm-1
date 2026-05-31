# Scripts

Helper scripts for starting and stopping the application in Docker.

## Starting the Application

### Windows
```bash
scripts/start-windows.bat
```

### macOS
```bash
chmod +x scripts/start-macos.sh
./scripts/start-macos.sh
```

### Linux
```bash
chmod +x scripts/start-linux.sh
./scripts/start-linux.sh
```

The application will be accessible at `http://localhost:8000`

## Stopping the Application

### Windows
```bash
scripts/stop-windows.bat
```

### macOS
```bash
chmod +x scripts/stop-macos.sh
./scripts/stop-macos.sh
```

### Linux
```bash
chmod +x scripts/stop-linux.sh
./scripts/stop-linux.sh
```

## Debugging

To see detailed logs while running:
```bash
docker-compose logs -f
```

To access the container shell:
```bash
docker-compose exec app bash
```

To rebuild the image without cache:
```bash
docker-compose build --no-cache
```
