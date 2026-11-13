# DataFog devcontainer features

Reusable [devcontainer features](https://containers.dev/implementors/features/) shared across DataFog repos.

## Convention

Every DataFog devcontainer uses a base image plus features — no hand-rolled Dockerfiles:

```jsonc
{
  "image": "ubuntu:24.04",
  "remoteUser": "ubuntu",
  "features": {
    // creates the non-root user, sudo, git, and other basics
    "ghcr.io/devcontainers/features/common-utils:2": { "username": "ubuntu", "installZsh": false },
    // keep "version" in sync with the repo's .nvmrc
    "ghcr.io/datafog/devcontainer-features/node-pinned:1": { "version": "24" }
  }
}
```

Versions are pinned **per repo** (in `devcontainer.json` / root files); the install
mechanism is shared here. Features run at image-build time, before the repo is
mounted, so they cannot read repo files — pass pins via options.

## Features

| Feature | Description |
| --- | --- |
| `node-pinned` | Installs Node.js from NodeSource at a pinned major version |
| `build-tools` | Native C/C++ toolchain for compiling Rust crates and native Python extensions |
| `python-tools` | Python 3 + optional system-wide pip packages (e.g. maturin) |
| `rust-pinned` | rustup with a pinned toolchain, optional components/targets and wasm-bindgen-cli |
| `playwright` | Playwright system deps and browser binaries in a shared path |

## Releasing

Features are published to GHCR on `workflow_dispatch` of
`.github/workflows/release.yaml` (uses `devcontainers/action@v1`, which packages
and pushes `ghcr.io/datafog/devcontainer-features/<feature-id>:<semver>` plus
major tags). Bump the `version` field in `devcontainer-feature.json` to ship a
new release.
