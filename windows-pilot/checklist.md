# Windows Pilot Checklist

## Environment

- [ ] Node 24 installed
- [ ] Git installed
- [ ] PostgreSQL available
- [ ] Redis/Memurai available
- [ ] Kore repo cloned at `C:\Apps\kore-app`
- [ ] `.env` configured

## Backend

- [ ] `npm ci`
- [ ] `prisma generate`
- [ ] `prisma migrate deploy`
- [ ] Backend build
- [ ] Backend starts
- [ ] `/api/health` works if available

## Frontend

- [ ] `npm ci`
- [ ] Build
- [ ] Frontend served
- [ ] App opens in browser

## App Validation

- [ ] Register company
- [ ] Mock billing activate if pilot uses mock
- [ ] Login
- [ ] Invite agent
- [ ] Accept invite
- [ ] Team page works
- [ ] Audit page works
- [ ] Instance state page works
- [ ] Inbox loads
- [ ] Socket connects

## Operational

- [ ] PM2 or NSSM configured
- [ ] Firewall reviewed
- [ ] Backups configured
- [ ] Logs location known
