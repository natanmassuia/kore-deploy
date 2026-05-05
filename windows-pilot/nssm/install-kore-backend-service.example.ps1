#Requires -RunAsAdministrator

# Example only. Edit all paths before running.

$ServiceName = "KoreBackend"
$AppDir = "C:\Apps\kore-app\node_backend"
$NodePath = "C:\Program Files\nodejs\node.exe"
$ScriptPath = "dist\index.js"
$NssmPath = "C:\Tools\nssm\nssm.exe"
$LogDir = "C:\Apps\logs"

if (-not (Test-Path $NssmPath)) {
    Write-Error "NSSM not found at $NssmPath"
    exit 1
}

if (-not (Test-Path $NodePath)) {
    Write-Error "Node 24 LTS not found at $NodePath"
    exit 1
}

$EntryPoint = Join-Path $AppDir $ScriptPath
if (-not (Test-Path $EntryPoint)) {
    Write-Error "Backend entry point not found at $EntryPoint. Run npm run build first."
    exit 1
}

New-Item -ItemType Directory -Path $LogDir -Force | Out-Null

$StdoutLog = Join-Path $LogDir "kore-backend.stdout.log"
$StderrLog = Join-Path $LogDir "kore-backend.stderr.log"

& $NssmPath install $ServiceName $NodePath $ScriptPath
& $NssmPath set $ServiceName AppDirectory $AppDir
& $NssmPath set $ServiceName AppStdout $StdoutLog
& $NssmPath set $ServiceName AppStderr $StderrLog
& $NssmPath set $ServiceName AppEnvironmentExtra "NODE_ENV=production"
& $NssmPath set $ServiceName AppRestartDelay 5000
& $NssmPath set $ServiceName DisplayName "Kore Backend"
& $NssmPath set $ServiceName Description "Kore v0.5 backend service for Windows pilot"

& $NssmPath start $ServiceName
