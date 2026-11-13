
# Node.js (pinned) (node-pinned)

Installs Node.js from NodeSource, pinned to a specific major version. Keep the version option in sync with the consuming repo's .nvmrc (features run at image-build time and cannot read repo files).

## Example Usage

```json
"features": {
    "ghcr.io/DataFog/devcontainer-features/node-pinned:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | Node.js major version to install (e.g. 24), or 'lts' for the current LTS | string | lts |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/DataFog/devcontainer-features/blob/main/src/node-pinned/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
