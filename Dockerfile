# Multi-stage build: build frontend, then package with backend
FROM node:20-alpine AS frontend-builder

WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm ci
COPY frontend/ .
RUN npm run build

# Final stage: Python backend with static frontend
FROM python:3.12-slim

WORKDIR /app

# Install uv package manager
RUN pip install --no-cache-dir uv

# Copy backend files
COPY backend/ ./backend/
COPY pyproject.toml ./

# Copy built frontend from previous stage
COPY --from=frontend-builder /app/frontend/out ./backend/static

# Install Python dependencies using uv
RUN uv pip install --system --no-cache-dir -e .

# Expose port
EXPOSE 8000

# Run the application
CMD ["uvicorn", "backend.main:app", "--host", "0.0.0.0", "--port", "8000"]
