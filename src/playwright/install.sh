#!/bin/bash
# DataFog devcontainer feature: Playwright browsers for all users. Runs as root.
set -euo pipefail

version="${VERSION:-latest}"
browsers="${BROWSERS:-chromium}"

export DEBIAN_FRONTEND=noninteractive
export PLAYWRIGHT_BROWSERS_PATH=/opt/pw-browsers

apt-get update -y
apt-get install -y --no-install-recommends ca-certificates curl
rm -rf /var/lib/apt/lists/*

# System libraries needed by the browser binaries.
npx --yes "playwright@${version}" install-deps ${browsers//,/ }

# Browser binaries into a shared path so the non-root user can launch them.
mkdir -p "$PLAYWRIGHT_BROWSERS_PATH"
npx --yes "playwright@${version}" install ${browsers//,/ }
chmod -R a+rX "$PLAYWRIGHT_BROWSERS_PATH"

printf 'export PLAYWRIGHT_BROWSERS_PATH=%s\n' "$PLAYWRIGHT_BROWSERS_PATH" \
    > /etc/profile.d/playwright.sh
chmod 644 /etc/profile.d/playwright.sh

echo "playwright: browsers installed under $PLAYWRIGHT_BROWSERS_PATH"
