param(
  [string]$OrderId,
  [string]$Notes = "Ack received",
  [string]$OutDir = "outbox/acks"
)

if (-not $OrderId) {
  Write-Error "-OrderId is required"
  exit 1
}

if (-not (Test-Path -Path $OutDir)) { New-Item -ItemType Directory -Force -Path $OutDir | Out-Null }

$ts = [DateTime]::UtcNow.ToString("yyyy-MM-dd-HHmmss")
$ackId = "${OrderId}-ack"
$fileName = "$ackId.json"
$path = Join-Path $OutDir $fileName

$payload = [ordered]@{
  order_id     = $OrderId
  ack_id       = $ackId
  workspace    = "archivist_ai_0"
  ack_timestamp= ([DateTimeOffset]::UtcNow.ToString("o"))
  notes        = $Notes
}

$json = $payload | ConvertTo-Json -Depth 6
Set-Content -Path $path -Value $json
Write-Host "Staged ack: $path"
