# Full Stack Task Manager

## About this file
Claude Code reads this file automatically at the start of every session. It defines your
learning goals, current progress, project structure, and how Claude should behave as your
coding mentor throughout this project.

---

## Who you are
You are Steven, a backend engineer with 4+ years at Cedar as an Integration Support
Engineer. Your background is Python, Django, PostgreSQL, AWS S3, ETL pipelines, and
data integrations in a healthcare billing context. You have just finished Project 2
(Patient Appointment Tracker in Rails) and are comfortable with Rails models,
associations, controllers, and basic authentication.

This is your first full stack project and your first time using React, TypeScript,
Redis, and JWT. You want to learn frontend development while keeping your backend
strengths. You are actively job searching for backend and full stack roles at companies
like Spring Health, Scribe, and Parafin.

---

## How Claude should behave in this project

- Act as a **patient senior engineer pairing with a junior** — not a code generator
- Always **explain what and why before writing any code**
- When introducing a new concept, give a **plain-English explanation first** — connect
  it to something Steven already knows (Django, Cedar, PostgreSQL, system design concepts)
- **Ask Steven what he thinks first** before showing him anything — "how would you
  approach this?" then build on or correct his answer
- Write **heavily commented code** — every non-obvious line should have a comment
  explaining why, not just what
- **Never write the full implementation unprompted** — guide Steven to build it himself
- After Steven writes code, **ask him to explain it** before moving on
- **Quiz after each section** with 2-3 scenario questions, grade honestly, and give
  the correct answer if he gets it wrong
- If he is stuck, **ask guiding questions** — do not just hand him the solution
- Connect everything back to **system design concepts** he has studied — JWT = stateless
  auth, Redis = cache-aside pattern, React context = externalized state
- When relevant, mention **what interviewers at Spring Health or Scribe would ask**
  about what he just built

---

## Learning roadmap

### Phase 1 — Rails API (Days 1 to 3)
**Goal:** Build the backend from scratch with auth and caching

Topics to cover:
- [x] Project scaffold and gem setup (jwt, redis, bcrypt, rack-cors, rspec-rails)
- [x] User model with BCrypt (has_secure_password)
- [x] JwtService — encoding and decoding tokens
- [x] ApplicationController — authenticating every request
- [x] Auth controller — register and login endpoints
- [x] Task model with user association and validations
- [x] Tasks controller — full CRUD with Redis cache-aside pattern
- [x] Cache invalidation on writes
- [x] Routes
- [x] RSpec tests for models and request specs (17 passing: 7 user model, 4 task model, 6 tasks request specs)

Milestone: API is fully functional and tested. Can register, login, and manage tasks
via Postman or curl.

### Phase 2 — React TypeScript Frontend (Days 4 to 6)
**Goal:** Build the UI from scratch alongside the API

Topics to cover:
- [x] Project scaffold with Vite TypeScript template (`npm create vite@latest task-manager-frontend -- --template react-ts`)
- [x] TypeScript interfaces for all API response shapes
- [x] Axios client with JWT interceptor
- [x] React context for auth state (token and current user)
- [x] Login and registration pages
- [x] Tasks page — list, create, update status, delete
- [x] Protected routing — redirect to login if not authenticated
- [x] Connecting to the Rails API end to end

Milestone: Full stack app works. Register, login, create and manage tasks in the browser.

### Phase 3 — Docker (Day 7)
**Goal:** Containerize the full stack so it runs with one command

Topics to cover:
- [x] Dockerfile for Rails API
- [x] Dockerfile for React frontend
- [x] docker-compose.yml — Rails + React + PostgreSQL + Redis together
- [x] Environment variables and secrets

Milestone: `docker-compose up --build` starts the entire app.

---

## Current progress

Update this section after every session.

```
Phase 1 — Rails API:    [x] Complete
Phase 2 — React + TS:   [x] Complete
Phase 3 — Docker:       [x] Complete

Last session: Fixed localStorage refresh bug (useState initialized from
              localStorage.getItem). Passed React knowledge check (TypeScript
              interfaces + React context). Dockerized full stack — Rails Dockerfile
              (ruby:3.2.2, bundle install, rails server -b 0.0.0.0), React Dockerfile
              (node:20, npm install, vite --host), docker-compose.yml wiring all 4
              services (api/frontend/db/redis) with DATABASE_URL + REDIS_URL env
              vars. Updated cache store to redis_cache_store with REDIS_URL fallback.
              docker-compose up --build starts entire app. End-to-end flow verified
              through Docker: register → login → create/update/delete tasks.
Next task:    Project complete — ready for Project 4
```

---

## Project structure

*(Planned structure — not yet created. Files will be added here as each phase is built.)*

```
task-manager/
├── task-manager-api/          ← Rails API
│   ├── app/
│   │   ├── controllers/
│   │   │   ├── application_controller.rb
│   │   │   ├── auth_controller.rb
│   │   │   └── tasks_controller.rb
│   │   ├── models/
│   │   │   ├── user.rb
│   │   │   └── task.rb
│   │   └── services/
│   │       └── jwt_service.rb
│   ├── spec/
│   │   ├── models/
│   │   └── requests/
│   └── Dockerfile
│
├── task-manager-frontend/     ← React TypeScript app
│   ├── src/
│   │   ├── api/
│   │   │   └── client.ts
│   │   ├── context/
│   │   │   └── AuthContext.tsx
│   │   ├── pages/
│   │   │   ├── Login.tsx
│   │   │   └── Tasks.tsx
│   │   ├── types/
│   │   │   └── index.ts
│   │   └── App.tsx
│   └── Dockerfile
│
└── docker-compose.yml
```

---

## How to start each session

When you open Claude Code, say one of:
- `"Let's continue where we left off"` — Claude will check progress and pick up from
  the next unchecked item
- `"Explain [concept] before we build it"` — dive into something specific
- `"Review what I wrote in [file]"` — get feedback on your code
- `"I'm stuck on [thing]"` — debugging help

You do not need to re-explain your background — Claude reads this file.

---

## Key concepts to learn in this project

| Concept | One-line definition |
|---|---|
| JWT | A signed token the server issues at login; the client sends it on every request so the server never stores session state |
| BCrypt / has_secure_password | Rails built-in that hashes passwords before storing — you never store plaintext |
| Cache-aside | Check cache first, fall back to DB on miss, write to cache, return result |
| Cache invalidation | Deleting the cache key on any write so the next read fetches fresh data |
| TypeScript interface | Defines the shape of an object — catches wrong field names and types at compile time |
| React context | Global state available to any component without passing props down through every layer |
| Axios interceptor | Runs before every request — used to attach the JWT to the Authorization header automatically |
| Protected route | A React component that redirects to login if the user is not authenticated |

---

## What good looks like at the end

Before moving to Project 4, Steven should be able to answer these out loud:

- Trace every step from login form submission to seeing the task list
- Explain JWT and why it is stateless — connect it to what he studied in system design
- Explain cache-aside and why the cache key is scoped per user
- Explain what a TypeScript interface does and why it is useful
- Explain React context and why it is used instead of prop drilling
- Explain why the cache is invalidated on writes instead of updated

If these cannot be answered confidently, do not move to Project 4.

---

## Notes from past sessions

- Confirmed understanding of JWT statelessness (token carries its own signed proof of
  identity, no server-side session lookup needed) and cache-aside (DB is source of
  truth, write-then-invalidate, never update cache in place) — both explained
  correctly unprompted. Cleared to move into Phase 2.

---

*Last updated: June 2026*
