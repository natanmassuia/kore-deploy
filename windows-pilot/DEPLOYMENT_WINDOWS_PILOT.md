# Kore v0.5 Windows Server Pilot Deployment Guide

## A. Purpose

This guide is for an internal/on-premise VM pilot only.

The goal is to run Kore v0.5 locally inside the company for stable internal testing.

This is not the final production architecture and must not be treated as the final SaaS deployment plan.

## B. Target Architecture

Windows Server VM:

- Node 24 LTS
- Git
- PostgreSQL for Windows or external Postgres
- Redis-compatible service:
  - Memurai Community
  - Redis via WSL
  - External Redis-compatible service
- Kore backend
- Kore frontend
- PM2 for pilot process management
- Optional NSSM for Windows Services
- Optional Nginx for Windows or IIS for static frontend/reverse proxy
- Evolution API running separately if used

## C. Prerequisites

- Windows Server admin access
- Node 24 LTS installed
- Git installed
- PostgreSQL database available
- Redis/Memurai available
- Main Kore application repo cloned
- Access to required environment variables

## D. Node 24 Setup

Check versions:

```powershell
node -v
npm -v
```

Expected:

```text
node v24.x.x
```

Do not use Node 25 Current. Kore v0.5 targets Node 24 LTS.

## E. Clone or Update Kore App

Use this example path:

```text
C:\Apps\kore-app
```

Clone and checkout the release:

```powershell
git clone <kore-app-repo-url> C:\Apps\kore-app
cd C:\Apps\kore-app
git checkout v0.5.0
```

If using a branch instead of a tag:

```powershell
cd C:\Apps\kore-app
git pull
```

## F. Environment Setup

Use:

```text
windows-pilot/.env.pilot.example
```

Copy it to the location expected by the Kore app. Usually this is the root `.env`:

```powershell
copy C:\Apps\kore-deploy\windows-pilot\.env.pilot.example C:\Apps\kore-app\.env
```

Fill the values in:

```text
C:\Apps\kore-app\.env
```

Never commit a real `.env`.

## G. Backend Setup

```powershell
cd C:\Apps\kore-app\node_backend
npm ci
npx prisma generate
npx prisma migrate deploy
npm run build
npm run start
```

If the start script differs, confirm the actual backend production script in:

```text
node_backend/package.json
```

## H. Frontend Setup

```powershell
cd C:\Apps\kore-app\react_frontend
npm ci
npm run build
```

Simple pilot serving option:

```powershell
npm install -g serve
serve -s dist -l 5173
```

Production-like options:

- IIS static site
- Nginx for Windows

## I. PM2 Pilot Setup

```powershell
npm install -g pm2
pm2 start windows-pilot/pm2/ecosystem.config.example.cjs
pm2 save
pm2 list
pm2 logs
```

PM2 is acceptable for this pilot.

PM2 startup on Windows can be limited. For persistent Windows Service behavior, use NSSM later.

## J. NSSM Optional Setup

See:

```text
windows-pilot/nssm/README.md
```

NSSM creates real Windows Services. It is recommended if the VM restarts often or if the pilot needs unattended startup.

## K. Nginx or IIS Reverse Proxy

Suggested pilot routes:

- Frontend exposed internally on port 80 or 5173
- Backend on port 3002
- `/api` proxied to backend if using a single domain
- `/socket.io` proxied with WebSocket headers
- HTTPS can be added later if the internal network requires it

See:

```text
windows-pilot/nginx/kore.windows.nginx.conf.example
```

## L. Database Migrations

```powershell
cd C:\Apps\kore-app\node_backend
npx prisma migrate deploy
```

Make backups before migrations on a persistent pilot database.

The backend uses `DATABASE_URL` from `.env`.

## M. Backups

Back up:

- PostgreSQL with `pg_dump`
- Media/storage if applicable
- `.env` in a secure location
- Logs if needed

See:

```text
windows-pilot/sql/backup-postgres.example.ps1
```

## N. Firewall

Recommended rules:

- Expose frontend internally.
- Keep backend port `3002` local/proxied only when possible.
- PostgreSQL should not be public.
- Redis/Memurai should not be public.
- If webhooks are needed from Evolution, the backend URL must be reachable from the Evolution host.

## O. Health and Validation

Checklist:

- `node -v` returns `v24.x.x`
- Backend typecheck PASS
- Frontend build PASS
- Backend starts
- Frontend loads
- `/api/health` works if available
- Register/login works
- Mock billing works if pilot uses mock
- Team invite works
- Instance current page loads
- Socket connects
- Inbox loads

## P. Known Pilot Limitations

- Evolution is an experimental/non-official WhatsApp integration.
- Risk of disconnection/ban exists.
- Meta Cloud API is not implemented yet.
- This VM pilot is not the final SaaS deployment.
