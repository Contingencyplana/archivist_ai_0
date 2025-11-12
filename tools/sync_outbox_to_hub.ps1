param(
  [string]$OrdersSubpath = "exchange/orders/dispatched",
  [string]$ReportsSubpath = "exchange/reports/archived",
  [string]$AcksSubpath   = "exchange/acknowledgements/logged",
  [string]$OutPath = "logs/sync_outbox.json"
)

function Get-HubPath {
  if ($env:SHAGI_EXCHANGE_PATH) { return $env:SHAGI_EXCHANGE_PATH }
  $cfg = Join-Path (Split-Path -Parent $PSCommandPath) "..\exchange\config.json"
  if (Test-Path -Path $cfg) {
    try {
      $obj = Get-Content -Path $cfg -Raw | ConvertFrom-Json
      if ($obj.hub_path) { return [string]$obj.hub_path }
    } catch {}
  }
  return $null
}

$hub = Get-HubPath
if (-not $hub) {
  Write-Warning "No hub path. Set SHAGI_EXCHANGE_PATH or edit exchange/config.json."
  exit 1
}

# Pre-sync validation (refuse to sync on errors)
$valOut = "logs/validate_staged.json"
try {
  & "$PSScriptRoot/validate_staged_json.ps1" -OutPath $valOut | Out-Null
} catch {
  Write-Warning "Validator failed to run: $($_.Exception.Message)";
  exit 1
}

$ok = $true
try {
  $val = Get-Content -Path $valOut -Raw | ConvertFrom-Json
  $ok = [bool]$val.ok
} catch { $ok = $false }
if (-not $ok) {
  Write-Warning "Validation reported errors; refusing to sync. See $valOut"
  exit 1
}

$ordersSrc  = "outbox/orders"
$reportsSrc = "outbox/reports"
$acksSrc    = "outbox/acks"
$ordersDst  = Join-Path $hub $OrdersSubpath
$reportsDst = Join-Path $hub $ReportsSubpath
$acksDst    = Join-Path $hub $AcksSubpath

foreach ($d in @($ordersDst, $reportsDst, $acksDst)) {
  if (-not (Test-Path -Path $d)) { New-Item -ItemType Directory -Force -Path $d | Out-Null }
}

$copiedOrders = @()
$copiedReports = @()
$copiedAcks = @()

if (Test-Path -Path $ordersSrc) {
  Get-ChildItem -Path $ordersSrc -Filter *.json -File -ErrorAction SilentlyContinue | ForEach-Object {
    $dest = Join-Path $ordersDst $_.Name
    Copy-Item -Path $_.FullName -Destination $dest -Force
    $copiedOrders += $_.Name
    Write-Host "Copied order: $($_.Name) -> $ordersDst"
  }
}

if (Test-Path -Path $reportsSrc) {
  Get-ChildItem -Path $reportsSrc -Filter *.json -File -ErrorAction SilentlyContinue | ForEach-Object {
    $dest = Join-Path $reportsDst $_.Name
    Copy-Item -Path $_.FullName -Destination $dest -Force
    $copiedReports += $_.Name
    Write-Host "Copied report: $($_.Name) -> $reportsDst"
  }
}

if (Test-Path -Path $acksSrc) {
  Get-ChildItem -Path $acksSrc -Filter *.json -File -ErrorAction SilentlyContinue | ForEach-Object {
    $dest = Join-Path $acksDst $_.Name
    Copy-Item -Path $_.FullName -Destination $dest -Force
    $copiedAcks += $_.Name
    Write-Host "Copied ack: $($_.Name) -> $acksDst"
  }
}

$summary = [ordered]@{
  timestamp_utc  = ([DateTimeOffset]::UtcNow.ToString("o"))
  workspace      = "archivist_ai_0"
  hub_path       = $hub
  copied_orders  = $copiedOrders
  copied_reports = $copiedReports
  copied_acks    = $copiedAcks
}

$outDir = Split-Path -Parent $OutPath
if ($outDir -and -not (Test-Path $outDir)) { New-Item -ItemType Directory -Force -Path $outDir | Out-Null }
$json = $summary | ConvertTo-Json -Depth 6
Set-Content -Path $OutPath -Value $json
Write-Host "Sync-outbox summary written to $OutPath"
