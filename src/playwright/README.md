
# Playwright browsers (playwright)

Installs Playwright's system dependencies and browser binaries into a shared, world-readable location. Keep the version in sync with the consuming project's playwright devDependency.

## Example Usage

```json
"features": {
    "ghcr.io/DataFog/devcontainer-features/playwright:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | playwright npm package version to install browsers for | string | latest |
| browsers | Comma-separated browsers to install (chromium, firefox, webkit) | string | chromium |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/DataFog/devcontainer-features/blob/main/src/playwright/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
