# Contributing Guide

Thank you for helping grow the Archivist genesis workspace. This repository is the documentation and standards hub for the Genesis Workspaces program; please keep contributions focused, well-evidenced, and easy to audit.

## Core Principles

- Keep changes minimal and reversible (see `AGENTS.md`).
- Favour clear documentation, updated indices, and working evidence links over large restructures.
- Reference relevant orders, ledger entries, or planning notes when you add or revise material.

## 1. Prepare Your Environment

1. Work in PowerShell on Windows (the tooling assumes this environment).
2. Set `SHAGI_EXCHANGE_PATH` to the local hub path when you need to interact with shared exchange artifacts.
3. Keep a checked-out copy of `high_command_ai_0` at `C:\Users\Admin\high_command_ai_0`; the Python shims in `tools/` delegate to that workspace.
4. Verify your setup with `python -m tools.ops_readiness` (populates env vars and runs the upstream readiness script).

## 2. Making Changes

- Update `docs/doc_map.md`, `docs/runbook_index.md`, and other indices whenever you add, rename, or relocate documents.
- Use relative paths in documentation and keep filenames lowercase with `_` separators, matching `docs/standards_index.md`.
- Capture rationale and outstanding questions in `planning/workspaces/archivist_ai_0/` so other operators can trace decisions.
- When touching exchange tooling, mirror schema expectations from the hub rather than inventing new shapes locally.

## 3. Validation and Evidence

- Run `./tools/check_docs.ps1` to confirm key docs exist and links resolve (writes `logs/docs_check.json`).
- Use `./tools/run_all_checks.ps1` for a full local sweep (heartbeat, sync dry-run, docs check) before submitting substantial updates.
- Record noteworthy outputs in `logs/` (ignored by git) and reference them in PR notes if they substantiate changes.
- For exchange operations, dry-run with `python tools/exchange_all.py` or `./tools/sync_exchange.ps1` before copying artifacts to the hub.

## 4. Change Tracking and Commits

- Summarize meaningful documentation shifts in `planning/change_log.md` with date-stamped bullets and order references when applicable.
- Keep commits small, descriptive, and evidence-backed (e.g., `docs: refresh standards index v0.2 (ARC-004)`).
- Avoid rebasing shared branches without coordinator approval; preserve history for audit trails.

## 5. Pull Requests

1. Describe the motivation, affected docs/scripts, and validation steps in the PR body.
2. Include links to relevant orders, ledger entries, or planning notes that justify the change.
3. Request review from another Archivist maintainer and ensure local checks complete without errors before merging.

## 6. Safety and Escalation

- Escalate immediately if you encounter schema drift, missing safeguards, or exchange anomalies; document the observation in `planning/workspaces/archivist_ai_0/`.
- Do not remove safety hooks or hub references without explicit approval from maintainers.
- When in doubt, pause and ask—rapid clarification beats silent divergence.

By contributing, you agree to follow this guide and the Archivist Code of Conduct.
