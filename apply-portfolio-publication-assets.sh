#!/usr/bin/env bash
set -euo pipefail

# Publication assets: favicon, web manifest, basic SEO, robots.txt and sitemap.xml.
# Run from the root of portfolio-giulia:
#   chmod +x apply-portfolio-publication-assets.sh
#   ./apply-portfolio-publication-assets.sh https://your-domain.example
#
# Example for a GitHub Pages project site:
#   ./apply-portfolio-publication-assets.sh https://username.github.io/portfolio-giulia

SITE_URL="${1:-}"

if [[ -z "$SITE_URL" ]]; then
  read -r -p "Public site URL (e.g. https://giuliacardarilli.com): " SITE_URL
fi

SITE_URL="${SITE_URL%/}"

if [[ ! "$SITE_URL" =~ ^https:// ]]; then
  echo "Error: use a complete HTTPS URL, e.g. https://giuliacardarilli.com" >&2
  exit 1
fi

required_files=("index.html" "assets/images/profile/giulia-cardarilli.jpeg")
for file in "${required_files[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "Error: missing required file: $file" >&2
    exit 1
  fi
done

mkdir -p assets/icons assets/images/decor

cat > favicon.svg <<'EOF'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64">
  <rect width="64" height="64" rx="18" fill="#7352B7"/>
  <path d="M43.8 18.4c-2.8-2-6.5-3.1-10.7-3.1-9.7 0-16.6 6.9-16.6 16.8 0 9.8 6.7 16.6 16.5 16.6 4.4 0 8.5-1.4 11.2-3.8V31.4H31.1v6.2h6.3v3.7c-1.2.7-2.8 1-4.4 1-5.2 0-8.8-4.1-8.8-10.1 0-6.2 3.8-10.4 9.1-10.4 2.8 0 5.1.8 7.1 2.5l3.4-5.9Z" fill="#fff"/>
</svg>
EOF

cat > assets/icons/linkedin.svg <<'EOF'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
  <path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-4 0v7h-4v-7a6 6 0 0 1 6-6z"/>
  <rect x="2" y="9" width="4" height="12"/>
  <circle cx="4" cy="4" r="2"/>
</svg>
EOF

cat > assets/icons/download.svg <<'EOF'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
  <path d="M12 3v12"/><path d="m7 10 5 5 5-5"/><path d="M5 21h14"/>
</svg>
EOF

cat > assets/icons/external-link.svg <<'EOF'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
  <path d="M14 3h7v7"/><path d="m10 14 11-11"/><path d="M21 14v5a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5"/>
</svg>
EOF

cat > assets/icons/globe.svg <<'EOF'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
  <circle cx="12" cy="12" r="9"/><path d="M3 12h18"/><path d="M12 3c2.3 2.5 3.5 5.5 3.5 9S14.3 18.5 12 21c-2.3-2.5-3.5-5.5-3.5-9S9.7 5.5 12 3z"/>
</svg>
EOF

cat > assets/images/decor/monogram-gc.svg <<'EOF'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 180" fill="none">
  <path d="M144 37c-22-16-50-24-80-24C-9 13-60 65-60 139s49 125 122 125c33 0 63-10 83-29v-62H50v38h48v6c-10 5-22 8-35 8-37 0-62-31-62-86S27 52 64 52c20 0 35 6 49 18l31-33Z" fill="#7352B7" fill-opacity=".12"/>
  <path d="M348 51c-17-16-39-24-65-24-57 0-96 42-96 94s38 94 95 94c28 0 51-8 69-26l-27-32c-11 10-24 15-41 15-31 0-52-22-52-51s21-51 52-51c16 0 30 5 41 15l24-34Z" fill="#7352B7" fill-opacity=".12"/>
</svg>
EOF

cat > site.webmanifest <<'EOF'
{
  "name": "Giulia Cardarilli | Psicología",
  "short_name": "Giulia Cardarilli",
  "lang": "es",
  "start_url": "./",
  "display": "standalone",
  "background_color": "#FAF8FE",
  "theme_color": "#7352B7"
}
EOF

cat > .nojekyll <<'EOF'
EOF

cat > robots.txt <<EOF
User-agent: *
Allow: /

Sitemap: ${SITE_URL}/sitemap.xml
EOF

cat > sitemap.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>${SITE_URL}/</loc>
    <changefreq>monthly</changefreq>
    <priority>1.0</priority>
  </url>
</urlset>
EOF

python3 - "$SITE_URL" <<'PY'
from pathlib import Path
import sys

site_url = sys.argv[1]
path = Path("index.html")
content = path.read_text(encoding="utf-8")

start = "    <!-- publication-meta:start -->"
end = "    <!-- publication-meta:end -->"
if start in content and end in content:
    before, remainder = content.split(start, 1)
    _, after = remainder.split(end, 1)
    content = before + after

meta = f'''    <!-- publication-meta:start -->
    <link rel="manifest" href="site.webmanifest" />
    <link rel="canonical" href="{site_url}/" />

    <meta property="og:type" content="website" />
    <meta property="og:site_name" content="Giulia Cardarilli" />
    <meta property="og:locale" content="es_ES" />
    <meta property="og:url" content="{site_url}/" />
    <meta property="og:title" content="Giulia Cardarilli | Psicología" />
    <meta property="og:description" content="Portfolio profesional de Giulia Cardarilli, psicóloga en formación clínica." />
    <meta property="og:image" content="{site_url}/assets/images/profile/giulia-cardarilli.jpeg" />
    <meta property="og:image:alt" content="Giulia Cardarilli" />

    <meta name="twitter:card" content="summary_large_image" />
    <meta name="twitter:title" content="Giulia Cardarilli | Psicología" />
    <meta name="twitter:description" content="Portfolio profesional de Giulia Cardarilli, psicóloga en formación clínica." />
    <meta name="twitter:image" content="{site_url}/assets/images/profile/giulia-cardarilli.jpeg" />
    <!-- publication-meta:end -->
'''

needle = '    <link rel="icon" href="favicon.svg" type="image/svg+xml" />\n'
if needle not in content:
    raise SystemExit("Expected favicon link not found in index.html")
content = content.replace(needle, needle + "\n" + meta, 1)

content = content.replace(
    '<img src="assets/images/profile/giulia-cardarilli.jpeg" alt="Giulia Cardarilli" data-i18n-alt="images.profileAlt" />',
    '<img src="assets/images/profile/giulia-cardarilli.jpeg" alt="Giulia Cardarilli" data-i18n-alt="images.profileAlt" fetchpriority="high" decoding="async" />',
    1,
)
content = content.replace(
    '<img class="certificate-card__image" src="assets/images/certificates/curso-apego-adulto-aepsis.jpeg" alt="Certificado del curso sobre apego adulto de AEPSIS" data-i18n-alt="images.certificateAlt" />',
    '<img class="certificate-card__image" src="assets/images/certificates/curso-apego-adulto-aepsis.jpeg" alt="Certificado del curso sobre apego adulto de AEPSIS" data-i18n-alt="images.certificateAlt" loading="lazy" decoding="async" />',
    1,
)
path.write_text(content, encoding="utf-8")
PY

printf '\nPublication files created successfully for: %s\n' "$SITE_URL"
printf 'Review index.html and then test the URL with Live Server before committing.\n'
