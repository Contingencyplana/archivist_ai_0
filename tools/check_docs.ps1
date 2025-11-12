param(
  [string]$OutPath = "logs/docs_check.json"
)

$files = @(
  "docs/doc_map.md",
  "docs/standards_index.md",
  "docs/runbook_index.md",
  "docs/publish_plan.md",
  "RUNBOOK.md",
  "planning/workspaces/archivist_ai_0/README.md"
)

$docMapPath = "docs/doc_map.md"
$expectedTokens = @(
  "runbook_index.md",
  "standards_index.md",
  "publish_plan.md",
  "planning/workspaces/archivist_ai_0/README.md",
  "RUNBOOK.md"
)

$checks = @()
foreach ($f in $files) {
  $exists = Test-Path -Path $f
  $checks += [pscustomobject]@{ path = $f; exists = $exists }
}

$docMapContent = ""
if (Test-Path -Path $docMapPath) {
  try { $docMapContent = Get-Content -Path $docMapPath -Raw } catch { $docMapContent = "" }
}

$tokenResults = @()
foreach ($t in $expectedTokens) {
  $hasToken = $false
  if ($docMapContent) { $hasToken = $docMapContent -like "*${t}*" }
  $tokenResults += [pscustomobject]@{ token = $t; present = [bool]$hasToken }
}

$allFilesExist = -not ($checks | Where-Object { -not $_.exists })
$allTokensPresent = -not ($tokenResults | Where-Object { -not $_.present })

$result = [ordered]@{
  timestamp_utc    = ([DateTimeOffset]::UtcNow.ToString("o"))
  workspace        = "archivist_ai_0"
  files_checked    = $checks
  doc_map_tokens   = $tokenResults
  ok               = ($allFilesExist -and $allTokensPresent)
}

$outDir = Split-Path -Parent $OutPath
if ($outDir -and -not (Test-Path $outDir)) {
  New-Item -ItemType Directory -Force -Path $outDir | Out-Null
}

$json = $result | ConvertTo-Json -Depth 6
Set-Content -Path $OutPath -Value $json
Write-Host "Docs check written to $OutPath (ok=$($result.ok))"
