document.addEventListener("turbo:load", () => {
  const open = document.querySelector('#open');
  const mask = document.querySelector('#mask');
  const modal = document.querySelector('#modal');
  const close = document.querySelector('#close');

  open.addEventListener('click', () => {
    modal.classList.remove('hidden');
    mask.classList.remove('hidden');
  });

  close.addEventListener('click', () => {
    modal.classList.add('hidden');
    mask.classList.add('hidden');
  });

  mask.addEventListener('click', () => {
    close.click();
  });
});