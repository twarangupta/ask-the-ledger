# AskTheLedger task runner. Run `just` to see every command.
# On Windows recipes run in PowerShell; on macOS and Linux they run in sh.
set windows-shell := ["powershell.exe", "-NoLogo", "-NoProfile", "-Command"]

# Show the list of commands (runs when you type just with no arguments).
default:
    @just --list

# First-time setup: create .env from the template and download images.
[windows]
setup:
    if (-not (Test-Path .env)) { Copy-Item .env.example .env; Write-Host "Created .env from .env.example. Change the passwords in it." } else { Write-Host ".env already exists, leaving it unchanged." }
    docker compose pull

# First-time setup: create .env from the template and download images.
[unix]
setup:
    if [ ! -f .env ]; then cp .env.example .env; echo "Created .env from .env.example. Change the passwords in it."; else echo ".env already exists, leaving it unchanged."; fi
    docker compose pull

# Start Postgres and Redis in the background and wait until they are healthy.
up:
    docker compose up -d --wait

# Stop the services. Your data is kept in Docker volumes.
down:
    docker compose down

# Show which services are running and whether they are healthy.
status:
    docker compose ps

# Follow the service logs (press Ctrl+C to stop following).
logs:
    docker compose logs -f

# Open a SQL shell inside the Postgres container.
psql:
    docker compose exec postgres sh -c 'psql -U "$POSTGRES_USER" -d "$POSTGRES_DB"'

# Open a Redis shell inside the Redis container.
redis-cli:
    docker compose exec redis sh -c 'redis-cli -a "$REDIS_PASSWORD" --no-auth-warning'

# DANGER: stop services and DELETE all local Postgres and Redis data (asks y/N first).
[confirm("This deletes all local Postgres and Redis data. Type y to continue [y/N]:")]
reset:
    docker compose down -v
