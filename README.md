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
 - Run all checks: `./tools/run_all_checks.ps1`

## Python commands
- Cadence: `python tools/end_of_block.py` (heartbeat -> offline_sync_exchange -> ops_readiness -> exchange_all)
- Readiness: `python -m tools.ops_readiness`
- Exchange (validate + sync): `python tools/exchange_all.py`
- Emitter smoke: `python tools/factory_order_emitter.py --help` (replaces any exchange_all smoke caveat)

Tests (smoke): `./tests/smoke_checks.ps1` (writes `logs/tests_smoke.json`)

## Publish (optional)
- Create local summary JSON: `./tools/publish_report.ps1`
- Copy to hub (if `SHAGI_EXCHANGE_PATH` set): `./tools/publish_report.ps1 -CopyToHub`

Notes: logs written under `logs/` (ignored by git). No secrets in repo.

## Exchange (shared hub)
- Set hub path: `$env:SHAGI_EXCHANGE_PATH = 'C:\\Users\\Admin\\high_command_exchange'`
- Stage an order: `./tools/stage_order.ps1 -Title 'Hello from archivist_ai_0'`
- Stage a report: `./tools/stage_report.ps1 -OrderId '<order-id>' -Summary 'Done'`
- Stage an ack: `./tools/stage_ack.ps1 -OrderId '<order-id>' -Notes 'received'`
- Sync outbox to hub: `./tools/sync_outbox_to_hub.ps1`

Pre-sync validate (recommended): `./tools/validate_staged_json.ps1` (writes `logs/validate_staged.json`)

Staging dirs in this repo: `outbox/orders/`, `outbox/reports/`, `outbox/acks/`. Hub remains the source of truth.
 
Note: `sync_outbox_to_hub.ps1` runs the validator first and refuses to sync if validation fails. You can run the validator directly via `./tools/validate_staged_json.ps1`.
