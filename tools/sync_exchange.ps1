param(
  [string]$OutPath = "logs/sync.json"
)

$workspace = "archivist_ai_0"
$exchange = $env:SHAGI_EXCHANGE_PATH
$exists = $false
if ($exchange) {
  try { $exists = Test-Path -Path $exchange } catch { $exists = $false }
}

$timestamp = [DateTimeOffset]::UtcNow.ToString("o")
$payload = [ordered]@{
  workspace       = $workspace
  timestamp_utc   = $timestamp
  exchange_path   = (if ($exchange) { $exchange } else { "UNSET" })
  exchange_exists = $exists
  mode            = "dry-run"
}

$outDir = Split-Path -Parent $OutPath
if ($outDir -and -not (Test-Path $outDir)) {
  New-Item -ItemType Directory -Force -Path $outDir | Out-Null
}

$json = $payload | ConvertTo-Json -Depth 5
Set-Content -Path $OutPath -Value $json
Write-Host "Sync evidence written to $OutPath (dry-run)"
