#!/bin/bash
# DataFog devcontainer feature: Playwright browsers for all users. Runs as root.
set -euo pipefail

version="${VERSION:-latest}"
browsers="${BROWSERS:-chromium}"

export DEBIAN_FRONTEND=noninteractive
export PLAYWRIGHT_BROWSERS_PATH=/opt/pw-browsers

apt-get update -y
apt-get install -y --no-install-recommends ca-certificates curl
# npx is needed to fetch the browsers; fall back to the distro package when
# no Node feature (node-pinned) is installed alongside.
# Playwright needs Node >= 20; the distro package is too old.
if ! command -v npx >/dev/null 2>&1; then
    curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
    apt-get install -y --no-install-recommends nodejs
fi
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
