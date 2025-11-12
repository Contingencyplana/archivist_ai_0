# Exchange Integration (shared hub model)

This workspace uses a shared Exchange hub for all orders, acks, reports, and ledger files.
Do not duplicate the Exchange tree inside this repo. Instead, stage locally and sync to the hub.

Key points
- Shared hub path comes from env: `SHAGI_EXCHANGE_PATH` (preferred) or `exchange/config.json` fallback.
- Stage artifacts locally under `outbox/` in this repo.
- Use the provided sync helper to copy staged artifacts into the hub.

Folders
- `outbox/orders/`  — staged orders (JSON)
- `outbox/reports/` — staged reports (JSON)
- `outbox/acks/`    — staged acknowledgements (JSON)

Hub destinations (relative to hub root)
- Orders (dispatched): `exchange/orders/dispatched/`
- Reports (archived): `exchange/reports/archived/`
- Acks (logged): `exchange/acknowledgements/logged/`

Quickstart (PowerShell)
1) Set hub path: `$env:SHAGI_EXCHANGE_PATH = 'C:\\Users\\Admin\\high_command_exchange'`
2) Stage an order: `./tools/stage_order.ps1 -Title 'Hello from archivist_ai_0'`
3) Stage an ack: `./tools/stage_ack.ps1 -OrderId '<order-id>' -Notes 'received'`
4) Sync to hub: `./tools/sync_outbox_to_hub.ps1`

Notes
- Evidence remains in `logs/` (ignored by git). No secrets in repo.
- The hub is the source of truth; keep changes minimal and reversible.
