# PM2 Pilot Setup

PM2 is acceptable for the Windows Server internal pilot. It keeps the backend and frontend processes running and provides basic logs and restarts.

Install PM2 and `serve`:

```powershell
npm install -g pm2 serve
```

Copy and edit the ecosystem config:

```powershell
copy ecosystem.config.example.cjs ecosystem.config.cjs
notepad ecosystem.config.cjs
```

Start services:

```powershell
pm2 start ecosystem.config.example.cjs
```

View processes and logs:

```powershell
pm2 list
pm2 logs
```

Restart or stop:

```powershell
pm2 restart kore-backend
pm2 stop kore-backend
```

Save the process list:

```powershell
pm2 save
```

PM2 startup behavior on Windows can be limited. Use NSSM if the pilot needs more reliable unattended startup after VM reboot.
