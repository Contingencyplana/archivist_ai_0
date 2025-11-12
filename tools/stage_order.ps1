param(
  [string]$Title = "Test order",
  [string]$OutDir = "outbox/orders"
)

if (-not (Test-Path -Path $OutDir)) { New-Item -ItemType Directory -Force -Path $OutDir | Out-Null }

$ts = [DateTime]::UtcNow.ToString("yyyy-MM-dd-HHmmss")
$id = "order-$ts-001"
$fileName = "$id.json"
$path = Join-Path $OutDir $fileName

$payload = [ordered]@{
  id         = $id
  workspace  = "archivist_ai_0"
  title      = $Title
  status     = "open"
  created_at = ([DateTimeOffset]::UtcNow.ToString("o"))
  attachments = @()
  issued_by  = "archivist_ai_0"
}

$json = $payload | ConvertTo-Json -Depth 6
Set-Content -Path $path -Value $json
Write-Host "Staged order: $path"
