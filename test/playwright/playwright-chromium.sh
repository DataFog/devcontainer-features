#!/bin/bash
set -euo pipefail
ls /opt/pw-browsers | grep -qi chromium || { echo "FAIL: chromium not installed" >&2; exit 1; }
PLAYWRIGHT_BROWSERS_PATH=/opt/pw-browsers npx --yes playwright@1.62.1 --version
echo "PASS: chromium installed and readable"
