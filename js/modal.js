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
