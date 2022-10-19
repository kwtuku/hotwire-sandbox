import { Modal } from 'bootstrap';

const newConfirmMethod = (message) => {
  const modalElement = document.getElementById('turbo-confirm-modal');
  const modal = new Modal(modalElement);
  const messageElement = document.getElementById('turbo-confirm-modal-message');
  const confirmButtonElement = document.getElementById('turbo-confirm-modal-confirm-button');

  messageElement.textContent = message;
  modal.show();

  return new Promise((resolve) => {
    confirmButtonElement.addEventListener(
      'click',
      () => {
        resolve(true);
        modal.hide();
      },
      { once: true },
    );
  });
};

Turbo.setConfirmMethod(newConfirmMethod);
