# Standards Anchors (v0.1)

This page summarizes common hub paths and filename patterns for operators. The hub is the source of truth; use these as quick references.

- Hub root (env): `$env:SHAGI_EXCHANGE_PATH`

## Exchange Folders
- Orders (dispatched): `exchange/orders/dispatched/`
- Acknowledgements (logged): `exchange/acknowledgements/logged/`
- Reports (archived): `exchange/reports/archived/`
- Ledger (index/months): `exchange/ledger/`

## Filename Patterns
- Orders: `order-YYYY-MM-DD-###.json`
- Acks: `order-YYYY-MM-DD-###-ack.json`
- Reports: `order-YYYY-MM-DD-###-report.json`
- Ledger month: `YYYY-MM.md`
- Ledger index: `index.json`

## Minimal Field Hints
- Orders: `id`, `workspace`, `title`, `status`, `created_at`, `attachments`
- Acks: `order_id`, `ack_id`, `workspace`, `ack_timestamp`, `notes`
- Reports: `order_id`, `report_id`, `workspace`, `summary`, `created_at`, `artifacts`
- Ledger: entries referencing order/ack/report paths and open/closed state

## Related
- See: `./standards_index.md`
