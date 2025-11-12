param(
  [string]$OutFile = "logs/publish_summary.json",
  [switch]$CopyToHub,
  [string]$HubSubpath = "exchange/reports/archived"
)

$workspace = "archivist_ai_0"
$timestamp = [DateTimeOffset]::UtcNow.ToString("o")

function Read-Json($path) {
  if (-not (Test-Path -Path $path)) { return $null }
  try { return Get-Content -Path $path -Raw | ConvertFrom-Json } catch { return $null }
}

$docsCheck = Read-Json "logs/docs_check.json"
$heartbeat  = Read-Json "logs/heartbeat.json"
$sync       = Read-Json "logs/sync.json"

$payload = [ordered]@{
  workspace       = $workspace
  timestamp_utc   = $timestamp
  docs_check_ok   = (if ($docsCheck) { [bool]$docsCheck.ok } else { $null })
  evidence        = [ordered]@{
    docs_check = [ordered]@{ present = [bool]$docsCheck; path = "logs/docs_check.json" }
    heartbeat  = [ordered]@{ present = [bool]$heartbeat;  path = "logs/heartbeat.json" }
    sync       = [ordered]@{ present = [bool]$sync;       path = "logs/sync.json" }
  }
}

$outDir = Split-Path -Parent $OutFile
if ($outDir -and -not (Test-Path $outDir)) {
  New-Item -ItemType Directory -Force -Path $outDir | Out-Null
}

$json = $payload | ConvertTo-Json -Depth 6
Set-Content -Path $OutFile -Value $json
Write-Host "Publish summary written to $OutFile"

if ($CopyToHub) {
  $hub = $env:SHAGI_EXCHANGE_PATH
  if (-not $hub) {
    Write-Warning "SHAGI_EXCHANGE_PATH is not set; skipping hub copy."
    return
  }
  $destDir = Join-Path $hub $HubSubpath
  if (-not (Test-Path -Path $destDir)) {
    try { New-Item -ItemType Directory -Force -Path $destDir | Out-Null } catch {}
  }
  $destFile = Join-Path $destDir ("archivist_ai_0-publish-" + ([DateTime]::UtcNow.ToString("yyyyMMdd-HHmmss")) + ".json")
  try {
    Copy-Item -Path $OutFile -Destination $destFile -Force
    Write-Host "Copied summary to hub: $destFile"
  } catch {
    Write-Warning "Failed to copy to hub at $destDir: $($_.Exception.Message)"
  }
} else {
  $hintHub = $env:SHAGI_EXCHANGE_PATH
  if ($hintHub) {
    $suggest = Join-Path $hintHub $HubSubpath
    Write-Host "Hint: Set -CopyToHub to copy into '$suggest'"
  } else {
    Write-Host "Hint: Set SHAGI_EXCHANGE_PATH to enable hub copy."
  }
}
