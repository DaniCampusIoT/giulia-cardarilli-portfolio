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
