#Requires -RunAsAdministrator

# Example only. Edit all paths before running.
# This example serves the built React frontend with the global "serve" package.

$ServiceName = "KoreFrontend"
$AppDir = "C:\Apps\kore-app\react_frontend"
$ServePath = "C:\Users\Administrator\AppData\Roaming\npm\serve.cmd"
$ServeArgs = "-s dist -l 5173"
$NssmPath = "C:\Tools\nssm\nssm.exe"
$LogDir = "C:\Apps\logs"

if (-not (Test-Path $NssmPath)) {
    Write-Error "NSSM not found at $NssmPath"
    exit 1
}

if (-not (Test-Path $ServePath)) {
    Write-Error "serve not found at $ServePath. Install with: npm install -g serve"
    exit 1
}

if (-not (Test-Path (Join-Path $AppDir "dist"))) {
    Write-Error "Frontend dist directory not found. Run npm run build first."
    exit 1
}

New-Item -ItemType Directory -Path $LogDir -Force | Out-Null

$StdoutLog = Join-Path $LogDir "kore-frontend.stdout.log"
$StderrLog = Join-Path $LogDir "kore-frontend.stderr.log"

& $NssmPath install $ServiceName $ServePath $ServeArgs
& $NssmPath set $ServiceName AppDirectory $AppDir
& $NssmPath set $ServiceName AppStdout $StdoutLog
& $NssmPath set $ServiceName AppStderr $StderrLog
& $NssmPath set $ServiceName AppEnvironmentExtra "NODE_ENV=production"
& $NssmPath set $ServiceName AppRestartDelay 5000
& $NssmPath set $ServiceName DisplayName "Kore Frontend"
& $NssmPath set $ServiceName Description "Kore v0.5 frontend service for Windows pilot"

& $NssmPath start $ServiceName
