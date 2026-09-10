import { initI18n } from "./i18n.js";

document.addEventListener("DOMContentLoaded", async () => {
  document.querySelector("#current-year").textContent = new Date().getFullYear();
  try {
    await initI18n();
  } catch (error) {
    console.error("Could not initialise translations.", error);
  }
});
