#!/bin/bash
# Assert the feature installed the pinned Node.js major version.
set -euo pipefail

node --version | grep -E '^v24\.' || {
    echo "FAIL: expected Node v24.x, got $(node --version)" >&2
    exit 1
}
echo "PASS: $(node --version)"
