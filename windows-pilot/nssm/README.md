# NSSM Windows Services

NSSM is optional for this pilot.

NSSM is more Windows-native than PM2 because it creates real Windows Services that can start automatically without an interactive user session.

Download NSSM:

```text
https://nssm.cc/download
```

Suggested location:

```text
C:\Tools\nssm\nssm.exe
```

Before running scripts:

- Build the backend.
- Build the frontend.
- Install Node 24 LTS.
- Install `serve` globally if using the frontend service example.
- Edit all paths in the scripts.
- Run PowerShell as Administrator.

Install backend service:

```powershell
.\install-kore-backend-service.example.ps1
```

Install frontend service:

```powershell
.\install-kore-frontend-service.example.ps1
```

Uninstall backend service:

```powershell
.\uninstall-kore-backend-service.example.ps1
```

View services:

```powershell
Get-Service KoreBackend
Get-Service KoreFrontend
```

View logs:

```powershell
Get-Content C:\Apps\logs\kore-backend.stdout.log -Tail 100 -Wait
Get-Content C:\Apps\logs\kore-backend.stderr.log -Tail 100 -Wait
```
