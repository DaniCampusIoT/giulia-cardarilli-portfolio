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
