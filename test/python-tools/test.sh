#!/bin/bash
set -euo pipefail
python3 --version
python3 -c 'import venv, ssl'
echo "PASS: python3 present"
