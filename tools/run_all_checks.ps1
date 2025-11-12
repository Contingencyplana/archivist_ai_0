param(
  [string]$OutPath = "logs/run_all_checks.json"
)

$results = @{}

function Run-Safe($name, $script, $args) {
  try {
    & $script @args | Out-Null
    $results[$name] = "ok"
  } catch {
    $results[$name] = "error: $($_.Exception.Message)"
  }
}

Run-Safe -name "heartbeat" -script "$PSScriptRoot/heartbeat.ps1" -args @{}
Run-Safe -name "sync"      -script "$PSScriptRoot/sync_exchange.ps1" -args @{}
Run-Safe -name "docs"      -script "$PSScriptRoot/check_docs.ps1" -args @{}

$summary = [ordered]@{
  timestamp_utc = ([DateTimeOffset]::UtcNow.ToString("o"))
  workspace     = "archivist_ai_0"
  results       = $results
}

$outDir = Split-Path -Parent $OutPath
if ($outDir -and -not (Test-Path $outDir)) {
  New-Item -ItemType Directory -Force -Path $outDir | Out-Null
}
$json = $summary | ConvertTo-Json -Depth 6
Set-Content -Path $OutPath -Value $json
Write-Host "Run-all summary written to $OutPath"
