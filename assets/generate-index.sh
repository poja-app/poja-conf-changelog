#!/usr/bin/env bash
set -euo pipefail

OUT="site/index.html"

VERSIONS=$(ls *.md 2>/dev/null \
  | grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.md$' \
  | sed 's/\.md$//' \
  | sort -rV)

LATEST=$(echo "$VERSIONS" | head -n1)

cat > "$OUT" << 'HTMLEOF'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Poja Changelog</title>
<link rel="icon" type="image/png" href="assets/favicon-32.png" />
<link rel="apple-touch-icon" href="assets/apple-touch-icon.png" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="assets/style.css" />
</head>
<body>
<header class="site-header">
  <div class="container header-inner">
    <a class="brand" href="https://console.poja.io">
      <img src="assets/logo-white.png" alt="Poja" class="brand-logo" />
    </a>
    <nav class="site-nav">
      <a href="https://console.poja.io" target="_blank" rel="noopener">Console</a>
      <a href="https://github.com/poja-app" target="_blank" rel="noopener" aria-label="Poja on GitHub" class="github-link">
        <svg viewBox="0 0 16 16" width="26" height="26" fill="currentColor" aria-hidden="true"><path d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0 0 16 8c0-4.42-3.58-8-8-8z"/></svg>
      </a>
    </nav>
  </div>
</header>
<section class="hero">
  <div class="container hero-inner">
    <h1>Changelog</h1>
    <p>Release notes and migration guides for every Poja version.</p>
  </div>
</section>
<main class="container">
  <div class="version-list">
HTMLEOF

for VERSION in $VERSIONS; do
  CONTENT=$(pandoc "$VERSION.md" -f markdown -t html 2>/dev/null || echo "<p>No content.</p>")

  LATEST_BADGE=""
  if [ "$VERSION" = "$LATEST" ]; then
    LATEST_BADGE='<span class="latest-badge">Latest</span>'
  fi

  cat >> "$OUT" << BLOCKEOF
    <article class="version-card" id="v$VERSION">
      <div class="version-card-header">
        <span class="version-badge">v$VERSION</span>
        $LATEST_BADGE
      </div>
      $CONTENT
      <div class="version-card-footer">
        <a class="version-link" href="$VERSION.html">View release &rarr;</a>
      </div>
    </article>
BLOCKEOF
done

cat >> "$OUT" << 'HTMLEOF'
  </div>
</main>
<footer class="site-footer">
  <div class="container footer-inner">
    <img src="assets/favicon-512.png" alt="" class="footer-mark" />
    <p>&copy; Poja &mdash; <a href="https://github.com/poja-app/poja-conf-changelog" target="_blank" rel="noopener">poja-conf-changelog</a></p>
  </div>
</footer>
</body>
</html>
HTMLEOF
