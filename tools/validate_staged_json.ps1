param(
  [string]$OrdersDir = "outbox/orders",
  [string]$AcksDir   = "outbox/acks",
  [string]$ReportsDir= "outbox/reports",
  [string]$OutPath   = "logs/validate_staged.json",
  [switch]$FailOnError
)

function Read-Json($path) {
  try { return Get-Content -Path $path -Raw | ConvertFrom-Json } catch { return $null }
}

function Check-Fields($obj, [string[]]$fields) {
  $missing = @()
  foreach ($f in $fields) { if ($null -eq $obj.$f) { $missing += $f } }
  return $missing
}

$results = @()

if (Test-Path -Path $OrdersDir) {
  Get-ChildItem -Path $OrdersDir -Filter *.json -File -ErrorAction SilentlyContinue | ForEach-Object {
    $o = Read-Json $_.FullName
    $missing = if ($o) { Check-Fields $o @('id','workspace','title','status','created_at','attachments') } else { @('invalid_json') }
    $results += [pscustomobject]@{ kind='order'; file=$_.Name; missing=$missing }
  }
}

if (Test-Path -Path $AcksDir) {
  Get-ChildItem -Path $AcksDir -Filter *.json -File -ErrorAction SilentlyContinue | ForEach-Object {
    $a = Read-Json $_.FullName
    $missing = if ($a) { Check-Fields $a @('order_id','ack_id','workspace','ack_timestamp','notes') } else { @('invalid_json') }
    $results += [pscustomobject]@{ kind='ack'; file=$_.Name; missing=$missing }
  }
}

if (Test-Path -Path $ReportsDir) {
  Get-ChildItem -Path $ReportsDir -Filter *.json -File -ErrorAction SilentlyContinue | ForEach-Object {
    $r = Read-Json $_.FullName
    $missing = if ($r) { Check-Fields $r @('order_id','report_id','workspace','summary','created_at','artifacts') } else { @('invalid_json') }
    $results += [pscustomobject]@{ kind='report'; file=$_.Name; missing=$missing }
  }
}

$errors = @($results | Where-Object { $_.missing.Count -gt 0 })
$ok = ($errors.Count -eq 0)

$summary = [ordered]@{
  timestamp_utc = ([DateTimeOffset]::UtcNow.ToString("o"))
  workspace     = "archivist_ai_0"
  ok            = $ok
  items_checked = $results
}

$outDir = Split-Path -Parent $OutPath
if ($outDir -and -not (Test-Path $outDir)) { New-Item -ItemType Directory -Force -Path $outDir | Out-Null }
($summary | ConvertTo-Json -Depth 10) | Set-Content -Path $OutPath
Write-Host "Validation summary written to $OutPath (ok=$ok)"

if (-not $ok -and $FailOnError) { exit 1 }
