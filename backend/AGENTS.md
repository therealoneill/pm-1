# Backend Documentation

## Overview

FastAPI-based backend for the Project Management MVP. Handles API endpoints, database operations, and AI integration.

**Status:** Basic scaffolding complete, ready for feature development

## Project Structure

```
backend/
├── __init__.py              # Package initialization
├── main.py                  # FastAPI application entry point
├── database.py              # Database configuration (Part 5)
├── routers/                 # API route handlers
│   ├── __init__.py
│   ├── auth.py             # Authentication endpoints (Part 4)
│   ├── boards.py           # Board CRUD endpoints (Part 6)
│   ├── columns.py          # Column CRUD endpoints (Part 6)
│   ├── cards.py            # Card CRUD endpoints (Part 6)
│   └── ai.py               # AI endpoints (Part 8)
├── models/                 # Data models and schemas
│   ├── __init__.py
│   ├── user.py             # User model (Part 4)
│   ├── board.py            # Board model (Part 5)
│   ├── column.py           # Column model (Part 5)
│   ├── card.py             # Card model (Part 5)
│   └── schemas.py          # Pydantic request/response schemas
├── services/               # Business logic
│   ├── __init__.py
│   ├── auth.py             # Authentication logic (Part 4)
│   ├── board_service.py    # Board operations (Part 6)
│   ├── card_service.py     # Card operations (Part 6)
│   ├── ai_service.py       # AI integration (Part 8)
│   ├── conversation_service.py # Chat history (Part 9)
│   └── operation_executor.py   # AI operation execution (Part 9)
└── tests/                  # Test suite
    ├── __init__.py
    ├── test_health.py      # Health check tests (Part 2)
    ├── test_auth.py        # Authentication tests (Part 4)
    ├── test_auth_endpoints.py
    ├── test_board_api.py   # Board API tests (Part 6)
    ├── test_column_api.py
    ├── test_card_api.py
    ├── test_ai_service.py  # AI tests (Part 8)
    ├── test_ai_chat.py     # Chat endpoint tests (Part 9)
    └── conftest.py         # Pytest fixtures
```

## Technology Stack

- **FastAPI 0.104.1** - Modern async Python web framework
- **Uvicorn 0.24.0** - ASGI server
- **Pydantic 2.5.0** - Data validation with type hints
- **SQLAlchemy 2.0.23** - ORM for database operations
- **SQLite** - Local database (created automatically)
- **python-jose** - JWT token handling
- **passlib** - Password hashing
- **httpx** - Async HTTP client for OpenRouter API
- **pytest** - Testing framework
- **python-dotenv** - Environment variable management

## Current Status (Part 2)

### Completed
- ✅ Docker containerization setup
- ✅ FastAPI app with health check endpoints
- ✅ Basic test infrastructure
- ✅ Environment configuration
- ✅ Start/stop scripts for all platforms
- ✅ Project structure scaffolding

### Not Yet Implemented
- ❌ Database models and migrations (Part 5)
- ❌ Authentication system (Part 4)
- ❌ API endpoints (Part 6)
- ❌ AI integration (Part 8-9)
- ❌ Database initialization on startup

## Running the Application

### Build and Start
```bash
# Using start script (recommended)
./scripts/start-macos.sh      # macOS
./scripts/start-linux.sh      # Linux
scripts/start-windows.bat     # Windows

# Or directly with Docker Compose
docker-compose up
```

### Access
- Application: `http://localhost:8000`
- Health check: `http://localhost:8000/health`
- API health: `http://localhost:8000/api/health`

### Stop
```bash
./scripts/stop-macos.sh       # macOS
./scripts/stop-linux.sh       # Linux
scripts/stop-windows.bat      # Windows

# Or directly
docker-compose down
```

## Running Tests

### Docker
```bash
docker-compose exec app pytest
docker-compose exec app pytest -v  # Verbose
docker-compose exec app pytest --cov  # With coverage
```

### Local (if Python environment set up)
```bash
pytest
pytest -v
pytest --cov
```

## Main.py Overview

The FastAPI application entry point handles:

1. **CORS Configuration** - Allows all origins for local development
2. **Health Endpoints** - Basic health checks for monitoring
3. **Static File Serving** - Serves built frontend from `backend/static/`

```python
app = FastAPI()
# CORS middleware
# Health check routes
# Mount static files at root
```

## Environment Variables

Configured in `.env` file (loaded by docker-compose):

```
OPENROUTER_API_KEY=sk-or-v1-...    # Your OpenRouter API key
DATABASE_URL=sqlite:///./kanban.db  # SQLite database path
JWT_SECRET=dev-secret-change-...   # JWT signing secret
DEBUG=true                          # Debug mode
```

## Database Setup

Database will be initialized automatically in Part 5. Currently, no persistent storage is used.

## API Structure (To Be Implemented)

Routes will be organized as:
- `GET/POST /api/auth/` - Authentication
- `GET/POST/PUT/DELETE /api/boards/` - Board management
- `GET/POST/PUT/DELETE /api/boards/{id}/columns/` - Column management
- `GET/POST/PUT/DELETE /api/boards/{id}/cards/` - Card management
- `POST /api/ai/test` - AI connectivity test (Part 8)
- `POST /api/ai/chat` - Chat endpoint (Part 9)

All endpoints will require JWT authentication (except test endpoints).

## Development Workflow

1. **Edit code** in `backend/` directory
2. **Changes auto-reload** in container (via `--reload` flag)
3. **Check logs** with `docker-compose logs -f`
4. **Run tests** with `docker-compose exec app pytest`
5. **Stop container** with stop script or Ctrl+C

## Debugging

### View Logs
```bash
docker-compose logs -f
docker-compose logs -f app  # Just app container
```

### Shell Access
```bash
docker-compose exec app bash
```

### Rebuild Without Cache
```bash
docker-compose build --no-cache
docker-compose up
```

## Next Steps

See main implementation plan in `/docs/PLAN.md` for Part 3 onwards:
- **Part 3** - Build frontend and integrate as static files
- **Part 4** - Add authentication system
- **Part 5** - Database schema and models
- **Part 6** - API endpoints for CRUD operations
- And so on...