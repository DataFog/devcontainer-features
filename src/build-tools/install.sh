#!/bin/bash
# DataFog devcontainer feature: native build toolchain. Runs as root.
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

apt-get update -y
apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    libssl-dev \
    pkg-config \
    wget \
    xz-utils
rm -rf /var/lib/apt/lists/*

echo "build-tools: installed $(gcc --version | head -1)"
