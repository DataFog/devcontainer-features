#!/bin/bash
set -euo pipefail
command -v maturin >/dev/null || { echo "FAIL: maturin not installed" >&2; exit 1; }
maturin --version
echo "PASS: pip_packages installed"
