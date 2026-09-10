#!/usr/bin/env bash
set -euo pipefail

# Adds a dynamically translated Resources section and creates a 1200x630 Open Graph artwork.
# Run in the project root. Optional first argument: the final public HTTPS URL.
# Example:
# ./apply-portfolio-resources-and-og-cover.sh https://username.github.io/portfolio-giulia

SITE_URL="${1:-}"
SITE_URL="${SITE_URL%/}"

required_files=(
  "index.html"
  "js/main.js"
  "js/i18n.js"
  "css/components.css"
  "css/layout.css"
  "css/responsive.css"
  "assets/i18n/es.json"
  "assets/i18n/it.json"
  "assets/i18n/en.json"
  "assets/images/profile/giulia-cardarilli.jpeg"
)

for file in "${required_files[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "Error: required file not found: $file" >&2
    exit 1
  fi
done

mkdir -p assets/images/social js

# Embedding the profile picture creates a self-contained SVG source artwork.
PHOTO_BASE64="$(base64 -w 0 assets/images/profile/giulia-cardarilli.jpeg)"

cat > assets/images/social/og-cover.svg <<EOF
<svg xmlns="http://www.w3.org/2000/svg" width="1200" height="630" viewBox="0 0 1200 630">
  <defs>
    <linearGradient id="background" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0" stop-color="#FAF8FE"/>
      <stop offset="1" stop-color="#E9E1F6"/>
    </linearGradient>
    <clipPath id="portraitClip">
      <rect x="774" y="52" width="340" height="526" rx="170"/>
    </clipPath>
  </defs>
  <rect width="1200" height="630" fill="url(#background)"/>
  <circle cx="93" cy="77" r="180" fill="#CDBCE9" opacity=".34"/>
  <circle cx="1120" cy="607" r="210" fill="none" stroke="#7352B7" stroke-width="2" opacity=".16"/>
  <path d="M0 522C163 458 253 563 417 511C548 470 599 385 738 374" fill="none" stroke="#7352B7" stroke-width="2" opacity=".22"/>
  <text x="88" y="166" fill="#62428F" font-family="Arial, sans-serif" font-size="22" font-weight="700" letter-spacing="5">PSYCHOLOGY · PSICOLOGÍA · PSICOLOGIA</text>
  <text x="86" y="286" fill="#28163E" font-family="Georgia, serif" font-size="76" font-weight="bold">Giulia</text>
  <text x="86" y="371" fill="#28163E" font-family="Georgia, serif" font-size="76" font-weight="bold">Cardarilli</text>
  <text x="90" y="448" fill="#49306A" font-family="Arial, sans-serif" font-size="29">Psychologist in clinical training</text>
  <rect x="88" y="492" width="124" height="4" rx="2" fill="#7352B7"/>
  <text x="88" y="543" fill="#6D6476" font-family="Arial, sans-serif" font-size="23">Listening, rigour and care.</text>
  <rect x="754" y="32" width="380" height="566" rx="190" fill="#7352B7" opacity=".13"/>
  <image x="774" y="52" width="340" height="526" preserveAspectRatio="xMidYMid slice" clip-path="url(#portraitClip)" href="data:image/jpeg;base64,${PHOTO_BASE64}"/>
</svg>
EOF

# Try to rasterise the artwork. Social crawlers are most reliable with PNG/JPEG.
OG_READY=false
if command -v rsvg-convert >/dev/null 2>&1; then
  rsvg-convert -w 1200 -h 630 assets/images/social/og-cover.svg -o assets/images/social/og-cover.png
  OG_READY=true
elif command -v magick >/dev/null 2>&1; then
  magick -background none assets/images/social/og-cover.svg assets/images/social/og-cover.png
  OG_READY=true
elif command -v convert >/dev/null 2>&1; then
  convert -background none assets/images/social/og-cover.svg assets/images/social/og-cover.png
  OG_READY=true
fi

cat > js/resources.js <<'EOF'
function escapeHtml(value = "") {
  return String(value)
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#039;");
}

function createCard(item) {
  const type = escapeHtml(item.type);
  const title = escapeHtml(item.title);
  const description = escapeHtml(item.description);
  const status = escapeHtml(item.status);

  return `
    <article class="resource-card reveal is-visible">
      <p class="resource-card__type">${type}</p>
      <h3>${title}</h3>
      <p>${description}</p>
      <span class="resource-card__status">${status}</span>
    </article>
  `;
}

function renderResources(dictionary) {
  const grid = document.querySelector("#resources-grid");
  if (!grid) return;

  const items = dictionary?.resources?.items;
  if (!Array.isArray(items) || !items.length) {
    grid.innerHTML = "";
    return;
  }

  grid.innerHTML = items.map(createCard).join("");
}

export function initResources() {
  document.addEventListener("languagechanged", (event) => {
    renderResources(event.detail.dictionary);
  });
}
EOF

cat > js/main.js <<'EOF'
import { initAnimations } from "./animations.js";
import { initI18n } from "./i18n.js";
import { initModal } from "./modal.js";
import { initNavigation } from "./navigation.js";
import { initResources } from "./resources.js";

document.addEventListener("DOMContentLoaded", async () => {
  document.querySelector("#current-year").textContent = new Date().getFullYear();
  initResources();

  try {
    await initI18n();
  } catch (error) {
    console.error("Could not initialise translations.", error);
  }

  initNavigation();
  initModal();
  initAnimations();
});
EOF

# Dispatch the loaded dictionary so modules such as resources.js can render language-specific data.
python3 <<'PY'
from pathlib import Path

path = Path("js/i18n.js")
content = path.read_text(encoding="utf-8")
needle = '''  localStorage.setItem("giulia-portfolio-language", lang);
  const url = new URL(window.location.href);'''
replacement = '''  localStorage.setItem("giulia-portfolio-language", lang);
  document.dispatchEvent(new CustomEvent("languagechanged", {
    detail: { language: lang, dictionary }
  }));
  const url = new URL(window.location.href);'''
if needle not in content:
    raise SystemExit("Expected insertion point not found in js/i18n.js")
content = content.replace(needle, replacement, 1)
path.write_text(content, encoding="utf-8")
PY

cat >> css/layout.css <<'EOF'

.resources-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1.25rem;
}
EOF

cat >> css/components.css <<'EOF'

/* Resources */
.resource-card {
  display: flex;
  min-height: 17rem;
  flex-direction: column;
  padding: 2rem;
  color: var(--violet-950);
  background: var(--white);
  border: 1px solid var(--line);
  border-radius: var(--radius-md);
  box-shadow: 0 .8rem 2.5rem rgba(55, 28, 92, .055);
  transition: transform var(--transition), box-shadow var(--transition), border-color var(--transition);
}

.resource-card:hover {
  transform: translateY(-.35rem);
  border-color: var(--violet-300);
  box-shadow: var(--shadow);
}

.resource-card__type {
  margin-bottom: 1.25rem;
  color: var(--violet-700);
  font-size: .74rem;
  font-weight: 700;
  letter-spacing: .12em;
  text-transform: uppercase;
}

.resource-card h3 {
  max-width: 15ch;
  font-size: 1.65rem;
}

.resource-card > p:not(.resource-card__type) {
  margin-top: 1rem;
  color: var(--muted);
}

.resource-card__status {
  display: inline-flex;
  width: fit-content;
  margin-top: auto;
  padding-top: 1.4rem;
  color: var(--violet-700);
  font-size: .84rem;
  font-weight: 700;
}

.resource-card__status::before {
  margin-right: .45rem;
  color: var(--violet-600);
  content: "✦";
}
EOF

cat >> css/responsive.css <<'EOF'

@media (max-width: 860px) {
  .resources-grid { grid-template-columns: 1fr; }
  .resource-card { min-height: 0; }
}
EOF

python3 - "$SITE_URL" "$OG_READY" <<'PY'
from pathlib import Path
import json
import sys

site_url, og_ready = sys.argv[1], sys.argv[2] == "true"
index_path = Path("index.html")
content = index_path.read_text(encoding="utf-8")

# Add the resource anchor in both navigation variants.
desktop_old = '''          <a href="#formacion" data-i18n="navigation.education">Formación</a>
          <a href="#contacto" data-i18n="navigation.contact">Contacto</a>'''
desktop_new = '''          <a href="#formacion" data-i18n="navigation.education">Formación</a>
          <a href="#recursos" data-i18n="navigation.resources">Recursos</a>
          <a href="#contacto" data-i18n="navigation.contact">Contacto</a>'''
if desktop_old not in content:
    raise SystemExit("Desktop navigation insertion point not found in index.html")
content = content.replace(desktop_old, desktop_new, 1)

mobile_old = '''          <a href="#formacion" data-i18n="navigation.education">Formación</a>
          <a href="#contacto" data-i18n="navigation.contact">Contacto</a>'''
if mobile_old not in content:
    raise SystemExit("Mobile navigation insertion point not found in index.html")
content = content.replace(mobile_old, desktop_new, 1)

section = '''
      <section id="recursos" class="section resources">
        <div class="container">
          <div class="section-heading section-heading--center reveal">
            <p class="eyebrow" data-i18n="resources.eyebrow">Recursos</p>
            <h2 data-i18n="resources.title">Lecturas y reflexiones.</h2>
            <p data-i18n="resources.description">Un espacio en construcción para compartir temas que inspiran mi aprendizaje y desarrollo profesional.</p>
          </div>
          <div id="resources-grid" class="resources-grid" aria-live="polite"></div>
        </div>
      </section>
'''
needle = '      <section id="contacto" class="section contact">'
if needle not in content:
    raise SystemExit("Contact section insertion point not found in index.html")
content = content.replace(needle, section + "\n" + needle, 1)

# Only point social metadata at the new art after a PNG was successfully generated.
if site_url and og_ready:
    previous = f'{site_url}/assets/images/profile/giulia-cardarilli.jpeg'
    current = f'{site_url}/assets/images/social/og-cover.png'
    content = content.replace(previous, current)

index_path.write_text(content, encoding="utf-8")

resources = {
  "es": {
    "eyebrow": "Recursos",
    "title": "Lecturas y reflexiones.",
    "description": "Un espacio en construcción para compartir temas que inspiran mi aprendizaje y desarrollo profesional.",
    "items": [
      {"type": "Tema de interés", "title": "Apego adulto y vínculos", "description": "Una aproximación a la influencia de los vínculos tempranos en la manera de relacionarnos en la vida adulta.", "status": "Próximamente"},
      {"type": "Reflexión", "title": "El valor de la escucha", "description": "Escuchar con atención supone abrir espacio a la experiencia, el ritmo y la perspectiva de cada persona.", "status": "Próximamente"},
      {"type": "Lectura", "title": "Filosofía y cuidado", "description": "Ideas y preguntas sobre la relación entre pensamiento, bienestar y la forma en que habitamos nuestras experiencias.", "status": "Próximamente"}
    ]
  },
  "it": {
    "eyebrow": "Risorse",
    "title": "Letture e riflessioni.",
    "description": "Uno spazio in costruzione per condividere temi che ispirano il mio apprendimento e il mio sviluppo professionale.",
    "items": [
      {"type": "Tema di interesse", "title": "Attaccamento adulto e legami", "description": "Uno sguardo sull'influenza dei legami precoci nel modo in cui ci relazioniamo durante la vita adulta.", "status": "Prossimamente"},
      {"type": "Riflessione", "title": "Il valore dell'ascolto", "description": "Ascoltare con attenzione significa creare spazio per l'esperienza, i tempi e la prospettiva di ogni persona.", "status": "Prossimamente"},
      {"type": "Lettura", "title": "Filosofia e cura", "description": "Idee e domande sul rapporto tra pensiero, benessere e il modo in cui viviamo le nostre esperienze.", "status": "Prossimamente"}
    ]
  },
  "en": {
    "eyebrow": "Resources",
    "title": "Readings and reflections.",
    "description": "A work-in-progress space for sharing topics that inspire my learning and professional development.",
    "items": [
      {"type": "Area of interest", "title": "Adult attachment and bonds", "description": "An introduction to the influence of early bonds on the way we relate to others in adult life.", "status": "Coming soon"},
      {"type": "Reflection", "title": "The value of listening", "description": "Listening attentively means making room for each person's experience, pace and perspective.", "status": "Coming soon"},
      {"type": "Reading", "title": "Philosophy and care", "description": "Ideas and questions about the relationship between thought, wellbeing and the way we inhabit our experiences.", "status": "Coming soon"}
    ]
  }
}

for lang, content_data in resources.items():
    path = Path(f"assets/i18n/{lang}.json")
    data = json.loads(path.read_text(encoding="utf-8"))
    data.setdefault("navigation", {})["resources"] = content_data["eyebrow"]
    data["resources"] = content_data
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
PY

if [[ "$OG_READY" == "true" ]]; then
  echo "Open Graph PNG generated: assets/images/social/og-cover.png"
  if [[ -z "$SITE_URL" ]]; then
    echo "Note: rerun this script with the final HTTPS site URL before publishing, so index.html can use the new image in social metadata."
  fi
else
  echo "SVG source generated: assets/images/social/og-cover.svg"
  echo "PNG was not generated because no SVG rasteriser was found."
  echo "Install one once: sudo apt install librsvg2-bin"
  echo "Then rerun this script to create og-cover.png and update metadata."
fi

echo "Resources section, dynamic language data and social artwork source applied successfully."
