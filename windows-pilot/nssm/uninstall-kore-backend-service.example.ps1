#Requires -RunAsAdministrator

# Example only. Edit the service name/path before running if needed.

$ServiceName = "KoreBackend"
$NssmPath = "C:\Tools\nssm\nssm.exe"

if (-not (Test-Path $NssmPath)) {
    Write-Error "NSSM not found at $NssmPath"
    exit 1
}

& $NssmPath stop $ServiceName
& $NssmPath remove $ServiceName confirm
