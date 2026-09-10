#!/usr/bin/env bash
set -euo pipefail

# Run from the root of ~/Proyectos/portfolio-giulia.
# This script adds an accessible mobile menu, language-selector synchronisation,
# active navigation, reveal-on-scroll animations and a certificate modal.
# It expects the files created by setup-portfolio-giulia-base.sh.

required_files=(
  "index.html"
  "js/i18n.js"
  "js/main.js"
  "css/components.css"
  "css/sections.css"
  "css/responsive.css"
  "assets/i18n/es.json"
  "assets/i18n/it.json"
  "assets/i18n/en.json"
)

for file in "${required_files[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "Error: missing required file: $file" >&2
    exit 1
  fi
done

cat > js/navigation.js <<'EOF'
const focusableSelector = [
  "a[href]",
  "button:not([disabled])",
  "select:not([disabled])"
].join(",");

export function initNavigation() {
  const toggle = document.querySelector("#menu-toggle");
  const menu = document.querySelector("#mobile-menu");
  const menuLinks = menu?.querySelectorAll('a[href^="#"]') ?? [];
  const navLinks = document.querySelectorAll('.site-nav a[href^="#"], .mobile-nav a[href^="#"]');

  if (toggle && menu) {
    const closeMenu = () => {
      toggle.setAttribute("aria-expanded", "false");
      menu.hidden = true;
      document.body.classList.remove("menu-is-open");
    };

    const openMenu = () => {
      toggle.setAttribute("aria-expanded", "true");
      menu.hidden = false;
      document.body.classList.add("menu-is-open");
      menu.querySelector(focusableSelector)?.focus();
    };

    toggle.addEventListener("click", () => {
      const isOpen = toggle.getAttribute("aria-expanded") === "true";
      isOpen ? closeMenu() : openMenu();
    });

    menuLinks.forEach((link) => link.addEventListener("click", closeMenu));

    document.addEventListener("keydown", (event) => {
      if (event.key === "Escape" && toggle.getAttribute("aria-expanded") === "true") {
        closeMenu();
        toggle.focus();
      }
    });
  }

  const sections = [...document.querySelectorAll("main section[id]")];
  if (!sections.length || !navLinks.length) return;

  const updateActiveLink = (id) => {
    navLinks.forEach((link) => {
      const isCurrent = link.getAttribute("href") === `#${id}`;
      link.classList.toggle("is-active", isCurrent);
      if (isCurrent) link.setAttribute("aria-current", "location");
      else link.removeAttribute("aria-current");
    });
  };

  const observer = new IntersectionObserver(
    (entries) => {
      const visible = entries
        .filter((entry) => entry.isIntersecting)
        .sort((a, b) => b.intersectionRatio - a.intersectionRatio)[0];
      if (visible) updateActiveLink(visible.target.id);
    },
    { rootMargin: "-35% 0px -55% 0px", threshold: [0.05, 0.2, 0.5] }
  );

  sections.forEach((section) => observer.observe(section));
}
EOF

cat > js/modal.js <<'EOF'
export function initModal() {
  const modal = document.querySelector("#certificate-modal");
  const image = document.querySelector("#modal-image");
  const closeButton = document.querySelector("#modal-close");
  const triggers = document.querySelectorAll("[data-modal-open]");

  if (!modal || !image || !closeButton || !triggers.length) return;

  let lastTrigger = null;

  const closeModal = () => {
    modal.close();
    document.body.classList.remove("modal-is-open");
    lastTrigger?.focus();
  };

  triggers.forEach((trigger) => {
    trigger.addEventListener("click", (event) => {
      event.preventDefault();
      lastTrigger = trigger;
      image.src = trigger.dataset.modalSrc || trigger.href;
      image.alt = trigger.dataset.modalAlt || trigger.textContent.trim();
      modal.showModal();
      document.body.classList.add("modal-is-open");
      closeButton.focus();
    });
  });

  closeButton.addEventListener("click", closeModal);

  modal.addEventListener("click", (event) => {
    const rect = modal.getBoundingClientRect();
    const outsideDialog =
      event.clientX < rect.left ||
      event.clientX > rect.right ||
      event.clientY < rect.top ||
      event.clientY > rect.bottom;
    if (outsideDialog) closeModal();
  });

  modal.addEventListener("cancel", (event) => {
    event.preventDefault();
    closeModal();
  });
}
EOF

cat > js/animations.js <<'EOF'
export function initAnimations() {
  const elements = document.querySelectorAll(".reveal");
  if (!elements.length) return;

  if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) {
    elements.forEach((element) => element.classList.add("is-visible"));
    return;
  }

  const observer = new IntersectionObserver(
    (entries, activeObserver) => {
      entries.forEach((entry) => {
        if (!entry.isIntersecting) return;
        entry.target.classList.add("is-visible");
        activeObserver.unobserve(entry.target);
      });
    },
    { threshold: 0.12 }
  );

  elements.forEach((element) => observer.observe(element));
}
EOF

cat > js/i18n.js <<'EOF'
const supportedLanguages = ["es", "it", "en"];
const defaultLanguage = "es";

function getValue(object, path) {
  return path.split(".").reduce((value, key) => value?.[key], object);
}

function getInitialLanguage() {
  const urlLanguage = new URL(window.location.href).searchParams.get("lang");
  const storedLanguage = localStorage.getItem("giulia-portfolio-language");
  const browserLanguage = navigator.language?.slice(0, 2).toLowerCase();
  return [urlLanguage, storedLanguage, browserLanguage]
    .find((language) => supportedLanguages.includes(language)) || defaultLanguage;
}

export async function setLanguage(language) {
  const lang = supportedLanguages.includes(language) ? language : defaultLanguage;
  const response = await fetch(`assets/i18n/${lang}.json`);
  if (!response.ok) throw new Error(`Translation file unavailable: ${lang}`);
  const dictionary = await response.json();

  document.documentElement.lang = lang;
  document.title = dictionary.meta.title;
  document.querySelector('meta[name="description"]')?.setAttribute("content", dictionary.meta.description);

  document.querySelectorAll("[data-i18n]").forEach((element) => {
    const value = getValue(dictionary, element.dataset.i18n);
    if (value) element.textContent = value;
  });

  document.querySelectorAll("[data-i18n-alt]").forEach((element) => {
    const value = getValue(dictionary, element.dataset.i18nAlt);
    if (value) element.alt = value;
  });

  document.querySelectorAll("[data-i18n-aria-label]").forEach((element) => {
    const value = getValue(dictionary, element.dataset.i18nAriaLabel);
    if (value) element.setAttribute("aria-label", value);
  });

  document.querySelectorAll("[data-cv-link]").forEach((link) => {
    link.href = `assets/documents/cv-giulia-cardarilli-${lang}.pdf`;
  });

  document.querySelectorAll("[data-language-select]").forEach((selector) => {
    selector.value = lang;
  });

  localStorage.setItem("giulia-portfolio-language", lang);
  const url = new URL(window.location.href);
  url.searchParams.set("lang", lang);
  window.history.replaceState({}, "", `${url.pathname}${url.search}${url.hash}`);
}

export function initI18n() {
  document.querySelectorAll("[data-language-select]").forEach((selector) => {
    selector.addEventListener("change", (event) => setLanguage(event.target.value));
  });
  return setLanguage(getInitialLanguage());
}
EOF

cat > js/main.js <<'EOF'
import { initAnimations } from "./animations.js";
import { initI18n } from "./i18n.js";
import { initModal } from "./modal.js";
import { initNavigation } from "./navigation.js";

document.addEventListener("DOMContentLoaded", async () => {
  document.querySelector("#current-year").textContent = new Date().getFullYear();

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

cat >> css/components.css <<'EOF'

/* Mobile navigation */
.menu-toggle {
  display: none;
  width: 2.75rem;
  height: 2.75rem;
  padding: 0;
  border: 1px solid var(--line);
  border-radius: 50%;
  background: var(--white);
  cursor: pointer;
}

.menu-toggle__lines,
.menu-toggle__lines::before,
.menu-toggle__lines::after {
  display: block;
  width: 1rem;
  height: 1px;
  margin: auto;
  background: var(--violet-800);
  transition: transform var(--transition), opacity var(--transition);
  content: "";
}

.menu-toggle__lines { position: relative; }
.menu-toggle__lines::before { position: absolute; top: -.32rem; }
.menu-toggle__lines::after { position: absolute; top: .32rem; }
.menu-toggle[aria-expanded="true"] .menu-toggle__lines { background: transparent; }
.menu-toggle[aria-expanded="true"] .menu-toggle__lines::before { transform: translateY(.32rem) rotate(45deg); }
.menu-toggle[aria-expanded="true"] .menu-toggle__lines::after { transform: translateY(-.32rem) rotate(-45deg); }

.mobile-menu {
  position: fixed;
  z-index: 19;
  top: 5.25rem;
  right: 0;
  left: 0;
  padding: 1rem 1.5rem 2rem;
  background: rgba(255, 255, 255, .98);
  border-bottom: 1px solid var(--line);
  box-shadow: 0 1rem 2rem rgba(55, 28, 92, .1);
}

.mobile-menu[hidden] { display: none; }
.mobile-nav { display: grid; gap: .2rem; }
.mobile-nav a { padding: .85rem 0; color: var(--violet-950); border-bottom: 1px solid var(--violet-100); font-family: var(--font-display); font-size: 1.45rem; }
.mobile-menu__bottom { display: flex; align-items: center; justify-content: space-between; gap: 1rem; margin-top: 1.5rem; }
.site-nav a.is-active,
.mobile-nav a.is-active { color: var(--violet-600); }

/* Certificate modal */
.modal-is-open,
.menu-is-open { overflow: hidden; }
.certificate-modal { width: min(58rem, calc(100% - 2rem)); max-width: none; max-height: min(90vh, 58rem); padding: .7rem; overflow: visible; border: 0; border-radius: var(--radius-md); background: var(--white); box-shadow: 0 1.5rem 5rem rgba(21, 8, 37, .35); }
.certificate-modal::backdrop { background: rgba(33, 18, 55, .72); backdrop-filter: blur(4px); }
.certificate-modal__content { position: relative; max-height: calc(90vh - 1.4rem); overflow: auto; }
.certificate-modal img { width: 100%; border-radius: .75rem; }
.modal-close { position: fixed; z-index: 2; top: 1.35rem; right: 1.35rem; display: grid; width: 2.65rem; height: 2.65rem; place-items: center; color: var(--violet-950); border: 1px solid var(--line); border-radius: 50%; background: var(--white); cursor: pointer; font-size: 1.25rem; box-shadow: 0 .4rem 1.2rem rgba(30, 15, 50, .16); }
.modal-close:hover { color: var(--white); background: var(--violet-600); }

/* Progressive reveal */
.reveal { opacity: 0; transform: translateY(1.25rem); transition: opacity 650ms ease, transform 650ms ease; animation: none; }
.reveal.is-visible { opacity: 1; transform: translateY(0); }
EOF

cat >> css/responsive.css <<'EOF'

@media (max-width: 860px) {
  .menu-toggle { display: grid; place-items: center; }
  .header-actions .button--header { display: none; }
}

@media (min-width: 861px) {
  .mobile-menu { display: none !important; }
}

@media (max-width: 540px) {
  .mobile-menu { top: 4.65rem; padding-inline: 1rem; }
  .header-actions .language-selector { display: none; }
  .certificate-modal { width: calc(100% - 1rem); padding: .35rem; }
  .modal-close { top: .85rem; right: .85rem; }
}
EOF

python3 <<'PY'
from pathlib import Path
import json

index = Path("index.html")
content = index.read_text(encoding="utf-8")

old = '''        <nav class="site-nav" aria-label="Navegación principal" data-i18n-aria-label="accessibility.mainNav">'''
new = '''        <button id="menu-toggle" class="menu-toggle" type="button" aria-expanded="false" aria-controls="mobile-menu" aria-label="Abrir menú" data-i18n-aria-label="accessibility.openMenu">
          <span class="menu-toggle__lines" aria-hidden="true"></span>
        </button>

        <nav class="site-nav" aria-label="Navegación principal" data-i18n-aria-label="accessibility.mainNav">'''
if old not in content:
    raise SystemExit("Expected desktop navigation markup was not found in index.html")
content = content.replace(old, new, 1)

content = content.replace('''          <select id="language-select" class="language-selector" aria-label="Cambiar idioma" data-i18n-aria-label="language.label">''', '''          <select id="language-select" class="language-selector" data-language-select aria-label="Cambiar idioma" data-i18n-aria-label="language.label">''', 1)

old = '''        </div>
      </div>
    </header>'''
new = '''        </div>
      </div>

      <div id="mobile-menu" class="mobile-menu" hidden>
        <nav class="mobile-nav container" aria-label="Navegación móvil" data-i18n-aria-label="accessibility.mobileNav">
          <a href="#sobre-mi" data-i18n="navigation.about">Sobre mí</a>
          <a href="#experiencia" data-i18n="navigation.experience">Experiencia</a>
          <a href="#formacion" data-i18n="navigation.education">Formación</a>
          <a href="#contacto" data-i18n="navigation.contact">Contacto</a>
        </nav>
        <div class="mobile-menu__bottom container">
          <label class="sr-only" for="language-select-mobile" data-i18n="language.label">Idioma</label>
          <select id="language-select-mobile" class="language-selector" data-language-select aria-label="Cambiar idioma" data-i18n-aria-label="language.label">
            <option value="es">ES</option>
            <option value="it">IT</option>
            <option value="en">EN</option>
          </select>
          <a class="text-link" href="https://www.linkedin.com/in/giulia-cardarilli-53b72a1b1" target="_blank" rel="noreferrer">LinkedIn <span aria-hidden="true">↗</span></a>
        </div>
      </div>
    </header>'''
if old not in content:
    raise SystemExit("Expected header closing markup was not found in index.html")
content = content.replace(old, new, 1)

old = '''<a class="text-link" href="assets/images/certificates/curso-apego-adulto-aepsis.jpeg" target="_blank" rel="noreferrer">'''
new = '''<a class="text-link" href="assets/images/certificates/curso-apego-adulto-aepsis.jpeg" data-modal-open data-modal-src="assets/images/certificates/curso-apego-adulto-aepsis.jpeg" data-modal-alt="Certificado del curso sobre apego adulto de AEPSIS">'''
if old not in content:
    raise SystemExit("Expected certificate link markup was not found in index.html")
content = content.replace(old, new, 1)

old = '''    <footer class="site-footer">'''
new = '''    <dialog id="certificate-modal" class="certificate-modal" aria-label="Certificado" data-i18n-aria-label="accessibility.certificateModal">
      <div class="certificate-modal__content">
        <button id="modal-close" class="modal-close" type="button" aria-label="Cerrar certificado" data-i18n-aria-label="accessibility.closeModal">×</button>
        <img id="modal-image" src="" alt="" />
      </div>
    </dialog>

    <footer class="site-footer">'''
if old not in content:
    raise SystemExit("Expected footer markup was not found in index.html")
content = content.replace(old, new, 1)
index.write_text(content, encoding="utf-8")

translations = {
    "es": {
        "openMenu": "Abrir menú", "mobileNav": "Navegación móvil", "certificateModal": "Certificado", "closeModal": "Cerrar certificado"
    },
    "it": {
        "openMenu": "Apri menu", "mobileNav": "Navigazione mobile", "certificateModal": "Attestato", "closeModal": "Chiudi attestato"
    },
    "en": {
        "openMenu": "Open menu", "mobileNav": "Mobile navigation", "certificateModal": "Certificate", "closeModal": "Close certificate"
    }
}

for language, labels in translations.items():
    path = Path(f"assets/i18n/{language}.json")
    data = json.loads(path.read_text(encoding="utf-8"))
    data.setdefault("accessibility", {}).update(labels)
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
PY

printf '\nInteraction improvements applied successfully.\n'
printf 'Run: python3 -m http.server 8000\n'
printf 'Then open: http://localhost:8000/?lang=es\n'
