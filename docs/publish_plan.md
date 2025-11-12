# Publish Plan (v0)

Goal: offline-friendly, simple steps to publish and refresh docs without network dependencies.

Cadence
- Spin-up: ad-hoc as documents stabilize (daily is fine).
- Steady state: weekly refresh, with a short changelog in `planning/change_log.md`.

Scope
- This repo's `docs/` and key planning indices under `planning/workspaces/archivist_ai_0/`.
- Evidence hooks stay local under `logs/` (ignored by git).

Steps (manual, minimal)
1) Update docs locally (no external build required).
2) Verify relative links resolve: open `docs/runbook_index.md` and `docs/standards_index.md`.
3) Record summary in `planning/change_log.md` (date + 1–3 bullets).
4) Commit with a small message (e.g., "docs: refresh indexes v0.y").

Exchange Notes
- If publishing artifacts to High Command, use `SHAGI_EXCHANGE_PATH` to locate the hub.
- Prefer file copy into hub folders (orders/reports/ledger) as defined by Standards Index.

Next
- Consider a lightweight static export (optional). Defer until needed.
