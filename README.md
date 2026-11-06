# AskTheLedger

A secure, multi-tenant, multi-agent Text-to-SQL analytics assistant, built in the open, one phase at a time.

Business users will ask questions in plain English about (fully synthetic) sales and contract data. The system will write SQL, check it for safety, run it with per-tenant isolation enforced by the database, and explain the answer.

> **Status: Phase 0 (project setup) only.** There is no AI, API or user interface yet. This README only describes what exists today.

## What exists right now

- PostgreSQL 17 and Redis 8 running locally in Docker, reachable only from this computer.
- A `justfile` with short commands to set up, start, stop and inspect them.

## Prerequisites

- Docker Desktop (or Docker Engine with Compose v2)
- [just](https://github.com/casey/just) (for example `uv tool install rust-just`)
- Git

## Quick start

```bash
just setup
```

Creates `.env` from `.env.example` (if it does not exist yet) and downloads the images. Open `.env` and change the passwords.

```bash
just up
```

Starts Postgres (port 5435) and Redis (port 6380) and waits until both are healthy.

```bash
just status
```

Run `just` on its own to see every command.

## Free-tier only

This project is designed to run entirely on free tiers and local tools. No paid API keys are required at any phase.

## License

Not chosen yet.
