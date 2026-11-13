#!/bin/bash
# DataFog devcontainer feature: Python 3 + optional pip packages. Runs as root.
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

apt-get update -y
apt-get install -y --no-install-recommends \
    python3 \
    python3-dev \
    python3-pip \
    python3-venv \
    python3.12-venv
rm -rf /var/lib/apt/lists/*

packages="${PIP_PACKAGES:-}"
if [ -n "$packages" ]; then
    # ubuntu ships an externally-managed Python; install system-wide on purpose.
    python3 -m pip install --break-system-packages $packages
fi

echo "python-tools: installed $(python3 --version)"
