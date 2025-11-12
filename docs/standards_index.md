# Standards Index (v0)

Scope: archivist_ai_0. Keep changes minimal and reversible.

## Naming and Versioning
- Workspace: `archivist_ai_0` (stable identifier)
- Docs: start at `v0`; prefer semantic intent (0.y.z). Optional date suffix in filenames when helpful.
- Filenames: use lowercase, `_` separators; avoid spaces.

## Schema Anchors (Exchange)
- Orders, Acks, Reports, Ledger: mirror High Command shapes. Source of truth lives in the hub.
- Env: `SHAGI_EXCHANGE_PATH` points to the hub root.
- Example anchors (paths relative to hub):
  - `exchange/orders/dispatched/`
  - `exchange/acknowledgements/logged/`
  - `exchange/reports/archived/`
  - `exchange/ledger/`

## Logs Layout
- Local evidence lives under `logs/` in this repo working tree.
- Typical files: `heartbeat.json`, `sync.json`, ad-hoc run notes.
- Git: `logs/` is ignored; treat as ephemeral. Do not store secrets.

## Exchange Paths
- Set in shell: `$env:SHAGI_EXCHANGE_PATH = 'C:\\path\\to\\high_command_exchange'`
- Do not assume network; prefer local file-based exchange operations.

## Data Shapes (v0.1 examples)
- Orders (dispatched): minimal fields typically include `id`, `workspace`, `title`, `status`, `created_at`, `attachments`.
- Acknowledgements (logged): `order_id`, `ack_id`, `workspace`, `ack_timestamp`, `notes`.
- Reports (archived): `order_id`, `report_id`, `workspace`, `summary`, `created_at`, `artifacts`.
- Ledger: index entries that reference order/ack/report paths and open/closed state.

Filenames (examples)
- Orders: `exchange/orders/dispatched/order-YYYY-MM-DD-###.json`
- Acks: `exchange/acknowledgements/logged/order-YYYY-MM-DD-###-ack.json`
- Reports: `exchange/reports/archived/order-YYYY-MM-DD-###-report.json`
- Ledger month: `exchange/ledger/YYYY-MM.md`, index: `exchange/ledger/index.json`

Notes
- Treat hub schemas as source of truth; this section is a convenience summary for operators.
- Prefer copying shapes from the hub when in doubt to avoid drift.

## Governance
- Prefer small PRs with clear evidence hooks.
- Avoid schema drift; link to hub schemas when in doubt.
