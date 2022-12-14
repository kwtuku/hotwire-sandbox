import { Modal } from 'bootstrap';

const newConfirmMethod = (message, formElement) => {
  const modalElement = document.getElementById('turbo-confirm-modal');
  const modal = new Modal(modalElement);
  const messageElement = document.getElementById('turbo-confirm-modal-message');
  const confirmButtonElement = document.getElementById('turbo-confirm-modal-confirm-button');
  const confirmButtonText = formElement.getAttribute('data-turbo-confirm-button');

  messageElement.textContent = message;
  if (confirmButtonText !== null) confirmButtonElement.textContent = confirmButtonText;
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
