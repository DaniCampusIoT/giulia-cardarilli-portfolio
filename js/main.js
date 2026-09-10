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
