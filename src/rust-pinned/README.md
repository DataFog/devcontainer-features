
# Rust (pinned toolchain) (rust-pinned)

Installs rustup with a pinned toolchain, optional components and targets, and an optional wasm-bindgen-cli version. Keep the toolchain in sync with rust-toolchain.toml.

## Example Usage

```json
"features": {
    "ghcr.io/DataFog/devcontainer-features/rust-pinned:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| toolchain | Rust toolchain channel to install (match rust-toolchain.toml) | string | stable |
| profile | rustup install profile | string | minimal |
| components | Comma-separated rustup components (e.g. rustfmt,clippy) | string | - |
| targets | Comma-separated extra compilation targets (e.g. wasm32-unknown-unknown) | string | - |
| wasm_bindgen | wasm-bindgen-cli version to cargo-install (match Cargo.lock) | string | - |
| username | Non-root user that owns the toolchain | string | ubuntu |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/DataFog/devcontainer-features/blob/main/src/rust-pinned/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
