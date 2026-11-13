#!/bin/bash
set -euo pipefail
export RUSTUP_HOME=/opt/rustup
export CARGO_HOME=/opt/cargo
export PATH="$CARGO_HOME/bin:$PATH"
su ubuntu --shell /bin/bash --command \
    "export RUSTUP_HOME=$RUSTUP_HOME CARGO_HOME=$CARGO_HOME PATH=$CARGO_HOME/bin:\$PATH; rustc --version"
rustc --version | grep -q '1\.88\.0' || { echo "FAIL: wrong toolchain $(rustc --version)" >&2; exit 1; }
rustup component list --installed | grep -qx clippy || { echo "FAIL: clippy missing" >&2; exit 1; }
rustup target list --installed | grep -qx wasm32-unknown-unknown || { echo "FAIL: wasm target missing" >&2; exit 1; }
wasm-bindgen --version
test -r /etc/profile.d/rust.sh
echo "PASS: pinned toolchain, components, target and wasm-bindgen present"
