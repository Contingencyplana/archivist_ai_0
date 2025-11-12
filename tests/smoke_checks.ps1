param(
  [string]$OutPath = "logs/tests_smoke.json"
)

$res = @{}

function Run-Safe($name, $cmd) {
  try {
    & $cmd | Out-Null
    $res[$name] = "ok"
  } catch {
    $res[$name] = "error: $($_.Exception.Message)"
  }
}

Run-Safe -name "validate_staged" -cmd "$PSScriptRoot/../tools/validate_staged_json.ps1"

$summary = [ordered]@{
  timestamp_utc = ([DateTimeOffset]::UtcNow.ToString("o"))
  workspace     = "tons_of_fun_ai_0"
  results       = $res
}

$outDir = Split-Path -Parent $OutPath
if ($outDir -and -not (Test-Path $outDir)) { New-Item -ItemType Directory -Force -Path $outDir | Out-Null }
($summary | ConvertTo-Json -Depth 6) | Set-Content -Path $OutPath
Write-Host "Smoke checks written to $OutPath"
