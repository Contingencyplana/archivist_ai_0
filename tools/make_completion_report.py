import json, os
from pathlib import Path
from datetime import datetime, timezone
ORDER_ID = "order-2025-11-13-053"
WORKSPACE = "archivist_ai_0"
ROOT = Path(__file__).resolve().parents[1]
out = ROOT/"outbox"/"reports"
out.mkdir(parents=True, exist_ok=True)
report = {
    "schema": "field-report@1.0",
    "report_id": f"{ORDER_ID}-report",
    "order_id": ORDER_ID,
    "workspace": WORKSPACE,
    "status": "completed",
    "timestamp_submitted": datetime.now(timezone.utc).isoformat(),
    "summary": "Genesis spin-up completed (hello report).",
    "artifacts": {
        "standards_index": "docs/standards_index.md",
        "readiness_log": "logs/ops_readiness.json"
    }
}
(dest := out/f"{ORDER_ID}-report.json").write_text(json.dumps(report, indent=2), encoding="utf-8")
print(dest)
