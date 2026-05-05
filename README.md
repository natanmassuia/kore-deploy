# kore-deploy

Deployment and operations material for Kore.

Application source code lives in the main `kore-app` repository. This repository contains only deployment documentation, environment examples, operational scripts, and checklists.

Current focus: the Windows Server internal pilot for Kore v0.5.

This is not the final SaaS production deployment. Final SaaS production may later use Linux, Docker, managed databases, managed Redis-compatible services, object storage, and other managed infrastructure.

## Important Rules

- Never commit real secrets.
- Never commit built application artifacts.
- Never commit database backups.
- Use Node 24 LTS.
- Do not use Node 25.
- Docker is intentionally not required for this pilot.
- Docker Desktop is not the target for this Windows Server pilot.
- Keep scripts as examples and adjust paths before use.

## Quick Links

- [Windows pilot deployment guide](windows-pilot/DEPLOYMENT_WINDOWS_PILOT.md)
- [Windows pilot checklist](windows-pilot/checklist.md)
- [Windows pilot environment example](windows-pilot/.env.pilot.example)

## Repository Structure

```text
kore-deploy/
|-- README.md
|-- windows-pilot/
|   |-- DEPLOYMENT_WINDOWS_PILOT.md
|   |-- .env.pilot.example
|   |-- checklist.md
|   |-- pm2/
|   |   |-- ecosystem.config.example.cjs
|   |   `-- README.md
|   |-- nssm/
|   |   |-- install-kore-backend-service.example.ps1
|   |   |-- install-kore-frontend-service.example.ps1
|   |   |-- uninstall-kore-backend-service.example.ps1
|   |   `-- README.md
|   |-- nginx/
|   |   |-- kore.windows.nginx.conf.example
|   |   `-- README.md
|   `-- sql/
|       `-- backup-postgres.example.ps1
`-- production-future/
    `-- README.md
```
