#!/bin/bash
set -euo pipefail
export RUSTUP_HOME=/opt/rustup
export CARGO_HOME=/opt/cargo
export PATH="$CARGO_HOME/bin:$PATH"
rustc --version
cargo --version
test -r /etc/profile.d/rust.sh
echo "PASS: rust toolchain present"
