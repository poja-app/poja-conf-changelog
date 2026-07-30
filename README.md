<img src="assets/logo-violet.png" alt="Poja" width="200" />

# poja-conf-changelog
Central repository for all POJA conf changelogs and migration guides across versions.

Browse the published changelog: **[poja-app.github.io/poja-conf-changelog](https://poja-app.github.io/poja-conf-changelog/)**

## Adding a release

Add a `x.y.z.md` file at the root with a `## What's new` section, and `## Breaking changes` and/or `## Fix` sections if relevant. Pushing to `main` builds and publishes the site automatically.

To show a release date on the site, start the file with a YAML front matter block:

```
---
date: 2026-07-15
---
## What's new
...
```

## Branding

`assets/` holds the site's brand assets and build templates:

- `logo-violet.png`, `logo-white.png`, `favicon-*.png`, `apple-touch-icon.png` — POJA logo and favicon variants
- `style.css` — shared stylesheet for every generated page
- `template.html` — pandoc template used to render each version page
- `generate-index.sh` — builds the changelog index page
