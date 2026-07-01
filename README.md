# Full Stack Task Manager

A full stack task management application built with a Rails API backend and React TypeScript frontend, containerized with Docker.

## What it does

- Register and log in with email and password
- Create, view, update status, and delete tasks
- Task statuses cycle through: `pending` → `in_progress` → `completed`
- JWT-based authentication — every request is authorized via a signed token
- Redis caching on the task list for faster reads (cache-aside pattern)
- Full Docker setup — the entire stack runs with one command

## Tech Stack

**Backend**
- Ruby on Rails 8 (API mode)
- PostgreSQL
- Redis (cache-aside pattern via `Rails.cache`)
- JWT authentication (`ruby-jwt` + BCrypt)
- RSpec (17 tests — model specs + request specs)

**Frontend**
- React 19 with TypeScript
- Vite
- Axios (with JWT interceptor)
- React Context (global auth state)

**Infrastructure**
- Docker + Docker Compose

## Project Structure

```
full-stack-task-manager/
├── task-manager-api/        ← Rails API (port 3000)
├── task-manager-frontend/   ← React + TypeScript (port 5173)
└── docker-compose.yml
```

## Getting Started

### Prerequisites

- [Docker](https://www.docker.com/get-started) installed and running

### Run with Docker (recommended)

```bash
# Clone the repo
git clone <your-repo-url>
cd full-stack-task-manager

# Build and start all services (Rails + React + PostgreSQL + Redis)
docker-compose up --build

# In a separate terminal, create and migrate the database
docker-compose exec api rails db:create db:migrate
```

- Frontend: http://localhost:5173
- API: http://localhost:3000

### Run locally (without Docker)

**Prerequisites:** Ruby 3.2.2, Node 20, PostgreSQL, Redis

```bash
# Start Redis
brew services start redis

# Start the Rails API
cd task-manager-api
bundle install
rails db:create db:migrate
rails server

# In a separate terminal, start the React frontend
cd task-manager-frontend
npm install
npm run dev
```

### Run the test suite

```bash
cd task-manager-api
bundle exec rspec
```

## API Endpoints

| Method | Path | Description | Auth required |
|--------|------|-------------|---------------|
| POST | `/auth/register` | Register a new user | No |
| POST | `/auth/login` | Log in, returns JWT | No |
| GET | `/tasks` | List all tasks (cached) | Yes |
| POST | `/tasks` | Create a task | Yes |
| GET | `/tasks/:id` | Get a task | Yes |
| PATCH | `/tasks/:id` | Update a task | Yes |
| DELETE | `/tasks/:id` | Delete a task | Yes |
