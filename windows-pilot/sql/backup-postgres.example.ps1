# Example PostgreSQL backup script for the Kore Windows pilot.
# Do not hardcode passwords in this file.
# Use PGPASSWORD in the environment or a pgpass file.

$PgDumpPath = "C:\Program Files\PostgreSQL\16\bin\pg_dump.exe"
$DatabaseName = "kore"
$DatabaseUser = "kore_user"
$DatabaseHost = "localhost"
$DatabasePort = "5432"
$OutputDir = "C:\Apps\backups"

if (-not (Test-Path $PgDumpPath)) {
    Write-Error "pg_dump not found at $PgDumpPath"
    exit 1
}

New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null

$Timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$OutputFile = Join-Path $OutputDir "kore-$Timestamp.dump"

& $PgDumpPath `
    -h $DatabaseHost `
    -p $DatabasePort `
    -U $DatabaseUser `
    -d $DatabaseName `
    -Fc `
    -f $OutputFile

if ($LASTEXITCODE -ne 0) {
    Write-Error "Backup failed"
    exit $LASTEXITCODE
}

Write-Host "Backup created: $OutputFile"
