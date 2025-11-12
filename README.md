# archivist_ai_0

Genesis workspace scaffold.

- Purpose: see RUNBOOK.md
- Exchange path: set SHAGI_EXCHANGE_PATH locally
- Ops: run heartbeat/sync via High Command tools until local wrappers exist

## Docs
- Standards Index: `docs/standards_index.md`
- Runbook Index: `docs/runbook_index.md`
- Publish Plan: `docs/publish_plan.md`
 - Doc Map: `docs/doc_map.md`

## Quickstart (PowerShell)
- Set exchange path (example): `$env:SHAGI_EXCHANGE_PATH = 'C:\\Users\\Admin\\high_command_exchange'`
- Heartbeat: `./tools/heartbeat.ps1`
- Sync (dry-run evidence): `./tools/sync_exchange.ps1`
 - Docs check: `./tools/check_docs.ps1` (writes `logs/docs_check.json`)

## Publish (optional)
- Create local summary JSON: `./tools/publish_report.ps1`
- Copy to hub (if `SHAGI_EXCHANGE_PATH` set): `./tools/publish_report.ps1 -CopyToHub`

Notes: logs written under `logs/` (ignored by git). No secrets in repo.
