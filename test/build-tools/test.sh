#!/bin/bash
set -euo pipefail
for tool in gcc cc make pkg-config; do
    command -v "$tool" >/dev/null || { echo "FAIL: missing $tool" >&2; exit 1; }
done
echo "PASS: build toolchain present"
