#!/bin/bash
set -euo pipefail
test -d /opt/pw-browsers || { echo "FAIL: browsers path missing" >&2; exit 1; }
test -n "$(ls -A /opt/pw-browsers)" || { echo "FAIL: no browsers installed" >&2; exit 1; }
echo "PASS: browsers present"
