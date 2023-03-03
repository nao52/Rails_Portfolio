document.addEventListener("turbo:load", function() {
  const email_form = document.querySelector('#session_email');
  const password_form = document.querySelector('#session_password');
  const guest_check = document.querySelector('#session_guest');

  guest_check.addEventListener('click', () => {
    if (guest_check.checked) {
      email_form.disabled = true;
      password_form.disabled = true;
    } else {
      email_form.disabled = false;
      password_form.disabled = false;
    }
  });

});