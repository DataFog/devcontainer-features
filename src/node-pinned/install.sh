#!/bin/bash
# DataFog devcontainer feature: install Node.js pinned to a specific major
# version via NodeSource. Runs as root during image build.
set -euo pipefail

version="${VERSION:-lts}"

# Normalize: strip leading 'v' and trailing '.x' so "v24.x" and "24" both work.
version="${version#v}"
version="${version%.x}"

if [ "$version" = "lts" ]; then
    setup="setup_lts.x"
elif [[ "$version" =~ ^[0-9]+$ ]]; then
    setup="setup_${version}.x"
else
    echo "node-pinned: unsupported version '$version' (use a major version like '24', or 'lts')." >&2
    exit 1
fi

export DEBIAN_FRONTEND=noninteractive

apt_get_update() {
    if [ "$(find /var/lib/apt/lists/* -mtime 0 2>/dev/null | wc -l)" -eq 0 ]; then
        echo "Running apt-get update..."
        apt-get update -y
    fi
}

apt_get_update
apt-get install -y --no-install-recommends ca-certificates curl gnupg

curl -fsSL "https://deb.nodesource.com/${setup}" | bash -

apt-get install -y --no-install-recommends nodejs
rm -rf /var/lib/apt/lists/*

echo "node-pinned: installed $(node --version)"
