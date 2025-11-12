param(
  [string]$OrderId,
  [string]$Summary = "Test report",
  [string]$OutDir = "outbox/reports"
)

if (-not $OrderId) {
  Write-Error "-OrderId is required"
  exit 1
}

if (-not (Test-Path -Path $OutDir)) { New-Item -ItemType Directory -Force -Path $OutDir | Out-Null }

$stamp = [DateTime]::UtcNow.ToString("yyyy-MM-dd-HHmmss")
$reportId = "${OrderId}-report"
$fileName = "$reportId.json"
$path = Join-Path $OutDir $fileName

$payload = [ordered]@{
  order_id   = $OrderId
  report_id  = $reportId
  workspace  = "archivist_ai_0"
  summary    = $Summary
  created_at = ([DateTimeOffset]::UtcNow.ToString("o"))
  artifacts  = @()
}

$json = $payload | ConvertTo-Json -Depth 6
Set-Content -Path $path -Value $json
Write-Host "Staged report: $path"
