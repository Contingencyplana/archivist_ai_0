param(
  [string]$OutPath = "logs/heartbeat.json"
)

$workspace = "archivist_ai_0"
$exchange = $env:SHAGI_EXCHANGE_PATH
$timestamp = [DateTimeOffset]::UtcNow.ToString("o")

$payload = [ordered]@{
  workspace     = $workspace
  timestamp_utc = $timestamp
  exchange_path = (if ($exchange) { $exchange } else { "UNSET" })
}

$outDir = Split-Path -Parent $OutPath
if ($outDir -and -not (Test-Path $outDir)) {
  New-Item -ItemType Directory -Force -Path $outDir | Out-Null
}

$json = $payload | ConvertTo-Json -Depth 5
Set-Content -Path $OutPath -Value $json
Write-Host "Heartbeat written to $OutPath"
