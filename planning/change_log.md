# Change Log

All notable updates to the High Command AI workspace are documented here. Entries reference corresponding orders and ledger notes.

## 2025-10-12

- **Order 2025-10-12-001** — Issued first exchange directive; toysoldiers_ai_0 stood up receiver, produced ack/report, and order closed in ledger.
- **Order 2025-10-12-002** — Directed toysoldiers_ai_0 to align acknowledgement/report payloads with official schemas and implement expiry warnings.
- **Order 2025-10-12-003** — Mandated governance collateral (MIT license, Code of Conduct, Contributing guide) across toysoldiers_ai_0; exchange ledger updated after acknowledgement/report cycle.
- **Exchange Watcher v1** — Introduced `tools/exchange_watcher.py` with tests to surface new orders/acks/reports automatically; recommended for deployment in all field theatres.
- **Doctrine Glossary** — Added `planning/glossary.md` capturing shared acronyms, terminology, and tooling references for High Command and field theatres.
- **Toyfoundry Charter Q4 2025** — Expanded `planning/toyfoundry/toyfoundry.md` with mission scope, interfaces, guardrails, and upcoming orders to prepare manufacturing rollout.

## 2025-11-08

- **Order 044 Comfort/Automation Vocabulary** — Refreshed `planning/glossary.md` with Comfort Path, Automation Path, Inbox Backlog, and Daily Doc Refresh definitions plus telemetry tooling references; aligns with ledger entry `2025-11-08 21:55` and promotes Toyfoundry/Toysoldiers evidence.

## 2025-11-13

- **ARC-001 (archivist_ai_0)** — Stood up Standards/Runbook indexes and evidence hooks; added heartbeat/sync wrappers; docs linked in README.
- **ARC-002 (archivist_ai_0)** — Added Doc Map and local docs check (`tools/check_docs.ps1`) writing `logs/docs_check.json`; cross-links verified.
 - **ARC-004 (archivist_ai_0)** — Added pre-sync validator (`tools/validate_staged_json.ps1`) and smoke checks; updated README to include validation step.
