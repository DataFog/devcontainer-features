#!/bin/bash
# DataFog devcontainer feature: pinned Rust toolchain. Runs as root, installs
# into a user-owned shared location so every user in the image can build.
set -euo pipefail

toolchain="${TOOLCHAIN:-stable}"
profile="${PROFILE:-minimal}"
components="${COMPONENTS:-}"
targets="${TARGETS:-}"
wasm_bindgen="${WASM_BINDGEN:-}"
user="${USERNAME:-ubuntu}"

export RUSTUP_HOME=/opt/rustup
export CARGO_HOME=/opt/cargo
export PATH="$CARGO_HOME/bin:$PATH"

if ! id "$user" >/dev/null 2>&1; then
    echo "rust-pinned: user '$user' does not exist (install common-utils first)." >&2
    exit 1
fi

if [ "$(find /var/lib/apt/lists/* -mtime 0 2>/dev/null | wc -l)" -eq 0 ]; then
    apt-get update -y
fi
apt-get install -y --no-install-recommends ca-certificates curl
rm -rf /var/lib/apt/lists/*

mkdir -p "$RUSTUP_HOME" "$CARGO_HOME"
chown -R "$user:$user" "$RUSTUP_HOME" "$CARGO_HOME"

as_user() {
    su "$user" --shell /bin/bash --command \
        "export RUSTUP_HOME=$RUSTUP_HOME CARGO_HOME=$CARGO_HOME PATH=$CARGO_HOME/bin:\$PATH; $1"
}

as_user "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain $toolchain --profile $profile --no-modify-path"

if [ -n "$components" ]; then
    as_user "rustup component add ${components//,/ }"
fi

if [ -n "$targets" ]; then
    as_user "rustup target add ${targets//,/ }"
fi

if [ -n "$wasm_bindgen" ]; then
    as_user "cargo install wasm-bindgen-cli --version $wasm_bindgen --locked"
fi

# rustup was installed with --no-modify-path; make the toolchain visible to all users.
printf 'export RUSTUP_HOME=%s\nexport CARGO_HOME=%s\nexport PATH="%s/bin:$PATH"\n' \
    "$RUSTUP_HOME" "$CARGO_HOME" "$CARGO_HOME" > /etc/profile.d/rust.sh
chmod 644 /etc/profile.d/rust.sh

echo "rust-pinned: installed $(as_user 'rustc --version')"
