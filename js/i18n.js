const supportedLanguages = ["es", "it", "en"];
const defaultLanguage = "es";

function getValue(object, path) {
  return path.split(".").reduce((value, key) => value?.[key], object);
}

function getInitialLanguage() {
  const fromUrl = new URLSearchParams(window.location.search).get("lang");
  const stored = localStorage.getItem("giulia-portfolio-language");
  const browser = navigator.language?.slice(0, 2).toLowerCase();
  return [fromUrl, stored, browser].find((lang) => supportedLanguages.includes(lang)) || defaultLanguage;
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

  document.querySelector("#language-select").value = lang;
  localStorage.setItem("giulia-portfolio-language", lang);
  window.history.replaceState({}, "", `${window.location.pathname}?lang=${lang}${window.location.hash}`);
}

export function initI18n() {
  const selector = document.querySelector("#language-select");
  selector.addEventListener("change", (event) => setLanguage(event.target.value));
  return setLanguage(getInitialLanguage());
}
