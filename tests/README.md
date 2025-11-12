# Tests (v0)

This repo uses simple, local checks rather than a full test framework.

- Docs check: `../tools/check_docs.ps1` — verifies core docs exist and Doc Map contains expected links; writes `../logs/docs_check.json`.
- Heartbeat: `../tools/heartbeat.ps1` — writes `../logs/heartbeat.json`.
- Sync (dry-run): `../tools/sync_exchange.ps1` — writes `../logs/sync.json`.

Notes
- `logs/` is ignored by git; evidence is local only.
- Keep changes minimal and reversible.
